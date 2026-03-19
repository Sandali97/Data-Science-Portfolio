/* ------------------------------------Bank Transaction Fraud Detection------------------------------------------------------------ */

/* ----------------------------------------------Import Data------------------------------------------------------------------------------------*/
FILENAME REFFILE '/home/u64467361/Sandali/Transactions.csv';
libname Bank '/home/u64467361/Sandali';

Proc import datafile= REFFILE dbms=CSV out=bank.Transactions replace;
run;

/*create new columns for transaction year,month,day*/
data Bank.Transactions;
    set Bank.Transactions;

    /* Extract hour from datetime */
    TransactionHour  = hour(TransactionDate);

    /* Convert datetime → date for day/month/weekday */
    TransactionDate_only = datepart(TransactionDate); /* numeric date */
    format TransactionDate_only date9.;

    /* Extract day, month, weekday from date */
    TransactionDay   = day(TransactionDate_only);
    TransactionMonth = month(TransactionDate_only);
    TransactionWeekday = weekday(TransactionDate_only);
    TransactionYear = year(TransactionDate_only);
run;

/* Check structure of data table */
Proc contents data=bank.transactions;
run;
/*Check summary statistics of the data table*/
Proc means data= bank.transactions n mean median min max std nmiss;
run;

/*There is no missing value in quantitative variables*/
/*Check missing values in the dataset*/
proc freq data=Bank.Transactions;
    tables _all_ / missing;
run;

/*Check for duplicates*/
proc sort data=Bank.Transactions out=SortedTransactions dupout=Duplicates nodupkey;
    by TransactionID;
run;


/*------------------------------------------------------------EDA-------------------------------------------------------------------------------*/
/*Check transactions by type*/
/*Majority Transactions are Debit Transactions*/
proc sgplot data=Bank.Transactions;
	vbar TransactionType/datalabel fillattrs=(color=gray);
	title "Transactions by Type";
	xaxis label="Transaction Type";
    yaxis label="Count of Transactions";
	
run;

/*Transactions by Location*/
ods graphics / reset width=1000px height=600px;
proc sgplot data=Bank.Transactions;
	vbar Location/datalabel fillattrs=(color=gray);
	title "Transactions by Location";
	xaxis label="Location";
    yaxis label="Count of Transactions";
	
run;

/*10 countries with highest number of transactions*/
/* Count transactions per Location */
proc sql;
    create table LocationCounts as
    select Location, count(*) as TransactionCount
    from Bank.Transactions
    group by Location
    order by TransactionCount desc;
quit;

/* Keep only top 10 locations */
data Top10Locations;
    set LocationCounts;
    if _N_ <= 10; /* first 10 rows after sorting */
run;

ods graphics / reset width=1000px height=600px;
/*plot top10 locations*/
proc sgplot data=Top10Locations;
    vbar Location / response=TransactionCount datalabel fillattrs=(color=gray);
    title "Top 10 Locations with Highest Transactions";
    xaxis label="Location";
    yaxis label="Number of Transactions";
run;


/*Transaction count by channel*/
ods graphics / reset width=1000px height=600px;
proc sgplot data=Bank.Transactions;
	vbar Channel/datalabel fillattrs=(color=gray);
	title "Transactions by Channel";
	xaxis label="Channel";
    yaxis label="Count of Transactions";
	
run;
/*Average transaction amount per channel*/
proc sql;
    create table channel_summary as
    select Channel,
           mean(TransactionAmount) as AvgTransactionAmount,
           count(TransactionID) as NumTransactions
    from Bank.Transactions
    group by Channel;
quit;
run;

proc sgplot data=channel_summary;
    vbar Channel / response=AvgTransactionAmount fillattrs=(color=steelblue);
    xaxis label="Transaction Channel";
    yaxis label="Average Transaction Amount";
    title "Average Transaction Amount per Channel";
run;


/*Customer occupation distribution*/
ods graphics / reset width=1000px height=600px;
proc sgplot data=Bank.Transactions;
	vbar CustomerOccupation/datalabel fillattrs=(color=gray);
	title "Transactions by Customer Occupation";
	xaxis label="Customer Occupation";
    yaxis label="Count of Transactions";
	
run;

/* Distribution of Daily Transactions */


/*Check Occupation Consistency for the Same AccountID*/
proc sql;
    create table Occupation_flag as
    select AccountID,
           case 
               when count(distinct CustomerOccupation) = 1 then 'Consistent'
               else 'Inconsistent'
           end as Occupation_Status
    from Bank.Transactions
    group by AccountID;
quit;

proc sql;
    create table Transactions_with_Occupation as
    select a.*,
           b.Occupation_Status
    from Bank.Transactions a
         left join Occupation_flag b
         on a.AccountID = b.AccountID;
quit;

/*Plot Occupation Status*/
proc sql;
    create table Occupation_summary as
    select Occupation_Status,
           count(distinct AccountID) as Num_Accounts
    from Transactions_with_Occupation
    group by Occupation_Status;
quit;

ods graphics / reset width=1000px height=600px;

proc sgplot data=Occupation_summary;
    vbar Occupation_Status / response=Num_Accounts datalabel fillattrs=(color=gray);
    title "Number of Accounts by Occupation Status";
    xaxis label="Occupation Status";
    yaxis label="Number of Accounts";
run;

/*Plot OccupationStatus by Year*/
proc sql;
    create table Occupation_summary_year as
    select TransactionYear,
           Occupation_Status,
           count(distinct AccountID) as Num_Accounts
    from Transactions_with_Occupation
    group by TransactionYear, Occupation_Status
    order by TransactionYear, Occupation_Status;
quit;
ods graphics / reset width=1000px height=600px;

proc sgplot data=Occupation_summary_year;
    vbar TransactionYear / response=Num_Accounts group=Occupation_Status datalabel;
    title "Number of Accounts by Occupation Status Over Years";
    xaxis label="Transaction Year";
    yaxis label="Number of Accounts";
run;

/*461 AccountIDs have inconsistent occupation status*/
/* Further Analysis will be conducted for those suspicious accounts */

data Bank.Transactions_inconsistent;
    set Transactions_with_Occupation;
    where Occupation_Status = 'Inconsistent';
run;

/*-------------------------------------------------Further Analysis---------------------------------------------------------*/
/*Transaction Amount Distribution*/
proc sgplot data=Bank.transactions_inconsistent;
	histogram TransactionAmount;
	density TransactionAmount;
	title "Transaction Amount Distribution";
run;

proc sgplot data=Bank.transactions_inconsistent;
    vbox TransactionAmount;
    title "Boxplot of Transaction Amounts for Inconsistent Accounts";
    yaxis label="Transaction Amount";
run;

/*Detect Outliers for each AccountID for each Year*/

proc univariate data=Bank.transactions_inconsistent noprint;
    class AccountID TransactionYear;
    var TransactionAmount;
    output out=AccountYear_bounds
        pctlpts=25 75
        pctlpre=Q;
run;

data AccountYear_bounds;
    set AccountYear_bounds;
    IQR = Q75 - Q25;
    UpperBound = Q75 + 1.5*IQR;
    LowerBound = Q25 - 1.5*IQR;
run;

proc sql;
    create table Transactions_flagged as
    select a.*,
           b.UpperBound,
           b.LowerBound,
           case
               when a.TransactionAmount > b.UpperBound 
                    or a.TransactionAmount < b.LowerBound
               then 1
               else 0
           end as Outlier_Flag
    from Bank.transactions_inconsistent a
         left join AccountYear_bounds b
         on a.AccountID = b.AccountID
         and a.TransactionYear = b.TransactionYear;
quit;

/* Overwrite on the transactions_inconsistent table */

/* Detect high login attempts (more than 3) */

data Bank.Transaction_Outliers;
	set Transactions_flagged;
	if LoginAttempts >=3 then Login_Flag=1; else Login_Flag=0;
    drop UpperBound LowerBound;
run;

/*Plot outlier flag by year*/

proc sql;
    create table Distinct_Accounts_Outlier as
    select TransactionYear,
           AccountID,
           max(Outlier_Flag) as Outlier_Flag
    from Bank.Transaction_Outliers
    group by TransactionYear, AccountID;
quit;

proc sgplot data=Distinct_Accounts_Outlier;
    vbar TransactionYear / response=Outlier_Flag stat=sum datalabel;
    title "Number of Distinct Accounts with Outliers per Year";
    xaxis label="Transaction Year";
    yaxis label="Number of Distinct Accounts";
run;
/*Detect Rapid Transactions*/

/*Get unique accountid and transaction count*/
proc sql;
    create table Transaction_frequency_unique as
    select AccountID,
           TransactionDate_only,
           count(TransactionID) as DailyTransactions
    from Bank.transactions_inconsistent
    group by AccountID, TransactionDate_only;
quit;

/*merge with the main table*/
proc sql;
    create table Transaction_Outputs_withDaily as
    select a.*,
           b.DailyTransactions
    from Bank.Transaction_Outputs a
         left join Transaction_frequency_unique b
         on a.AccountID = b.AccountID
         and a.TransactionDate_only = b.TransactionDate_only;
quit;

data Bank.Transaction_Outputs; 
	set Transaction_Outputs_withDaily;
	
	if DailyTransactions > 5 then TransFreq_Flag=1;
	else TransFreq_Flag=0;

run;

/*Create fraud Score*/
data Bank.Fraud_score;
	SET Bank.Transaction_Outputs;
	FraudScore = sum(Outlier_Flag, Login_Flag, TransFreq_Flag);
run;

/*Plot fraud Score*/
proc sql;
    create table Bank.AccountYear_FraudScore as
    select TransactionYear,
           AccountID,
           max(FraudScore) as Final_FraudScore
    from Bank.Fraud_score
    group by TransactionYear, AccountID;
quit;

ods graphics / reset width=1000px height=600px;

proc sgplot data=AccountYear_FraudScore;
    vbar TransactionYear / group=Final_FraudScore groupdisplay=cluster stat=freq datalabel;
    title "Distinct Accounts by Final Fraud Score per Year";
    xaxis label="Transaction Year";
    yaxis label="Number of Distinct Accounts";
run;


/*filter AccountIDs with fraud score is 1 or more */
data Bank.Fraud_IDs_EDA;
    set Bank.AccountYear_FraudScore ;
	where Final_FraudScore>= 1;
run;


/*Delete duplicate AccountIds*/
proc sort data=Bank.Fraud_IDs_EDA out=Bank.UniqueID_EDA nodupkey;
    by AccountID TransactionYear ;
run;

/*These 329 AccountIDs are high risk as it is identified as fraud accounts in multiple transactions*/

/*---------------------------------------------------------Unsupervised Learning----------------------------------------------*/
/*--------------01.Clustering-------------------------------------------------------------------------------------------------*/

data Bank.Clustering;
	set Bank.TRANSACTIONS;
run;


proc sql;
	create table Bank.Account_Features as
	select 
	    AccountID,
	    count(*) as Total_Transactions,
	    mean(TransactionAmount) as Avg_Amount,
	    max(TransactionAmount) as Max_Amount,
	    std(TransactionAmount) as Std_Amount,
	    mean(TransactionDuration) as Avg_Duration,
	    mean(LoginAttempts) as Avg_LoginAttempts,
	    max(LoginAttempts) as Max_LoginAttempts,
	    mean(AccountBalance) as Avg_Balance,
	    count(distinct DeviceID) as Unique_Devices,
	  
	    count(distinct Location) as Unique_Locations
	from Bank.Clustering
	group by AccountID, TransactionYear;
quit;


proc stdize data=Bank.Account_Features 
            out=Bank.Account_Features_Scaled 
            method=range;
run;


proc fastclus data=Bank.Account_Features_Scaled
              maxclusters=3
              out=Bank.Clustered
              outstat=Bank.ClusterStats;
    var Total_Transactions Avg_Amount Max_Amount Std_Amount
        Avg_Duration Avg_LoginAttempts Max_LoginAttempts
        Avg_Balance Unique_Devices Unique_Locations;
run;

proc means data=Bank.Clustered mean;
    class cluster;
    var Total_Transactions Avg_Amount Max_Amount 
        Avg_LoginAttempts Unique_Devices  Unique_Locations;
run;

data Bank.Final;
    set Bank.Clustered;

    if cluster = 1 then Risk_Level = "Low";
    else if cluster = 2 then Risk_Level = "High";
    else if cluster = 3 then Risk_Level = "Medium";
run;


/* plot clusters */
proc sgscatter data=Bank.Clustered;
    matrix Total_Transactions Avg_Amount Max_Amount Avg_LoginAttempts Unique_Devices Unique_Locations / group=cluster;
    title "Pairwise Scatter Plot of Clusters";
run;

/* --------------------------------------------------------------Comparison----------------------------------------------------------------- */
/*Get unique AccountIDs identified with Potential Risk */
proc sort data=Bank.Fraud_IDs_EDA out=Bank.UniqueID_EDA nodupkey;
    by AccountID ;
run;


/*Compare Descriptive Analysis Fraud IDs with Cluster IDs*/
data Bank.Fraud_IDs_Cluster;
    set Bank.clustered;
    where cluster<>1;
run;
/*Delete duplicate AccountIds*/
proc sort data=Bank.Fraud_IDs_Cluster out=Bank.Unique_IDC nodupkey;
    by AccountID;
run;

/*Get the high risk account ids which identified as fraud transactions in both EDA and Clustering*/
proc sql;
    create table Bank.Common_Accounts as
    select a.AccountID
    from Bank.Unique_IDC as a
    inner join Bank.UniqueID_EDA as b
    on a.AccountID = b.AccountID;
quit;


/* Count of unique accounts from EDA */
proc sql;
    select count(*) into :EDA_Count
    from Bank.UniqueID_EDA;
quit;

/* Count of unique accounts from Clustering */
proc sql;
    select count(*) into :Cluster_Count
    from Bank.Unique_IDC;
quit;

/* Count of common accounts */
proc sql;
    select count(*) into :Common_Count
    from Bank.Common_Accounts;
quit;

data Bank.Fraud_Counts;
    length Source $20 Count 8;
    Source = "Descriptive Analysis"; Count = &EDA_Count; output;
    Source = "Clustering"; Count = &Cluster_Count; output;
    Source = "Common IDs"; Count = &Common_Count; output;
run;

proc sgplot data=Bank.Fraud_Counts;
    vbar Source / response=Count datalabel;
    yaxis label="Number of Accounts";
    title "Fraud Accounts Identified by EDA, Clustering, and Common Accounts";
run;