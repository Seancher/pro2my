drop database if exists rbsall;
create database rbsall;
use rbsall;
DROP TABLE IF EXISTS `common_AckMessage`;
CREATE TABLE `common_AckMessage`(
	`AckResult`	CHAR(8) COMMENT "character|x(8)|Result|?|Response result|",
	`AckStatus`	INT DEFAULT "0" COMMENT "integer|9|Status|?|Response status|",
	`AckTarget`	CHAR(16) COMMENT "character|x(16)|Response Target|Target|Response target (external request ID)|",
	`AddInfo`	CHAR(30) COMMENT "character|x(30)|Additional Info|Info|Additional info|",
	`Created`	DATETIME COMMENT "datetime|99-99-9999 HH:MM:SS.SSS|Created|?|Response created|",
	`HostTable`	CHAR(16) COMMENT "character|x(16)|Host Table|Table|Host table|",
	`KeyValue`	CHAR(16) COMMENT "character|X(16)|Key Value|Key|Key value of the record|",
	`QueueName`	CHAR(20) COMMENT "character|x(20)|Queue|?|Response queue name|",
	`ResultDescription`	CHAR(30) COMMENT "character|x(30)|Result Description|Description|Result description (error message)|",
	PRIMARY KEY	(`HostTable`,`KeyValue`,`Created`),
	KEY	`AckStatus` (
				`AckStatus`,
				`Created`),
## The PROGRESS database primary index
	KEY	`HostTable` (
				`HostTable`,
				`KeyValue`,
				`Created`))
	COMMENT = "Ack messages";
DROP TABLE IF EXISTS `common_ActionLog`;
CREATE TABLE `common_ActionLog`(
	`ActionChar`	CHAR(8) COMMENT "character|x(8)|Character Value|Char|Character value|",
	`ActionDec`	DECIMAL DEFAULT "0" COMMENT "decimal|->>>>>>9.9999|Decimal Value|Dec|Decimal value|",
	`ActionID`	CHAR(8) COMMENT "character|x(8)|Action ID|ID|Action ID|",
	`ActionPeriod`	INT DEFAULT "0" COMMENT "integer|999999|Period|?|Period|",
	`ActionStatus`	INT DEFAULT "0" COMMENT "integer|>9|Status|?|Status|",
	`ActionTS`	DECIMAL DEFAULT "0" COMMENT "decimal|99999999.99999|Action Time Stamp|Time Stamp|Action time stamp|",
	`Brand`	CHAR(8) COMMENT "character|x(8)|Brand|?|Code Of Brand|",
	`CustNum`	INT DEFAULT "0" NOT NULL COMMENT "integer|>>>>>>>>9|Customer|Customer|Customer's number|",
	`FromDate`	DATE COMMENT "date|99-99-99|From|?|From date|",
	`KeyValue`	CHAR(16) NOT NULL COMMENT "character|x(16)|Key Value|Key|Key value of the record related to the action|",
	`TableName`	CHAR(15) NOT NULL COMMENT "character|X(15)|Table Name|Table|Table related to the action|",
	`ToDate`	DATE COMMENT "date|99-99-99|To|?|To date|",
	`UserCode`	CHAR(8) COMMENT "character|x(8)|User Code|User|User who triggered the action|",
	PRIMARY KEY	(`Brand`,`ActionID`,`ActionTS`),
## The PROGRESS database primary index
	KEY	`ActionID` (
				`Brand`,
				`ActionID`,
				`ActionTS`),
	KEY	`CustNum` (
				`CustNum`,
				`ActionID`,
				`ToDate`),
	KEY	`TableName` (
				`Brand`,
				`TableName`,
				`KeyValue`,
				`ActionID`,
				`ActionPeriod`),
	KEY	`UserCode` (
				`Brand`,
				`UserCode`,
				`ActionID`,
				`ActionTS`))
	COMMENT = "Action log";
DROP TABLE IF EXISTS `common_BillTimeTable`;
CREATE TABLE `common_BillTimeTable`(
	`BillCycle`	CHAR(20) COMMENT "character|x(20)|Billing Cycle|BillCycle|Billing Cycle (list)|",
	`BillingDate`	DATE COMMENT "date|99-99-9999|Billing Date|Bill.Date|Billing date|",
	`Brand`	CHAR(8) COMMENT "character|x(8)|Brand|Brand|Code of brand|",
	`DueDate`	DATE COMMENT "date|99-99-9999|Due Date|Due Date|Due date|",
	`FRQueueID`	INT DEFAULT "0" COMMENT "integer|>>>>>>>>>9|Queue ID|Queue|Queue in which billing is processed|",
	`FRSchedule`	CHAR(5) COMMENT "character|x(5)|Schedule|Sched.|Schedule automatically (hh:mm)|",
	`InvGroup`	CHAR(12) COMMENT "character|x(12)|Invoicing Group|Inv.Group|Invoicing group|",
	`InvType`	INT DEFAULT "0" COMMENT "integer|>>|Invoice Type|Inv.Type|Invoice type|",
	PRIMARY KEY	(`Brand`,`InvGroup`,`InvType`,`BillingDate`,`BillCycle`),
	KEY	`BillingDate` (
				`Brand`,
				`BillingDate`),
## The PROGRESS database primary index
	KEY	`InvGroup` (
				`Brand`,
				`InvGroup`,
				`InvType`,
				`BillingDate`,
				`BillCycle`))
	COMMENT = "?";
DROP TABLE IF EXISTS `common_BRAND`;
CREATE TABLE `common_BRAND`(
	`Brand`	CHAR(8) COMMENT "character|x(8)|Brand|Brand|Code Of Brand|",
	`BRName`	CHAR(20) COMMENT "character|x(20)|BrName|BrName|Name of Brand|",
	PRIMARY KEY	(`Brand`),
## The PROGRESS database primary index
	KEY	`Brand` (
				`Brand`),
	KEY	`BRName` (
				`BRName`))
	COMMENT = "Brand info";
DROP TABLE IF EXISTS `common_Company`;
CREATE TABLE `common_Company`(
	`Address`	CHAR(30) COMMENT "character|x(30)|Address|Address|Company's address|",
	`Address2`	CHAR(30) COMMENT "character|x(30)|Address 2|Addr2|Additional address|",
	`Address3`	CHAR(30) COMMENT "character|x(30)|Address 3|Addr3|Additional address|",
	`Address4`	CHAR(30) COMMENT "character|x(30)|Address 4|Addr4|Additional address|",
	`Brand`	CHAR(8) COMMENT "character|x(8)|Brand|Brand|Code Of Brand|",
	`CompanyID`	CHAR(20) COMMENT "character|x(20)|Company ID|?|Company ID|",
	`CompName`	CHAR(30) COMMENT "character|x(30)|CompName|Comp.Name|Company's name|",
	`EDICode`	CHAR(16) COMMENT "character|x(16)|EDI Code|EDI|EDI code|",
	`HomeLocation`	CHAR(30) COMMENT "character|x(30)|Home Location|Home|Home location that is printed to invoice|",
	`Phone`	CHAR(30) COMMENT "character|x(30)|Phone|Phone|Company's telephone number|",
	`Phone2`	CHAR(30) COMMENT "character|x(30)|Phone 2|?|Phone|",
	`Phone3`	CHAR(30) COMMENT "character|x(30)|Phone 3|?|Phone|",
	`PostOffice`	CHAR(30) COMMENT "character|x(30)|Postcode|Postcode|Company's postal code + city|",
	`UnitCode`	INT DEFAULT "0" COMMENT "integer|>>9|Unit|?|Unit number|",
	`VATID`	CHAR(16) COMMENT "character|x(16)|VAT ID|VATID|VAT ID|",
	PRIMARY KEY	(`Brand`,`UnitCode`),
## The PROGRESS database primary index
	KEY	`unitcode` (
				`Brand`,
				`UnitCode`))
	COMMENT = "Company data";
DROP TABLE IF EXISTS `common_Country`;
CREATE TABLE `common_Country`(
	`CoName`	CHAR(30) COMMENT "character|x(30)|Name of Country|Name of Country|Name of Country|",
	`Country`	CHAR(3) COMMENT "character|x(3)|?|Country|Country Code (according to ISO Standard)|",
	PRIMARY KEY	(`Country`),
	KEY	`CoName` (
				`CoName`),
## The PROGRESS database primary index
	KEY	`Country` (
				`Country`))
	COMMENT = "Country codes (ISO) and names";
DROP TABLE IF EXISTS `common_CurRate`;
CREATE TABLE `common_CurRate`(
	`Currency`	CHAR(5) COMMENT "character|x(5)|Code|Code|Currency code|",
	`ExchRate`	DECIMAL DEFAULT "0" COMMENT "decimal|>>9.999999|Rate|Rate|Currency rate|",
	`RateDate`	DATE COMMENT "date|99-99-99|Date|Date|Date when updated|",
	PRIMARY KEY	(`Currency`,`RateDate`),
## The PROGRESS database primary index
	KEY	`Currency` (
				`Currency`,
				`RateDate`),
	KEY	`RateDate` (
				`RateDate`,
				`Currency`))
	COMMENT = "Currency exchange rates";
DROP TABLE IF EXISTS `common_Currency`;
CREATE TABLE `common_Currency`(
	`Currency`	CHAR(3) COMMENT "character|x(3)|Currency|Currency|Currency code|",
	`CurrName`	CHAR(20) COMMENT "character|x(20)|Currency Name|Currency Name|Name of the currency|",
	`SubName`	CHAR(12) COMMENT "character|x(12)|SubName|SubName|Name of subunit|",
	`SubUnit`	CHAR(8) COMMENT "character|x(8)|SubUnit|SubUnit|Subunit of currency (1/100)|",
	PRIMARY KEY	(`Currency`),
## The PROGRESS database primary index
	KEY	`Currency` (
				`Currency`),
	KEY	`CurrName` (
				`CurrName`,
				`Currency`),
	KEY	`subunit` (
				`SubUnit`,
				`Currency`))
	COMMENT = "Currency file";
DROP TABLE IF EXISTS `common_CustSaldo`;
CREATE TABLE `common_CustSaldo`(
	`Amt`	DECIMAL DEFAULT "0" COMMENT "decimal|->>>>>>9.99999|Amount|Amount|Amount|",
	`CustNum`	INT DEFAULT "0" COMMENT "integer|>>>>>>9|Custnum|Custnum|Customer number|",
	`FromDate`	DATE COMMENT "date|99-99-9999|From|From|Saldo valid from|",
	`SaldoType`	INT DEFAULT "0" COMMENT "integer|>>>9|Type|Type|Type of saldo record|",
	`ToDate`	DATE COMMENT "date|99-99-9999|To|To|Saldo valid to|",
	PRIMARY KEY	(`CustNum`,`ToDate`,`SaldoType`),
## The PROGRESS database primary index
	KEY	`idx_custnum` (
				`CustNum`,
				`ToDate`,
				`SaldoType`))
	COMMENT = "?";
DROP TABLE IF EXISTS `common_DFField`;
CREATE TABLE `common_DFField`(
	`Brand`	CHAR(8) COMMENT "character|x(8)|Brand|?|Code of brand|",
	`DFField`	CHAR(20) COMMENT "character|x(20)|Field Name|Field|Field name|",
	`DFLabel`	CHAR(30) COMMENT "character|x(30)|Label|?|Label|",
	`DFTable`	CHAR(20) COMMENT "character|x(20)|Table Name|Table|Table name|",
	`DumpID`	INT DEFAULT "0" COMMENT "integer|>>>>>>>9|Dump ID|ID|Unique ID|",
	`FromDate`	DATE COMMENT "date|99-99-99|Valid From|From|Valid from|",
	`OrderNbr`	INT DEFAULT "0" COMMENT "integer|>>>9|Order Number|Order|Order number in file|",
	`ToDate`	DATE COMMENT "date|99-99-99|Valid To|To|Valid to|",
	PRIMARY KEY	(`DumpID`,`OrderNbr`),
## The PROGRESS database primary index
	KEY	`DumpID` (
				`DumpID`,
				`OrderNbr`))
	COMMENT = "Fields in a dump file";
DROP TABLE IF EXISTS `common_DFTimeTable`;
CREATE TABLE `common_DFTimeTable`(
	`Brand`	CHAR(8) COMMENT "character|x(8)|Brand|?|Code of brand|",
	`DumpDay`	CHAR(30) COMMENT "character|x(30)|Days|?|Days of the month when file is created|",
	`DumpID`	INT DEFAULT "0" COMMENT "integer|>>>>>>>9|Dump ID|ID|Unique ID|",
	`DumpMode`	CHAR(8) COMMENT "character|x(8)|Dump Mode|Mode|Dump mode|",
	`DumpTime`	CHAR(20) COMMENT "character|x(20)|Time|?|Time when dump files is created|",
	`DumpWeekday`	CHAR(30) COMMENT "character|x(30)|Weekdays|?|Weekdays when dump file is created|",
	`FromDate`	DATE COMMENT "date|99-99-99|Valid From|From|Valid from|",
	`LastRun`	DECIMAL DEFAULT "0" COMMENT "decimal|99999999.99999|Last Run|Last|Latest creation of dump file|",
	`ToDate`	DATE COMMENT "date|99-99-99|Valid To|To|Valid to|",
	PRIMARY KEY	(`Brand`,`DumpID`,`ToDate`),
## The PROGRESS database primary index
	KEY	`DumpID` (
				`Brand`,
				`DumpID`,
				`ToDate`))
	COMMENT = "Time table for dump files";
DROP TABLE IF EXISTS `common_DPSubject`;
CREATE TABLE `common_DPSubject`(
	`DPId`	INT DEFAULT "0" NOT NULL COMMENT "integer|>>>>>>>9|Discount Plan Id|PlanId|Discount Plan Id|",
	`DPSubject`	CHAR(16) COMMENT "character|x(16)|Subject|Subject||",
	`ValidFrom`	DATE COMMENT "date|99-99-9999|Valid From|From|Effective from date|",
	`ValidTo`	DATE COMMENT "date|99-99-9999|Valid To|To|Effective to date|",
	PRIMARY KEY	(`DPId`,`DPSubject`,`ValidTo`),
## The PROGRESS database primary index
	KEY	`DPId` (
				`DPId`,
				`DPSubject`,
				`ValidTo`))
	COMMENT = "This is the child table of DiscountPlan for different subjects";
DROP TABLE IF EXISTS `common_DumpFile`;
CREATE TABLE `common_DumpFile`(
	`Active`	TINYINT(1) DEFAULT "1" COMMENT "logical|Yes/No|Active|?|Is dump active|",
	`Brand`	CHAR(8) COMMENT "character|x(8)|Brand|?|Code of brand|",
	`ConfigParam`	CHAR(20) COMMENT "character|x(20)|Configuration Parameters|Parameter|Configuration parameters for the external procedures|",
	`DecimalPoint`	CHAR(8) COMMENT "character|x(8)|Decimal Point|Dec.Point|Decimal point (numeric-format)|",
	`Description`	CHAR(50) COMMENT "character|x(50)|Description|?|Description of dump|",
	`DumpCharSet`	CHAR(20) COMMENT "character|x(20)|Character Set|Char.Set|Character set for the file|",
	`DumpDelimiter`	CHAR(8) COMMENT "character|x(8)|Delimiter|?|Delimiter|",
	`DumpFormat`	CHAR(8) COMMENT "character|x(8)|Dump Format|Format|Dump file format|",
	`DumpID`	INT DEFAULT "0" COMMENT "integer|>>>>>>>9|Dump ID|ID|Unique ID|",
	`DumpName`	CHAR(20) COMMENT "character|x(20)|Dump Name|Name|Unique name for the dump|",
	`EmptyFile`	TINYINT(1) DEFAULT "0" COMMENT "logical|Yes/No|Create Empty File|Empty File|Create always a file even if events don't exist|",
	`EventLogFields`	CHAR(30) COMMENT "character|x(30)|EventLog Fields|Mod.Fields|Modified fields that will be checked from EventLog|",
	`FileCategory`	CHAR(12) COMMENT "character|x(12)|File Category|Category|File category|",
	`FileName`	CHAR(50) COMMENT "character|x(50)|File Name|File|File name|",
	`HasHeader`	TINYINT(1) DEFAULT "0" COMMENT "logical|Yes/No|Has Header|HasHeader|Does the report has header|",
	`LinkKey`	CHAR(20) COMMENT "character|x(20)|Link Key|Key|Key field that is used to link the side tables to main table|",
	`LogFile`	CHAR(40) COMMENT "character|x(40)|Log File|Log|Log file|",
	`LogicModule`	CHAR(30) COMMENT "character|x(30)|Logic Module|Module|Module that contains logic for data collection|",
	`MainTable`	CHAR(30) COMMENT "character|x(30)|Main Table|Table|Main table|",
	`ModCollModule`	CHAR(30) COMMENT "character|x(30)|Collect Modified|Collection|Module for collecting modified events|",
	`ModFromEventLog`	TINYINT(1) DEFAULT "0" COMMENT "logical|Yes/No|Check EventLog|EventLog|Check modifications from EventLog|",
	`ModFromField`	CHAR(30) COMMENT "character|x(30)|Check Field|Field|Check modification from (timestamp) field|",
	`SideTables`	CHAR(50) COMMENT "character|x(50)|Additional Tables|Side Tables|Additional tables|",
	`SpoolDir`	CHAR(50) COMMENT "character|x(50)|Spool Directory|Spool|Spool directory|",
	`TransDir`	CHAR(50) COMMENT "character|x(50)|Transfer Directory|Transfer|Transfer directory|",
	PRIMARY KEY	(`DumpID`),
	KEY	`Description` (
				`Brand`,
				`Description`),
## The PROGRESS database primary index
	KEY	`DumpID` (
				`DumpID`),
	KEY	`DumpName` (
				`Brand`,
				`DumpName`),
	KEY	`FileName` (
				`Brand`,
				`FileName`))
	COMMENT = "Dump file";
DROP TABLE IF EXISTS `common_ErrorLog`;
CREATE TABLE `common_ErrorLog`(
	`ActionID`	CHAR(8) COMMENT "character|x(8)|Action ID|ID|Action ID|",
	`ActionTS`	DECIMAL DEFAULT "0" COMMENT "decimal|99999999.99999|Action Time Stamp|Time Stamp|Action time stamp|",
	`Brand`	CHAR(8) COMMENT "character|x(8)|Brand|?|Code Of Brand|",
	`ErrorChar`	CHAR(8) COMMENT "character|x(8)|Character Value|Char|Character value|",
	`ErrorMsg`	CHAR(50) COMMENT "character|x(50)|Error Message|Message|Error message|",
	`ErrorStatus`	INT DEFAULT "0" COMMENT "integer|>9|Status|?|Status|",
	`KeyValue`	CHAR(16) NOT NULL COMMENT "character|x(16)|Key Value|Key|Key value of the record related to the action|",
	`TableName`	CHAR(15) NOT NULL COMMENT "character|X(15)|Table Name|Table|Table related to the action|",
	`UserCode`	CHAR(8) COMMENT "character|x(8)|User ID|?|User ID of log event|",
	PRIMARY KEY	(`Brand`,`ActionID`,`ActionTS`),
## The PROGRESS database primary index
	KEY	`ActionID` (
				`Brand`,
				`ActionID`,
				`ActionTS`),
	KEY	`ActionTS` (
				`Brand`,
				`ActionTS`),
	KEY	`ErrorStatus` (
				`Brand`,
				`ErrorStatus`,
				`ActionID`),
	KEY	`TableName` (
				`Brand`,
				`TableName`,
				`KeyValue`,
				`ActionID`,
				`ActionTS`))
	COMMENT = "Error log";
DROP TABLE IF EXISTS `common_EventLog`;
CREATE TABLE `common_EventLog`(
	`action`	CHAR(8) COMMENT "character|X(8)|Action|?|Action type.. Create,Modity,Delete|",
	`datavalues`	CHAR(50) COMMENT "character|X(50)|Values|?|Changed values of record|",
	`eventdate`	DATE COMMENT "date|99.99.99|Date|?|Event date|",
	`EventLogStatus`	INT DEFAULT "0" COMMENT "integer|9|EventLogStatus|EventLogStatus|Status of eventlog|",
	`eventtime`	CHAR(8) COMMENT "character|X(8)|Time|?|Event time|",
	`fieldformats`	CHAR(50) COMMENT "character|X(50)|Field formats|?|Field formats of modified fields|",
	`key`	CHAR(30) COMMENT "character|X(30)|Key|?|Key to source record|",
	`modifiedfields`	CHAR(50) COMMENT "character|X(50)|Modified fields|?|Fieldnames from BUFFER-COMPARE|",
	`Reported`	CHAR(30) COMMENT "character|x(30)|Reported|Report|Event reported to|",
	`tablename`	CHAR(15) COMMENT "character|X(15)|Table|?|Source table name|",
	`TimingTS`	DECIMAL DEFAULT "0" COMMENT "decimal|99999999.99999|TimingTS|TimingTS|Timing Timestamp|",
	`usercode`	CHAR(8) COMMENT "character|X(8)|User|?|User code|",
	PRIMARY KEY	(`tablename`,`key`,`eventdate`,`eventtime`),
	KEY	`EventDate` (
				`eventdate`,
				`eventtime`,
				`tablename`,
				`key`),
	KEY	`EventLogStatus` (
				`EventLogStatus`,
				`TimingTS`),
## The PROGRESS database primary index
	KEY	`TableName` (
				`tablename`,
				`key`,
				`eventdate`,
				`eventtime`),
	KEY	`UserName` (
				`usercode`,
				`eventdate`,
				`eventtime`),
	KEY	`UserTable` (
				`usercode`,
				`tablename`,
				`key`,
				`eventdate`,
				`eventtime`))
	COMMENT = "?";
DROP TABLE IF EXISTS `common_EventLogConf`;
CREATE TABLE `common_EventLogConf`(
	`ConfigType`	CHAR(12) COMMENT "character|x(12)|Configuration Type|Type|Configuration type|",
	`ConfigValue`	CHAR(30) COMMENT "character|x(30)|Configuration Value|Value|Configuration value|",
	`FromDate`	DATE COMMENT "date|99-99-99|Valid From|From|Valid from|",
	`TableName`	CHAR(15) NOT NULL COMMENT "character|X(15)|Table Name|Table|Table name|",
	`ToDate`	DATE COMMENT "date|99-99-99|Valid To|To|Valid to|",
	PRIMARY KEY	(`TableName`,`ConfigType`,`ToDate`),
## The PROGRESS database primary index
	KEY	`TableName` (
				`TableName`,
				`ConfigType`,
				`ToDate`))
	COMMENT = "Eventlog configuration";
DROP TABLE IF EXISTS `common_FuncRunConfig`;
CREATE TABLE `common_FuncRunConfig`(
	`Active`	TINYINT(1) DEFAULT "0" COMMENT "logical|Yes/No|Active|?|Is configuration active|",
	`Brand`	CHAR(8) COMMENT "character|x(8)|Brand|?|Code of brand|",
	`ConfName`	CHAR(12) COMMENT "character|x(12)|Name|?|Description for configuration|",
	`Description`	CHAR(40) COMMENT "character|x(40)|Description|?|Short description of the run|",
	`FRConfigID`	INT DEFAULT "0" COMMENT "integer|>>>>>>>>>9|Configuration ID|ID|Unique ID for configuration|",
	`MailOnFinish`	TINYINT(1) DEFAULT "0" COMMENT "logical|Yes/No|Mail On Finish|FinishMail|Send mail when execution finishes|",
	`MailOnStart`	TINYINT(1) DEFAULT "0" COMMENT "logical|Yes/No|Mail On Start|StartMail|Send mail when execution starts|",
	`RunCommand`	CHAR(20) COMMENT "character|x(20)|Run Command|Command|Command for starting the session|",
	`RunQty`	INT DEFAULT "0" COMMENT "integer|>>>>>>9|Quantity Of Runs|Runs|Quantity of parallel runs|",
	`SMSOnFinish`	TINYINT(1) DEFAULT "0" COMMENT "logical|Yes/No|SMS On Finish|FinishSMS|Send SMS when execution finishes|",
	`SMSOnRunMode`	CHAR(12) COMMENT "character|x(12)|SMS On Run Mode|SMS Modes|Run modes on which SMS is sent|",
	`SMSOnStart`	TINYINT(1) DEFAULT "0" COMMENT "logical|Yes/No|SMS On Start|StartSMS|Send SMS when execution starts|",
	`StatusInterval`	INT DEFAULT "0" COMMENT "integer|>>>>>9|Status Update Interval|Status Update|Interval (quantity of events) for updating status info|",
	PRIMARY KEY	(`FRConfigID`),
	KEY	`ConfName` (
				`Brand`,
				`ConfName`),
## The PROGRESS database primary index
	KEY	`FRConfigID` (
				`FRConfigID`))
	COMMENT = "Configuration for functions";
DROP TABLE IF EXISTS `common_FuncRunExec`;
CREATE TABLE `common_FuncRunExec`(
	`Brand`	CHAR(8) COMMENT "character|x(8)|Brand|?|Code of brand|",
	`EndTS`	DECIMAL DEFAULT "0" COMMENT "decimal|99999999.99999|End Time|End|Time when run ended|",
	`FeedFromExecSeq`	INT DEFAULT "0" COMMENT "integer|>>>>>9|Feeds From|Feeds|Execution from which feeds are taken from|",
	`FRConfigID`	INT DEFAULT "0" COMMENT "integer|>>>>>>>9|Configuration ID|ID|ID of the configuration|",
	`FRExecID`	INT DEFAULT "0" COMMENT "integer|>>>>>>>9|Execution ID|Exec.|Unique ID for the execution|",
	`FRExecSeq`	INT DEFAULT "0" COMMENT "integer|>>9|Execution Sequence|Exec.Seq|Execution sequence|within FuncRunConfig",
	`FRQRowSeq`	INT DEFAULT "0" COMMENT "integer|>>9|Queue Order|Order|Execution order when belongs to a queue|",
	`FRQScheduleID`	INT DEFAULT "0" COMMENT "integer|>>>>>>>>9|Queue Timing ID|Timing|Unique ID for this timing row|",
	`FRQueueID`	INT DEFAULT "0" COMMENT "integer|>>>>>>>>>9|Queue ID|Queue|Unique ID for the queue|",
	`RunMode`	CHAR(12) COMMENT "character|x(12)|Run Mode|Mode|Run mode, e.g. production or test|",
	`RunState`	CHAR(16) COMMENT "character|x(16)|Status Of the Run|Status|Status of the run|",
	`StartTS`	DECIMAL DEFAULT "0" COMMENT "decimal|99999999.99999|Start Time|Start|Time when run started|",
	`WaitForExecSeq`	INT DEFAULT "0" COMMENT "integer|>>>>>>>>9|Wait For Execution|Wait Exec.|Execution that must be completed before this one can be started|",
	PRIMARY KEY	(`FRConfigID`,`FRExecSeq`),
	KEY	`FRExecID` (
				`FRExecID`),
## The PROGRESS database primary index
	KEY	`FRExecSeq` (
				`FRConfigID`,
				`FRExecSeq`),
	KEY	`FRQScheduleID` (
				`FRQScheduleID`,
				`FRQRowSeq`),
	KEY	`RunState` (
				`Brand`,
				`RunState`))
	COMMENT = "Execution of function";
DROP TABLE IF EXISTS `common_FuncRunExecLog`;
CREATE TABLE `common_FuncRunExecLog`(
	`FRExecID`	INT DEFAULT "0" COMMENT "integer|>>>>>>>9|Execution ID|Exec.|Unique ID for the execution|",
	`FRStatus`	CHAR(20) COMMENT "character|x(20)|Status|?|Status|",
	`StatusStamp`	DECIMAL DEFAULT "0" COMMENT "decimal|99999999.99999|Time Stamp|Time|Time of the status change|",
	PRIMARY KEY	(`FRExecID`,`StatusStamp`),
## The PROGRESS database primary index
	KEY	`FRExecID` (
				`FRExecID`,
				`StatusStamp`))
	COMMENT = "Status of a function";
DROP TABLE IF EXISTS `common_FuncRunParam`;
CREATE TABLE `common_FuncRunParam`(
	`DefaultValue`	CHAR(20) COMMENT "character|x(20)|Default Value|Default|Default value for parameter|",
	`FRConfigID`	INT DEFAULT "0" COMMENT "integer|>>>>>>>>>9|Configuration ID|Conf.|Unique ID for configuration|",
	`ParamName`	CHAR(20) COMMENT "character|x(20)|Parameter Name|Name|Parameter name|",
	`ParamSeq`	INT DEFAULT "0" COMMENT "integer|>>9|Parameter Sequence|Sequence|Parameter sequence (order)|",
	`ParamType`	CHAR(8) COMMENT "character|x(8)|Parameter Type|Type|Parameter type|",
	PRIMARY KEY	(`FRConfigID`,`ParamSeq`),
## The PROGRESS database primary index
	KEY	`ParamSeq` (
				`FRConfigID`,
				`ParamSeq`))
	COMMENT = "Parameters for function configuration";
DROP TABLE IF EXISTS `common_FuncRunProcess`;
CREATE TABLE `common_FuncRunProcess`(
	`EndTS`	DECIMAL DEFAULT "0" COMMENT "decimal|99999999.99999|End Time|Ended|End time|",
	`FRConfigID`	INT DEFAULT "0" COMMENT "integer|>>>>>>9|Configuration ID|Conf.|Configuration ID|",
	`FRExecID`	INT DEFAULT "0" COMMENT "integer|>>>>>>>9|Execution ID|Exec.|ID of the execution|",
	`FRProcessID`	INT DEFAULT "0" COMMENT "integer|>>>>>>>>9|FR Process ID|Proc.|Unique ID of the process|",
	`LastTS`	DECIMAL DEFAULT "0" COMMENT "decimal|99999999.99999|Last Update|Updated|Time of last update|",
	`Processed`	INT DEFAULT "0" COMMENT "integer|>>>>>>>9|Processed Events|Events|Processed event qty|",
	`ProcessID`	INT DEFAULT "0" COMMENT "integer|>>>>9|OS Process ID|OS PID|OS process ID|",
	`ProcSeq`	INT DEFAULT "0" COMMENT "integer|>>>>>>9|Process Sequence|Sequence|Sequence of the process within the execution|",
	`RunCommand`	CHAR(30) COMMENT "character|x(30)|Run Command|Command|Command for starting the session|",
	`RunState`	CHAR(16) COMMENT "character|x(16)|Run Status|Status|Status of the process|",
	`StartTS`	DECIMAL DEFAULT "0" COMMENT "decimal|99999999.99999|Start Time|Started|Start time|",
	PRIMARY KEY	(`FRConfigID`,`FRExecID`,`ProcSeq`),
## The PROGRESS database primary index
	KEY	`FRConfigID` (
				`FRConfigID`,
				`FRExecID`,
				`ProcSeq`),
	KEY	`FRProcessID` (
				`FRProcessID`))
	COMMENT = "Single process of a function";
DROP TABLE IF EXISTS `common_FuncRunQRow`;
CREATE TABLE `common_FuncRunQRow`(
	`FeedFromRowSeq`	INT DEFAULT "0" COMMENT "integer|>>>>>9|Feeds From|Feeds|Row from which feeds are taken from|",
	`FRConfigID`	INT DEFAULT "0" COMMENT "integer|>>>>>>>>>9|Configuration ID|Conf.|Unique ID for configuration|",
	`FRQRowSeq`	INT DEFAULT "0" COMMENT "integer|>>>>>9|Row Sequence|Row|Row sequence (order)|",
	`FRQueueID`	INT DEFAULT "0" COMMENT "integer|>>>>>>>>>9|Queue ID|Queue|Unique ID for the queue|",
	`WaitForRowSeq`	INT DEFAULT "0" COMMENT "integer|>>>>>9|Wait For|Wait|Row which must be handled before this one is started|",
	PRIMARY KEY	(`FRQueueID`,`FRQRowSeq`),
	KEY	`FRConfigID` (
				`FRConfigID`),
## The PROGRESS database primary index
	KEY	`FuncRunQRow` (
				`FRQueueID`,
				`FRQRowSeq`))
	COMMENT = "Row for function queue configuration";
DROP TABLE IF EXISTS `common_FuncRunQSchedule`;
CREATE TABLE `common_FuncRunQSchedule`(
	`DoneTS`	DECIMAL DEFAULT "0" COMMENT "decimal|99999999.99999|Start Time|Start|Time when run will be started|",
	`FRQScheduleID`	INT DEFAULT "0" COMMENT "integer|>>>>>>>>9|Queue Timing ID|Timing|Unique ID for this timing row|",
	`FRQTimetableID`	INT DEFAULT "0" COMMENT "integer|>>>>>>>>9|Queue Timetable ID|Timetable|Timetable on which this scheduling is based|",
	`FRQueueID`	INT DEFAULT "0" COMMENT "integer|>>>>>>>>>9|Queue ID|Queue|Unique ID for the queue|",
	`RunMode`	CHAR(12) COMMENT "character|x(12)|Run Mode|Mode|Run mode, e.g. production or test|",
	`RunState`	CHAR(16) COMMENT "character|x(16)|Run Status|Status|Status of the scheduled run|",
	`StartTS`	DECIMAL DEFAULT "0" COMMENT "decimal|99999999.99999|Start Time|Start|Time when run will be started|",
	`UserCode`	CHAR(8) COMMENT "character|x(8)|UserId|UserId|User who scheduled the execution|",
	PRIMARY KEY	(`FRQScheduleID`),
## The PROGRESS database primary index
	KEY	`FRQScheduleID` (
				`FRQScheduleID`),
	KEY	`FRQueueID` (
				`FRQueueID`,
				`StartTS`),
	KEY	`RunState` (
				`FRQueueID`,
				`RunState`,
				`StartTS`))
	COMMENT = "Timetable for function queue";
DROP TABLE IF EXISTS `common_FuncRunQSParam`;
CREATE TABLE `common_FuncRunQSParam`(
	`CharParam`	CHAR(20) COMMENT "character|x(20)|Character Parameter|Char|Default value for character parameter|",
	`DateParam`	DATE COMMENT "date|99-99-9999|Date Parameter|Date|Default value for date parameter|",
	`FRConfigID`	INT DEFAULT "0" COMMENT "integer|>>>>>>>>>9|Configuration ID|Conf.|Unique ID for configuration|",
	`FRQRowSeq`	INT DEFAULT "0" COMMENT "integer|>>>>>9|Row Sequence|Row|Row sequence (order)|",
	`FRQScheduleID`	INT DEFAULT "0" COMMENT "integer|>>>>>>>>9|Queue Timing ID|Timing|Unique ID for scheduling row|",
	`FRQueueID`	INT DEFAULT "0" COMMENT "integer|>>>>>>>>>9|Queue ID|Queue|Unique ID for the queue|",
	`IntParam`	INT DEFAULT "0" COMMENT "integer|->>>>>>>9|Integer Parameter|Int|Default value for integer parameter|",
	`LogParam`	TINYINT(1) DEFAULT "0" COMMENT "logical|Yes/No|Logical Parameter|Logic|Default value for logical parameter|",
	`ParamSeq`	INT DEFAULT "0" COMMENT "integer|>>9|Parameter Sequence|Sequence|Parameter sequence (order)|",
	`ParamType`	CHAR(8) COMMENT "character|x(8)|Parameter Type|Type|Parameter type|",
	PRIMARY KEY	(`FRQScheduleID`,`FRQRowSeq`,`ParamSeq`),
	KEY	`FuncRunQRow` (
				`FRQueueID`,
				`FRQRowSeq`,
				`ParamSeq`),
## The PROGRESS database primary index
	KEY	`FuncRunQSchedule` (
				`FRQScheduleID`,
				`FRQRowSeq`,
				`ParamSeq`))
	COMMENT = "Parameters for scheduled function queue";
DROP TABLE IF EXISTS `common_FuncRunQTimetable`;
CREATE TABLE `common_FuncRunQTimetable`(
	`Brand`	CHAR(8) COMMENT "character|x(8)|Brand|?|Code of brand|",
	`ExecDay`	CHAR(30) COMMENT "character|x(30)|Days|?|Days of the month when executed|",
	`ExecTime`	CHAR(20) COMMENT "character|x(20)|Time|?|Time when executed|",
	`ExecWeekday`	CHAR(30) COMMENT "character|x(30)|Weekdays|?|Weekdays when executed|",
	`FromDate`	DATE COMMENT "date|99-99-99|Valid From|From|Valid from|",
	`FRQTimetableID`	INT DEFAULT "0" COMMENT "integer|>>>>>>>>>9|Timetable ID|ID|Unique ID for the timetable|",
	`FRQueueID`	INT DEFAULT "0" COMMENT "integer|>>>>>>>>>9|Queue ID|Queue|Unique ID for the queue|",
	`OnlyOnWorkDays`	TINYINT(1) DEFAULT "0" COMMENT "logical|Yes/No|Only On Workdays|Workdays|Execute only on working days|",
	`RunMode`	CHAR(12) COMMENT "character|x(12)|Run Mode|Mode|Run mode|",
	`ToDate`	DATE COMMENT "date|99-99-99|Valid To|To|Valid to|",
	PRIMARY KEY	(`FRQueueID`,`ToDate`),
	KEY	`FRQTimetableID` (
				`FRQTimetableID`),
## The PROGRESS database primary index
	KEY	`FRQueuID` (
				`FRQueueID`,
				`ToDate`),
	KEY	`ToDate` (
				`Brand`,
				`ToDate`))
	COMMENT = "Timetable for FuncRun queue executions";
DROP TABLE IF EXISTS `common_FuncRunQTTParam`;
CREATE TABLE `common_FuncRunQTTParam`(
	`DefaultValue`	CHAR(20) COMMENT "character|x(20)|Default Value|Default|Default value for parameter|",
	`FRConfigID`	INT DEFAULT "0" COMMENT "integer|>>>>>>>>>9|Configuration ID|Conf.|Unique ID for configuration|",
	`FRQTimetableID`	INT DEFAULT "0" COMMENT "integer|>>>>>>>>9|Queue Timetable ID|Timetable|Unique ID for timetable|",
	`FRQueueID`	INT DEFAULT "0" COMMENT "integer|>>>>>>>>>9|Queue ID|Queue|Unique ID for the queue|",
	`ParamSeq`	INT DEFAULT "0" COMMENT "integer|>>9|Parameter Sequence|Sequence|Parameter sequence (order)|",
	`ToDate`	DATE COMMENT "date|99-99-99|Valid To|To|Valid to|",
	PRIMARY KEY	(`FRQTimetableID`,`FRConfigID`,`ParamSeq`,`ToDate`),
## The PROGRESS database primary index
	KEY	`FuncRunQTimetable` (
				`FRQTimetableID`,
				`FRConfigID`,
				`ParamSeq`,
				`ToDate`))
	COMMENT = "Parameters for function queue timetable";
DROP TABLE IF EXISTS `common_FuncRunQueue`;
CREATE TABLE `common_FuncRunQueue`(
	`Active`	TINYINT(1) DEFAULT "0" COMMENT "logical|Yes/No|Active|?|Is queue active|",
	`Brand`	CHAR(8) COMMENT "character|x(8)|Brand|?|Code of brand|",
	`FRQueueID`	INT DEFAULT "0" COMMENT "integer|>>>>>>>>>9|Queue ID|Queue|Unique ID for the queue|",
	`QueueDesc`	CHAR(30) COMMENT "character|x(30)|Description|?|Short description of the queue|",
	PRIMARY KEY	(`FRQueueID`),
	KEY	`BrandQueue` (
				`Brand`,
				`FRQueueID`),
## The PROGRESS database primary index
	KEY	`FRQueueID` (
				`FRQueueID`))
	COMMENT = "Configuration for function queue";
DROP TABLE IF EXISTS `common_FuncRunResult`;
CREATE TABLE `common_FuncRunResult`(
	`CharParam`	CHAR(8) COMMENT "character|x(8)|Character Parameter|Char.Param|Character parameter|",
	`DecParam`	DECIMAL DEFAULT "0" COMMENT "decimal|->>>>>>>>9.99999|Decimal Parameter|Dec.Param|Decimal parameter|",
	`FRExecID`	INT DEFAULT "0" COMMENT "integer|>>>>>>>9|Execution ID|Exec.|Execution from which the feeds were created|",
	`FRProcessID`	INT DEFAULT "0" COMMENT "integer|>>>>>>>>>9|FR Process ID|Proc.|Unique ID of the process|",
	`FRResultSeq`	INT DEFAULT "0" COMMENT "integer|>>>>>9|Sequence|Seq.|Sequence (order) within one execution|",
	`IntParam`	INT DEFAULT "0" COMMENT "integer|>>>>>>>>9|Integer Parameter|Int.Param|Integer parameter|",
	`ResultOrder`	INT DEFAULT "0" COMMENT "integer|>>>>>>>>>>9|Result Order|Order|Order of the result rows|",
	PRIMARY KEY	(`FRProcessID`,`FRResultSeq`,`ResultOrder`),
	KEY	`FRExecID` (
				`FRExecID`,
				`FRResultSeq`),
## The PROGRESS database primary index
	KEY	`FRProcessID` (
				`FRProcessID`,
				`FRResultSeq`,
				`ResultOrder`))
	COMMENT = "Feed to a function process";
DROP TABLE IF EXISTS `common_InvASub`;
CREATE TABLE `common_InvASub`(
	`Amt`	DECIMAL DEFAULT "0" COMMENT "decimal|>>>>>>9.99|Value|Value|Value of calls to this CCN|",
	`BillCode`	CHAR(16) COMMENT "character|x(16)|ProdCd|ProdCd|Product code, max 16 characters|",
	`CCN`	INT DEFAULT "0" NOT NULL COMMENT "integer|zz9|CCN|CCN|Consecutive country number|",
	`CLI`	CHAR(12) COMMENT "character|x(12)|A-Sub|A-Sub|A-Subscriber number|",
	`FromDate`	DATE COMMENT "date|99-99-99|DateFrom|DateFrom|FROM date (oldest call date)|",
	`GenPrice`	DECIMAL DEFAULT "0" COMMENT "decimal|zz,zz9.99|GenPrice|GenPrice|Call's general price|",
	`InvNum`	INT DEFAULT "0" COMMENT "integer|zzzzzzz9|InvoiceNo|InvoiceNo|Consecutive Invoice Number, 1 ... 99999999|",
	`InvSeq`	INT DEFAULT "0" COMMENT "integer|>>>>>>9|InvSeq|InvSeq|Calls invoice sequence|",
	`Minutes`	INT DEFAULT "0" COMMENT "integer|>>>>>>>9|AmtMin|AmtMin|Amount of minutes to this CCN|",
	`MPMAmt`	DECIMAL DEFAULT "0" COMMENT "decimal|>>>>>>9.99|MPM Amount|MPM|Value of MPM|",
	`Qty`	INT DEFAULT "0" COMMENT "integer|>>>>>>9|Amount|Amount|Amount of call to this CCN|",
	`SubInvNum`	INT DEFAULT "0" COMMENT "integer|>>9|SubInvoice Number|SubInv|Sequential nbr of the subinvoice within the combined invoice|",
	`TariffNum`	INT DEFAULT "0" COMMENT "integer|>>>>>9|TariffID|TariffID|Tariff ID for rate used|",
	`ToDate`	DATE COMMENT "date|99-99-99|DateTo|DateTo|TO date (latest call date)|",
	PRIMARY KEY	(`InvNum`,`SubInvNum`,`CLI`,`BillCode`,`CCN`),
## The PROGRESS database primary index
	KEY	`InvNum` (
				`InvNum`,
				`SubInvNum`,
				`CLI`,
				`BillCode`,
				`CCN`))
	COMMENT = "Invoiced calls by CLI";
DROP TABLE IF EXISTS `common_InvPaymTerm`;
CREATE TABLE `common_InvPaymTerm`(
	`Category`	CHAR(10) COMMENT "character|x(10)|Customer Category|Category|Customer Category|",
	`InvDelType`	INT DEFAULT "0" COMMENT "integer|zz9|Delivery Type|InvDelType|E-mail Paper|",
	`InvType`	INT DEFAULT "0" COMMENT "integer|zz9|Invoice Type|Invoice Type|Normal Credit PP|",
	`PaymTerm`	INT DEFAULT "0" COMMENT "integer|zz9|Duedate days|PaymentTerms|Days to duedate|",
	PRIMARY KEY	(`Category`,`InvType`,`InvDelType`),
## The PROGRESS database primary index
	KEY	`idxPaymTerms` (
				`Category`,
				`InvType`,
				`InvDelType`))
	COMMENT = "invoice payment terms";
DROP TABLE IF EXISTS `common_Language`;
CREATE TABLE `common_Language`(
	`ISOCode`	CHAR(2) COMMENT "character|x(2)|ISO Code|ISO|Two character ISO code|",
	`LangCode`	CHAR(3) COMMENT "character|x(3)|ISO Code|ISO Code|ISO code for language|",
	`LangName`	CHAR(35) COMMENT "character|x(35)|LangName|LangName|Name of Language|",
	`Language`	INT DEFAULT "0" COMMENT "integer|>9|Language|Language|Code of Language|",
	PRIMARY KEY	(`Language`),
	KEY	`LangCode` (
				`LangCode`),
	KEY	`LangName` (
				`LangName`,
				`Language`),
## The PROGRESS database primary index
	KEY	`Language` (
				`Language`))
	COMMENT = "Language";
DROP TABLE IF EXISTS `common_MainContract`;
CREATE TABLE `common_MainContract`(
	`AgrCust`	INT DEFAULT "0" COMMENT "integer|>>>>>>9|AgrCust|AgrCust|Owner customer|",
	`ContractId`	INT DEFAULT "0" COMMENT "integer|>>>>>>9|ContractId|ContractId|ContractId|",
	`FromDate`	DATE COMMENT "date|99-99-9999|From|From|Day from contract is valid|",
	`InvCust`	INT DEFAULT "0" COMMENT "integer|>>>>>>9|InvCust|InvCust|Invoice customer|",
	`ToDate`	DATE COMMENT "date|99-99-9999|To|To|Day until contract is valid|",
	PRIMARY KEY	(`ContractId`),
	KEY	`idx_AgrCust` (
				`AgrCust`),
## The PROGRESS database primary index
	KEY	`idx_ContractID` (
				`ContractId`),
	KEY	`idx_Date` (
				`FromDate`,
				`ToDate`),
	KEY	`idx_InvCust` (
				`InvCust`))
	COMMENT = "?";
DROP TABLE IF EXISTS `common_MenuClass`;
CREATE TABLE `common_MenuClass`(
	`MCName`	CHAR(40) COMMENT "character|x(40)|Name of Class|Name of Class|Name of Program Class|",
	`MenuClass`	INT DEFAULT "0" COMMENT "integer|zzz9|No|No.|Unique number for Program Class|",
	PRIMARY KEY	(`MenuClass`),
	KEY	`MCName` (
				`MCName`,
				`MenuClass`),
## The PROGRESS database primary index
	KEY	`MenuClass` (
				`MenuClass`))
	COMMENT = "Menu classes";
DROP TABLE IF EXISTS `common_MenuText`;
CREATE TABLE `common_MenuText`(
	`MenuNum`	INT DEFAULT "0" NOT NULL COMMENT "integer|ZZZ9|MenuNo|MenuNo|Number of menu|",
	`MenuText`	CHAR(16) COMMENT "character|x(16)|MenuTxt|MenuTxt|Menu's text|",
	PRIMARY KEY	(`MenuNum`),
## The PROGRESS database primary index
	KEY	`MenuNum` (
				`MenuNum`),
	KEY	`MenuText` (
				`MenuText`))
	COMMENT = "Menu texts";
DROP TABLE IF EXISTS `common_MenuTree`;
CREATE TABLE `common_MenuTree`(
	`HotKey`	CHAR(8) COMMENT "character|x(8)|Shortcut|Shortcut|Function's shortcut|",
	`Level`	CHAR(16) NOT NULL COMMENT "character|x(16)|Level|Level|Menu level (main level 0, sublevel f.ex. 134)|",
	`MenuClass`	INT DEFAULT "0" COMMENT "integer|zzz9|PgCl|PgCl|Unique number for Program Class|",
	`MenuId`	CHAR(8) COMMENT "character|x(8)|Fcode|Fcode|Function code|",
	`MenuNum`	INT DEFAULT "0" NOT NULL COMMENT "integer|>>9|Mno|Mno|Menutext's number|",
	`MenuTitle`	CHAR(40) COMMENT "character|x(40)|Fname|Fname|Function name|",
	`MenuType`	INT DEFAULT "1" NOT NULL COMMENT "integer|9|T|T|Leads to: 1: program, 2: next menu, 3: previous menu|",
	`Module`	CHAR(10) NOT NULL COMMENT "character|x(10)|Module|Module|Name of called program or the next menu level|",
	`Position`	INT DEFAULT "0" NOT NULL COMMENT "integer|9|P|P|Menu slot (1  ...  8), 0 if not a MENU item|",
	`State[1]`	TINYINT(1) DEFAULT "0" COMMENT "logical|Yes/No|Status|Status|Status code|",
	`TokenCode`	CHAR(12) COMMENT "character|X(12)|Token|?|Comma separed list of Token codes|",
	PRIMARY KEY	(`Level`,`Position`),
	KEY	`HotKey` (
				`HotKey`),
## The PROGRESS database primary index
	KEY	`Level` (
				`Level`,
				`Position`),
	KEY	`MenuClass` (
				`MenuClass`,
				`MenuId`),
	KEY	`MenuId` (
				`MenuId`),
	KEY	`MenuTitle` (
				`MenuTitle`,
				`MenuId`),
	KEY	`Module` (
				`Module`,
				`Level`,
				`Position`))
	COMMENT = "Menu configuration, menu tree";
DROP TABLE IF EXISTS `common_MsReqFuncItem`;
CREATE TABLE `common_MsReqFuncItem`(
	`IParam`	INT DEFAULT "0" COMMENT "integer|zz9|IParam|IParam||Parameter(integer)",
	`ItemDesc`	CHAR(30) DEFAULT "0" COMMENT "character|x(30)|ItemDesc|ItemDesc||Description of items function",
	`ItemId`	CHAR(5) DEFAULT "0" COMMENT "character|x(5)|FuncItemId|StatFuncItemId||ReqStat function item identifier",
	`Module`	CHAR(12) COMMENT "character|x(12)|Module|Module||Code / Action",
	PRIMARY KEY	(`ItemId`),
## The PROGRESS database primary index
	KEY	`ItemId` (
				`ItemId`))
	COMMENT = "?";
DROP TABLE IF EXISTS `common_MsReqStatFunc`;
CREATE TABLE `common_MsReqStatFunc`(
	`FuncGroup`	CHAR(40) COMMENT "character|x(40)|FuncGroup|FuncGrp||Available functions for status",
	`ReqStatus`	INT DEFAULT "0" COMMENT "integer|zz9|MsRquest Status|RequestStatus||Avaialble status of MsRequest",
	`ReqType`	INT DEFAULT "0" COMMENT "integer|zz9|Request type|Type||Request type",
	PRIMARY KEY	(`ReqType`,`ReqStatus`),
## The PROGRESS database primary index
	KEY	`ReqType` (
				`ReqType`,
				`ReqStatus`))
	COMMENT = "?";
DROP TABLE IF EXISTS `common_MSRequest`;
CREATE TABLE `common_MSRequest`(
	`ActStamp`	DECIMAL DEFAULT "0" COMMENT "decimal|99999999.99999|Activation Time|Activate|Time when request will be processed|",
	`Brand`	CHAR(8) COMMENT "character|x(8)|Brand|Brand|Code Of Brand|",
	`CLI`	CHAR(15) COMMENT "character|X(15)|MSISDN|CLI|MSISDN subscriber number|",
	`CreateFees`	TINYINT(1) DEFAULT "1" COMMENT "logical|Yes/No|Create Fees|Fees|Create fees that are associated to request|",
	`CreStamp`	DECIMAL DEFAULT "0" COMMENT "decimal|99999999.99999|Creation Time|Created|Time when request was made|",
	`CustNum`	INT DEFAULT "0" COMMENT "integer|>>>>>>>9|Customer|Cust|Customer number|mobsub.custnum",
	`DoneStamp`	DECIMAL DEFAULT "0" COMMENT "decimal|99999999.99999|Handling Time|Handled|Time when request was handled (completed)|",
	`Forced`	TINYINT(1) DEFAULT "0" COMMENT "logical|Yes/No|Forced Run|Forced|Request has been run immediately, bypassing original scheduling|",
	`Mandatory`	INT DEFAULT "0" COMMENT "integer|9|Mandatory|Mand.|This request must be handled before father request can continue|",
	`Memo`	CHAR(60) COMMENT "character|x(60)|Memo|?|Memo|",
	`MsRequest`	INT DEFAULT "0" COMMENT "integer|->,>>>,>>9|Request ID|ID|Unique ID for request|",
	`MsSeq`	INT DEFAULT "0" NOT NULL COMMENT "integer|>>>>>>>9|MobSub Sequence|SubSeq|Sequence for a subscription|",
	`OrigRequest`	INT DEFAULT "0" COMMENT "integer|>>>>>>>>9|Original Request ID|Orig.ID|ID of the original (father) request|",
	`ReqCParam1`	CHAR(30) COMMENT "character|x(30)|Char Parameter 1|CParam1|Character parameter 1|",
	`ReqCParam2`	CHAR(30) COMMENT "character|x(30)|Char Parameter 2|CParam2|Character parameter 2|",
	`ReqCParam3`	CHAR(30) COMMENT "character|x(30)|Char Parameter 3|CParam3|Character parameter 3|",
	`ReqCParam4`	CHAR(30) COMMENT "character|x(30)|Char Parameter 4|CParam4|Character parameter 4|",
	`ReqDParam1`	DECIMAL DEFAULT "0" COMMENT "decimal|->>,>>9.99|Dec Parameter 1|DParam1|Decimal parameter 1|",
	`ReqDParam2`	DECIMAL DEFAULT "0" COMMENT "decimal|->>,>>9.99|Dec Parameter 2|DParam2|Decimal parameter 2|",
	`ReqDtParam1`	DATE COMMENT "date|99-99-99|Date parameter 1|DateParam1|Date parameter 1|",
	`ReqDtParam2`	DATE COMMENT "date|99-99-99|Date parameter 2|DateParam2|Date parameter 2|",
	`ReqIParam1`	INT DEFAULT "0" COMMENT "integer|->>>>>>>9|Integer Parameter 1|IntParam1|Integer parameter 1|",
	`ReqIParam2`	INT DEFAULT "0" COMMENT "integer|->>>>>>>9|Integer Parameter 2|IntParam2|Integer parameter 2|",
	`ReqIParam3`	INT DEFAULT "0" COMMENT "integer|->>>>>>>9|Integer Parameter 3|IntParam3|Integer parameter 3|",
	`ReqIParam4`	INT DEFAULT "0" COMMENT "integer|->>>>>>>9|Integer Parameter 4|IntParam4|Integer parameter 4|",
	`ReqSource`	CHAR(8) COMMENT "character|x(8)|Source|?|Request source (orderer)|",
	`ReqStatus`	INT DEFAULT "0" COMMENT "integer|9|Status|Stat|Status of request|",
	`ReqType`	INT DEFAULT "0" COMMENT "integer|>9|Request Type|Type|Type of request|",
	`ResponseStatus`	INT DEFAULT "0" COMMENT "integer|>>9|Response Status|Response|Response status|",
	`SendSMS`	INT DEFAULT "0" COMMENT "integer|9|Send SMS|SMS|Send SMS when request is handled|0=no, 1=to user, 2=to owner, 3=both",
	`SMSText`	CHAR(12) COMMENT "character|x(12)|SMS Text|SMS|SMS text that is sent|",
	`SoLog`	INT DEFAULT "0" NOT NULL COMMENT "integer|>>>>>>>9|Solog ID|Solog|Sequence for Solog|",
	`UpdateStamp`	DECIMAL DEFAULT "0" COMMENT "decimal|99999999.99999|UpdateStamp|Last updated|When this request was last updated|",
	`UserCode`	CHAR(8) COMMENT "character|x(8)|UserId|UserId|User who made the request|",
	`WaitForRequest`	INT DEFAULT "0" COMMENT "integer|>>>>>>>9|Wait For Request|Wait Req.|Wait for another request to complete|",
	PRIMARY KEY	(`MsRequest`),
	KEY	`BrandReq` (
				`Brand`,
				`MsRequest`),
	KEY	`BrandType` (
				`Brand`,
				`ReqType`,
				`MsRequest`),
	KEY	`CLI` (
				`Brand`,
				`ReqType`,
				`CLI`,
				`ActStamp`),
	KEY	`CustNum` (
				`Brand`,
				`ReqType`,
				`CustNum`,
				`ActStamp`),
	KEY	`MsActStamp` (
				`MsSeq`,
				`ActStamp`),
## The PROGRESS database primary index
	KEY	`MsRequest` (
				`MsRequest`),
	KEY	`MsSeq` (
				`MsSeq`,
				`ReqType`,
				`ReqStatus`),
	KEY	`OrigRequest` (
				`OrigRequest`),
	KEY	`ReqCParam1` (
				`MsSeq`,
				`ReqType`,
				`ReqCParam1`,
				`ReqStatus`),
	KEY	`ReqStatus` (
				`Brand`,
				`ReqStatus`,
				`ActStamp`),
	KEY	`ReqType` (
				`Brand`,
				`ReqType`,
				`ReqStatus`,
				`ActStamp`),
	KEY	`ResponseStatus` (
				`Brand`,
				`ResponseStatus`),
	KEY	`UpdateStamp` (
				`Brand`,
				`ReqStatus`,
				`UpdateStamp`),
	KEY	`UserCode` (
				`Brand`,
				`UserCode`,
				`ActStamp`))
	COMMENT = "MobSub related action requests";
DROP TABLE IF EXISTS `common_MsRequestParam`;
CREATE TABLE `common_MsRequestParam`(
	`CharValue`	CHAR(30) COMMENT "character|X(30)|Character Value|Character|Character value|",
	`DateValue`	DATE COMMENT "date|99-99-9999|Date Value|Date|Date value|",
	`MsRequest`	INT DEFAULT "0" COMMENT "integer|>>>>>>>9|Request ID|ID|Unique ID for request|",
	`NumericValue`	DECIMAL DEFAULT "0" COMMENT "decimal|->>>>>9.999|Numeric Value|Numeric|Numeric value|",
	`ParamName`	CHAR(16) COMMENT "character|x(16)|Parameter Name|Name|Parameter name|",
	`ParamType`	CHAR(12) COMMENT "character|x(12)|Parameter Type|Type|Parameter type|",
	PRIMARY KEY	(`MsRequest`,`ParamName`),
## The PROGRESS database primary index
	KEY	`ParamName` (
				`MsRequest`,
				`ParamName`))
	COMMENT = "Request parameter";
DROP TABLE IF EXISTS `common_NatHoliday`;
CREATE TABLE `common_NatHoliday`(
	`HName`	CHAR(30) COMMENT "character|x(30)|Explan|Explan|Holiday's name|",
	`Holiday`	DATE COMMENT "date|99-99-9999|Date|Date|Holiday's date|",
	PRIMARY KEY	(`Holiday`),
	KEY	`HName` (
				`HName`,
				`Holiday`),
## The PROGRESS database primary index
	KEY	`Holiday` (
				`Holiday`))
	COMMENT = "National holidays (weekend prices used)";
DROP TABLE IF EXISTS `common_Nationality`;
CREATE TABLE `common_Nationality`(
	`Nationality`	CHAR(8) COMMENT "character|x(8)|Nationality|Nation.|Nationality|",
	`NtName`	CHAR(30) COMMENT "character|x(30)|Description|?|Description|",
	PRIMARY KEY	(`Nationality`),
## The PROGRESS database primary index
	KEY	`Nationality` (
				`Nationality`),
	KEY	`NtName` (
				`NtName`))
	COMMENT = "Nationalities";
DROP TABLE IF EXISTS `common_PaymVouch`;
CREATE TABLE `common_PaymVouch`(
	`Brand`	CHAR(8) COMMENT "character|x(8)|Brand|?|Code Of Brand|",
	`FromDate`	DATE COMMENT "date|99-99-99|Valid From|From|Date when sequence becomes effective|",
	`Voucher`	INT DEFAULT "0" COMMENT "integer|>>>>>>>9|Voucher Nbr|Voucher|Last used voucher number|",
	`VoucherType`	INT DEFAULT "0" COMMENT "integer|>9|Voucher Type|Type|Voucher type|",
	PRIMARY KEY	(`Brand`,`VoucherType`,`FromDate`,`Voucher`),
## The PROGRESS database primary index
	KEY	`Voucher` (
				`Brand`,
				`VoucherType`,
				`FromDate`,
				`Voucher`))
	COMMENT = "Number series for payment vouchers";
DROP TABLE IF EXISTS `common_PLMNRate`;
CREATE TABLE `common_PLMNRate`(
	`BCC`	INT DEFAULT "0" COMMENT "integer|>>>9|BCC|BCC|BCC|",
	`Bdest`	CHAR(16) COMMENT "character|x(16)|B-Destination|B-dest|B-destination|",
	`CustNum`	INT DEFAULT "0" COMMENT "integer|>>>>>>>9|Customer|Cust.|Customer number|",
	`PLMN`	CHAR(8) COMMENT "character|x(8)|PLMN code|PLMN Code|PLMN code|",
	`RZIType`	CHAR(8) COMMENT "character|x(8)|Type|Type|product type|",
	`ValidFrom`	DATE COMMENT "date|99-99-9999|Valid From|ValidFrom|From Date|",
	`ValidTo`	DATE COMMENT "date|99-99-9999|Valid To|ValidTo|To Date|",
	PRIMARY KEY	(`PLMN`,`BCC`,`RZIType`,`ValidTo`),
	KEY	`CustNum` (
				`CustNum`,
				`PLMN`,
				`RZIType`,
				`ValidTo`),
## The PROGRESS database primary index
	KEY	`PLMN` (
				`PLMN`,
				`BCC`,
				`RZIType`,
				`ValidTo`))
	COMMENT = "PLMN rate";
DROP TABLE IF EXISTS `common_PLMNRule`;
CREATE TABLE `common_PLMNRule`(
	`DialType`	INT DEFAULT "0" COMMENT "integer|>>9|DialType|DialType|PLMN rule|",
	`Limit`	DECIMAL DEFAULT "0" COMMENT "decimal|>>>9.99|Limit|Limit|Limit|",
	`PlmnCode`	CHAR(8) COMMENT "character|x(8)|PlmnCode|PLMN Code|Code of PLMN|",
	`ValidFrom`	DATE COMMENT "date|99-99-9999|Valid From|From|Effective from date|",
	`ValidTo`	DATE COMMENT "date|99-99-9999|Valid To|To|Effective to date|",
	PRIMARY KEY	(`PlmnCode`,`DialType`,`ValidTo`,`ValidFrom`),
## The PROGRESS database primary index
	KEY	`PLMNCode` (
				`PlmnCode`,
				`DialType`,
				`ValidTo`,
				`ValidFrom`))
	COMMENT = "PLMN rules";
DROP TABLE IF EXISTS `common_PrintCodes`;
CREATE TABLE `common_PrintCodes`(
	`AvailLines`	INT DEFAULT "0" COMMENT "integer|ZZ9|Rows|Rows|Number of lines available on page|",
	`Effect`	CHAR(1) COMMENT "character|x(1)|Code|Code|Code of a control character string|",
	`EffName`	CHAR(30) COMMENT "character|x(30)|FX's name|FX's name|Descriptive name for a control code|",
	`PageLength`	INT DEFAULT "0" COMMENT "integer|ZZ9|PageLength|PageLength|Total lines per page|",
	`PageWidth`	INT DEFAULT "0" COMMENT "integer|ZZ9|PageWe|PageWe|Maximum no. of characters per line on printer|",
	`PrinterId`	CHAR(24) COMMENT "character|x(24)|Printer|Printer|Printer's logical name|",
	PRIMARY KEY	(`Effect`,`PrinterId`),
## The PROGRESS database primary index
	KEY	`Effect` (
				`Effect`,
				`PrinterId`),
	KEY	`EffName` (
				`PrinterId`,
				`EffName`))
	COMMENT = "Printer control codes";
DROP TABLE IF EXISTS `common_RatePref`;
CREATE TABLE `common_RatePref`(
	`Brand`	CHAR(8) COMMENT "character|x(8)|Brand|Brand|Code Of Brand|",
	`CustRate`	TINYINT(1) DEFAULT "0" COMMENT "logical|Yes/No|CustRate|CustRate|Are customer related rates allowed|",
	`DialType`	INT DEFAULT "0" COMMENT "integer|>9|Dialling Type|DialType|Dialling Type|",
	`Prefix`	CHAR(5) COMMENT "character|x(5)|Prefix|Prefix|Operator prefix where price list is attached to|",
	`RatePref`	CHAR(5) COMMENT "character|x(5)|Rating Prefix|RatePref|Prefix that is used for rating|",
	PRIMARY KEY	(`Brand`,`Prefix`,`DialType`),
	KEY	`DialType` (
				`Brand`,
				`DialType`,
				`Prefix`),
## The PROGRESS database primary index
	KEY	`Prefix` (
				`Brand`,
				`Prefix`,
				`DialType`))
	COMMENT = "?";
DROP TABLE IF EXISTS `common_RequestAction`;
CREATE TABLE `common_RequestAction`(
	`Action`	INT DEFAULT "0" COMMENT "integer|>9|Action|?|Action|1=create,2=terminate,3=move",
	`ActionKey`	CHAR(12) COMMENT "character|x(12)|Action Key|Key|Key value of the action type|",
	`ActionType`	CHAR(20) COMMENT "character|x(20)|Action Type|Act.Type|Action type|",
	`Brand`	CHAR(8) COMMENT "character|x(8)|Brand|?|Code of brand|",
	`CLIType`	CHAR(12) COMMENT "character|x(12)|CLI Type|CLIType|Type of the subscription|",
	`PayType`	INT DEFAULT "0" COMMENT "integer|9|Payment Type|PayType|Payment type|postpaid, prepaid",
	`ReqType`	INT DEFAULT "0" COMMENT "integer|>>9|Request Type|Type||Request type",
	`RequestActionID`	INT DEFAULT "0" COMMENT "integer|>>>>>>>9|Request Action ID|ID|Request action ID|",
	`ValidFrom`	DATE COMMENT "date|99-99-99|Valid From|From|Date when configuration becomes effective|",
	`ValidTo`	DATE COMMENT "date|99-99-99|Valid To|To|Date when configuration expires|",
	PRIMARY KEY	(`RequestActionID`),
	KEY	`CLIType` (
				`Brand`,
				`CLIType`,
				`ReqType`,
				`ValidTo`),
	KEY	`PayType` (
				`Brand`,
				`PayType`,
				`ReqType`,
				`ValidTo`),
	KEY	`ReqType` (
				`Brand`,
				`ReqType`,
				`ValidTo`),
## The PROGRESS database primary index
	KEY	`RequestActionID` (
				`RequestActionID`))
	COMMENT = "Request actions";
DROP TABLE IF EXISTS `common_RequestParam`;
CREATE TABLE `common_RequestParam`(
	`Brand`	CHAR(8) COMMENT "character|x(8)|Brand|?|Code of brand|",
	`CharConfig`	CHAR(30) COMMENT "character|x(30)|Configuration|?|Configuration|",
	`Description`	CHAR(50) COMMENT "character|x(50)|Description|?|Description|",
	`DispParam`	TINYINT(1) DEFAULT "1" COMMENT "logical|Yes/No|Display Parameter|Display|Display parameter in UI|",
	`ParamField`	CHAR(12) COMMENT "character|x(12)|Parameter|?|Parameter field|",
	`ReqType`	INT DEFAULT "0" COMMENT "integer|>>9|Request Type|Type||Request type",
	`Usage`	CHAR(30) COMMENT "character|x(30)|Usage|?|Usage, i.e. contents of parameter|",
	PRIMARY KEY	(`Brand`,`ReqType`,`ParamField`),
## The PROGRESS database primary index
	KEY	`ParamField` (
				`Brand`,
				`ReqType`,
				`ParamField`))
	COMMENT = "Request parameters";
DROP TABLE IF EXISTS `common_RequestQueue`;
CREATE TABLE `common_RequestQueue`(
	`Brand`	CHAR(8) COMMENT "character|x(8)|Brand|?|Code of brand|",
	`Interval`	INT DEFAULT "0" COMMENT "integer|>>>>>9|Interval|?|Interval in seconds|",
	`InUse`	TINYINT(1) DEFAULT "1" COMMENT "logical|Yes/No|Used|?|Request type is handled|",
	`LogEntry`	CHAR(20) COMMENT "character|x(20)|Log Entry|?|Log entry|",
	`LogOn`	TINYINT(1) DEFAULT "0" COMMENT "logical|Yes/No|Logging On|Logging|Logging on|",
	`LogThreshold`	DECIMAL DEFAULT "0" COMMENT "decimal|>>>>>>>>>9|Log Threshold|Threshold|Log threshold|",
	`Monitor`	CHAR(40) COMMENT "character|x(40)|Monitor Command|Monitor|Command for monitoring|",
	`MonitorOn`	TINYINT(1) DEFAULT "0" COMMENT "logical|Yes/No|Monitoring On|?|Monitoring on|",
	`QName`	CHAR(30) COMMENT "character|x(30)|Description|Name|Queue description|",
	`Queue`	INT DEFAULT "0" COMMENT "integer|>>>9|Queue Nbr|Queue|Queue in which this type is handled|",
	PRIMARY KEY	(`Brand`,`Queue`),
## The PROGRESS database primary index
	KEY	`Queue` (
				`Brand`,
				`Queue`))
	COMMENT = "Request queue";
DROP TABLE IF EXISTS `common_RequestStatus`;
CREATE TABLE `common_RequestStatus`(
	`Brand`	CHAR(8) COMMENT "character|x(8)|Brand|?|Code of brand|",
	`InUse`	TINYINT(1) DEFAULT "1" COMMENT "logical|Yes/No|Used|?|Request status is handled|",
	`LogClear`	TINYINT(1) DEFAULT "0" COMMENT "logical|Yes/No|Clear Log|?|Clear log on each round|",
	`LogEntry`	CHAR(20) COMMENT "character|x(20)|Log Entry|?|Log entry|",
	`LogFile`	CHAR(40) COMMENT "character|x(40)|Log File|File|Log file|",
	`LogOn`	TINYINT(1) DEFAULT "0" COMMENT "logical|Yes/No|Logging On|Logging|Logging on|",
	`LogThreshold`	DECIMAL DEFAULT "0" COMMENT "decimal|>>>>>>>>>9|Log Threshold|Threshold|Log threshold|",
	`Program`	CHAR(30) COMMENT "character|x(30)|Program|?|Program that contains logic for this status|",
	`ReqStatus`	INT DEFAULT "0" COMMENT "integer|>>9|Request Status|Status|Request status|",
	`ReqType`	INT DEFAULT "0" COMMENT "integer|>>9|Request Type|Type||Request type",
	PRIMARY KEY	(`Brand`,`ReqType`,`ReqStatus`),
## The PROGRESS database primary index
	KEY	`ReqStatus` (
				`Brand`,
				`ReqType`,
				`ReqStatus`))
	COMMENT = "Status configuration for requests";
DROP TABLE IF EXISTS `common_RequestType`;
CREATE TABLE `common_RequestType`(
	`Brand`	CHAR(8) COMMENT "character|x(8)|Brand|?|Code of brand|",
	`InUse`	TINYINT(1) DEFAULT "1" COMMENT "logical|Yes/No|Used|?|Request type is handled|",
	`LogClear`	TINYINT(1) DEFAULT "0" COMMENT "logical|Yes/No|Clear Log|?|Clear log on each round|",
	`LogEntry`	CHAR(20) COMMENT "character|x(20)|Log Entry|?|Log entry|",
	`LogFile`	CHAR(40) COMMENT "character|x(40)|Log File|File|Log file|",
	`LogOn`	TINYINT(1) DEFAULT "0" COMMENT "logical|Yes/No|Logging On|Logging|Logging on|",
	`Program`	CHAR(30) COMMENT "character|x(30)|Program|?|Program that contains logic for this type|",
	`Queue`	INT DEFAULT "0" COMMENT "integer|>>>9|Queue Nbr|Queue|Queue in which this type is handled|",
	`ReqName`	CHAR(30) COMMENT "character|x(30)|Name|?|Description of request type|",
	`ReqType`	INT DEFAULT "0" COMMENT "integer|>>9|Request Type|Type||Request type",
	`UserCode`	CHAR(12) NOT NULL COMMENT "character|x(12)|User ID|?|User ID for logs|",
	PRIMARY KEY	(`Brand`,`ReqType`),
	KEY	`Queue` (
				`Brand`,
				`Queue`,
				`ReqType`),
## The PROGRESS database primary index
	KEY	`ReqType` (
				`Brand`,
				`ReqType`))
	COMMENT = "Request type configuration";
DROP TABLE IF EXISTS `common_RZItem`;
CREATE TABLE `common_RZItem`(
	`CountryPrefix`	CHAR(6) COMMENT "character|x(6)|CountryPrefix|CCode|Country Code ()|",
	`CustNum`	INT DEFAULT "0" COMMENT "integer|>>>>>>>9|Customer|Cust.|Customer number|",
	`PlmnCode`	CHAR(8) COMMENT "character|x(8)|PlmnCode|PLMN Code|Code of PLMN|",
	`RoamZone`	CHAR(12) COMMENT "character|x(12)|RZItem|RoamZone|RoamZone|",
	`RZIType`	CHAR(8) COMMENT "character|x(8)|Type|Type|product type|",
	`ValidFrom`	DATE COMMENT "date|99-99-9999|Valid From|From|Effective from date|",
	`ValidTo`	DATE COMMENT "date|99-99-9999|Valid To|To|Effective to date|",
	PRIMARY KEY	(`RZIType`,`PlmnCode`,`ValidFrom`,`ValidTo`),
	KEY	`CountryPrefix` (
				`CountryPrefix`),
	KEY	`CustNum` (
				`CustNum`,
				`PlmnCode`,
				`ValidFrom`,
				`ValidTo`),
## The PROGRESS database primary index
	KEY	`PLMNCode` (
				`RZIType`,
				`PlmnCode`,
				`ValidFrom`,
				`ValidTo`),
	KEY	`RoamZone` (
				`RoamZone`,
				`PlmnCode`))
	COMMENT = "Roaming Zone for PLMN";
DROP TABLE IF EXISTS `common_SalesChain`;
CREATE TABLE `common_SalesChain`(
	`Brand`	CHAR(8) COMMENT "character|x(8)|Brand|Brand|Code of brand|",
	`CompanyID`	CHAR(16) COMMENT "character|x(16)|Company ID|Company|Company ID|",
	`SalesChain`	CHAR(16) COMMENT "character|x(16)|Sales Chain|Chain|Sales chain|",
	`SCName`	CHAR(40) COMMENT "character|x(40)|Name|Name|Chain name|",
	PRIMARY KEY	(`Brand`,`SalesChain`),
## The PROGRESS database primary index
	KEY	`SalesChain` (
				`Brand`,
				`SalesChain`))
	COMMENT = "?";
DROP TABLE IF EXISTS `common_SalesEvent`;
CREATE TABLE `common_SalesEvent`(
	`Brand`	CHAR(8) COMMENT "character|x(8)|Brand|Brand|Code of brand|",
	`Commission`	DATE COMMENT "date|99-99-9999|Commission|Comm.|Commission calculated|",
	`EventDate`	DATE COMMENT "date|99-99-9999|Event Date|Date|Event Date|",
	`HostTable`	CHAR(16) COMMENT "character|x(16)|Host Table|Table|Host table|",
	`KeyValue`	CHAR(16) COMMENT "character|x(16)|Key Value|Key|Key value|",
	`OrderDate`	DATE COMMENT "date|99-99-9999|Order date|Order date|Date when order is placed|",
	`OrderId`	CHAR(16) COMMENT "character|x(16)|Order Id|Order Id|Order Id of the sales event|",
	`OrderMsisdn`	CHAR(12) COMMENT "character|x(12)|Order Msisdn|Order Msisdn|Msisdn used during order|",
	`Reseller`	CHAR(16) COMMENT "character|x(16)|Reseller|Reseller|Reseller|",
	`SalesChain`	CHAR(16) COMMENT "character|x(16)|Sales Chain|Chain|Sales chain|",
	`SalesChannel`	CHAR(16) COMMENT "character|x(16)|Sales Channel|Sales Channel|Sales Channel|",
	`SalesEventID`	INT DEFAULT "0" COMMENT "integer|>>>>>>>9|Sales Event ID|EventID|Sales event ID|unique sequence ID",
	`Salesman`	CHAR(16) COMMENT "character|x(16)|Salesman|Salesman|Salesman|",
	`SalesType`	CHAR(10) DEFAULT "new" COMMENT "character|x(10)|Sales Type|Sales Type|Sales type category|",
	PRIMARY KEY	(`Brand`,`SalesChain`,`Reseller`,`Salesman`,`EventDate`),
	KEY	`Commission` (
				`Brand`,
				`Commission`),
	KEY	`EventDate` (
				`Brand`,
				`EventDate`),
	KEY	`HostTable` (
				`Brand`,
				`HostTable`,
				`KeyValue`,
				`EventDate`),
	KEY	`Reseller` (
				`Brand`,
				`Reseller`,
				`EventDate`),
## The PROGRESS database primary index
	KEY	`SalesChain` (
				`Brand`,
				`SalesChain`,
				`Reseller`,
				`Salesman`,
				`EventDate`),
	KEY	`SalesEventID` (
				`SalesEventID`),
	KEY	`Salesman` (
				`Brand`,
				`Salesman`,
				`EventDate`))
	COMMENT = "?";
DROP TABLE IF EXISTS `common_SalesmanToReseller`;
CREATE TABLE `common_SalesmanToReseller`(
	`Reseller`	CHAR(16) COMMENT "character|x(16)|Reseller|Reseller|Reseller code|",
	`Salesman`	CHAR(16) COMMENT "character|x(16)|Salesman|Salesman|Salesman|",
	PRIMARY KEY	(`Salesman`,`Reseller`),
## The PROGRESS database primary index
	KEY	`SalRes` (
				`Salesman`,
				`Reseller`))
	COMMENT = "?";
DROP TABLE IF EXISTS `common_SubventionEvent`;
CREATE TABLE `common_SubventionEvent`(
	`BillCode`	CHAR(16) COMMENT "character|x(16)|Billing Item|Bill.Item|Billing item for invoice rows|",
	`CustNum`	INT DEFAULT "0" COMMENT "integer|>>>>>>>9|Customer|Cust.|Customer number (saleschain/dealer)|",
	`EventActivated`	DATE COMMENT "date|99-99-9999|EventActivated|Activated|Event activated|",
	`InvNum`	INT DEFAULT "0" COMMENT "integer|>>>>>>>9|Invoice Number|Invoice|Invoice number (internal)|",
	`SalesEventID`	INT DEFAULT "0" COMMENT "integer|>>>>>>>9|Sales Event ID|SalesEvent|Sales event ID|Sales event ID",
	`SubInvNum`	INT DEFAULT "0" COMMENT "integer|>>>>>>>9|SubInvoice Number|SubInvoice|SubInvoice number (internal)|",
	`SubvAmount`	DECIMAL DEFAULT "0" COMMENT "decimal|->>>>>>9.99|Subvention Amount|Subv.Amt|Subvention amount|",
	`SubvCalculated`	DATE COMMENT "date|99-99-9999|Subvention Calculated|Subv.Calc|Subvention calculated|",
	`SubvEventID`	INT DEFAULT "0" COMMENT "integer|>>>>>>>9|Event ID|Event|Subvention event ID|",
	`SubvPaid`	DATE COMMENT "date|99-99-9999|Subvention Paid|Subv.Paid|Subvention paid|",
	`SubvPointDate`	DATE COMMENT "date|99-99-99|Subvention Point|Subv.Point|Subvention point|",
	`SubvRateID`	INT DEFAULT "0" COMMENT "integer|>>>>>>>9|Rate ID|?|Subvention rate ID|",
	`SubvRuleID`	INT DEFAULT "0" COMMENT "integer|>>>>>>>9|Rule ID|Rule|Subvention rule ID|",
	`SubvType`	CHAR(16) COMMENT "character|x(16)|Type|?|Subvention type|",
	`VATIncl`	TINYINT(1) DEFAULT "1" COMMENT "logical|Incl/Excl|Tax Included|Tax|Is tax Included/Excluded in amounts|",
	PRIMARY KEY	(`SubvEventID`),
	KEY	`CustNum` (
				`CustNum`,
				`SubvPaid`),
	KEY	`InvNum` (
				`InvNum`,
				`SubInvNum`),
	KEY	`SalesEventID` (
				`SalesEventID`),
## The PROGRESS database primary index
	KEY	`SubvEventID` (
				`SubvEventID`),
	KEY	`SubvPointDate` (
				`SubvPointDate`),
	KEY	`SubvRateID` (
				`SubvRateID`,
				`SubvCalculated`),
	KEY	`SubvRuleID` (
				`SubvRuleID`,
				`SubvPaid`))
	COMMENT = "Event from subvention calculation";
DROP TABLE IF EXISTS `common_SubventionLog`;
CREATE TABLE `common_SubventionLog`(
	`RejectReason`	CHAR(8) COMMENT "character|x(8)|Reject Reason|Reject|Reject reason|",
	`SalesEventID`	INT DEFAULT "0" COMMENT "integer|>>>>>>>9|Sales Event ID|SalesEvent|Sales event ID|Sales event ID",
	`SubvCalculated`	DATE COMMENT "date|99-99-9999|Subv. Calculated|Calculated|Subvention calculated|",
	`SubvInfo`	CHAR(40) COMMENT "character|x(40)|Info|Info|Information|",
	`SubvPointDate`	DATE COMMENT "date|99-99-9999|Subv. Point|Subv.Point|Subvention point|",
	`SubvType`	CHAR(16) COMMENT "character|x(16)|Type|?|Subvention type|",
	PRIMARY KEY	(`SalesEventID`,`SubvCalculated`),
## The PROGRESS database primary index
	KEY	`SalesEventID` (
				`SalesEventID`,
				`SubvCalculated`),
	KEY	`SubvCalculated` (
				`SubvCalculated`),
	KEY	`SubvPointDate` (
				`SubvPointDate`))
	COMMENT = "Log from subvention calculation";
DROP TABLE IF EXISTS `common_TableToken`;
CREATE TABLE `common_TableToken`(
	`tablename`	CHAR(15) COMMENT "character|X(15)|Table name|?|Database table name|",
	`tokencode`	CHAR(50) COMMENT "character|X(50)|Tokens|?|Comma separed list of Token codes|",
	PRIMARY KEY	(`tablename`),
## The PROGRESS database primary index
	KEY	`tablename` (
				`tablename`))
	COMMENT = "?";
DROP TABLE IF EXISTS `common_TMSCodes`;
CREATE TABLE `common_TMSCodes`(
	`CodeGroup`	CHAR(10) COMMENT "character|X(10)|Group|Group|Group Name for pre-defined values|Group in which pre-defined values can be categorised.",
	`CodeName`	CHAR(50) COMMENT "character|X(50)|Description|Description|Description/Name for pre-defined value|",
	`CodeValue`	CHAR(8) COMMENT "character|X(8)|Value|Value|Possible pre-defined value|",
	`ConfigValue`	CHAR(20) COMMENT "character|x(20)|Configuration Value|Config|Configuration value|",
	`FieldName`	CHAR(20) NOT NULL COMMENT "character|X(20)|Field Name|FieldName|Field Name in the table|Name of the Field in the table which is using pre-defined values.",
	`InUse`	INT DEFAULT "0" COMMENT "integer|9|Code In Use|Used|Is code in use|",
	`Memo`	CHAR(60) COMMENT "character|X(60)|Memo|Memo|Detailed description for pre-defined values|",
	`TableName`	CHAR(15) NOT NULL COMMENT "character|X(15)|Table Name|Table Name|Database Table Name|DB table, field of which is using pre-defined values.",
	PRIMARY KEY	(`TableName`,`FieldName`,`CodeValue`),
	KEY	`CodeGroup` (
				`CodeGroup`,
				`FieldName`),
## The PROGRESS database primary index
	KEY	`TableName` (
				`TableName`,
				`FieldName`,
				`CodeValue`))
	COMMENT = "General selection list values in TMS application";
DROP TABLE IF EXISTS `common_TMSParam`;
CREATE TABLE `common_TMSParam`(
	`Brand`	CHAR(8) COMMENT "character|x(8)|Brand|Brand|Code Of Brand|",
	`CharVal`	CHAR(50) COMMENT "character|x(50)|Char|Char|Character value|",
	`DateVal`	DATE COMMENT "date|99-99-9999|Date|Date|Date|",
	`DecVal`	DECIMAL DEFAULT "0" COMMENT "decimal|->>>>>>>9.99<<<<|Decimal|Decimal|Decimal value|",
	`IntVal`	INT DEFAULT "0" COMMENT "integer|->>>>>>>>9|Integer|Integer|Integer value|",
	`Online`	TINYINT(1) DEFAULT "0" COMMENT "logical|Y/N|OnLine|OnLine|Is this parameter used with OnLine connection ?|",
	`ParamCode`	CHAR(24) COMMENT "character|x(24)|Code|Code|Parameter code (description)|",
	`ParamGroup`	CHAR(16) NOT NULL COMMENT "character|x(16)|Group|Group|Parameter Group|",
	`ParamName`	CHAR(30) COMMENT "character|x(30)|Parameter|Parameter|Name of parameter|",
	`ParamType`	CHAR(2) COMMENT "character|xx|Type|Type|Type of character (I,C,DE,DA)|",
	PRIMARY KEY	(`Brand`,`ParamGroup`,`ParamCode`),
	KEY	`ParamCode` (
				`Brand`,
				`ParamCode`,
				`ParamGroup`),
## The PROGRESS database primary index
	KEY	`ParamGroup` (
				`Brand`,
				`ParamGroup`,
				`ParamCode`),
	KEY	`ParamName` (
				`Brand`,
				`ParamName`))
	COMMENT = "Company parameters";
DROP TABLE IF EXISTS `common_TMSPass`;
CREATE TABLE `common_TMSPass`(
	`CreateTS`	DECIMAL DEFAULT "0" NOT NULL COMMENT "decimal|99999999.99999|CreateTS|CreateTS|Password create timestamp|Timestamp of password creation",
	`Creator`	CHAR(8) NOT NULL COMMENT "character|x(8)|Created by|Created by|User ID, 1 - 8 characters|Creator of the password",
	`Password`	CHAR(16) NOT NULL COMMENT "character|x(16)|Password|Password|Password, 8 - 16 characters|Password",
	`UserCode`	CHAR(8) NOT NULL COMMENT "character|x(8)|User ID|User ID|User ID, 1 - 8 characters|Usercode",
	PRIMARY KEY	(`UserCode`,`CreateTS`),
## The PROGRESS database primary index
	KEY	`UserCode` (
				`UserCode`,
				`CreateTS`))
	COMMENT = "TMS Passwords";
DROP TABLE IF EXISTS `common_TMSPrinter`;
CREATE TABLE `common_TMSPrinter`(
	`Device`	CHAR(30) COMMENT "character|x(30)|FysName|FysName|Printer's device name|",
	`PageLength`	INT DEFAULT "0" COMMENT "integer|ZZ9|PageSize|PageSize|Total length of page (default)|",
	`PageWidth`	INT DEFAULT "0" COMMENT "integer|ZZ9|PageWidth|PageWidht|Default line width on printer|",
	`PrinterId`	CHAR(24) COMMENT "character|x(24)|Mnemonic|Mnemonic|Printer's logical name|",
	`UseScript`	TINYINT(1) DEFAULT "0" COMMENT "logical|yes/no|Use scripts|Scripts|Use Unix scripts in output command|If true  then output through is used",
	PRIMARY KEY	(`PrinterId`),
## The PROGRESS database primary index
	KEY	`PrinterId` (
				`PrinterId`))
	COMMENT = "Printers";
DROP TABLE IF EXISTS `common_TMSRepCfg`;
CREATE TABLE `common_TMSRepCfg`(
	`Effect`	CHAR(1) COMMENT "character|x(1)|FX|FX|Code of a control code sequence|",
	`PrinterId`	CHAR(24) COMMENT "character|x(24)|Printer|Printer|Logical name for printer|",
	`RepName`	CHAR(8) COMMENT "character|x(8)|Print.name|Print.name|Name of a printout|",
	`UpdPerm`	TINYINT(1) DEFAULT "1" COMMENT "logical|Kylla/Ei|Ask|Ask|Ask printer's setup when starting to print (Y/N)|",
	`UserCode`	CHAR(8) NOT NULL COMMENT "character|x(8)|User ID|User ID|User ID, 1 - 8 characters|",
	PRIMARY KEY	(`RepName`,`UserCode`),
	KEY	`PrinterId` (
				`PrinterId`),
## The PROGRESS database primary index
	KEY	`RepName` (
				`RepName`,
				`UserCode`))
	COMMENT = "Report configuration";
DROP TABLE IF EXISTS `common_TMSReport`;
CREATE TABLE `common_TMSReport`(
	`ChEMail`	TINYINT(1) DEFAULT "0" COMMENT "logical|yes/no|?|?|Can user change the eMail address|",
	`Memo`	CHAR(32) COMMENT "character|x(32)|PrtExplanation|PrtExplanation|Name of a printout|",
	`PageWidth`	INT DEFAULT "0" COMMENT "integer|ZZ9|Width|Width|Maximum number of characters per line on printer|",
	`RepName`	CHAR(8) COMMENT "character|x(8)|Printname|Printname|Name of a printout|",
	`UpdPerm`	TINYINT(1) DEFAULT "1" COMMENT "logical|Kylla/Ei|Ask|Ask|Ask printer's setup when starting to print (Y/N)|",
	PRIMARY KEY	(`RepName`),
## The PROGRESS database primary index
	KEY	`RepName` (
				`RepName`))
	COMMENT = "Reports";
DROP TABLE IF EXISTS `common_TMSUser`;
CREATE TABLE `common_TMSUser`(
	`Active`	TINYINT(1) DEFAULT "1" COMMENT "logical|Yes/No|Activ|Activ|Active|",
	`AdminUser`	TINYINT(1) DEFAULT "0" COMMENT "logical|Yes/No|Admin User|Admin|Admin level user|",
	`Brand`	CHAR(40) COMMENT "character|x(40)|Brand|Brand|Code Of Brands|",
	`CreditLimit`	DECIMAL DEFAULT "0" COMMENT "decimal|>>>>>>>>>9.99|Crediting Limit|CreditLimit|Max. invoice amount that this user can credit|",
	`Email`	CHAR(40) COMMENT "character|x(40)|E-mail|E-mail|Customer's e-mail address|",
	`ErgoKeyb`	TINYINT(1) DEFAULT "0" COMMENT "logical|yes/no|ErgoKbd|ErgoKeyboard|Is this Erconomy keyboard|",
	`ForeignId`	CHAR(20) COMMENT "character|x(20)|ForeignId|ForeignId||",
	`FromDate`	DATE COMMENT "date|99-99-99|Date from|Date from|Activation date|",
	`Initials`	CHAR(3) COMMENT "character|x(3)|Sort|Sort|User initials|",
	`Password`	CHAR(8) COMMENT "character|x(8)|Passwrd|Passwrd|Password, 1 - 8 characters|",
	`RepDir`	CHAR(30) COMMENT "character|x(30)|Txt-directory|Txt-directory|Default output  dirctory of .txt files|",
	`StartMenu`	CHAR(5) COMMENT "character|x(5)|GroupNo|GroupNo|Salesgroup's ID|",
	`ToDate`	DATE COMMENT "date|99-99-99|Date to|Date to|Expiring date|",
	`TopUpLimit`	INT DEFAULT "75" COMMENT "integer|999|TopUpLimit|TopUpLimit|Max amount TMS-user can give TopUp|",
	`UserCode`	CHAR(8) NOT NULL COMMENT "character|x(8)|User ID|User ID|User ID, 1 - 8 characters|",
	`UserGroup`	CHAR(10) COMMENT "character|x(10)|GroupCode|GroupCode|Individual Code for a User Group|",
	`UserName`	CHAR(30) COMMENT "character|x(30)|Name|Name|Entire name of user|",
	`UserNum`	INT DEFAULT "0" NOT NULL COMMENT "integer|999|UserNo|UserNo|User's internal consecutive number|User ID number",
	`WorkStation`	TINYINT(1) DEFAULT "0" COMMENT "logical|Monocrome/Color|Workst.|Workst.|Is a workstation black&white or colour|",
	PRIMARY KEY	(`UserCode`),
	KEY	`ForeignId` (
				`ForeignId`,
				`UserCode`,
				`UserName`),
## The PROGRESS database primary index
	KEY	`UserCode` (
				`UserCode`),
	KEY	`UserGroup` (
				`UserGroup`),
	KEY	`UserName` (
				`UserName`,
				`UserCode`),
	KEY	`UserNum` (
				`UserNum`))
	COMMENT = "Users";
DROP TABLE IF EXISTS `common_Token`;
CREATE TABLE `common_Token`(
	`AdminToken`	TINYINT(1) DEFAULT "0" COMMENT "logical|Yes/No|Admin Token|Admin|Admin level token|",
	`tokencode`	CHAR(12) COMMENT "character|X(12)|Token|?|Token code|",
	`tokenname`	CHAR(30) COMMENT "character|X(30)|Name|?|Name of token|",
	PRIMARY KEY	(`tokencode`),
## The PROGRESS database primary index
	KEY	`token` (
				`tokencode`))
	COMMENT = "?";
DROP TABLE IF EXISTS `common_UserGrp`;
CREATE TABLE `common_UserGrp`(
	`ChgDate`	DATE COMMENT "date|99-99-99|Changed|Changed|Date when Group and/or its members were changed|",
	`ChgUser`	CHAR(8) COMMENT "character|x(8)|Changed by|Changed by|User who changed/updated this group latest|",
	`CreDate`	DATE COMMENT "date|99-99-99|Created|Created|Date When Group Was Created|",
	`CreUser`	CHAR(8) COMMENT "character|x(8)|Created by|Created by|User who created this group|",
	`ModifyTokens`	CHAR(50) COMMENT "character|x(50)|Modify Tokens|?|Comma separed list of Token codes|",
	`PasswordExpires`	TINYINT(1) DEFAULT "1" COMMENT "logical|Yes/No|Password expires|?|Shall the passwords of this group expire|",
	`ShowTokens`	CHAR(50) COMMENT "character|x(50)|Show Tokens|?|Comma separed list of Token codes|",
	`UGName`	CHAR(40) COMMENT "character|x(40)|Name|Name|Name of user group|",
	`UserGroup`	CHAR(10) COMMENT "character|x(10)|GroupCode|GroupCode|Individual Code for a User Group|",
	PRIMARY KEY	(`UserGroup`),
	KEY	`UGName` (
				`UGName`),
## The PROGRESS database primary index
	KEY	`UserGroup` (
				`UserGroup`))
	COMMENT = "User Groups";
DROP TABLE IF EXISTS `common_UserLimit`;
CREATE TABLE `common_UserLimit`(
	`Brand`	CHAR(8) COMMENT "character|x(8)|Brand|Brand|Code Of Brands|",
	`LimitAmt`	DECIMAL DEFAULT "0" COMMENT "decimal|>>>>>>>>>9.99|LimitAmt|LimitAmt|Limit amount|",
	`LimitTarget`	CHAR(12) COMMENT "character|x(12)|LimitTarget|LimitTarget|Limit target type|",
	`LimitTargetID`	CHAR(12) COMMENT "character|x(12)|LimitTargetID|LimitTargetID|Limit target ID|",
	`LimitType`	INT DEFAULT "0" COMMENT "integer|>9|LimitType|LimitType|Limit type|",
	PRIMARY KEY	(`Brand`,`LimitType`,`LimitTarget`,`LimitTargetID`),
## The PROGRESS database primary index
	KEY	`Limit` (
				`Brand`,
				`LimitType`,
				`LimitTarget`,
				`LimitTargetID`))
	COMMENT = "User or usergroup limits";
