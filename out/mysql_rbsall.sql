DROP DATABASE IF EXISTS rbsall;
CREATE DATABASE rbsall;
USE rbsall;
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
