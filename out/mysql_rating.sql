drop database if exists rbsall;
create database rbsall;
use rbsall;
DROP TABLE IF EXISTS `rating_BDest`;
CREATE TABLE `rating_BDest`(
	`BDest`	CHAR(25) NOT NULL COMMENT "character|x(25)|B-subNo|B-subNo|B-number|",
	`BDName`	CHAR(30) COMMENT "character|x(30)|DestName|DestName|Destination's name|",
	`Brand`	CHAR(8) COMMENT "character|x(8)|Brand|Brand|Code Of Brand|",
	`CCN`	INT DEFAULT "0" NOT NULL COMMENT "integer|zz9|Country|Country|Consecutive Country/Service Number|",
	`Class`	INT DEFAULT "1" COMMENT "integer|9|Class|Cl|Class: 1: A-sub pays 2: Freephone, B-sub pays|",
	`DestType`	INT DEFAULT "0" COMMENT "integer|>9|Type|Type|B-subscriber type, used with FTAM server.|",
	`Free`	TINYINT(1) DEFAULT "0" COMMENT "logical|Yes/No|Free|Free|Are calls to this B-number free of charge ?|",
	`FTAM`	TINYINT(1) DEFAULT "0" COMMENT "logical|Yes/No|FTAM|FTAM|Send this b-number to FTAM configuration file|",
	`PNPCustNum`	INT DEFAULT "0" NOT NULL COMMENT "integer|>>>>>>>>>9|Customer|Customer|Customer's number, 1 ... 999999|",
	`RateBDest`	CHAR(25) COMMENT "character|X(25)|Rating Destination|RateBDest|Rating B-destination|",
	`ToDate`	DATE COMMENT "date|99-99-99|Valid To|To|Last effective day|",
	PRIMARY KEY	(`Brand`,`PNPCustNum`,`BDest`),
## The PROGRESS database primary index
	KEY	`BDest` (
				`Brand`,
				`PNPCustNum`,
				`BDest`),
	KEY	`BDName` (
				`Brand`,
				`BDName`,
				`BDest`),
	KEY	`CCN` (
				`Brand`,
				`CCN`,
				`BDName`,
				`BDest`),
	KEY	`DestType` (
				`Brand`,
				`PNPCustNum`,
				`BDest`,
				`DestType`),
	KEY	`ws-bsub` (
				`Brand`,
				`BDest`))
	COMMENT = "B-Destinations";
DROP TABLE IF EXISTS `rating_BDestRule`;
CREATE TABLE `rating_BDestRule`(
	`Clitype`	CHAR(8) COMMENT "character|x(8)|CLI Type|CLIType||",
	`Prior`	INT DEFAULT "0" COMMENT "integer|>>9|?|Prior|Rule Prior|Rule",
	`RuleName`	CHAR(20) COMMENT "character|x(20)|?|RuleName|Name of Rule|",
	`RuleType`	INT DEFAULT "0" COMMENT "integer|9|Rule Type|Type|Bdest rule type|",
	PRIMARY KEY	(`Clitype`,`Prior`),
## The PROGRESS database primary index
	KEY	`CliType` (
				`Clitype`,
				`Prior`))
	COMMENT = "?";
DROP TABLE IF EXISTS `rating_BillTarget`;
CREATE TABLE `rating_BillTarget`(
	`BillTarget`	INT DEFAULT "0" COMMENT "integer|>9|Billing Target|BT|No. for customer's billing target|",
	`CustNum`	INT DEFAULT "0" NOT NULL COMMENT "integer|>>>>>>>>9|Customer|Customer|Customer Number|",
	`RatePlan`	CHAR(12) COMMENT "character|x(12)|Rating Plan|RatePlan|Rating plan code|",
	PRIMARY KEY	(`CustNum`,`BillTarget`),
## The PROGRESS database primary index
	KEY	`CustNum` (
				`CustNum`,
				`BillTarget`))
	COMMENT = "Customer's Billing Target";
DROP TABLE IF EXISTS `rating_CCN`;
CREATE TABLE `rating_CCN`(
	`Brand`	CHAR(8) COMMENT "character|x(8)|Brand|Brand|Code Of Brand|",
	`CCN`	INT DEFAULT "0" NOT NULL COMMENT "integer|zz9|CCN|CCN|Call Case Number (CCN)|",
	`CCNName`	CHAR(30) COMMENT "character|x(30)|Name|Name|Name of CCN|",
	`RepCCN`	INT DEFAULT "0" NOT NULL COMMENT "integer|zz9|Reporting CCN|RepCCN|Reporting CCN|",
	PRIMARY KEY	(`Brand`,`CCN`),
## The PROGRESS database primary index
	KEY	`CCN` (
				`Brand`,
				`CCN`),
	KEY	`CCNName` (
				`Brand`,
				`CCNName`),
	KEY	`RepCCN` (
				`Brand`,
				`RepCCN`,
				`CCN`))
	COMMENT = "CCN";
DROP TABLE IF EXISTS `rating_CDRStreamCounter`;
CREATE TABLE `rating_CDRStreamCounter`(
	`Brand`	CHAR(8) COMMENT "character|x(8)|Brand|?|Code of brand|",
	`CDRQty`	INT DEFAULT "0" COMMENT "integer|>>>>>>>>>9|Quantity|Qty|CDR quantity|",
	`CounterType`	CHAR(8) COMMENT "character|x(8)|Counter Type|Type|Counter type|",
	`DataAmt`	DECIMAL DEFAULT "0" COMMENT "decimal|>>>>>>>>>>>9|DataAmt|DataAmt|DataAmt|",
	`ImportDate`	DATE COMMENT "date|99-99-99|Import Date|Import|Import date|",
	`MSCID`	CHAR(8) COMMENT "character|x(8)|MSCID|?|Mobile switching center|",
	`OnlineStream`	INT DEFAULT "0" COMMENT "integer|>>9|Online Stream|Stream|Stream from which CDR was read|",
	`Second`	DECIMAL DEFAULT "0" COMMENT "decimal|>>>>>>>>>>>9|Second|sec|Seconds|",
	PRIMARY KEY	(`Brand`,`ImportDate`,`CounterType`,`MSCID`,`OnlineStream`),
## The PROGRESS database primary index
	KEY	`ImportDate` (
				`Brand`,
				`ImportDate`,
				`CounterType`,
				`MSCID`,
				`OnlineStream`))
	COMMENT = "CDR Stream Counter";
DROP TABLE IF EXISTS `rating_CSVHeader`;
CREATE TABLE `rating_CSVHeader`(
	`CSV`	CHAR(8) COMMENT "character|x(8)|CSV|CSV||",
	`Version`	CHAR(6) COMMENT "character|x(6)|Version|Version||",
	PRIMARY KEY	(`Version`),
## The PROGRESS database primary index
	KEY	`Version` (
				`Version`))
	COMMENT = "?";
DROP TABLE IF EXISTS `rating_DBConf`;
CREATE TABLE `rating_DBConf`(
	`DBSeq`	INT DEFAULT "0" COMMENT "integer|>>>>9|DBSeq|DBSeq||",
	`FromDate`	DATE COMMENT "date|99.99.99|FromDate|FromDate||",
	`Hostname`	CHAR(12) COMMENT "character|x(12)|Hostname|Hostname|Hostname of db server|",
	`Name`	CHAR(12) COMMENT "character|x(12)|Name|Name||",
	`Path`	CHAR(30) COMMENT "character|x(30)|Path|Path||",
	`State`	INT DEFAULT "0" COMMENT "integer|9|State|State|State of database|",
	`TableName`	CHAR(12) COMMENT "character|x(12)|TableName|TableName||",
	`ToDate`	DATE COMMENT "date|99.99.99|ToDate|ToDate||",
	PRIMARY KEY	(`DBSeq`),
## The PROGRESS database primary index
	KEY	`DBSeq` (
				`DBSeq`))
	COMMENT = "?";
DROP TABLE IF EXISTS `rating_DialType`;
CREATE TABLE `rating_DialType`(
	`DialType`	INT DEFAULT "0" COMMENT "integer|>>9|Dialling Type|DT|Dialling type code|",
	`DTName`	CHAR(30) COMMENT "character|x(30)|Name|?|Name for dialling type|",
	PRIMARY KEY	(`DialType`),
## The PROGRESS database primary index
	KEY	`DialType` (
				`DialType`),
	KEY	`DTName` (
				`DTName`))
	COMMENT = "Dialling Type
Dialling Type";
DROP TABLE IF EXISTS `rating_DtlSeq`;
CREATE TABLE `rating_DtlSeq`(
	`SeqDate`	DATE COMMENT "date|99.99.99|Date|Date|Date|",
	`SeqStream`	INT DEFAULT "0" COMMENT "integer|>9|Stream|?|Stream|",
	`SeqVal`	INT DEFAULT "0" COMMENT "integer|99999999|Value|?|Value|",
	PRIMARY KEY	(`SeqDate`,`SeqStream`),
## The PROGRESS database primary index
	KEY	`SeqDate` (
				`SeqDate`,
				`SeqStream`))
	COMMENT = "?";
DROP TABLE IF EXISTS `rating_EDRHistory`;
CREATE TABLE `rating_EDRHistory`(
	`Amount`	DECIMAL DEFAULT "0" COMMENT "decimal|>>>>>>9.99|Amount|Amt|Amount|",
	`BDest`	CHAR(16) COMMENT "character|x(16)|B-Destination|BDest|B-Destination|",
	`BillCode`	CHAR(16) COMMENT "character|x(16)|Billing Item|BillItem|Billing item|",
	`CCN`	INT DEFAULT "0" COMMENT "integer|zz9|CCN|CCN|Consecutive country/service number of call's  destination|",
	`CLI`	CHAR(12) COMMENT "character|x(12)|MSISDN|MSISDN|MSISDN|",
	`CLIType`	CHAR(12) COMMENT "character|x(12)|CLIType|CLIType|Code of Subscription Type|",
	`DateSt`	DATE COMMENT "date|99-99-99|Event Date|Date|Event date|",
	`DCEvent`	CHAR(12) COMMENT "character|x(12)|Rating Package|Package|Rating package (periodical contract)|",
	`DtlSeq`	INT DEFAULT "0" COMMENT "integer|>>>>>>9|Stream Sequence|Stream Seq.|Daily stream sequence|",
	`ErrorCode`	INT DEFAULT "0" COMMENT "integer|>>>>9|Error Code|Error|Error code|",
	`InvCust`	INT DEFAULT "0" COMMENT "integer|>>>>>>>9|Invoice Customer|Customer|Invoice customer|",
	`MsSeq`	INT DEFAULT "0" COMMENT "integer|>>>>>>>9|Subscription ID|Subscr.ID|Subscription ID|",
	`TariffNum`	INT DEFAULT "0" COMMENT "integer|>>>>>>>>>9|Tariff ID|Tariff|Tariff ID|",
	`TimeStart`	INT DEFAULT "0" COMMENT "integer|>>>>9|Start Time|Time|Starting time|",
	`UpdateDate`	DATE COMMENT "date|99-99-99|Update Date|Upd.Date|Update date|",
	`UpdateSource`	CHAR(20) COMMENT "character|x(20)|Update Source|Source|Source of update|",
	`UpdateTime`	INT DEFAULT "0" COMMENT "integer|>>>>9|Update Time|Upd.Time|Update time|",
	PRIMARY KEY	(`CLI`,`DateSt`,`TimeStart`),
## The PROGRESS database primary index
	KEY	`CLI` (
				`CLI`,
				`DateSt`,
				`TimeStart`),
	KEY	`InvCust` (
				`InvCust`,
				`DateSt`),
	KEY	`MsSeq` (
				`MsSeq`,
				`DateSt`,
				`TimeStart`),
	KEY	`UpdateDate` (
				`UpdateDate`,
				`UpdateTime`))
	COMMENT = "";
DROP TABLE IF EXISTS `rating_MobError`;
CREATE TABLE `rating_MobError`(
	`MEName`	CHAR(60) COMMENT "character|x(60)|Explanation|Explanation|Explanation (name) of an Error Code|",
	`MobError`	INT DEFAULT "0" COMMENT "integer|zzz9|Error Code|Error Code|Error Code 1 ... 9999|",
	`TableName`	CHAR(16) COMMENT "character|x(16)|TargetDB|TargetDB|Target Of EDR|",
	PRIMARY KEY	(`MobError`),
	KEY	`MEName` (
				`MEName`,
				`MobError`),
## The PROGRESS database primary index
	KEY	`MobError` (
				`MobError`))
	COMMENT = "";
DROP TABLE IF EXISTS `rating_PListConf`;
CREATE TABLE `rating_PListConf`(
	`Brand`	CHAR(8) COMMENT "character|x(8)|Brand|Brand|Code Of Brand|",
	`dFrom`	DATE COMMENT "date|99-99-99|DateFrom|DateFrom|FROM date for price list validation|",
	`dTo`	DATE COMMENT "date|99-99-99|DateTo|DateTo|TO date for price list validation|",
	`PriceList`	CHAR(8) COMMENT "character|x(8)|Plist|Plist|Code (identifier) for a Price List|",
	`Prior`	INT DEFAULT "0" COMMENT "integer|>9|Priority|Priority|Priority for simultaneous price list|",
	`RatePlan`	CHAR(8) COMMENT "character|x(8)|Rating Plan|RatePlan|Rating plan code|",
	`StartCharge`	TINYINT(1) DEFAULT "1" COMMENT "logical|A/P|Start charge|Start charge|Allow / Prohibit starting charges (A/P)|",
	PRIMARY KEY	(`Brand`,`RatePlan`,`dFrom`,`dTo`,`Prior`),
	KEY	`Browse` (
				`Brand`,
				`RatePlan`,
				`dFrom`,
				`dTo`,
				`Prior`),
## The PROGRESS database primary index
	KEY	`RatePlan` (
				`Brand`,
				`RatePlan`,
				`dFrom`,
				`dTo`,
				`Prior`))
	COMMENT = "Price configuration";
DROP TABLE IF EXISTS `rating_PLMN`;
CREATE TABLE `rating_PLMN`(
	`CommName`	CHAR(16) COMMENT "character|x(16)|CommName|CommName|Commercial Name|",
	`CoName`	CHAR(30) COMMENT "character|x(30)|Name of Country|Name of Country|Name of Country|",
	`Country`	CHAR(3) COMMENT "character|xxx|Country|CCode|Country Code (according to ISO Standard)|",
	`CountryPrefix`	CHAR(6) COMMENT "character|x(6)|Country Prefix|Prefix|Country prefix|",
	`PLMN`	CHAR(8) COMMENT "character|x(8)|PLMN|PLMN|Code of PLMN|",
	`PrefToNor`	CHAR(8) COMMENT "character|x(8)|PrefixToNorway|PrefixToNorway|Prefix to Norway|",
	PRIMARY KEY	(`PLMN`,`Country`),
	KEY	`Country` (
				`Country`),
	KEY	`CountryPrefix` (
				`CountryPrefix`),
## The PROGRESS database primary index
	KEY	`plmn` (
				`PLMN`,
				`Country`))
	COMMENT = "PLMN";
DROP TABLE IF EXISTS `rating_PriceList`;
CREATE TABLE `rating_PriceList`(
	`Brand`	CHAR(8) COMMENT "character|x(8)|Brand|Brand|Code Of Brand|",
	`Currency`	CHAR(3) COMMENT "character|x(3)|Currency|Currency|Price List's currency code|",
	`CurrUnit`	TINYINT(1) DEFAULT "1" COMMENT "logical|Full/Sub|CurrUnit|CurrUnit|Currency FULL (1) or SUB (1/100)|",
	`CustNum`	INT DEFAULT "0" COMMENT "integer|>>>>>>>>>9|CustNum|CustNum|Customer number|",
	`DedicList`	TINYINT(1) DEFAULT "0" COMMENT "logical|Dedicated/General|Dedicated Pricelist|Dedicated|Type of price list; general or dedicated to certain customers|",
	`InclVAT`	TINYINT(1) DEFAULT "1" COMMENT "logical|Incl/Excl|VAT|VAT|Is VAT Included/Excluded in tariffs|",
	`Memo`	CHAR(60) COMMENT "character|x(60)|Memo|Memo|Memo|",
	`PLName`	CHAR(30) COMMENT "character|x(30)|Name|Name|Name of a Price List|",
	`Prefix`	CHAR(5) COMMENT "character|x(5)|Prefix|Prefix|Operator prefix where price list is attached to|",
	`PriceList`	CHAR(8) COMMENT "character|x(8)|Plist|Plist|Code (identifier) for a Price List|",
	`Rounding`	INT DEFAULT "2" COMMENT "integer|9|Decimals|Decimals|How many decimals will be used for call prices|",
	PRIMARY KEY	(`Brand`,`PriceList`,`CustNum`),
	KEY	`DedicList` (
				`Brand`,
				`DedicList`,
				`PriceList`),
	KEY	`DedicName` (
				`Brand`,
				`DedicList`,
				`PLName`),
	KEY	`PLName` (
				`Brand`,
				`PLName`,
				`PriceList`),
## The PROGRESS database primary index
	KEY	`PriceList` (
				`Brand`,
				`PriceList`,
				`CustNum`))
	COMMENT = "Price list header";
DROP TABLE IF EXISTS `rating_RatePlan`;
CREATE TABLE `rating_RatePlan`(
	`Brand`	CHAR(8) COMMENT "character|x(8)|Brand|Brand|Code Of Brand|",
	`RatePlan`	CHAR(12) COMMENT "character|x(12)|Rating Plan|RatePlan|Rating plan code|",
	`RPName`	CHAR(30) COMMENT "character|x(30)|Name|?|Name of rating plan|",
	PRIMARY KEY	(`Brand`,`RatePlan`),
## The PROGRESS database primary index
	KEY	`RatePlan` (
				`Brand`,
				`RatePlan`),
	KEY	`RPName` (
				`Brand`,
				`RPName`))
	COMMENT = "Rating plan for invoice target";
DROP TABLE IF EXISTS `rating_RerateLog`;
CREATE TABLE `rating_RerateLog`(
	`ChangedQty`	INT DEFAULT "0" COMMENT "integer|>>>>>>>9|Changed Qty|Changed|Quantity of changed records|",
	`CLI`	CHAR(12) COMMENT "character|x(12)|MSISDN|MSISDN|MSISDN|",
	`Ended`	DECIMAL DEFAULT "0" COMMENT "decimal|99999999.99999|Ended|Ended|End time for rerate|",
	`ErrorCode`	INT DEFAULT "0" COMMENT "integer|>>>>9|Error Code|Error|Error code|",
	`EventSource`	CHAR(12) COMMENT "character|x(12)|Source|Source|Source of the rerate|",
	`InvCust`	INT DEFAULT "0" COMMENT "integer|>>>>>>>9|Invoice Customer|Customer|Invoice customer|",
	`MsSeq`	INT DEFAULT "0" COMMENT "integer|>>>>>>>9|Subscription ID|Subscr.ID|Subscription ID|",
	`PeriodBegin`	DATE COMMENT "date|99-99-9999|Period Begin|Begin|Begin date for period|",
	`PeriodEnd`	DATE COMMENT "date|99-99-9999|Period End|End|End date for period|",
	`StartDate`	DATE COMMENT "date|99-99-99|Start Date|Started|Starting date|",
	`Started`	DECIMAL DEFAULT "0" COMMENT "decimal|99999999.99999|Started|?|Start time for rerate|",
	PRIMARY KEY	(`InvCust`,`StartDate`),
	KEY	`CLI` (
				`CLI`,
				`StartDate`),
## The PROGRESS database primary index
	KEY	`InvCust` (
				`InvCust`,
				`StartDate`),
	KEY	`MsSeq` (
				`MsSeq`,
				`StartDate`),
	KEY	`StartDate` (
				`StartDate`,
				`Started`))
	COMMENT = "Rerate action log";
DROP TABLE IF EXISTS `rating_RoamZone`;
CREATE TABLE `rating_RoamZone`(
	`RoamZone`	CHAR(12) COMMENT "character|x(12)|RoamZone|RoamZone|RoamZone|",
	`RZName`	CHAR(8) COMMENT "character|x(8)|RoamZone Name|RoamZone Name|Name of RoamZone|",
	PRIMARY KEY	(`RoamZone`),
## The PROGRESS database primary index
	KEY	`RoamZone` (
				`RoamZone`))
	COMMENT = "Roaming Zone";
DROP TABLE IF EXISTS `rating_RZBDest`;
CREATE TABLE `rating_RZBDest`(
	`BDest`	CHAR(15) NOT NULL COMMENT "character|x(15)|?|BDest|B-Destination|",
	`RoamZone`	CHAR(12) COMMENT "character|x(12)|?|RoamZone||",
	`RoamZone2`	CHAR(12) COMMENT "character|x(12)|RoamZone|RoamZone||",
	`ValidFrom`	DATE COMMENT "date|99-99-99|Valid From|Valid From|The date FROM which this RZBdest will be used.|",
	`ValidTo`	DATE COMMENT "date|99-99-99|Valid To|Valid To|The date TO (until) which this RZBdest will be used.|",
	PRIMARY KEY	(`RoamZone`,`RoamZone2`,`ValidTo`),
	KEY	`Bdest` (
				`BDest`,
				`ValidTo`),
## The PROGRESS database primary index
	KEY	`RoamZone` (
				`RoamZone`,
				`RoamZone2`,
				`ValidTo`))
	COMMENT = "?";
DROP TABLE IF EXISTS `rating_ServiceLimit`;
CREATE TABLE `rating_ServiceLimit`(
	`DialType`	INT DEFAULT "0" COMMENT "integer|>>9|Dialling Type|DT|Dialling type code|",
	`ForeignKey`	DECIMAL DEFAULT "0" COMMENT "decimal|9999999999999999|?|ForeignKey|ForeignKey from another system|",
	`GroupCode`	CHAR(16) COMMENT "character|x(16)|GroupCode|Group Code|Group Code of Servicelimit|",
	`InclAmt`	DECIMAL DEFAULT "0" COMMENT "decimal|->>>>>9.99|Included Amount|Incl.Amt|Amount of billable material that is included in this fee|",
	`InclUnit`	INT DEFAULT "0" COMMENT "integer|>9|Included Unit|Incl.Unit|Unit of included material|",
	`ReportType`	INT DEFAULT "1" COMMENT "integer|9|Report Type|RT|Reporting type|",
	`SLCode`	CHAR(12) COMMENT "character|x(12)|ServiceLimit|ServiceLimit|Code of Servicelimit|",
	`SLName`	CHAR(30) COMMENT "character|x(30)|Servicelimit Name|Servicelimit Name|Name of Service limit|",
	`SLSeq`	INT DEFAULT "0" COMMENT "integer|>>>>>>9|SLSeq|SLseq|Sequence for Servicelimit|",
	`ValidFrom`	DATE COMMENT "date|99-99-99|Valid From|?|Valid from this date on|",
	`ValidTo`	DATE COMMENT "date|99-99-99|Valid To|?|Valid until this date|",
	`WebDisp`	INT DEFAULT "1" COMMENT "integer|9|Web|Web|Web|",
	PRIMARY KEY	(`GroupCode`),
	KEY	`ForeignKey` (
				`ForeignKey`),
## The PROGRESS database primary index
	KEY	`GroupCode` (
				`GroupCode`),
	KEY	`SLSeq` (
				`SLSeq`))
	COMMENT = "?";
DROP TABLE IF EXISTS `rating_ServiceLimitGroup`;
CREATE TABLE `rating_ServiceLimitGroup`(
	`Brand`	CHAR(8) COMMENT "character|x(8)|Brand|Brand|Code Of Brand|",
	`GroupCode`	CHAR(16) COMMENT "character|x(16)|GroupCode|Group Code|Group Code of Servicelimit|",
	`GroupName`	CHAR(30) COMMENT "character|x(30)|Group Name|Group Name|Name of Servicelimit Group|",
	`ValidFrom`	DATE COMMENT "date|99-99-99|Valid From|Valid From|The date FROM which this servicelimit group will be used.|",
	`ValidTo`	DATE COMMENT "date|99-99-99|Valid To|Valid To|The date TO (until) which this Servicelimit group will be used.|",
	PRIMARY KEY	(`Brand`,`GroupCode`),
## The PROGRESS database primary index
	KEY	`GroupCode` (
				`Brand`,
				`GroupCode`),
	KEY	`GroupName` (
				`Brand`,
				`GroupName`))
	COMMENT = "";
DROP TABLE IF EXISTS `rating_ServiceLimitTarget`;
CREATE TABLE `rating_ServiceLimitTarget`(
	`InsideRate`	CHAR(8) COMMENT "character|x(8)|LimitRate|LimitRate|Rate-key when belongs to group|",
	`OutsideRate`	CHAR(8) COMMENT "character|x(8)|OutsideRate|OutsideRate|Rate-key when limit is full|",
	`ServiceLMember`	CHAR(16) COMMENT "character|x(16)|ServiceLimit Member|ServiceLimit Member|Momber of Service Limit|",
	`SLSeq`	INT DEFAULT "0" COMMENT "integer|>>>>>>9|SLSeq|SLseq|Sequence for Servicelimit|",
	PRIMARY KEY	(`SLSeq`,`ServiceLMember`),
## The PROGRESS database primary index
	KEY	`SLSeq` (
				`SLSeq`,
				`ServiceLMember`))
	COMMENT = "?";
DROP TABLE IF EXISTS `rating_SLGAnalyse`;
CREATE TABLE `rating_SLGAnalyse`(
	`BDest`	CHAR(16) COMMENT "character|x(16)|B-subNo|B-subNo|B-subscriber/destination|",
	`BelongTo`	TINYINT(1) DEFAULT "1" COMMENT "logical|+/-|BelongTo|BelongTo|Belong to ServicelimitGroup|",
	`BillCode`	CHAR(16) COMMENT "character|x(16)|Billing Item|BillCode|Billing item code, max 16 characters|",
	`Brand`	CHAR(8) COMMENT "character|x(8)|Brand|Brand|Code Of Brand|",
	`CCN`	INT DEFAULT "0" COMMENT "integer|>>9|CCN|CCN|CCN|",
	`Clitype`	CHAR(8) COMMENT "character|x(8)|CLI Type|CLIType|CLI Type|",
	`Prior`	INT DEFAULT "0" COMMENT "integer|>>9|Prior|Priority|Priority|",
	`ServiceLimitGroup`	CHAR(16) COMMENT "character|x(16)|ServiceLimit Group|ServiceLimitGroup|ServiceLimitGroup|",
	`SLGAType`	INT DEFAULT "0" COMMENT "integer|9|Type|Type|Service type|",
	`ValidFrom`	DATE COMMENT "date|99-99-9999|Valid From|Valid From|The date FROM which this SLG analyse will be used.|",
	`ValidTo`	DATE COMMENT "date|99-99-9999|Valid To|Valid To|The date TO which this SLG analyse will be used.|",
	PRIMARY KEY	(`Brand`,`BillCode`,`Clitype`,`ValidTo`),
	KEY	`BelongTo` (
				`Brand`,
				`BelongTo`,
				`Clitype`,
				`BillCode`,
				`CCN`,
				`BDest`,
				`Prior`,
				`ValidTo`),
## The PROGRESS database primary index
	KEY	`BillCode` (
				`Brand`,
				`BillCode`,
				`Clitype`,
				`ValidTo`),
	KEY	`CliType` (
				`Brand`,
				`Clitype`,
				`BillCode`,
				`ValidTo`),
	KEY	`ServiceLimitGroup` (
				`Brand`,
				`ServiceLimitGroup`,
				`Clitype`,
				`ValidTo`))
	COMMENT = "?";
DROP TABLE IF EXISTS `rating_Tariff`;
CREATE TABLE `rating_Tariff`(
	`BDest`	CHAR(16) NOT NULL COMMENT "character|x(16)|B-subNo|B-subNo|B-subscriber/destination|",
	`BillCode`	CHAR(16) NOT NULL COMMENT "character|x(16)|Billing Item|BillItem|Billing item code|",
	`Brand`	CHAR(8) COMMENT "character|x(8)|Brand|Brand|Code Of Brand|",
	`CCN`	INT DEFAULT "0" NOT NULL COMMENT "integer|zz9|CCN|CCN|Call case number|",
	`CurrUnit`	TINYINT(1) DEFAULT "1" COMMENT "logical|Full/Sub|CurrUnit|CurrUnit|Currency FULL (1) or SUB (1/100)|",
	`CustNum`	INT DEFAULT "0" COMMENT "integer|>>>>>>>>9|Customer|Customer|Customer number|",
	`DataType`	INT DEFAULT "0" COMMENT "integer|>>9|Data Type|Data Type|Data type for tariff|",
	`DayType[2]`	INT DEFAULT "0" COMMENT "integer|9|DayType|DayType|Day type: 1) WeekDay, 2) WeekEnd, 3) National holiday|",
	`DayType[3]`	INT DEFAULT "0" COMMENT "integer|9|DayType|DayType|Day type: 1) WeekDay, 2) WeekEnd, 3) National holiday|",
	`DayType[4]`	INT DEFAULT "0" COMMENT "integer|9|DayType|DayType|Day type: 1) WeekDay, 2) WeekEnd, 3) National holiday|",
	`DayType[5]`	INT DEFAULT "0" COMMENT "integer|9|DayType|DayType|Day type: 1) WeekDay, 2) WeekEnd, 3) National holiday|",
	`Discount[4]`	TINYINT(1) DEFAULT "0" COMMENT "logical|Yes/No|Discnt|Disc|Shall discounts be applied to this rate|1= direct discount allowed
2= volume discount allowed
3= absolute price
4= minimum seconds or starting fee
6= price per minute or second",
	`MinSec`	INT DEFAULT "0" COMMENT "integer|zzz9|Min.sec|Min.sec|Minimum amt of charged seconds|",
	`Price[1]`	DECIMAL DEFAULT "0" COMMENT "decimal|zz9.99999|Rate|Rate|Rate: 1/100 per sec (ENTER)  or 1/1 per min (HOME)|",
	`Price[2]`	DECIMAL DEFAULT "0" COMMENT "decimal|zz9.99999|Rate|Rate|Rate: 1/100 per sec (ENTER)  or 1/1 per min (HOME)|",
	`Price[3]`	DECIMAL DEFAULT "0" COMMENT "decimal|zz9.99999|Rate|Rate|Rate: 1/100 per sec (ENTER)  or 1/1 per min (HOME)|",
	`Price[4]`	DECIMAL DEFAULT "0" COMMENT "decimal|zz9.99999|Rate|Rate|Rate: 1/100 per sec (ENTER)  or 1/1 per min (HOME)|",
	`Price[5]`	DECIMAL DEFAULT "0" COMMENT "decimal|zz9.99999|Rate|Rate|Rate: 1/100 per sec (ENTER)  or 1/1 per min (HOME)|",
	`PriceList`	CHAR(8) COMMENT "character|x(8)|Price List|Price List|Code (identifier) for a Price List|",
	`RateType`	INT DEFAULT "1" COMMENT "integer|99|Type|Type|RATE TYPE: how many seconds is one rating unit|",
	`StartCharge[1]`	DECIMAL DEFAULT "0" COMMENT "decimal|zzz9.999|St.charge|St.charge|Starting charge for each time zone|",
	`StartCharge[2]`	DECIMAL DEFAULT "0" COMMENT "decimal|zzz9.999|St.charge|St.charge|Starting charge for each time zone|",
	`StartCharge[3]`	DECIMAL DEFAULT "0" COMMENT "decimal|zzz9.999|St.charge|St.charge|Starting charge for each time zone|",
	`StartCharge[4]`	DECIMAL DEFAULT "0" COMMENT "decimal|zzz9.999|St.charge|St.charge|Starting charge for each time zone|",
	`StartCharge[5]`	DECIMAL DEFAULT "0" COMMENT "decimal|zzz9.999|St.charge|St.charge|Starting charge for each time zone|",
	`TariffNum`	INT DEFAULT "0" COMMENT "integer|>>>>>9|rowid|rowid|Consecutive row identification number|",
	`TariffType`	INT DEFAULT "1" COMMENT "integer|>>9|TariffType|TariffType|Tariff type for browsing windows and analysis|",
	`TZFrom[2]`	CHAR(5) DEFAULT "00:00" COMMENT "character|99:99|Time From|Tfrom|Time from which the rate is valid|",
	`TZFrom[3]`	CHAR(5) DEFAULT "00:00" COMMENT "character|99:99|Time From|Tfrom|Time from which the rate is valid|",
	`TZName[1]`	CHAR(30) COMMENT "character|X(30)|Timezone|?|Description for the timezone|",
	`TZName[2]`	CHAR(30) COMMENT "character|X(30)|Timezone|?|Description for the timezone|",
	`TZName[3]`	CHAR(30) COMMENT "character|X(30)|Timezone|?|Description for the timezone|",
	`TZName[4]`	CHAR(30) COMMENT "character|X(30)|Timezone|?|Description for the timezone|",
	`TZName[5]`	CHAR(30) COMMENT "character|X(30)|Timezone|?|Description for the timezone|",
	`TZTo[1]`	CHAR(5) DEFAULT "00:00" COMMENT "character|99:99|Time To|Tto|Time till which the rate is valid|",
	`TZTo[2]`	CHAR(5) DEFAULT "00:00" COMMENT "character|99:99|Time To|Tto|Time till which the rate is valid|",
	`TZTo[3]`	CHAR(5) DEFAULT "00:00" COMMENT "character|99:99|Time To|Tto|Time till which the rate is valid|",
	`TZTo[4]`	CHAR(5) DEFAULT "00:00" COMMENT "character|99:99|Time To|Tto|Time till which the rate is valid|",
	`TZTo[5]`	CHAR(5) DEFAULT "00:00" COMMENT "character|99:99|Time To|Tto|Time till which the rate is valid|",
	`ValidFrom`	DATE COMMENT "date|99-99-99|Valid From|Valid From|The date FROM which this price will be used.|",
	`ValidTo`	DATE COMMENT "date|99-99-99|Valid To|Valid To|The date TO (until) which this price will be used.|",
	PRIMARY KEY	(`Brand`,`CCN`,`PriceList`,`BDest`,`ValidFrom`,`ValidTo`),
## The PROGRESS database primary index
	KEY	`CCN` (
				`Brand`,
				`CCN`,
				`PriceList`,
				`BDest`,
				`ValidFrom`,
				`ValidTo`),
	KEY	`CCNCust` (
				`Brand`,
				`CCN`,
				`CustNum`,
				`BDest`,
				`ValidFrom`),
	KEY	`CustNum` (
				`Brand`,
				`CustNum`,
				`CCN`,
				`ValidFrom`,
				`ValidTo`,
				`BDest`),
	KEY	`CustNum_s` (
				`CustNum`,
				`CCN`,
				`ValidFrom`,
				`ValidTo`,
				`BDest`),
	KEY	`PriceList` (
				`Brand`,
				`PriceList`,
				`CCN`,
				`BDest`,
				`ValidFrom`),
	KEY	`TariffNum` (
				`Brand`,
				`TariffNum`),
	KEY	`TariffType` (
				`Brand`,
				`TariffType`))
	COMMENT = "B-number tariffs, either general or customer depended";
DROP TABLE IF EXISTS `rating_TCC`;
CREATE TABLE `rating_TCC`(
	`BCCN`	INT DEFAULT "0" NOT NULL COMMENT "integer|zzzz9|?|BCCN|Billing Call Case Number (BCCN)|",
	`BDest`	CHAR(16) COMMENT "character|x(16)|B-Destination|B-Dest|B-Destination|",
	`Brand`	CHAR(8) COMMENT "character|x(8)|Brand|Brand|Code of brand|",
	`DialType`	INT DEFAULT "0" COMMENT "integer|>>>9|Dialling Type|DT|Dialling type code|",
	`DurTo`	INT DEFAULT "0" COMMENT "integer|>>>>>>9|Duration To|Dur.To|Duration to|",
	`ErrorCode`	INT DEFAULT "0" COMMENT "integer|>>>9|Error Code|Error|Error code|",
	`GsmBnr`	CHAR(16) COMMENT "character|x(16)|B-Number|B-Nbr|B-number|",
	`Pulses`	INT DEFAULT "0" COMMENT "integer|zz9|Pulses|Pulses|Pulses|",
	`TariffRule`	INT DEFAULT "0" COMMENT "integer|9|Tariff Rule|TR|Pricing method|",
	`TCC`	INT DEFAULT "0" NOT NULL COMMENT "integer|zzzz9|Technical Call Case|TCC|Technical call case number (TCC)|",
	`TCCName`	CHAR(30) COMMENT "character|x(30)|Name|Name|Name|",
	`TCCPayer`	INT DEFAULT "0" COMMENT "integer|zz9|TCC Payer|Payer|Payer; Where to find payer/owner information|",
	`TCCRule`	INT DEFAULT "0" COMMENT "integer|zz9|TCC Rule|Rule|Technical rule for TCC|",
	`TrafficType`	INT DEFAULT "0" COMMENT "integer|9|Traffic Type|Traffic Type|Traffic type|",
	`ValidFrom`	DATE COMMENT "date|99-99-99|Valid From|From|Effective from|",
	`ValidTo`	DATE COMMENT "date|99-99-99|Valid To|To|Effective until|",
	PRIMARY KEY	(`Brand`,`TCC`,`DurTo`),
	KEY	`BCCN` (
				`Brand`,
				`BCCN`,
				`ValidTo`),
	KEY	`DialType` (
				`Brand`,
				`DialType`,
				`ErrorCode`),
## The PROGRESS database primary index
	KEY	`TCC` (
				`Brand`,
				`TCC`,
				`DurTo`),
	KEY	`TCCName` (
				`Brand`,
				`TCCName`))
	COMMENT = "Technical CCN";
DROP TABLE IF EXISTS `rating_TCCBarr`;
CREATE TABLE `rating_TCCBarr`(
	`ErrorCode`	INT DEFAULT "0" NOT NULL COMMENT "integer|zzzz9|TCC|ErrorCode|Errorcode|",
	`GsmBnr`	CHAR(30) COMMENT "character|x(30)|Gsmbnr|Gsmbnr||",
	`TCC`	INT DEFAULT "0" NOT NULL COMMENT "integer|zzzz9|?|TCC|Technical Call Case Number|",
	`TCCPName`	CHAR(30) COMMENT "character|x(30)|Name|Name|Name of TCC Parameter|",
	`ValidFrom`	DATE COMMENT "date|99-99-99|Valid From|Valid From|The date FROM which this TCCBarr will be used.|",
	`ValidTo`	DATE COMMENT "date|99-99-99|Valid To|Valid To|The date TO (until) which this TCCBarr will be used.|",
	PRIMARY KEY	(`TCC`,`GsmBnr`,`ValidTo`),
## The PROGRESS database primary index
	KEY	`TCC` (
				`TCC`,
				`GsmBnr`,
				`ValidTo`))
	COMMENT = "Technical CC Params";
DROP TABLE IF EXISTS `rating_TCCError`;
CREATE TABLE `rating_TCCError`(
	`ErrorCode`	INT DEFAULT "0" NOT NULL COMMENT "integer|zzzz9|TCC|Error Code|Error code|",
	`ErrorValue`	CHAR(30) COMMENT "character|x(30)|Value|Value|Value that triggers errorcode|",
	`TCC`	INT DEFAULT "0" NOT NULL COMMENT "integer|zzzz9|TCC|TCC|Technical Call Case Number|",
	`TCCPName`	CHAR(30) COMMENT "character|x(30)|Name|Name|Name of TCC Parameter|",
	`ValidFrom`	DATE COMMENT "date|99-99-99|Valid From|Valid From|The date from which this TCCError will be used.|",
	`ValidTo`	DATE COMMENT "date|99-99-99|Valid To|Valid To|The date to (until) which this TCCError will be used.|",
	`ValueType`	CHAR(30) COMMENT "character|x(30)|Value Type|Type|Type of the value that triggers errorcode|",
	PRIMARY KEY	(`TCC`,`ValueType`,`ErrorValue`,`ValidTo`),
## The PROGRESS database primary index
	KEY	`TCC` (
				`TCC`,
				`ValueType`,
				`ErrorValue`,
				`ValidTo`))
	COMMENT = "Technical CC Params";
DROP TABLE IF EXISTS `rating_TCCGroupItem`;
CREATE TABLE `rating_TCCGroupItem`(
	`TCC`	INT DEFAULT "0" NOT NULL COMMENT "integer|zzzz9|Technical Call Case|TCC|Technical call case number (TCC)|",
	`TCCGroupCode`	CHAR(10) NOT NULL COMMENT "character|x(10)|TCC GroupCode|TCCgroup|TCC groupcode|",
	`ValidFrom`	DATE COMMENT "date|99-99-99|Valid From|From|Effective from|",
	`ValidTo`	DATE COMMENT "date|99-99-99|Valid To|To|Effective until|",
	PRIMARY KEY	(`TCCGroupCode`,`TCC`,`ValidTo`),
	KEY	`TCC` (
				`TCC`,
				`ValidTo`),
## The PROGRESS database primary index
	KEY	`TCCGroupCode` (
				`TCCGroupCode`,
				`TCC`,
				`ValidTo`))
	COMMENT = "TCC Group";
DROP TABLE IF EXISTS `rating_TCCMPMLink`;
CREATE TABLE `rating_TCCMPMLink`(
	`BCC`	INT DEFAULT "0" NOT NULL COMMENT "integer|zzz9|Billing Call Case Number|?||",
	`Brand`	CHAR(8) NOT NULL COMMENT "character|X(8)|Brand code|?||",
	`TCC`	INT DEFAULT "0" NOT NULL COMMENT "integer|zzzz9|TCC|TCC|Technical Call Case number|",
	PRIMARY KEY	(`Brand`,`TCC`,`BCC`),
## The PROGRESS database primary index
	KEY	`tccbcc_p` (
				`Brand`,
				`TCC`,
				`BCC`))
	COMMENT = "This table has configuration details for Internation Calls Local charge (MPM)";
DROP TABLE IF EXISTS `rating_Telecompany`;
CREATE TABLE `rating_Telecompany`(
	`BDest`	CHAR(16) NOT NULL COMMENT "character|x(16)|B-Dest|B-Dest|B-subscriber/destination|",
	`TCCode`	CHAR(8) COMMENT "character|x(8)|?|TCCode|Telecompany code|",
	`TCName`	CHAR(30) COMMENT "character|x(30)|Telecompany Name|TeleCompanyName|Telecompany name|",
	PRIMARY KEY	(`TCCode`),
## The PROGRESS database primary index
	KEY	`TCCode` (
				`TCCode`))
	COMMENT = "?";
DROP TABLE IF EXISTS `rating_TriggerConf`;
CREATE TABLE `rating_TriggerConf`(
	`EventRule`	INT DEFAULT "0" COMMENT "integer|9|Event rule|EventRule|TriggerEvent rule|",
	`Prior`	INT DEFAULT "0" COMMENT "integer|>9|Priority|Priority|Priority order of Trigger Configuration|",
	`TCName`	CHAR(20) COMMENT "character|x(20)|TriggerConf Name|TriggerConf Name||",
	`TriggerConfID`	CHAR(14) COMMENT "character|x(14)|TriggerConf|TriggerConf|Trigger Configuration code|",
	`ValidFrom`	DATE COMMENT "date|99-99-99|ValidFrom|ValidFrom|The date FROM which this TriggerConf will be used|",
	`ValidTo`	DATE COMMENT "date|99-99-99|ValidTo|ValidTo|The date TO which this Trigger Configuration will be used|",
	PRIMARY KEY	(`Prior`,`ValidTo`),
## The PROGRESS database primary index
	KEY	`Prior` (
				`Prior`,
				`ValidTo`),
	KEY	`TCName` (
				`TCName`,
				`ValidFrom`),
	KEY	`TriggerConfID` (
				`TriggerConfID`))
	COMMENT = "";
DROP TABLE IF EXISTS `rating_TriggerEvent`;
CREATE TABLE `rating_TriggerEvent`(
	`Activated`	DATETIME COMMENT "datetime|99-99-9999 HH:MM:SS.SSS|Activated|Activated|Event activated Date and Time|",
	`ChangedFields`	CHAR(40) COMMENT "character|x(40)|ChangedFields|ChangedField|All changed fields|",
	`ChangedValues`	CHAR(20) COMMENT "character|x(20)|ChangedValues|ChangedValues|Changed Values|",
	`Created`	DATETIME COMMENT "datetime|99-99-9999 HH:MM:SS.SSS|Created|Created|Event creation date and time|",
	`EventSource`	CHAR(12) COMMENT "character|x(12)|Activated|Activated|Name of the activation module|",
	`Handled`	DATETIME COMMENT "datetime|99-99-9999 HH:MM:SS.SSS|Handled|Handled|Event handled Date and Time|",
	`KeyValue`	CHAR(16) COMMENT "character|x(16)|Key Value|Key|Key value of the record related to the action|",
	`Reason`	CHAR(16) COMMENT "character|x(16)|Reason|Reason|Reason|",
	`StatusCode`	INT DEFAULT "0" COMMENT "integer|>9|StatusCode|StatusCode|Status of Trigger Event|",
	`TableID`	INT COMMENT "integer|>>>>>>>>>9|TableID|TableID|RecordID|",
	`TableName`	CHAR(15) COMMENT "character|X(15)|Table Name|Table|Table related to the action|",
	`TriggerConfID`	CHAR(14) COMMENT "character|x(14)|TriggerConf|TriggerConf|Trigger Configuration code|",
	`TriggerEventID`	INT DEFAULT "0" COMMENT "integer|>>>>>>>>9|TriggerEventID|TriggerEventID|Trigger EventID|",
	PRIMARY KEY	(`TriggerConfID`,`StatusCode`),
## The PROGRESS database primary index
	KEY	`TriggerConf` (
				`TriggerConfID`,
				`StatusCode`),
	KEY	`TriggerEventID` (
				`TriggerEventID`,
				`Created`))
	COMMENT = "Trigger event";
DROP TABLE IF EXISTS `rating_TriggerField`;
CREATE TABLE `rating_TriggerField`(
	`FieldName`	CHAR(14) COMMENT "character|x(14)|TriggerConf|TriggerConf|Trigger Configuration code|",
	`TableName`	CHAR(14) COMMENT "character|x(14)|TriggerConf|TriggerConf|Trigger Configuration code|",
	`TriggerConfID`	CHAR(14) COMMENT "character|x(14)|TriggerConf|TriggerConf|Trigger Configuration code|",
	PRIMARY KEY	(`TriggerConfID`),
## The PROGRESS database primary index
	KEY	`TriggerConfID` (
				`TriggerConfID`))
	COMMENT = "";
