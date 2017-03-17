drop database if exists rbsall;
create database rbsall;
use rbsall;
DROP TABLE IF EXISTS `rbs_Account`;
CREATE TABLE `rbs_Account`(
	`AccName`	CHAR(30) COMMENT "character|x(30)|Name|Name|Account name|",
	`AccNum`	INT DEFAULT "0" COMMENT "integer|>>>>>9|Account|Account|Account number|",
	`AccType`	INT DEFAULT "0" COMMENT "integer|>9|Type|Type|Account usage type number|",
	`Brand`	CHAR(8) COMMENT "character|x(8)|Brand|Brand|Code Of Brand|",
	PRIMARY KEY	(`Brand`,`AccNum`),
	KEY	`AccName` (
				`Brand`,
				`AccName`),
## The PROGRESS database primary index
	KEY	`AccNum` (
				`Brand`,
				`AccNum`))
	COMMENT = "Accounts";
DROP TABLE IF EXISTS `rbs_AccPeriod`;
CREATE TABLE `rbs_AccPeriod`(
	`Brand`	CHAR(8) COMMENT "character|x(8)|Brand|Brand|Code Of Brand|",
	`FromDate`	DATE COMMENT "date|99-99-99|From|?|Beginning of period|",
	`LockDate`	DATE COMMENT "date|99/99/99|Lock date|Lock date|Period lock date|",
	`Period`	INT DEFAULT "0" COMMENT "integer|999999|Period|?|Accounting period|",
	`PerLocked`	TINYINT(1) DEFAULT "0" COMMENT "logical|Locked/Unlocked|Locked|?|If period is locked then no events can be posted to it.|",
	`ToDate`	DATE COMMENT "date|99-99-99|To|?|End of period|",
	PRIMARY KEY	(`Brand`,`Period`),
	KEY	`FromDate` (
				`Brand`,
				`FromDate`),
## The PROGRESS database primary index
	KEY	`Period` (
				`Brand`,
				`Period`),
	KEY	`ToDate` (
				`Brand`,
				`ToDate`))
	COMMENT = "?";
DROP TABLE IF EXISTS `rbs_Address`;
CREATE TABLE `rbs_Address`(
	`Address`	CHAR(30) COMMENT "character|x(30)|Street Address|Address|Street Address|",
	`AddressID`	INT DEFAULT "0" COMMENT "integer|>>>>>>>>>9|Address ID|ID|Address ID (sequence)|",
	`AddressType`	CHAR(8) COMMENT "character|x(8)|Address Type|Type|Address Type|",
	`Brand`	CHAR(8) COMMENT "character|x(8)|Brand|?|Code of brand|",
	`City`	CHAR(30) COMMENT "character|x(30)|City|?|City (post office)|",
	`Country`	CHAR(3) COMMENT "character|x(3)|Country|?|Country code|",
	`HostTable`	CHAR(12) NOT NULL COMMENT "character|x(12)|Host Table|Host|Name of table which this address is assigned to|",
	`KeyValue`	CHAR(16) NOT NULL COMMENT "character|x(16)|Key Value|Key|Key value of the record related to the address|",
	`Region`	CHAR(8) COMMENT "character|x(8)|Region|?|Region code|",
	`ZipCode`	CHAR(8) COMMENT "character|x(8)|Zip Code|?|Zip code|",
	PRIMARY KEY	(`Brand`,`HostTable`,`KeyValue`,`AddressType`),
	KEY	`AddressID` (
				`AddressID`),
	KEY	`AddressType` (
				`Brand`,
				`AddressType`,
				`HostTable`,
				`KeyValue`),
## The PROGRESS database primary index
	KEY	`HostTable` (
				`Brand`,
				`HostTable`,
				`KeyValue`,
				`AddressType`))
	COMMENT = "?";
DROP TABLE IF EXISTS `rbs_BankAccount`;
CREATE TABLE `rbs_BankAccount`(
	`AccNum`	INT DEFAULT "0" COMMENT "integer|>>>>>>>9|Account Number|Account|Account number|",
	`BankAccount`	CHAR(20) COMMENT "character|X(20)|Bank Account|?|Bank Account|",
	`BankData`	CHAR(20) COMMENT "character|X(20)|Bank Data|?|Bank account in standard format for transfer files|",
	`BankOffice`	CHAR(40) NOT NULL COMMENT "character|x(40)|Office|Office|Bank office's name|",
	`BarCode`	CHAR(60) COMMENT "character|x(60)|BarCode Forms|BarCode|Invoice forms, in which bar code uses this bank account|",
	`BIC`	CHAR(25) COMMENT "character|x(25)|Bank Identifier Code|BIC|Bank Identifier Code|",
	`Brand`	CHAR(8) COMMENT "character|x(8)|Brand|Brand|Code Of Brand|",
	`IBAN`	CHAR(25) COMMENT "character|x(25)|IBAN|IBAN|International bank account number|",
	`InvForm`	CHAR(60) COMMENT "character|x(60)|Invoice Forms|Forms|Invoice forms, to which this bank account is printed|",
	`UnitCode`	INT DEFAULT "0" COMMENT "integer|>>9|Unit|?|Unit number|",
	PRIMARY KEY	(`Brand`,`UnitCode`,`BankAccount`),
	KEY	`AccNum` (
				`Brand`,
				`BankAccount`),
## The PROGRESS database primary index
	KEY	`UnitBank` (
				`Brand`,
				`UnitCode`,
				`BankAccount`))
	COMMENT = "Company's bank accounts";
DROP TABLE IF EXISTS `rbs_BillItem`;
CREATE TABLE `rbs_BillItem`(
	`AccNum`	INT DEFAULT "0" COMMENT "integer|>>>>>9|Account|Account|Account number|",
	`Active`	TINYINT(1) DEFAULT "1" COMMENT "logical|Yes/No|Active|?|Is billing item active|",
	`BIGroup`	CHAR(8) COMMENT "character|x(8)|Bill.Item Group|BI Group|Billing item group code|",
	`BillCode`	CHAR(16) COMMENT "character|x(16)|Billing Item|BillItem|Billing item code, max 16 characters|",
	`BIName`	CHAR(30) COMMENT "character|x(30)|Bill.Item Name|BI Name|Billing item's name|",
	`Brand`	CHAR(8) COMMENT "character|x(8)|Brand|Brand|Code Of Brand|",
	`DebtType`	CHAR(12) COMMENT "character|x(12)|Debt Type|DebtType|Debt type|",
	`DispMPM`	TINYINT(1) DEFAULT "0" COMMENT "logical|Yes/No|Display MPM|MPM|Display MPM on specification reports|",
	`InvSect`	CHAR(8) COMMENT "character|x(8)|Invoice Section|Inv.Sect|Code of an Invoice Section|",
	`ISOrder`	INT DEFAULT "0" COMMENT "integer|>>9|Section Order|Order|Order within invoice section|",
	`SAPRid`	CHAR(8) COMMENT "character|x(8)|SAP Reporting ID|SAP RID|SAP reporting ID|",
	`TaxClass`	CHAR(8) COMMENT "character|x(8)|Tax Class|Class|Tax class|",
	`VATCode`	INT DEFAULT "1" COMMENT "integer|z9|VAT code|VAT code|VAT code|",
	PRIMARY KEY	(`Brand`,`BillCode`),
	KEY	`BIGroup` (
				`Brand`,
				`BIGroup`,
				`BillCode`),
## The PROGRESS database primary index
	KEY	`BillCode` (
				`Brand`,
				`BillCode`),
	KEY	`BIName` (
				`Brand`,
				`BIName`))
	COMMENT = "Billing items";
DROP TABLE IF EXISTS `rbs_BillItemRule`;
CREATE TABLE `rbs_BillItemRule`(
	`BillCode`	CHAR(16) COMMENT "character|x(16)|Billing Item|BillItem|Billing item|",
	`RuleText`	INT DEFAULT "0" COMMENT "integer|>>>9|Text ID|Text|Id for the text|",
	`RuleType`	CHAR(12) COMMENT "character|x(12)|Rule Type|Type|Rule type|",
	`SubstBillCode`	CHAR(16) COMMENT "character|x(16)|Substitute Bill. Item|Substitute|Substitute billing item|",
	`ValidFrom`	DATE COMMENT "date|99-99-9999|Valid From|From|Effective from date|",
	`ValidTo`	DATE COMMENT "date|99-99-9999|Valid To|To|Effective to date|",
	PRIMARY KEY	(`BillCode`,`RuleType`,`ValidTo`),
## The PROGRESS database primary index
	KEY	`BillCode` (
				`BillCode`,
				`RuleType`,
				`ValidTo`),
	KEY	`RuleType` (
				`RuleType`,
				`ValidTo`))
	COMMENT = "Billing item rule";
DROP TABLE IF EXISTS `rbs_BillType`;
CREATE TABLE `rbs_BillType`(
	`BillType`	CHAR(8) COMMENT "character|x(8)|Billing Object|Billing Object|Type Of Billing Object|",
	`BTName`	CHAR(30) COMMENT "character|x(30)|Billing Object Name|Billing Object Name|Name Of The Billing Object|",
	PRIMARY KEY	(`BillType`),
## The PROGRESS database primary index
	KEY	`BillType` (
				`BillType`),
	KEY	`BTName` (
				`BTName`,
				`BillType`))
	COMMENT = "Object Of Billing Type";
DROP TABLE IF EXISTS `rbs_BItemGroup`;
CREATE TABLE `rbs_BItemGroup`(
	`BIGName`	CHAR(30) COMMENT "character|x(30)|BIGroup Name|BIGName|Billing Item group name|",
	`BIGroup`	CHAR(8) COMMENT "character|x(8)|Bill.Item Group|BI Group|Billing item group code|",
	`Brand`	CHAR(8) COMMENT "character|x(8)|Brand|Brand|Code Of Brand|",
	`CCNDisplay`	TINYINT(1) DEFAULT "0" COMMENT "logical|yes/no|ShowCCN|ShowCCN|Should Billcode or CCN be shown on invoice xml|",
	`InvoiceOrder`	INT DEFAULT "0" COMMENT "integer|>>9|Invoice Order|Order|Printing order in invoice specification|",
	`Prior`	INT DEFAULT "10" COMMENT "integer|>9|Priority|Priority||",
	PRIMARY KEY	(`Brand`,`BIGroup`),
	KEY	`BIGName` (
				`Brand`,
				`BIGName`),
## The PROGRESS database primary index
	KEY	`BIGroup` (
				`Brand`,
				`BIGroup`))
	COMMENT = "Product Groups";
DROP TABLE IF EXISTS `rbs_CallAlarm`;
CREATE TABLE `rbs_CallAlarm`(
	`ActInterval`	CHAR(12) COMMENT "character|x(12)|Activation Interval|Act.Interval|Time interval of day when CallAlarm handling is allowed|",
	`ActStamp`	DECIMAL DEFAULT "0" COMMENT "decimal|99999999.99999|Activated|Activated|Date and Time When Call Alarm was  activated|Time Stamp yyyymmdd.time (sec)",
	`Brand`	CHAR(8) COMMENT "character|x(8)|Brand|Brand|Code Of Brand|",
	`CASeq`	INT DEFAULT "0" COMMENT "integer|>>>>>>>9|Seq|Seq|Call Alarm Sequence|",
	`CLI`	CHAR(12) COMMENT "character|x(12)|A-Sub|A-Sub|A-Subscriber number|",
	`ContractId`	INT DEFAULT "0" COMMENT "integer|>>>>>>9|Parent Contract ID|Contr.ID|Parent Contract ID|",
	`CreditType`	INT DEFAULT "0" COMMENT "integer|>9|CreditType|CreditType|Credit Type|",
	`CustNo`	INT DEFAULT "0" COMMENT "integer|zzzzzzzzz|CustNo|CustNo|Customer Number|",
	`DeliMsg`	CHAR(255) COMMENT "character|x(255)|Msg|Msg|Delivere message|",
	`DeliPara`	CHAR(40) COMMENT "character|x(40)|DeliverParam|DP|Delivere Parameter|",
	`DeliStat`	INT DEFAULT "1" COMMENT "integer|9|DeliStat|DeliStat|Delivery Status|",
	`Delitype`	INT DEFAULT "0" COMMENT "integer|>9|DeliType|DeliType|Delivere Type|",
	`Language`	CHAR(4) COMMENT "character|x(4)|ISO Language|ISO Lang|ISO Language Code|",
	`Orig`	CHAR(12) COMMENT "character|x(12)|OrigNo||Originating number|",
	PRIMARY KEY	(`Brand`,`CustNo`,`DeliStat`),
	KEY	`ActStamp` (
				`Brand`,
				`ActStamp`),
	KEY	`CLI` (
				`Brand`,
				`CLI`,
				`DeliStat`),
	KEY	`CLI_s` (
				`CLI`,
				`DeliStat`),
## The PROGRESS database primary index
	KEY	`CustNo` (
				`Brand`,
				`CustNo`,
				`DeliStat`),
	KEY	`Delistat` (
				`Brand`,
				`DeliStat`,
				`Delitype`,
				`CustNo`),
	KEY	`TimeStamp` (
				`ActStamp`))
	COMMENT = "?";
DROP TABLE IF EXISTS `rbs_CallAlarmParam`;
CREATE TABLE `rbs_CallAlarmParam`(
	`CASeq`	INT DEFAULT "0" COMMENT "integer|>>>>>>>9|Seq|Seq|Call alarm sequence|",
	`TagKey`	CHAR(30) COMMENT "character|x(30)|TagKey|TagKey|SMS message tag|",
	`TagValue`	CHAR(30) COMMENT "character|x(30)|TagValue|TagValue|SMS message tag value|",
	PRIMARY KEY	(`CASeq`,`TagKey`),
## The PROGRESS database primary index
	KEY	`CASeq` (
				`CASeq`,
				`TagKey`))
	COMMENT = "?";
DROP TABLE IF EXISTS `rbs_CallScanner`;
CREATE TABLE `rbs_CallScanner`(
	`EndTime`	CHAR(20) COMMENT "character|x(20)|EndTime|EndTime|EndTime to|",
	`EventType`	CHAR(8) COMMENT "character|x(8)|EventType|EventType|EventType|",
	`ReasonCode`	CHAR(8) COMMENT "character|x(8)|ReasonC|ReasonC|Reason code|",
	`SearchRule`	CHAR(40) COMMENT "character|x(40)|SearchRule|SearchRule|SearchRule|",
	`StartTime`	CHAR(20) COMMENT "character|x(20)|StartTime|StartTime|StartTime From|",
	`SystemID`	CHAR(8) COMMENT "character|x(8)|SystemID|SystemID|System ID|",
	`Target`	CHAR(20) COMMENT "character|x(20)|Target|Target|Target|",
	`TMSTime`	DECIMAL DEFAULT "0" COMMENT "decimal|99999999.99999|TMS Time|TMS Time|Timestamp|",
	`UserCode`	CHAR(8) COMMENT "character|x(8)|UserId|UserId|User ID who makes the CallScanner event|",
	PRIMARY KEY	(`TMSTime`),
	KEY	`ReasonCode` (
				`ReasonCode`,
				`TMSTime`),
## The PROGRESS database primary index
	KEY	`TMSTime` (
				`TMSTime`),
	KEY	`UserCode` (
				`UserCode`))
	COMMENT = "?";
DROP TABLE IF EXISTS `rbs_CCRule`;
CREATE TABLE `rbs_CCRule`(
	`AccNum`	INT DEFAULT "0" COMMENT "integer|>>>>>>>9|Account Number|Account|Account number|",
	`BillCode`	CHAR(16) COMMENT "character|x(16)|Billing Item|Bill.Item|Billing item|",
	`Brand`	CHAR(8) COMMENT "character|x(8)|Brand|Brand|Code Of Brand|",
	`Category`	CHAR(4) COMMENT "character|x(4)|Category|Category|Customer category code|",
	`CostCentre`	CHAR(8) COMMENT "character|x(8)|Cost Centre|Cc|Cost centre to be used|",
	`EUAccNum`	INT DEFAULT "0" COMMENT "integer|>>>>>>>9|EU Sales Account|EU Sales|EU sales account number|",
	`EUConsAccNum`	INT DEFAULT "0" COMMENT "integer|>>>>>>>9|EU Consumer Sales Account|EU Cons.Sales|EU consumer sales account number|",
	`FromDate`	DATE COMMENT "date|99-99-99|From|From|Date when rule becomes effective|",
	`FSAccNum`	INT DEFAULT "0" COMMENT "integer|>>>>>>>9|Foreign Sales Account|Foreign Sales|Foreign (outside EU) sales account number|",
	`ReportingID`	CHAR(12) COMMENT "character|x(12)|Reporting ID|ReportID|Reporting ID|",
	`ToDate`	DATE COMMENT "date|99-99-99|To|To|Date when rule expires|",
	PRIMARY KEY	(`Brand`,`Category`,`BillCode`,`ToDate`),
	KEY	`BillCode` (
				`Brand`,
				`BillCode`,
				`ToDate`),
## The PROGRESS database primary index
	KEY	`Category` (
				`Brand`,
				`Category`,
				`BillCode`,
				`ToDate`))
	COMMENT = "Rules for determining cost centre";
DROP TABLE IF EXISTS `rbs_CLIType`;
CREATE TABLE `rbs_CLIType`(
	`ArAccNum`	INT DEFAULT "0" COMMENT "integer|>>>>>>>9|Receivables Account|Receiv.|Account no. for Receivables|",
	`BillTarget`	INT DEFAULT "0" COMMENT "integer|>9|Number|Number|Customer's billing target|",
	`Brand`	CHAR(8) COMMENT "character|x(8)|BrCode|BrCode|Code Of Brand|",
	`CliName`	CHAR(25) COMMENT "character|x(25)|CLI Type Name|Name|Name of CLI type|",
	`Clitype`	CHAR(8) COMMENT "character|x(8)|CLI Type|CLIType|CLI Type|",
	`ContrType`	INT DEFAULT "1" COMMENT "integer|9|Contract Type|ContrType|Default contract type|",
	`PayType`	INT DEFAULT "0" COMMENT "integer|9|Payment Type|PayType|Payment type|",
	`PricePlan`	CHAR(12) COMMENT "character|x(12)|PricePlan Code|PPlan|Code of Price Plan|",
	`RoamGroup`	CHAR(12) COMMENT "character|x(12)|RoamGroup|RoamGroup|Roaming Group|",
	`ServicePack`	CHAR(8) COMMENT "character|x(8)|ServPack|ServPack|Default ServPack|",
	`WebDisp`	TINYINT(1) DEFAULT "0" COMMENT "logical|Yes/No|Display in Web|Web|Display CLI type in web|",
	PRIMARY KEY	(`Brand`,`Clitype`),
## The PROGRESS database primary index
	KEY	`Clitype` (
				`Brand`,
				`Clitype`),
	KEY	`CliType_s` (
				`Clitype`))
	COMMENT = "";
DROP TABLE IF EXISTS `rbs_CommissionEvent`;
CREATE TABLE `rbs_CommissionEvent`(
	`BillCode`	CHAR(16) COMMENT "character|x(16)|Billing Item|Bill.Item|Billing item for invoice rows|",
	`CommAmount`	DECIMAL DEFAULT "0" COMMENT "decimal|->>>>>>9.99|Commission Amount|Comm.Amt|Commission amount|",
	`CommCalculated`	DATE COMMENT "date|99-99-9999|Comm. Calculated|Calculated|Commission calculated|",
	`CommEventID`	INT DEFAULT "0" COMMENT "integer|>>>>>>>9|Event ID|Event|Commission event ID|",
	`CommPaid`	DATE COMMENT "date|99-99-9999|Commission Paid|Comm.Paid|Commission paid|",
	`CommPointDate`	DATE COMMENT "date|99-99-99|Commission Point|Comm.Point|Commission point|",
	`CommRateID`	INT DEFAULT "0" COMMENT "integer|>>>>>>>9|Rate ID|?|Commission rate ID|",
	`CommRuleID`	INT DEFAULT "0" COMMENT "integer|>>>>>>>9|Rule ID|Rule|Commission rule ID|",
	`CommType`	CHAR(16) COMMENT "character|x(16)|Type|?|Commission type|",
	`CustNum`	INT DEFAULT "0" COMMENT "integer|>>>>>>>9|Customer|Cust.|Customer number (saleschain/dealer)|",
	`EventActivated`	DATE COMMENT "date|99-99-9999|EventActivated|Activated|Event activated|",
	`EventAgrCust`	INT DEFAULT "0" COMMENT "integer|>>>>>>>9|Event Agr.Customer|Event Cust.|Event agreement customer number|",
	`InvNum`	INT DEFAULT "0" COMMENT "integer|>>>>>>>9|Invoice Number|Invoice|Invoice number (internal)|",
	`SalesEventID`	INT DEFAULT "0" COMMENT "integer|>>>>>>>9|Sales Event ID|SalesEvent|Sales event ID|Sales event ID",
	`SubInvNum`	INT DEFAULT "0" COMMENT "integer|>>>>>>>9|SubInvoice Number|SubInvoice|SubInvoice number (internal)|",
	`VATIncl`	TINYINT(1) DEFAULT "1" COMMENT "logical|Incl/Excl|Tax Included|Tax|Is tax Included/Excluded in amounts|",
	PRIMARY KEY	(`CommEventID`),
## The PROGRESS database primary index
	KEY	`CommEventID` (
				`CommEventID`),
	KEY	`CommPointDate` (
				`CommPointDate`),
	KEY	`CommRateID` (
				`CommRateID`,
				`CommCalculated`),
	KEY	`CommRuleID` (
				`CommRuleID`,
				`CommPaid`),
	KEY	`CustNum` (
				`CustNum`,
				`CommPaid`),
	KEY	`InvNum` (
				`InvNum`,
				`SubInvNum`),
	KEY	`SalesEventID` (
				`SalesEventID`))
	COMMENT = "Event from commission calculation";
DROP TABLE IF EXISTS `rbs_CommissionLog`;
CREATE TABLE `rbs_CommissionLog`(
	`CommCalculated`	DATE COMMENT "date|99-99-9999|Comm. Calculated|Calculated|Commission calculated|",
	`CommInfo`	CHAR(40) COMMENT "character|x(40)|Info|Info|Information|",
	`CommPointDate`	DATE COMMENT "date|99-99-9999|Comm. Point|Comm.Point|Commission point|",
	`CommTarget`	CHAR(16) COMMENT "character|x(16)|Commission Target|Target|Commission target|",
	`CommType`	CHAR(16) COMMENT "character|x(16)|Type|?|Commission type|",
	`RejectReason`	CHAR(8) COMMENT "character|x(8)|Reject Reason|Reject|Reject reason|",
	`SalesEventID`	INT DEFAULT "0" COMMENT "integer|>>>>>>>9|Sales Event ID|SalesEvent|Sales event ID|Sales event ID",
	PRIMARY KEY	(`SalesEventID`,`CommCalculated`),
	KEY	`CommCalculated` (
				`CommCalculated`),
	KEY	`CommPointDate` (
				`CommPointDate`),
## The PROGRESS database primary index
	KEY	`SalesEventID` (
				`SalesEventID`,
				`CommCalculated`))
	COMMENT = "Log from commission calculation";
DROP TABLE IF EXISTS `rbs_CommissionRate`;
CREATE TABLE `rbs_CommissionRate`(
	`BillCode`	CHAR(16) COMMENT "character|x(16)|Billing Item|Bill.Item|Billing item for invoice rows|",
	`CLIType`	CHAR(12) COMMENT "character|x(12)|Subscription Type|Subscr.Type|Subscription type|",
	`CommRate`	DECIMAL DEFAULT "0" COMMENT "decimal|->>>>>>9.99|Rate|?|Commission rate|",
	`CommRateID`	INT DEFAULT "0" COMMENT "integer|>>>>>>>9|Rate ID|?|Commission rate ID|",
	`CommRuleID`	INT DEFAULT "0" COMMENT "integer|>>>>>>>9|Rule ID|Rule|Commission rule ID|",
	`CommTarget`	CHAR(16) COMMENT "character|x(16)|Commission Target|Target|Commission target|",
	`RateType`	CHAR(8) COMMENT "character|x(8)|Rate Type|?|Rate type|",
	`SalesChannel`	CHAR(16) COMMENT "character|x(16)|Sales Channel|?|Sales channel|",
	`SalesType`	CHAR(10) COMMENT "character|x(10)|Sales Type|?|Sales type category|",
	`ValidFrom`	DATE COMMENT "date|99-99-9999|Valid From|From|Effective from date|",
	`ValidTo`	DATE COMMENT "date|99-99-9999|Valid To|To|Effective to date|",
	`VATIncl`	TINYINT(1) DEFAULT "1" COMMENT "logical|Incl/Excl|Tax Included|Tax|Is tax Included/Excluded in amounts|",
	PRIMARY KEY	(`CommRuleID`,`SalesChannel`,`SalesType`,`CLIType`,`CommTarget`,`ValidTo`),
	KEY	`CommRateID` (
				`CommRateID`),
## The PROGRESS database primary index
	KEY	`CommRuleID` (
				`CommRuleID`,
				`SalesChannel`,
				`SalesType`,
				`CLIType`,
				`CommTarget`,
				`ValidTo`))
	COMMENT = "Commission rate";
DROP TABLE IF EXISTS `rbs_CommissionRule`;
CREATE TABLE `rbs_CommissionRule`(
	`CommClass`	CHAR(8) COMMENT "character|x(8)|Class|?|Commission class|",
	`CommPoint`	INT DEFAULT "0" COMMENT "integer|>>9|Commission Point|Comm.Point|Commission (control) point|",
	`CommRuleID`	INT DEFAULT "0" COMMENT "integer|>>>>>>>9|Rule ID|Rule|Commission rule ID|",
	`CommType`	CHAR(16) COMMENT "character|x(16)|Type|?|Commission type|",
	`CRName`	CHAR(30) COMMENT "character|x(30)|Name|?|Rule name|",
	`DeliveryType`	CHAR(16) COMMENT "character|x(16)|Delivery Type|Delivery|Delivery type|",
	`MaxUnpaidDebt`	DECIMAL DEFAULT "0" COMMENT "decimal|->>>>>>9.99|Max Unpaid Debt|Max.Unpaid|Maximum unpaid debt|",
	`MinBilledAmt`	DECIMAL DEFAULT "0" COMMENT "decimal|->>>>>>9.99|Min Billed Amount|Min.Billed|Minimum billed amount|",
	`MinUnpaidDue`	INT DEFAULT "0" COMMENT "integer|>>>>9|Min Unpaid Overdue|Min.Overdue|Minimum overdue days for unpaid debt|",
	`ValidFrom`	DATE COMMENT "date|99-99-9999|Valid From|From|Effective from date|",
	`ValidTo`	DATE COMMENT "date|99-99-9999|Valid To|To|Effective to date|",
	`WaitForCommType`	CHAR(30) COMMENT "character|x(30)|Wait For Type|Wait Type|Commission type(s) that has to be handled before this one|",
	PRIMARY KEY	(`CommRuleID`),
	KEY	`CommClass` (
				`CommClass`,
				`CommType`,
				`DeliveryType`,
				`ValidTo`),
## The PROGRESS database primary index
	KEY	`CommRuleID` (
				`CommRuleID`),
	KEY	`CommType` (
				`CommType`,
				`ValidTo`))
	COMMENT = "Commission rule";
DROP TABLE IF EXISTS `rbs_CostCentre`;
CREATE TABLE `rbs_CostCentre`(
	`Brand`	CHAR(8) COMMENT "character|x(8)|Brand|Brand|Code Of Brand|",
	`CCName`	CHAR(30) COMMENT "character|x(30)|Name|?|Name of the cost centre|",
	`CostCentre`	CHAR(8) COMMENT "character|x(8)|Cost Centre|Cc|Cost Centre|",
	PRIMARY KEY	(`Brand`,`CostCentre`),
	KEY	`CCN` (
				`Brand`,
				`CCName`),
## The PROGRESS database primary index
	KEY	`CostCentre` (
				`Brand`,
				`CostCentre`))
	COMMENT = "Lowest level of cost accounting";
DROP TABLE IF EXISTS `rbs_CTServAttr`;
CREATE TABLE `rbs_CTServAttr`(
	`ChgAllowed`	TINYINT(1) DEFAULT "1" COMMENT "logical|Yes/No|Change Allowed|Changeable|Value can be changed on subscription level|",
	`CTServEl`	INT DEFAULT "0" COMMENT "integer|>>>>>>>9|Element ID|ID|Unique ID of CTServEl|",
	`DefValue`	CHAR(8) COMMENT "character|x(8)|Default Value|Value|Default value|",
	`FromDate`	DATE COMMENT "date|99-99-99|From Date|From|Valid from date|",
	`SendToHLR`	TINYINT(1) DEFAULT "1" COMMENT "logical|Yes/No|Send To HLR|HLR|Update the change of attribute value to HLR|",
	`ServAttr`	CHAR(14) COMMENT "character|x(14)|Service Attribute|Attribute|Attribute of a service component|",
	PRIMARY KEY	(`CTServEl`,`ServAttr`,`FromDate`),
## The PROGRESS database primary index
	KEY	`CTServAttr` (
				`CTServEl`,
				`ServAttr`,
				`FromDate`),
	KEY	`ServAttr` (
				`ServAttr`,
				`FromDate`))
	COMMENT = "Attributes of CLI type's service components";
DROP TABLE IF EXISTS `rbs_CTServEl`;
CREATE TABLE `rbs_CTServEl`(
	`Brand`	CHAR(8) COMMENT "character|x(8)|Brand|Brand|Code Of Brand|",
	`ChgAllowed`	TINYINT(1) DEFAULT "1" COMMENT "logical|Yes/No|Change Allowed|Changeable|Value can be changed on subscription level|",
	`CLIType`	CHAR(8) COMMENT "character|x(8)|CLI Type|CLIType|CLI type|",
	`CTServEl`	INT DEFAULT "0" COMMENT "integer|>>>>>>>9|Element ID|ID|Unique ID|",
	`DefValue`	INT DEFAULT "0" COMMENT "integer|>>>9|Default Value|Default|Default value|",
	`FromDate`	DATE COMMENT "date|99-99-99|From Date|From|Valid from date|",
	`ServCom`	CHAR(12) COMMENT "character|x(12)|Service Component|Component|Code of Service Component|",
	`ServPac`	CHAR(12) COMMENT "character|x(12)|Service Package|ServPack|Service package code|",
	PRIMARY KEY	(`Brand`,`CLIType`,`ServPac`,`ServCom`,`FromDate`),
## The PROGRESS database primary index
	KEY	`CLIType` (
				`Brand`,
				`CLIType`,
				`ServPac`,
				`ServCom`,
				`FromDate`),
	KEY	`CTServEl` (
				`CTServEl`),
	KEY	`ServCom` (
				`Brand`,
				`ServCom`,
				`CLIType`,
				`FromDate`))
	COMMENT = "Service elements of a CLI type";
DROP TABLE IF EXISTS `rbs_CTServPac`;
CREATE TABLE `rbs_CTServPac`(
	`Brand`	CHAR(8) COMMENT "character|x(8)|Brand|Brand|Code Of Brand|",
	`CLIType`	CHAR(8) COMMENT "character|x(8)|CLI Type|CLIType|CLI type|",
	`FromDate`	DATE COMMENT "date|99-99-99|From Date|From|Valid from date|",
	`ServPac`	CHAR(12) COMMENT "character|x(12)|Service Package|ServPack|Service package code|",
	`ServType`	INT DEFAULT "0" COMMENT "integer|9|Package Type|Type|Package type|",
	`ToDate`	DATE COMMENT "date|99-99-99|To Date|To|Valid to date|",
	PRIMARY KEY	(`Brand`,`CLIType`,`ServPac`,`FromDate`),
## The PROGRESS database primary index
	KEY	`CLIType` (
				`Brand`,
				`CLIType`,
				`ServPac`,
				`FromDate`),
	KEY	`ServPac` (
				`Brand`,
				`ServPac`,
				`CLIType`,
				`FromDate`))
	COMMENT = "Service Packages of a CLI type";
DROP TABLE IF EXISTS `rbs_CustBal`;
CREATE TABLE `rbs_CustBal`(
	`BalTarget`	CHAR(15) COMMENT "character|x(15)|Target|?|Balance target|",
	`CreditLoss`	DECIMAL DEFAULT "0" COMMENT "decimal|->>>>>>9.99|Credit Loss|Cr.Loss|Credit loss balance|",
	`CustNum`	INT DEFAULT "0" NOT NULL COMMENT "integer|>>>>>>>>9|Customer|Customer|Customer's number|",
	`Debt`	DECIMAL DEFAULT "0" COMMENT "decimal|->>>>>>9.99|Debt|?|Customer's open balance|",
	`LatestInv`	INT DEFAULT "0" COMMENT "integer|999999|InvPeriod|InvPer|Period of latest invoice|",
	`LatestPaym`	DATE COMMENT "date|99-99-99|Latest Payment|LastPaymDay|Customer's latest payment date|",
	`MsSeq`	INT DEFAULT "0" COMMENT "integer|>>>>>>>>9|Subscription ID|MobSub|Mobile subscription ID|",
	`OverPaym`	DECIMAL DEFAULT "0" COMMENT "decimal|->>>>>>>9.99|Overpayment|OverPaym|Overpayment balance|",
	`PaymMethod`	INT DEFAULT "0" COMMENT "integer|->>>9|MethOfPaym|MethOfPaym|Customer's payment behavior (days +/- dueday)|",
	`PaymQty`	INT DEFAULT "0" COMMENT "integer|>>>>9|Qty of Payments|PaymQty|Qty of customer's payments|Used in calculating payment behaviour",
	`TargetType`	CHAR(16) COMMENT "character|x(16)|Target Type|Type|Target type|",
	PRIMARY KEY	(`CustNum`,`TargetType`,`BalTarget`),
## The PROGRESS database primary index
	KEY	`CustNum` (
				`CustNum`,
				`TargetType`,
				`BalTarget`),
	KEY	`MsSeq` (
				`CustNum`,
				`MsSeq`))
	COMMENT = "Customer's balances";
DROP TABLE IF EXISTS `rbs_CustCat`;
CREATE TABLE `rbs_CustCat`(
	`ArAccNum`	INT DEFAULT "0" COMMENT "integer|>>>>>9|Receivables Account|Receiv.|Account no. for Receivables|",
	`Brand`	CHAR(8) COMMENT "character|x(8)|Brand|Brand|Code Of Brand|",
	`Category`	CHAR(4) COMMENT "character|x(4)|Category|Category|Category code, max 4 characters|",
	`CatName`	CHAR(30) COMMENT "character|x(30)|CategName|CategName|Name's of customer category|",
	`CatType`	CHAR(12) COMMENT "character|x(12)|Category Type|Type|Category type|",
	`CustIdType`	CHAR(8) COMMENT "character|x(8)|Customer ID Type|ID Type|Customer ID type|",
	`IntType`	INT DEFAULT "1" COMMENT "integer|9|Interest type|IntType|1 = fixed interest, 2 = in addition to euribor|",
	`MaxCredit`	INT DEFAULT "0" COMMENT "integer|z,zzz,zz9|MaxCredit|MaxCredit|Max credit for a customer in this category|",
	`PaymTerm`	INT DEFAULT "0" COMMENT "integer|>9|Payment Term|PaymTerm|Terms of payment (days)|",
	`SelfEmployed`	TINYINT(1) DEFAULT "0" COMMENT "logical|yes/no|Selfemployed|Selfempl.||",
	PRIMARY KEY	(`Brand`,`Category`),
## The PROGRESS database primary index
	KEY	`Category` (
				`Brand`,
				`Category`),
	KEY	`CatName` (
				`Brand`,
				`CatName`,
				`MaxCredit`))
	COMMENT = "Customer category";
DROP TABLE IF EXISTS `rbs_CustClass`;
CREATE TABLE `rbs_CustClass`(
	`Amt`	DECIMAL DEFAULT "0" COMMENT "decimal|>>>,>>9.99|Amt|Amt|Lowest limit|",
	`Brand`	CHAR(8) COMMENT "character|x(8)|Brand|Brand|Code Of Brand|",
	`CCName`	CHAR(30) COMMENT "character|x(30)|Name|Name|Name of the customer class|",
	`CustClass`	INT DEFAULT "0" COMMENT "integer|9|Class|Class|Customer Class (depend on avg. amount of invoices)|",
	PRIMARY KEY	(`Brand`,`CustClass`,`Amt`),
	KEY	`Amt` (
				`Brand`,
				`Amt`),
	KEY	`CCName` (
				`Brand`,
				`CCName`,
				`CustClass`),
## The PROGRESS database primary index
	KEY	`Class` (
				`Brand`,
				`CustClass`,
				`Amt`))
	COMMENT = "";
DROP TABLE IF EXISTS `rbs_CustCommClass`;
CREATE TABLE `rbs_CustCommClass`(
	`CommClass`	CHAR(16) COMMENT "character|x(16)|Class|?|Commission class|",
	`CustNum`	INT DEFAULT "0" COMMENT "integer|>>>>>>>9|Customer|Cust.|Customer number|",
	`ValidFrom`	DATE COMMENT "date|99-99-9999|Valid From|From|Effective from date|",
	`ValidTo`	DATE COMMENT "date|99-99-9999|Valid To|To|Effective to date|",
	PRIMARY KEY	(`CustNum`,`ValidTo`),
	KEY	`CommClass` (
				`CommClass`,
				`ValidTo`),
## The PROGRESS database primary index
	KEY	`CustNum` (
				`CustNum`,
				`ValidTo`))
	COMMENT = "Class to be used for customer (dealer)";
DROP TABLE IF EXISTS `rbs_CustContact`;
CREATE TABLE `rbs_CustContact`(
	`Brand`	CHAR(8) COMMENT "character|x(8)|Brand|Brand|Code Of Brand|",
	`CustContactID`	INT DEFAULT "0" COMMENT "integer|>>>>>>>9|Contact ID|ID|Contact ID|",
	`CustName`	CHAR(30) COMMENT "character|x(30)|CustContact's name|CustContact's name|CustContact's name|",
	`CustNum`	INT DEFAULT "0" NOT NULL COMMENT "integer|>>>>>>>>9|CustContact|CustContact|CustContact's number|",
	`CustType`	INT DEFAULT "0" NOT NULL COMMENT "integer|>>9|CustType|CustType|Contact customer type|",
	`DirMarkEmail`	TINYINT(1) DEFAULT "0" COMMENT "logical|yes/no|Direct Marketing Via Email|Dir.Mark.Email|Direct marketing using Email|",
	`DirMarkPost`	TINYINT(1) DEFAULT "0" COMMENT "logical|yes/no|Direct Marketing Via Post|Dir.Mark.Post|Direct marketing using post|",
	`DirMarkSMS`	TINYINT(1) DEFAULT "0" COMMENT "logical|yes/no|Direct Marketing Via SMS|Dir.Mark.SMS|Direct marketing using SMS|",
	`Email`	CHAR(60) COMMENT "character|x(60)|Email|Email|CustContact's Email ID|",
	`OrgId`	CHAR(11) COMMENT "character|x(11)|Pers/Comp.ID|?|CustContact's organisation ID or personal ID|",
	`OutMarkEmail`	TINYINT(1) DEFAULT "0" COMMENT "logical|yes/no|Out. Marketing Via Email|Out.Mark.Email|3rd party marketing using eMail|",
	`OutMarkPost`	TINYINT(1) DEFAULT "0" COMMENT "logical|yes/no|Out. Marketing Via Post|Out.Mark.Post|3rd part marketing using post|",
	`OutMarkSMS`	TINYINT(1) DEFAULT "0" COMMENT "logical|yes/no|Out. Marketing Via SMS|Out.Mark.SMS|3rd party marketing using SMS|",
	`SMSNumber`	CHAR(15) COMMENT "character|x(15)|SMS Number|SMS|Mobile number for SMS messages|",
	PRIMARY KEY	(`CustContactID`),
	KEY	`CustContact` (
				`Brand`,
				`CustNum`,
				`CustType`),
## The PROGRESS database primary index
	KEY	`CustContactId` (
				`CustContactID`))
	COMMENT = "CustContact";
DROP TABLE IF EXISTS `rbs_CustContractHistory`;
CREATE TABLE `rbs_CustContractHistory`(
	`AgrCust`	INT DEFAULT "0" COMMENT "integer|>>>>>>9|AgrCust|AgrCust|Owner customer|",
	`InvCust`	INT DEFAULT "0" COMMENT "integer|>>>>>>9|InvCust|InvCust|Invoice customer|",
	`PerContractId`	INT DEFAULT "0" COMMENT "integer|>>>>>>9|PerContractId|PerContractId|Unique ContractId|",
	`ValidFrom`	DATE COMMENT "date|99-99-9999|From|From|Start date|",
	`ValidTo`	DATE COMMENT "date|99-99-9999|To|To|End date|",
	PRIMARY KEY	(`PerContractId`,`ValidTo`),
	KEY	`idx_AgrCust` (
				`AgrCust`,
				`PerContractId`),
	KEY	`idx_InvCust` (
				`InvCust`,
				`PerContractId`),
## The PROGRESS database primary index
	KEY	`idx_PerContractID` (
				`PerContractId`,
				`ValidTo`))
	COMMENT = "?";
DROP TABLE IF EXISTS `rbs_CustCount`;
CREATE TABLE `rbs_CustCount`(
	`CustNum`	INT DEFAULT "0" NOT NULL COMMENT "integer|>>>>>>>>9|Customer|Customer|Customer's number|",
	`Unbilled`	DECIMAL DEFAULT "0" COMMENT "decimal|->>>>>>>9.99|Unbilled|?|Amount of customer's unbilled events|",
	PRIMARY KEY	(`CustNum`),
## The PROGRESS database primary index
	KEY	`CustNum` (
				`CustNum`))
	COMMENT = "Customer counters";
DROP TABLE IF EXISTS `rbs_Customer`;
CREATE TABLE `rbs_Customer`(
	`BankAcct`	CHAR(16) COMMENT "character|x(16)|BankAccount|BankAccount|Customer's Bank  Account No  (for DirectDebit purposes)|",
	`BankId`	CHAR(10) COMMENT "character|X(10)|BankId|BankId|Identification code for bank|",
	`BillingPerm`	TINYINT(1) DEFAULT "1" COMMENT "logical|Yes/No|Billing Permission|Bill.Perm.|Billing permission|",
	`Brand`	CHAR(8) COMMENT "character|x(8)|Brand|Brand|Code Of Brand|",
	`Category`	CHAR(4) COMMENT "character|x(4)|Cat|Cat|Category code, max 4 characters|",
	`ChargeType`	INT DEFAULT "1" COMMENT "integer|9|Charge Type|Charge|Customers default charging type|3=netgiro",
	`ChgStamp`	DECIMAL DEFAULT "0" COMMENT "decimal|99999999.99999|Created|Created|Date and Time When Customer Record was last changed|Time Stamp yyyymmdd.time (sec)",
	`ClaimPerm`	TINYINT(1) DEFAULT "1" COMMENT "logical|Yes/No|DueCond|DueCond|Send a payment reminder of the invoice (Y/N)|",
	`CompanyName`	CHAR(30) COMMENT "character|x(30)|Company Name|Company|Company name|",
	`COName`	CHAR(30) COMMENT "character|x(30)|Addt'l name|Addt'l name|Additional name of a customer|",
	`ContrBeg`	DATE COMMENT "date|99-99-9999|Cstart|Cstart|Day when contract was begun|",
	`CreDate`	DATE COMMENT "date|99-99-99|Created|Created|Date of creation|",
	`CreUser`	CHAR(8) COMMENT "character|x(8)|Created by|Created by|User who created this customer|",
	`Currency`	CHAR(5) COMMENT "character|x(5)|Currency|Currency|Currency code|",
	`CustIdType`	CHAR(8) COMMENT "character|x(8)|Customer ID Type|ID Type|Customer ID type|",
	`CustName`	CHAR(30) COMMENT "character|x(30)|Customer's name|Customer's name|Customer's name|",
	`CustNum`	INT DEFAULT "0" NOT NULL COMMENT "integer|>>>>>>>>9|Customer|Customer|Customer's number|",
	`DelType`	INT DEFAULT "0" COMMENT "integer|9|Delivery Type|Del.Type|Customers invoice delivery type|",
	`DirMarkEmail`	TINYINT(1) DEFAULT "0" COMMENT "logical|yes/no|Direct Marketing Via Email|Dir.Mark.Email|Direct marketing using Email|",
	`DirMarkMMS`	TINYINT(1) DEFAULT "0" COMMENT "logical|Yes/No|Direct Marketing Via MMS|Dir.Mark.MMS|Direct marketing using MMS|",
	`DirMarkPost`	TINYINT(1) DEFAULT "0" COMMENT "logical|yes/no|Direct Marketing Via Post|Dir.Mark.Post|Direct marketing using post|",
	`DirMarkSMS`	TINYINT(1) DEFAULT "0" COMMENT "logical|yes/no|Direct Marketing Via SMS|Dir.Mark.SMS|Direct marketing using SMS|",
	`DirMarkTrans`	TINYINT(1) DEFAULT "0" COMMENT "logical|Yes/No|Transmission Information|Dir.Mark.Trans.|Transmission Inf. (e.g. location) use in marketing by DNA)|",
	`EDICode`	CHAR(16) COMMENT "character|x(16)|EDI Code|EDI|EDI code|",
	`Email`	CHAR(60) COMMENT "character|x(60)|Email|Email|Customer's Email ID|",
	`FirstName`	CHAR(20) COMMENT "character|x(20)|Forename|Forename|Customer's forename|",
	`ForeignKey`	DECIMAL DEFAULT "0" COMMENT "decimal|9999999999999999|?|ForeignKey|ForeignKey from another system|",
	`InterestPerm`	TINYINT(1) DEFAULT "1" COMMENT "logical|Yes/No|IntCond|IntCond|Charge a overtime interest to customer (Y/N)|",
	`InvCode`	INT DEFAULT "0" COMMENT "integer|99|Invoice Code|Invoice Code|Code for week / day of a month for used invoice run (99)|",
	`InvGroup`	CHAR(8) COMMENT "character|x(8)|InvGroup|InvGroup|Alphanumeric code for Invoicing Group|",
	`InvoiceSMS`	INT DEFAULT "0" COMMENT "integer|9|Invoice SMS|Inv.SMS|Invoice information SMS sending|",
	`InvoiceTargetRule`	INT DEFAULT "0" COMMENT "integer|9|Invoice Target Rule|IT Rule|Rule for adding new invoice targets|",
	`Language`	INT DEFAULT "0" COMMENT "integer|>>9|Language|Language|Customer's language code (1 ...999)|",
	`LetterDelType`	CHAR(16) DEFAULT "email_letter" COMMENT "character|x(16)|LetterDelType|LetterDelType|Letter delivery type|",
	`Nationality`	CHAR(8) COMMENT "character|x(8)|Nationality|Nation.|Nationality|",
	`OrgId`	CHAR(11) COMMENT "character|x(11)|Pers/Comp.ID|?|Customer's organisation ID or personal ID|",
	`OutMarkEmail`	TINYINT(1) DEFAULT "0" COMMENT "logical|yes/no|Out. Marketing Via Email|Out.Mark.Email|3rd party marketing using eMail|",
	`OutMarkMMS`	TINYINT(1) DEFAULT "0" COMMENT "logical|Yes/No|Out. Marketing Via MMS|Out.Mark.MMS|3rd party marketing using MMS|",
	`OutMarkPost`	TINYINT(1) DEFAULT "0" COMMENT "logical|yes/no|Out. Marketing Via Post|Out.Mark.Post|3rd part marketing using post|",
	`OutMarkSMS`	TINYINT(1) DEFAULT "0" COMMENT "logical|yes/no|Out. Marketing Via SMS|Out.Mark.SMS|3rd party marketing using SMS|",
	`PaymTerm`	INT DEFAULT "0" COMMENT "integer|>9|Payment Terms|Payment Terms|Terms of payment (days)|",
	`Region`	CHAR(8) COMMENT "character|x(8)|Region|?|Region code|",
	`Salesman`	CHAR(8) COMMENT "character|x(8)|Salesman|Salesman|Salesman who is responsible for customer|",
	`SearchName`	CHAR(8) COMMENT "character|x(8)|Abbrev|Abbrev|Alphanumeric key for browsing|",
	`Size`	CHAR(2) DEFAULT "M" NOT NULL COMMENT "character|x(2)|Size|Size|Size of customer: (XL)arge, (L)arge, (M)edium, (S)mall|",
	`SMSNumber`	CHAR(15) COMMENT "character|x(15)|SMS Number|SMS|Mobile number for SMS messages|",
	`StartCharge`	TINYINT(1) DEFAULT "1" COMMENT "logical|A/P|Start charge|Start charge|Allow / Prohibit starting charges for this customer (A/P)|",
	`SurName2`	CHAR(30) COMMENT "character|x(30)|Second Surname|2.Surname|Second surname|",
	`UpdDate`	DATE COMMENT "date|99-99-99|Updated|Updated|Date of latest updation|",
	`UpdUser`	CHAR(8) COMMENT "character|x(8)|Updated by|Updated by|User who updated this customer latest|",
	`UserRightStatus`	TINYINT(1) DEFAULT "1" COMMENT "logical|yes/no|UserRightStatus|UserRightStatus|Status of Self service user rights as per RBS|",
	`VATIncl`	TINYINT(1) DEFAULT "1" COMMENT "logical|Included/Excluded|VAT Included|VATIncl|Format for invoices; is VAT included or excluded in amounts|",
	`VATUsage`	INT DEFAULT "1" COMMENT "integer|9|VAT Usage|VAT|How VAT is calculated for this customer|",
	PRIMARY KEY	(`CustNum`),
	KEY	`CompanyName` (
				`Brand`,
				`CompanyName`),
	KEY	`CustName` (
				`Brand`,
				`CustName`,
				`FirstName`),
	KEY	`CustNum` (
				`Brand`,
				`CustNum`),
## The PROGRESS database primary index
	KEY	`CustNum_s` (
				`CustNum`),
	KEY	`ForeignKey` (
				`ForeignKey`),
	KEY	`InvCode` (
				`Brand`,
				`InvCode`,
				`CustNum`),
	KEY	`InvGroup` (
				`Brand`,
				`InvGroup`,
				`CustNum`),
	KEY	`Orgid` (
				`Brand`,
				`OrgId`),
	KEY	`SearchName` (
				`Brand`,
				`SearchName`,
				`CustName`),
	KEY	`SurName2` (
				`Brand`,
				`SurName2`,
				`CustName`,
				`FirstName`))
	COMMENT = "Customer";
DROP TABLE IF EXISTS `rbs_CustParam`;
CREATE TABLE `rbs_CustParam`(
	`Activated`	DATE COMMENT "date|99-99-99|activated|?|Activated|",
	`CustNum`	INT DEFAULT "0" NOT NULL COMMENT "integer|>>>>>>>>9|Customer|Customer|Customer's number|",
	`ParamName`	CHAR(16) COMMENT "character|x(16)|Name||Name of Customer parameter|",
	`ParamValue`	CHAR(16) COMMENT "character|x(16)|Value||Value of Customers parameter|",
	PRIMARY KEY	(`CustNum`,`ParamName`),
## The PROGRESS database primary index
	KEY	`ParamName` (
				`CustNum`,
				`ParamName`),
	KEY	`ParamValue` (
				`CustNum`,
				`ParamValue`))
	COMMENT = "Customers parameters";
DROP TABLE IF EXISTS `rbs_CustPerContract`;
CREATE TABLE `rbs_CustPerContract`(
	`AgrCust`	INT DEFAULT "0" COMMENT "integer|>>>>>>9|AgrCust|AgrCust|Owner customer|",
	`BillingPerm`	TINYINT(1) DEFAULT "1" COMMENT "logical|Yes/No|Billing Permission|Bill.Perm.|Billing permission|",
	`Brand`	CHAR(8) COMMENT "character|x(8)|Brand|Brand|Code of brand|",
	`ClaimState`	DECIMAL DEFAULT "0" COMMENT "decimal|>9.99|Claiming Status|ClaimSt|Claiming status|",
	`CMCreatedTS`	DECIMAL DEFAULT "0" COMMENT "decimal|99999999.99999|CM creation time|CM creation time|Time when contract was created in CM|",
	`ContractDate`	DATE COMMENT "date|99-99-9999|Contract Date|Signed|Date when contract was originally signed|",
	`CreateFees`	TINYINT(1) DEFAULT "1" COMMENT "logical|Yes/No|Create Fees|Fees|Create fees when contract is changed or terminated|",
	`CustNum`	INT DEFAULT "0" NOT NULL COMMENT "integer|>>>>>>>9|Customer|Cust.|Customer number|",
	`DCEvent`	CHAR(12) COMMENT "character|x(12)|Periodical Contract|Contract|Periodical contract|",
	`ExperimentDate`	DATE COMMENT "date|99-99-99|Experiment Date|Experiment|Date when experiment period expires|",
	`MainContractID`	INT DEFAULT "0" COMMENT "integer|>>>>>>9|Parent contractid|Parent contractid|Parent contractid|",
	`OrderId`	CHAR(16) COMMENT "character|x(16)|Order Id|Order Id|Order Id of the customer contract|",
	`OriginalValidTo`	DATE COMMENT "date|99-99-9999|Original Valid To|Orig. To|Original valid to|",
	`PerContractID`	INT DEFAULT "0" COMMENT "integer|>>>>>>>9|Periodical Contract ID|Per.Contr.|Periodical contract ID|unique sequence ID",
	`Setting`	CHAR(16) COMMENT "character|x(16)|Setting|Set|Setting|",
	`TermDate`	DATE COMMENT "date|99-99-9999|Termination Date|Terminated|Date when contract when will be terminated|",
	`ValidFrom`	DATE COMMENT "date|99-99-9999|Valid From|From|Valid from|",
	`ValidTo`	DATE COMMENT "date|99-99-9999|Valid To|To|Valid to|",
	PRIMARY KEY	(`CustNum`,`DCEvent`,`ValidTo`),
## The PROGRESS database primary index
	KEY	`Contract` (
				`CustNum`,
				`DCEvent`,
				`ValidTo`),
	KEY	`CustNum` (
				`CustNum`,
				`ValidTo`),
	KEY	`DCEvent` (
				`Brand`,
				`DCEvent`,
				`CustNum`,
				`ValidTo`),
	KEY	`idx_AgrCust` (
				`AgrCust`,
				`ValidTo`),
	KEY	`idx_MainCtr` (
				`MainContractID`),
	KEY	`PerContractID` (
				`PerContractID`))
	COMMENT = "?";
DROP TABLE IF EXISTS `rbs_CustSubvClass`;
CREATE TABLE `rbs_CustSubvClass`(
	`CustNum`	INT DEFAULT "0" COMMENT "integer|>>>>>>>9|Customer|Cust.|Customer number|",
	`SubvClass`	CHAR(16) COMMENT "character|x(16)|Class|?|Subvention class|",
	`ValidFrom`	DATE COMMENT "date|99-99-9999|Valid From|From|Effective from date|",
	`ValidTo`	DATE COMMENT "date|99-99-9999|Valid To|To|Effective to date|",
	PRIMARY KEY	(`CustNum`,`ValidTo`),
## The PROGRESS database primary index
	KEY	`CustNum` (
				`CustNum`,
				`ValidTo`),
	KEY	`SubvClass` (
				`SubvClass`,
				`ValidTo`))
	COMMENT = "Class to be used for customer (dealer)";
DROP TABLE IF EXISTS `rbs_DayCampaign`;
CREATE TABLE `rbs_DayCampaign`(
	`BillCode`	CHAR(16) COMMENT "character|x(16)|Billing Item|BillCode|Billing item code|",
	`Brand`	CHAR(8) COMMENT "character|x(8)|Brand|Brand|Code Of Brand|",
	`CalcMethod`	INT DEFAULT "0" COMMENT "integer|9|Calculation Method|Method|Calculation method|",
	`CCN`	INT DEFAULT "0" COMMENT "integer|>>>9|CCN|?|Report CCN that is marked to CDRs|",
	`DCEvent`	CHAR(12) COMMENT "character|x(12)|Periodical Term|ID|ID of periodical term|",
	`DCName`	CHAR(60) COMMENT "character|x(60)|Name|Name|Name of periodical term|",
	`DCTarget`	CHAR(12) COMMENT "character|x(12)|Target|Target|Target (allowed billing item)|",
	`DCType`	CHAR(8) COMMENT "character|x(8)|Campaign Type|Type|Campaign type|",
	`DurMonths`	INT DEFAULT "0" COMMENT "integer|>>9|Duration In Months|Duration|Duration in months|",
	`DurType`	INT DEFAULT "0" COMMENT "integer|9|Type Of Duration|Dur.Type|Type of duration|",
	`DurUnit`	INT DEFAULT "0" COMMENT "integer|>9|Duration Unit|Dur.Unit|Duration unit|",
	`Effective`	INT DEFAULT "0" COMMENT "integer|>9|Effective|Eff.|When contract becomes effective|",
	`FeeModel`	CHAR(12) COMMENT "character|x(12)|Creation Fee Model|Creation FM|Fee model for creating contract|",
	`InclStartCharge`	TINYINT(1) DEFAULT "1" COMMENT "logical|yes/no|Include Start Charge|InclStartFee|Include start charge to final price|",
	`InclUnit`	INT DEFAULT "0" COMMENT "integer|>9|Included Unit|Incl.Unit|Unit of included material|",
	`InstanceLimit`	INT DEFAULT "1" COMMENT "integer|>>9|Instance Limit|InstanceLimit|How many contracts can be active at the same time|",
	`MaxChargeExcl`	DECIMAL DEFAULT "0" COMMENT "decimal|->>>>>>>9.999|Max. Charge Excl.VAT|MaxExcl|Maximum charge excluding VAT|",
	`MaxChargeIncl`	DECIMAL DEFAULT "0" COMMENT "decimal|->>,>>9.999|Max. Charge Incl. VAT|MaxIncl|Maximum charge including VAT|",
	`SubvGroup`	CHAR(16) COMMENT "character|x(16)|Subvention Group|Subv.Group|Subvention group|",
	`TermFeeCalc`	INT DEFAULT "0" COMMENT "integer|>9|Term. Fee Calculation|TFee Calc|Termination fee calculation method|",
	`TermFeeModel`	CHAR(12) COMMENT "character|x(12)|Termination Fee Model|Term.FM|Fee model for terminating contract|",
	`ValidFrom`	DATE COMMENT "date|99-99-9999|Valid From|From|Valid from|",
	`ValidTo`	DATE COMMENT "date|99-99-9999|Valid To|To|Valid to|",
	`Weekday`	CHAR(7) COMMENT "character|x(7)|Weekday|Weekday|Weekday (1=Sunday, 2=monday...7=Saturday)|",
	PRIMARY KEY	(`Brand`,`DCEvent`),
## The PROGRESS database primary index
	KEY	`DCEvent` (
				`Brand`,
				`DCEvent`),
	KEY	`DCType` (
				`Brand`,
				`DCType`))
	COMMENT = "?";
DROP TABLE IF EXISTS `rbs_DCCli`;
CREATE TABLE `rbs_DCCli`(
	`Active`	TINYINT(1) DEFAULT "1" COMMENT "logical|Yes/No|Active|Active|Is service active|",
	`Brand`	CHAR(8) COMMENT "character|x(8)|Brand|Brand|Code Of Brand|",
	`CLI`	CHAR(12) COMMENT "character|x(12)|MSISDN|CLI|MSISDN|",
	`CMCreatedTS`	DECIMAL DEFAULT "0" COMMENT "decimal|99999999.99999|CM creation time|CM creation time|Time when contract was created in CM|",
	`ContractDate`	DATE COMMENT "date|99-99-99|Contract Date|Contract|Date when contract was originally signed|",
	`CreateFees`	TINYINT(1) DEFAULT "1" COMMENT "logical|Yes/No|Create Fees|Fees|Create fees when contract is changed or terminated|",
	`DCEvent`	CHAR(12) COMMENT "character|x(12)|Periodical Term|Term|ID of periodical term|",
	`ExperimentDate`	DATE COMMENT "date|99-99-99|Experiment Date|Experiment|Date when experiment period expires|",
	`ForeignKey`	DECIMAL DEFAULT "0" COMMENT "decimal|9999999999999999|?|ForeignKey|ForeignKey from another system|",
	`MainContractID`	INT DEFAULT "0" COMMENT "integer|>>>>>>9|Parent contractid|Parent contractid|Parent contractid|",
	`MSSeq`	INT DEFAULT "0" NOT NULL COMMENT "integer|>>>>>>>9|Subscription ID|Sub.ID|Sequence for a subscription|",
	`OrderId`	CHAR(16) COMMENT "character|x(16)|Order Id|Order Id|Order Id of the contract|",
	`PenaltyFee`	DECIMAL DEFAULT "0" COMMENT "decimal|->>>>>>9.99|Penalty Fee|Penalty|Penalty fee|",
	`PerContractID`	INT DEFAULT "0" COMMENT "integer|>>>>>>>9|Periodical Contract ID|Per.Contr.|Periodical contract ID|unique sequence ID",
	`TermDate`	DATE COMMENT "date|99-99-99|Termination Date|Terminate|Date when contract when will be terminated|",
	`ValidFrom`	DATE COMMENT "date|99-99-9999|Valid From|From|Valid from|",
	`ValidTo`	DATE COMMENT "date|99-99-9999|Valid To|To|Valid to|",
	`ValidToOrig`	DATE COMMENT "date|99-99-9999|Valid To Original|ValidToOrig|Original Valid To|",
	PRIMARY KEY	(`MSSeq`,`DCEvent`),
## The PROGRESS database primary index
	KEY	`Contract` (
				`MSSeq`,
				`DCEvent`),
	KEY	`DCEvent` (
				`Brand`,
				`DCEvent`,
				`MSSeq`,
				`ValidTo`),
	KEY	`ForeignKey` (
				`ForeignKey`),
	KEY	`idx_MainCtr` (
				`MainContractID`),
	KEY	`MSSeq` (
				`MSSeq`,
				`ValidTo`),
	KEY	`PerContractID` (
				`PerContractID`))
	COMMENT = "?";
DROP TABLE IF EXISTS `rbs_DiscountPlan`;
CREATE TABLE `rbs_DiscountPlan`(
	`BillCode`	CHAR(32) COMMENT "character|x(32)|Billling Item|Bill.Item|Billing item for invoice rows|",
	`Brand`	CHAR(12) COMMENT "character|x(12)|Brand|Brand|Brand|",
	`BrokenRental`	INT DEFAULT "0" COMMENT "integer|9|Broken Rental|Broken Rental|Broken Rental for last month|",
	`DiscountType`	CHAR(16) COMMENT "character|x(16)|Discount Type|Disc.Type|Discount type|",
	`DPId`	INT DEFAULT "0" NOT NULL COMMENT "integer|>>>>>>>9|Discount Plan Id|PlanId|Discount plan Id|",
	`DPName`	CHAR(64) COMMENT "character|x(64)|Name|Name|Plan name|",
	`DPRuleId`	CHAR(12) NOT NULL COMMENT "character|x(12)|Discount Rule Id|Rule Id|Discount Rule Id|",
	`DPUnit`	CHAR(8) COMMENT "character|x(8)|Discount Unit|Unit|Discount unit|",
	`FirstMonthBR`	INT DEFAULT "0" COMMENT "integer|9|First Month Broken Rental|1.Month BR|Broken rental for first month|",
	`Priority`	INT DEFAULT "0" COMMENT "integer|>>>9|Priority|Prior.|Priority between discount plans|",
	`ProcessStopper`	TINYINT(1) DEFAULT "0" COMMENT "logical|Yes/No|Process Stopper|Stopper|Process stopper for a lower priority plan|",
	`Subject`	CHAR(32) COMMENT "character|x(32)|Determinative Subject|Subject|Discount plan subject|",
	`SubjectType`	CHAR(8) COMMENT "character|x(8)|Subject Type|Subj.Type|Used for All or for a List|",
	`TargetType`	CHAR(16) COMMENT "character|x(16)|Targeted To|Target|Targeted to All or List of targets|",
	`ValidFrom`	DATE COMMENT "date|99-99-9999|Valid From|From|Effective from date|",
	`ValidPeriods`	INT DEFAULT "0" COMMENT "integer|>>9|Valid Periods|Periods|How many periods discount is valid for a member|",
	`ValidTo`	DATE COMMENT "date|99-99-9999|Valid To|To|Effective to date|",
	PRIMARY KEY	(`Brand`,`DPRuleId`,`ValidTo`),
	KEY	`DPId` (
				`DPId`),
## The PROGRESS database primary index
	KEY	`DPRuleId` (
				`Brand`,
				`DPRuleId`,
				`ValidTo`))
	COMMENT = "This is the header table for Discount module. This contains Discount Plan summary";
DROP TABLE IF EXISTS `rbs_DPMember`;
CREATE TABLE `rbs_DPMember`(
	`DiscountId`	CHAR(36) COMMENT "character|x(36)|Discount id|DiscountId|Discount id|",
	`DiscValue`	DECIMAL DEFAULT "0" COMMENT "decimal|->>>>>9.99|Discount Value|Discount Value|Discount amount|",
	`DPId`	INT DEFAULT "0" NOT NULL COMMENT "integer|zzzzzzz9|Discount Plan Id|PlanId|Discount Plan Id|",
	`HostTable`	CHAR(12) COMMENT "character|x(12)|Host Table|Host Table|Name of the host table|",
	`KeyValue`	CHAR(12) COMMENT "character|x(12)|Key Value|Key Value|Key value|",
	`ValidFrom`	DATE COMMENT "date|99-99-9999|Valid From|From|Effective from date|",
	`ValidTo`	DATE COMMENT "date|99-99-9999|Valid To|To|Effective to date|",
	PRIMARY KEY	(`DPId`,`HostTable`,`KeyValue`),
	KEY	`DiscountId` (
				`DiscountId`),
	KEY	`DPHostKey` (
				`HostTable`,
				`KeyValue`),
## The PROGRESS database primary index
	KEY	`DPId` (
				`DPId`,
				`HostTable`,
				`KeyValue`))
	COMMENT = "This is the child table for DiscountPlan table. When we have TargetBillitemType.";
DROP TABLE IF EXISTS `rbs_DPRate`;
CREATE TABLE `rbs_DPRate`(
	`DiscValue`	DECIMAL DEFAULT "0" COMMENT "decimal|->>>>>9.99|Discount Value|Value|Discount amount|",
	`DPId`	INT DEFAULT "0" NOT NULL COMMENT "integer|zzzzzzz9|Discount Plan Id|PlanId|Discount Plan Id|",
	`ValidFrom`	DATE COMMENT "date|99-99-9999|Valid From|From|Effective from date|",
	`ValidTo`	DATE COMMENT "date|99-99-9999|Valid To|To|Effective to date|",
	PRIMARY KEY	(`DPId`),
## The PROGRESS database primary index
	KEY	`DPId` (
				`DPId`))
	COMMENT = "This table will contain actual amount/percentage for each DiscountPlan record.";
DROP TABLE IF EXISTS `rbs_DPTarget`;
CREATE TABLE `rbs_DPTarget`(
	`DPId`	INT DEFAULT "0" NOT NULL COMMENT "integer|zzzzzzz9|Discount Plan Id|PlanId|Discount Plan Id|",
	`Included`	TINYINT(1) DEFAULT "1" COMMENT "logical|Yes/No|Included|?|Included in targets|",
	`TargetKey`	CHAR(16) COMMENT "character|x(16)|Target Key|Key|Target key value|",
	`TargetTable`	CHAR(20) COMMENT "character|x(20)|Target Table|Table|Target table|",
	`ValidFrom`	DATE COMMENT "date|99-99-9999|Valid From|From|Effective from date|",
	`ValidTo`	DATE COMMENT "date|99-99-9999|Valid To|To|Effective to date|",
	PRIMARY KEY	(`DPId`,`TargetTable`,`TargetKey`,`ValidTo`),
	KEY	`DPId` (
				`DPId`,
				`ValidTo`),
## The PROGRESS database primary index
	KEY	`DPTarget` (
				`DPId`,
				`TargetTable`,
				`TargetKey`,
				`ValidTo`))
	COMMENT = "Child table for DiscountPlan for each TargetBillitemType.";
DROP TABLE IF EXISTS `rbs_EInvoiceAuth`;
CREATE TABLE `rbs_EInvoiceAuth`(
	`Brand`	CHAR(8) COMMENT "character|x(8)|Brand|Brand|Code of brand|",
	`CustNum`	INT DEFAULT "0" NOT NULL COMMENT "integer|>>>>>>>9|Customer|Cust.|Customer number|",
	`EInvoiceAuthID`	INT DEFAULT "0" COMMENT "integer|>>>>>>>>>9|Authorization ID|Auth.|Unique ID for the authorization|",
	`FromDate`	DATE COMMENT "date|99-99-99|Valid From|From|Valid from|",
	`ITGroupID`	INT DEFAULT "0" COMMENT "integer|>>>>>>>>9|Invoice Target Group|ITGroup|Invoice target group ID|",
	`PaymentIdentifier`	CHAR(12) COMMENT "character|x(12)|Payment Identifier|Payment ID|Payment instruction identifier|",
	`RecipientAddress`	CHAR(20) COMMENT "character|x(20)|Invoice Recipient Address|Recipient|Invoice recipient address|",
	`RecipientIntermediator`	CHAR(8) COMMENT "character|x(8)|Recipient Intermediator|Recipient Interm.|Recipient intermediator|",
	`SenderAddress`	CHAR(20) COMMENT "character|x(20)|Invoice Sender Address|Sender|Invoice sender address|",
	`SenderIntermediator`	CHAR(8) COMMENT "character|x(8)|Sender Intermediator|Sender Interm.|Sender intermediator|",
	`ToDate`	DATE COMMENT "date|99-99-99|Valid To|To|Valid to|",
	PRIMARY KEY	(`EInvoiceAuthID`),
	KEY	`CustNum` (
				`CustNum`,
				`ToDate`),
## The PROGRESS database primary index
	KEY	`EInvoiceAuthID` (
				`EInvoiceAuthID`),
	KEY	`FromDate` (
				`Brand`,
				`FromDate`),
	KEY	`ITGroupId` (
				`ITGroupID`,
				`ToDate`))
	COMMENT = "EInvoice authorizations";
DROP TABLE IF EXISTS `rbs_EInvoiceEvent`;
CREATE TABLE `rbs_EInvoiceEvent`(
	`ActionCode`	CHAR(20) COMMENT "character|x(20)|Action Code|Action|Message action code|",
	`ActivationDate`	DATE COMMENT "date|99-99-9999|Activation Date|ActivDate|Processing date|",
	`Brand`	CHAR(8) COMMENT "character|x(8)|Brand|Brand|Code of brand|",
	`CustName`	CHAR(40) COMMENT "character|x(40)|Customer Name|Customer|Customer name as written in authorization|",
	`CustNum`	INT DEFAULT "0" NOT NULL COMMENT "integer|>>>>>>>9|Customer|Cust.|Customer number|",
	`EInvoiceAuthID`	INT DEFAULT "0" COMMENT "integer|>>>>>>>>>9|Authorization ID|Auth.|Unique ID for the authorization|",
	`FileName`	CHAR(25) COMMENT "character|x(25)|File name|File Name|Processed file name|",
	`InvoiceIdentifier`	CHAR(20) COMMENT "character|x(20)|Invoice Identifier|Invoice ID|Seller invoice identifier|",
	`MessageID`	CHAR(20) COMMENT "character|x(20)|Message ID|Message|Message ID|",
	`PaymentIdentifier`	CHAR(12) COMMENT "character|x(12)|Payment Identifier|Payment ID|Payment instruction identifier|",
	`ReceiverTimeStamp`	DATETIME COMMENT "datetime|99-99-9999 hh:mm:ss|Event Time|Time|Receiver info time stamp|",
	`RecipientAddress`	CHAR(20) COMMENT "character|x(20)|Invoice Recipient Address|Recipient|Invoice recipient address|",
	`RecipientIntermediator`	CHAR(8) COMMENT "character|x(8)|Recipient Intermediator|Recipient Interm.|Recipient intermediator|",
	`SenderAddress`	CHAR(20) COMMENT "character|x(20)|Invoice Sender Address|Sender|Invoice sender address|",
	`SenderIntermediator`	CHAR(8) COMMENT "character|x(8)|Sender Intermediator|Sender Interm.|Sender intermediator|",
	PRIMARY KEY	(`EInvoiceAuthID`,`ReceiverTimeStamp`),
	KEY	`ActivationDate` (
				`ActivationDate`),
	KEY	`CustNum` (
				`CustNum`,
				`ReceiverTimeStamp`),
## The PROGRESS database primary index
	KEY	`EInvoiceAuthID` (
				`EInvoiceAuthID`,
				`ReceiverTimeStamp`))
	COMMENT = "EInvoice authorization events";
DROP TABLE IF EXISTS `rbs_ExternalID`;
CREATE TABLE `rbs_ExternalID`(
	`ExternalID`	CHAR(16) NOT NULL COMMENT "character|x(16)|?|ExternalID||",
	`ExtSource`	CHAR(20) COMMENT "character|x(20)|Source|?|Source of external ID|",
	`InternalID`	CHAR(16) NOT NULL COMMENT "character|x(16)|?|InternalID||",
	`Type`	CHAR(8) NOT NULL COMMENT "character|x(8)|?|Type|Type of ID|Type of ID",
	PRIMARY KEY	(`Type`,`ExternalID`,`InternalID`),
	KEY	`ExternalID` (
				`ExternalID`),
	KEY	`ExtSource` (
				`ExtSource`,
				`Type`,
				`ExternalID`),
## The PROGRESS database primary index
	KEY	`Type_ExternalID_InternalID` (
				`Type`,
				`ExternalID`,
				`InternalID`),
	KEY	`Type_InternalID_ExternalID` (
				`Type`,
				`InternalID`,
				`ExternalID`))
	COMMENT = "External system id mapping table";
DROP TABLE IF EXISTS `rbs_FATGMember`;
CREATE TABLE `rbs_FATGMember`(
	`Brand`	CHAR(8) COMMENT "character|x(8)|Brand|Brand|Code Of Brand|",
	`FtgMember`	CHAR(16) COMMENT "character|x(16)|Group Member|Member|Group member|",
	`FtGrp`	CHAR(8) COMMENT "character|x(8)|FatGroup|FtGrp|Fat Group (for products)|",
	`MemberType`	INT DEFAULT "0" COMMENT "integer|9|Member Type|Type|Type of the member (product, FAT Group)|",
	PRIMARY KEY	(`Brand`,`FtGrp`,`MemberType`,`FtgMember`),
## The PROGRESS database primary index
	KEY	`FtGrp` (
				`Brand`,
				`FtGrp`,
				`MemberType`,
				`FtgMember`))
	COMMENT = "Members for the FAT Group (FtGrp)";
DROP TABLE IF EXISTS `rbs_FATGroup`;
CREATE TABLE `rbs_FATGroup`(
	`Amount`	DECIMAL DEFAULT "0" COMMENT "decimal|->>>>>>9.99|Amount|?|Amount per period|",
	`AmtLimit`	DECIMAL DEFAULT "0" COMMENT "decimal|>>>>>>9.99|Amount Limit|Limit|Max amount of FAT per CLI|",
	`BillCode`	CHAR(16) COMMENT "character|x(16)|Billing Item|B.Item|Billing item|",
	`Brand`	CHAR(8) COMMENT "character|x(8)|Brand|Brand|Code Of Brand|",
	`FatTarget`	CHAR(8) COMMENT "character|x(8)|FATime Target|Target|To whom FATime can be used|",
	`FATType`	INT DEFAULT "0" COMMENT "integer|9|FATime Type|Type|FATime type|0=calls, 1=fixed fees, 2=all",
	`FtgName`	CHAR(30) COMMENT "character|x(30)|Name|?|Group name|",
	`FtGrp`	CHAR(8) COMMENT "character|x(8)|FatGroup|FtGrp|Fat Group (for products)|",
	`GroupType`	INT DEFAULT "0" COMMENT "integer|>>9|Group Type|GType|FATime group type|",
	`Interval`	INT DEFAULT "1" COMMENT "integer|>9|Interval|?|Interval; number of months between events|",
	`InvMemo[1]`	CHAR(60) COMMENT "character|x(60)|Invoice Text|Inv.Txt|Text to invoice|",
	`PeriodQty`	INT DEFAULT "1" COMMENT "integer|>9|Period Quantity|Periods|Period quantity|",
	`Priority`	INT DEFAULT "0" COMMENT "integer|>>9|Priority|Pri|Relative priority to other FATimes|",
	`QtyUnit`	CHAR(8) COMMENT "character|x(8)|Qty Unit|Unit|Unit of the amount|",
	`Transfer`	TINYINT(1) DEFAULT "0" COMMENT "logical|Yes/No|Transferrable|Transfer|Transferrable to next period|",
	`TypeId`	CHAR(15) COMMENT "character|x(15)|TypeId|TypeId|Type identification|",
	`ValidPeriods`	INT DEFAULT "0" COMMENT "integer|>>9|Valid Periods|Valid|How many periods is FATime valid for|",
	PRIMARY KEY	(`Brand`,`FtGrp`),
	KEY	`FatType` (
				`Brand`,
				`FATType`,
				`FtGrp`),
	KEY	`FtgName` (
				`Brand`,
				`FtgName`),
## The PROGRESS database primary index
	KEY	`FtGrp` (
				`Brand`,
				`FtGrp`),
	KEY	`GroupType` (
				`Brand`,
				`GroupType`,
				`FtGrp`),
	KEY	`Priority` (
				`Brand`,
				`Priority`))
	COMMENT = "FAT Group for products";
DROP TABLE IF EXISTS `rbs_FATime`;
CREATE TABLE `rbs_FATime`(
	`ActStamp`	DECIMAL DEFAULT "0" COMMENT "decimal|99999999.99999|Activation Time|Activate|Time when activated|",
	`Amt`	DECIMAL DEFAULT "0" COMMENT "decimal|->>,>>9.99|Free amount|FAT|Free amount (minutes, qty or sum)|",
	`Brand`	CHAR(8) COMMENT "character|x(8)|Brand|Brand|Code Of Brand|",
	`CLI`	CHAR(11) COMMENT "character|x(11)|MSISDN|MSISDN No|MSISDN Subscriber No|",
	`Creator`	CHAR(10) COMMENT "character|x(10)|Creator|Creator|Who created compensation|",
	`CustNum`	INT DEFAULT "0" NOT NULL COMMENT "integer|>>>>>>>>9|Customer|Customer|Customer's number|",
	`FATClass`	TINYINT(1) DEFAULT "1" COMMENT "logical|Calls/FixedFees|Class|Class|(C)alls / (F)ixed fees|",
	`FATId`	INT DEFAULT "0" COMMENT "integer|->,>>>,>>9|fatimeId|?|Fatime table's primary key.|",
	`FATNum`	INT DEFAULT "0" COMMENT "integer|>>>>>>9|FatId|?|Unique id for fat-definition|",
	`FATType`	INT DEFAULT "0" COMMENT "integer|9|FATime Type|Type|FATime type|0=calls, 1=fixed fees, 2=all",
	`FFItemNum`	INT DEFAULT "0" COMMENT "integer|zzzzzzzz9|Link to BItem|BItem|Link to BITEM which is created to bill the payer|",
	`ForeignKey`	DECIMAL DEFAULT "0" COMMENT "decimal|9999999999999999|?|ForeignKey|ForeignKey from another system|",
	`FTGrp`	CHAR(8) COMMENT "character|x(8)|FatGroup|FtGrp|Fat Group (for products)|",
	`HostTable`	CHAR(16) COMMENT "character|x(16)|HostTable|?|Host table|",
	`Interval`	INT DEFAULT "1" COMMENT "integer|z9|Interval|Interval|FATime interval; number of months betw. 2 consecutive bills|",
	`InvNum`	INT DEFAULT "0" COMMENT "integer|zzzzzzzz9|InvNo|InvNo|Invoice number, where FAT was used|",
	`KeyValue`	CHAR(20) COMMENT "character|x(20)|Link Key|Key|Link key to hosttable|",
	`LastPeriod`	INT DEFAULT "0" COMMENT "integer|999999|Last Period|Last|Last period which FAtime can be applied to|",
	`MainContractID`	INT DEFAULT "0" COMMENT "integer|>>>>>>9|Parent contractid|Parent contractid|Parent contractid|",
	`Memo[1]`	CHAR(60) COMMENT "character|x(60)|Memo|Memo|Explanation / memory field for Free Air Time|",
	`Memo[2]`	CHAR(60) COMMENT "character|x(60)|Memo|Memo|Explanation / memory field for Free Air Time|",
	`MsSeq`	INT DEFAULT "0" COMMENT "integer|->,>>>,>>9|Mobsub|Msub|Link to mobsub-table|",
	`OrigFat`	INT DEFAULT "0" COMMENT "integer|->,>>>,>>9|Original FAT|Orig.FAT|Link to the original FAT (from which transferred)|",
	`PayerType`	CHAR(8) COMMENT "character|x(8)|Payer Type|PType|Type of the payer (f.ex. reseller)|",
	`PerContractId`	INT DEFAULT "0" COMMENT "integer|>>>>>>9|PerContractId|?|Customer's periodical contract id|",
	`Period`	INT DEFAULT "0" COMMENT "integer|999999|Period|?|Period when the free air time is to be used|",
	`QtyUnit`	CHAR(8) COMMENT "character|x(8)|Qty Unit|Unit|Unit of the free amount|",
	`ReasonCode`	CHAR(8) COMMENT "character|x(8)|Reason|Reason|Reason for compensation|",
	`Source`	CHAR(10) COMMENT "character|x(10)|Source|Source|Source of compensation|",
	`SubInvNum`	INT DEFAULT "0" COMMENT "integer|>>9|SubInvoice Number|SubInv|Sequential nbr of the subinvoice within the combined invoice|",
	`Transfer`	TINYINT(1) DEFAULT "0" COMMENT "logical|yes/no|Transferrable|Transfer|Transferrable to next period|",
	`TransPeriod`	INT DEFAULT "0" COMMENT "integer|999999|Transf.Period|Tr.Period|Period which the unused qty is transferred to|",
	`TransQty`	DECIMAL DEFAULT "0" COMMENT "decimal|->>,>>9.99|Transferred|Tr.Amt|Transferred amount|",
	`Used`	DECIMAL DEFAULT "0" COMMENT "decimal|->>,>>9.99|Used Amount|Used|Used FAT amount|",
	`VatIncl`	TINYINT(1) DEFAULT "1" COMMENT "logical|Included/Excluded|VAT Included|VAT|Is VAT included or excluded in prices|",
	PRIMARY KEY	(`CustNum`,`CLI`,`FATType`,`InvNum`,`Period`),
	KEY	`CLI` (
				`Brand`,
				`CLI`),
	KEY	`CLI_s` (
				`CLI`),
	KEY	`CustNum_s` (
				`CustNum`),
	KEY	`FATId` (
				`Brand`,
				`FATId`),
	KEY	`FATNum` (
				`Brand`,
				`FATNum`),
## The PROGRESS database primary index
	KEY	`FatType` (
				`CustNum`,
				`CLI`,
				`FATType`,
				`InvNum`,
				`Period`),
	KEY	`FFItemNum` (
				`Brand`,
				`FFItemNum`),
	KEY	`ForeignKey` (
				`ForeignKey`),
	KEY	`ftgrd` (
				`Brand`,
				`FTGrp`),
	KEY	`HostTable` (
				`Brand`,
				`HostTable`,
				`KeyValue`),
	KEY	`idx_MainCtr` (
				`MainContractID`),
	KEY	`InvNum` (
				`InvNum`,
				`SubInvNum`),
	KEY	`Mobsub` (
				`Brand`,
				`MsSeq`,
				`Period`),
	KEY	`OrigFat` (
				`Brand`,
				`OrigFat`))
	COMMENT = "Free air time (or free qty or free sum)";
DROP TABLE IF EXISTS `rbs_FeeModel`;
CREATE TABLE `rbs_FeeModel`(
	`Brand`	CHAR(8) COMMENT "character|x(8)|Brand|Brand|Code Of Brand|",
	`FeeModel`	CHAR(8) COMMENT "character|x(8)|BEvent|BEvent|An unique code for a Billing Event|",
	`FeeName`	CHAR(40) COMMENT "character|x(40)|Name|Name|Name of Billing Case|",
	`FMGroup`	INT DEFAULT "0" COMMENT "integer|>>9|Group|Group|FeeModel Group|",
	PRIMARY KEY	(`Brand`,`FeeModel`),
	KEY	`FeeGroup` (
				`Brand`,
				`FMGroup`),
## The PROGRESS database primary index
	KEY	`FeeModel` (
				`Brand`,
				`FeeModel`),
	KEY	`FeeName` (
				`Brand`,
				`FeeName`,
				`FeeModel`))
	COMMENT = "A group of single and/or periodical fees";
DROP TABLE IF EXISTS `rbs_FFItem`;
CREATE TABLE `rbs_FFItem`(
	`Amt`	DECIMAL DEFAULT "0" COMMENT "decimal|->>>,>>9.9999|Amount|Amount|Payable Contract Payment per bill|",
	`BillCode`	CHAR(6) COMMENT "character|x(6)|ProdCode|ProdCode|Product code|",
	`Billed`	TINYINT(1) DEFAULT "0" COMMENT "logical|yes/no|Billed|Billed|Is this item billed (y/n)|",
	`BillPeriod`	INT DEFAULT "0" COMMENT "integer|999999|Period|Period|Period YYYYMM (month when a service shall be BILLED)|",
	`Concerns[1]`	INT DEFAULT "0" COMMENT "integer|999999|Concerns|Concerns|Period that this fee concerns|",
	`Concerns[2]`	INT DEFAULT "0" COMMENT "integer|999999|Concerns|Concerns|Period that this fee concerns|",
	`CustNum`	INT DEFAULT "0" NOT NULL COMMENT "integer|ZZZZZZZZ9|CustNo|CustNo|Customer number|",
	`FeeQuantity`	DECIMAL DEFAULT "0" COMMENT "decimal|>9.999|Quantity|Qty|Quantity|",
	`FFItemNum`	INT DEFAULT "0" COMMENT "integer|zzzzzzzz9|ItemNo|ItemNo|Individual invisible sequence for this item|",
	`FFNum`	INT DEFAULT "0" COMMENT "integer|zzzzzzz9|Contract|Contract|Consecutive number (sequence) of contract|",
	`InvNum`	INT DEFAULT "0" COMMENT "integer|zzzzzzzzz|InvNo|InvNo|Number of an invoice where this item was billed|",
	`Memo[1]`	CHAR(60) COMMENT "character|x(60)|Explanation|Explanation|Individual Explanation Text for the invoice|",
	`SubInvNum`	INT DEFAULT "0" COMMENT "integer|>>9|SubInvoice Number|SubInv|Sequential nbr of the subinvoice within the combined invoice|",
	`UnitPrice`	DECIMAL DEFAULT "0" COMMENT "decimal|->>>>>>9.9999|Unit Price|U.Price|Unit price|",
	`VATCode`	INT DEFAULT "1" COMMENT "integer|z9|VAT code|VAT code|VAT code 1 ... 10|",
	`VatIncl`	TINYINT(1) DEFAULT "1" COMMENT "logical|Included/Excluded|VAT Included|VAT|Is VAT included or excluded in prices|",
	PRIMARY KEY	(`FFNum`,`BillPeriod`,`FFItemNum`),
	KEY	`CustNum` (
				`CustNum`,
				`BillPeriod`,
				`Billed`),
	KEY	`FFItemNum` (
				`FFItemNum`),
## The PROGRESS database primary index
	KEY	`FFNum` (
				`FFNum`,
				`BillPeriod`,
				`FFItemNum`),
	KEY	`InvNum` (
				`InvNum`))
	COMMENT = "Monthly item (one billable transaction) of a contract fee";
DROP TABLE IF EXISTS `rbs_FixedFee`;
CREATE TABLE `rbs_FixedFee`(
	`Active`	TINYINT(1) DEFAULT "0" COMMENT "logical|Yes/No|Active|Active|Is this contract active ?|",
	`AgrCust`	INT DEFAULT "0" COMMENT "integer|>>>>>>>>9|Agr. Customer|Agr.Cust|Agreement customer number|",
	`Amt`	DECIMAL DEFAULT "0" COMMENT "decimal|->>>,>>9.9999|To Pay|To Pay|Contract payment per bill|",
	`BegDate`	DATE COMMENT "date|99-99-9999|ContDate|ContDate|Date of Contract|",
	`BegPeriod`	INT DEFAULT "0" COMMENT "integer|999999|FromPer|FromPer|1. Period YYYYMM (month when a service was DELIVERED)|",
	`BillCode`	CHAR(6) COMMENT "character|x(6)|Product|Product|Product code|",
	`BillMethod`	INT DEFAULT "3" COMMENT "integer|9|Type|Type|When this fee is to be billed: 1:before 2:during 3:after MONTH|",
	`Brand`	CHAR(8) COMMENT "character|x(8)|Brand|Brand|Code Of Brand|",
	`CalcObj`	CHAR(16) COMMENT "character|x(16)|CalcObject|CalcObject|Calculation Object Within Customer/InvTarg/Billing Level|",
	`CLI`	CHAR(12) COMMENT "character|x(12)|A-Subscriber|A-Sub|A-Subscriber number|",
	`Contract`	CHAR(8) COMMENT "character|x(8)|Contract ID|ContrID|Contract ID|",
	`CustNum`	INT DEFAULT "0" NOT NULL COMMENT "integer|>>>>>>>>9|Customer|Customer|Customer number|",
	`CustPP`	INT DEFAULT "0" COMMENT "integer|->>>>>>9|Seq|Seq|Internal sequence no of Contract/Product Pack|",
	`EndPeriod`	INT DEFAULT "999999" COMMENT "integer|999999|ExpPer|ExpPer|Last Period YYYYMM (month when a service was DELIVERED)|",
	`FeeModel`	CHAR(8) COMMENT "character|x(8)|BEvent|BEvent|Code of Billing Event|",
	`FeeQuantity`	DECIMAL DEFAULT "0" COMMENT "decimal|>9.999|Quantity|Qty|Quantity|",
	`FFNum`	INT DEFAULT "0" COMMENT "integer|zzzzzzz9|Contract|Contract|Consecutive number (sequence) of contract|",
	`ForeignKey`	DECIMAL DEFAULT "0" COMMENT "decimal|9999999999999999|?|ForeignKey|ForeignKey from another system|",
	`HostTable`	CHAR(16) COMMENT "character|x(16)|HostTable|HostTable|HostTable|",
	`Interval`	INT DEFAULT "0" COMMENT "integer|z9|Interval|Interval|Invoicing interval; number of months betw. 2 consecutive bills|",
	`InUse`	TINYINT(1) DEFAULT "1" COMMENT "logical|Yes/No|Used|Used|Is this payment in use ?|",
	`KeyValue`	CHAR(20) COMMENT "character|x(20)|KeyValue|KeyValue|KeyValue|",
	`MainContractID`	INT DEFAULT "0" COMMENT "integer|>>>>>>9|Parent contractid|Parent contractid|Parent contractid|",
	`Memo[1]`	CHAR(60) COMMENT "character|x(60)|MemoExp|MemoExp|Explanation text for the invoice|",
	`UnitPrice`	DECIMAL DEFAULT "0" COMMENT "decimal|->>>>>>9.9999|Unit Price|U.Price|Unit price|",
	`UserCust`	INT DEFAULT "0" COMMENT "integer|>>>>>>>9|User Customer|User|User customer|",
	`VatIncl`	TINYINT(1) DEFAULT "1" COMMENT "logical|Included/Excluded|VAT Included|VAT|Is VAT included or excluded in prices|",
	PRIMARY KEY	(`Brand`,`CustNum`,`HostTable`,`KeyValue`,`EndPeriod`),
	KEY	`AgrCust` (
				`AgrCust`),
	KEY	`BillCode` (
				`Brand`,
				`BillCode`,
				`CustNum`),
	KEY	`Contract` (
				`Brand`,
				`Contract`,
				`BillCode`),
## The PROGRESS database primary index
	KEY	`CustNum` (
				`Brand`,
				`CustNum`,
				`HostTable`,
				`KeyValue`,
				`EndPeriod`),
	KEY	`CustNum_s` (
				`CustNum`,
				`BillCode`),
	KEY	`CustPP` (
				`Brand`,
				`CustPP`),
	KEY	`FeeModel` (
				`Brand`,
				`FeeModel`),
	KEY	`FFNum` (
				`FFNum`),
	KEY	`ForeignKey` (
				`ForeignKey`),
	KEY	`HostTable` (
				`Brand`,
				`HostTable`,
				`KeyValue`),
	KEY	`idx_MainCtr` (
				`MainContractID`),
	KEY	`used` (
				`Brand`,
				`CustNum`,
				`InUse`))
	COMMENT = "Constant / contract fees";
DROP TABLE IF EXISTS `rbs_FMItem`;
CREATE TABLE `rbs_FMItem`(
	`Amount`	DECIMAL DEFAULT "0" COMMENT "decimal|-z,zz9.9999|Price|Price|Billable price of an item|",
	`BillCode`	CHAR(16) COMMENT "character|x(16)|Product|Product|Product code|",
	`BillCycle`	INT DEFAULT "1" COMMENT "integer|9|BMeth|BMeth|When this fee is to be billed 1:before 2:during 3:after|",
	`BillMethod`	TINYINT(1) DEFAULT "0" COMMENT "logical|Single/Fixed|Type|Type|Is this a (S)ingle fee or a (F)ixed fee ?|",
	`BillType`	CHAR(8) COMMENT "character|x(8)|Billing Type|Billing Type|Type Of Billing Object|",
	`Brand`	CHAR(8) COMMENT "character|x(8)|Brand|Brand|Code Of Brand|",
	`BrokenRental`	INT DEFAULT "0" COMMENT "integer|9|Broken Rental|Broken Rental|Broken Rental|",
	`FeeModel`	CHAR(8) COMMENT "character|x(8)|BEvent|BEvent|An unique code for a Billing Event|",
	`FFItemQty`	INT DEFAULT "0" COMMENT "integer|>>9|Fixed Fee Qty|FF Qty|Quantity of fixed fee items|",
	`FirstMonthBR`	INT DEFAULT "0" COMMENT "integer|9|First Month Broken Rental|1.Month BR|Broken rental for first month|",
	`FromDate`	DATE COMMENT "date|99-99-99|From Date|From|First effective date|",
	`Interval`	INT DEFAULT "0" COMMENT "integer|z9|Interval|Interval|Billing Interval (1= every month, 12=every year etc)|",
	`PriceList`	CHAR(8) COMMENT "character|x(8)|Price List|Price List|Code (identifier) for a Price List|",
	`ToDate`	DATE COMMENT "date|99-99-99|To Date|To|Last effective date|",
	PRIMARY KEY	(`Brand`,`FeeModel`,`PriceList`,`BillCode`,`FromDate`),
	KEY	`BillCode` (
				`Brand`,
				`FeeModel`,
				`BillCode`,
				`PriceList`,
				`FromDate`),
## The PROGRESS database primary index
	KEY	`FeeModel` (
				`Brand`,
				`FeeModel`,
				`PriceList`,
				`BillCode`,
				`FromDate`))
	COMMENT = "List of billable items of a single 'billing event'";
DROP TABLE IF EXISTS `rbs_HdrText`;
CREATE TABLE `rbs_HdrText`(
	`Brand`	CHAR(8) COMMENT "character|x(8)|Brand|Brand|Code Of Brand|",
	`te-kie`	INT DEFAULT "0" NOT NULL COMMENT "integer|9|Lang|Lang|Language code (1 - 9)|",
	`te-nro`	INT DEFAULT "0" COMMENT "integer|zz9|No|No.|Serial number(1 - 999) of a text element|",
	`te-text`	CHAR(60) COMMENT "character|x(60)|Text|Text|Text in choosen language|",
	PRIMARY KEY	(`Brand`,`te-nro`,`te-kie`),
	KEY	`te-kie` (
				`Brand`,
				`te-kie`,
				`te-nro`),
## The PROGRESS database primary index
	KEY	`te-nro` (
				`Brand`,
				`te-nro`,
				`te-kie`),
	KEY	`te-text` (
				`Brand`,
				`te-text`))
	COMMENT = "Header texts for reports";
DROP TABLE IF EXISTS `rbs_IGInvNum`;
CREATE TABLE `rbs_IGInvNum`(
	`Brand`	CHAR(8) COMMENT "character|x(8)|Brand|?|Code Of Brand|",
	`FromDate`	DATE COMMENT "date|99-99-99|Valid From|From|Date when sequence becomes effective|",
	`InvGroup`	CHAR(8) COMMENT "character|x(8)|InvGroup|?|Invoice group|",
	`InvNum`	INT DEFAULT "0" COMMENT "integer|>>>>>>>9|Invoice Number|Inv.Nbr|Invoice number sequence (last used number)|",
	`InvType`	INT DEFAULT "0" COMMENT "integer|>9|Invoice Type|Type|Invoice type|",
	`SeqPrefix`	CHAR(8) COMMENT "character|x(8)|Sequence Prefix|Prefix|Sequence prefix|",
	PRIMARY KEY	(`Brand`,`InvGroup`,`InvType`,`FromDate`),
## The PROGRESS database primary index
	KEY	`InvGroup` (
				`Brand`,
				`InvGroup`,
				`InvType`,
				`FromDate`))
	COMMENT = "Invoice group invoice number sequences";
DROP TABLE IF EXISTS `rbs_IGVoucher`;
CREATE TABLE `rbs_IGVoucher`(
	`Brand`	CHAR(8) COMMENT "character|x(8)|Brand|?|Code Of Brand|",
	`FromDate`	DATE COMMENT "date|99-99-99|Valid From|From|Date when sequence becomes effective|",
	`InvGroup`	CHAR(8) COMMENT "character|x(8)|InvGroup|?|Invoice group|",
	`PaymType`	INT DEFAULT "0" COMMENT "integer|>9|Payment Type|Type|Payment type|",
	`SeqPrefix`	CHAR(8) COMMENT "character|x(8)|Sequence Prefix|Prefix|Sequence prefix|",
	`Voucher`	INT DEFAULT "0" COMMENT "integer|>>>>>>>9|Voucher Number|Voucher|Voucher number sequence (last used number)|",
	PRIMARY KEY	(`Brand`,`InvGroup`,`PaymType`,`FromDate`),
## The PROGRESS database primary index
	KEY	`InvGroup` (
				`Brand`,
				`InvGroup`,
				`PaymType`,
				`FromDate`))
	COMMENT = "Invoice group invoice number sequences";
DROP TABLE IF EXISTS `rbs_Interest`;
CREATE TABLE `rbs_Interest`(
	`Brand`	CHAR(8) COMMENT "character|x(8)|Brand|Brand|Code Of Brand|",
	`IntPerc`	DECIMAL DEFAULT "0" COMMENT "decimal|z9.99|Interest %|Interest %|Amount of interest (%)|",
	`IntType`	INT DEFAULT "1" COMMENT "integer|>>9|Interest type|IntType|1 = fixed interest, 2 = in addition to euribor|",
	`ValidFrom`	DATE NOT NULL COMMENT "date|99-99-99|Valid|Valid|Date from which this interest is valid|",
	PRIMARY KEY	(`Brand`,`IntType`,`ValidFrom`),
	KEY	`IntPerc` (
				`Brand`,
				`IntPerc`,
				`ValidFrom`),
## The PROGRESS database primary index
	KEY	`ValidFrom` (
				`Brand`,
				`IntType`,
				`ValidFrom`))
	COMMENT = "Overtime interests for different time periods";
DROP TABLE IF EXISTS `rbs_InvGroup`;
CREATE TABLE `rbs_InvGroup`(
	`Banned`	TINYINT(1) DEFAULT "0" COMMENT "logical|Yes/No|Banned|Banned|Is group excluded (banned) from invoice run (Yes/No)|",
	`BillPerm`	TINYINT(1) DEFAULT "1" COMMENT "logical|Yes/No|Invoiced|Invoiced|Shall this group be invoiced (new calls left unmarked) (Y/N)|",
	`Brand`	CHAR(8) COMMENT "character|x(8)|Brand|Brand|Code Of Brand|",
	`IGName`	CHAR(40) COMMENT "character|x(40)|Group Name|Group Name|Name of Invoicing Group|",
	`InvForm`	CHAR(12) COMMENT "character|x(12)|Form Code|Form Code|Invoice Form Code|",
	`InvGroup`	CHAR(8) COMMENT "character|x(8)|InvGroup|InvGroup|Alphanumeric code for Invoicing Group|",
	`MinInvAmt`	DECIMAL DEFAULT "0" COMMENT "decimal|zz9.99|MinInvoice|MinInv|Billing threshold|Minimum amount of invoicing",
	`TaxZone`	CHAR(8) COMMENT "character|x(8)|Tax Zone|Zone|Tax Zone|",
	`UnbilledLimit`	INT DEFAULT "0" COMMENT "integer|>9|Unpaid months|Unpaid months|After how many months unpaid calls will be invoiced|",
	`UpdCustBal`	TINYINT(1) DEFAULT "1" COMMENT "logical|Yes/No|Account|Account|Will this group update accounts (Y/N)|",
	PRIMARY KEY	(`Brand`,`InvGroup`),
	KEY	`IGName` (
				`Brand`,
				`IGName`),
## The PROGRESS database primary index
	KEY	`InvGroup` (
				`Brand`,
				`InvGroup`))
	COMMENT = "Groups for customers which are to be invoiced simultaneously";
DROP TABLE IF EXISTS `rbs_InvoiceTarget`;
CREATE TABLE `rbs_InvoiceTarget`(
	`FromDate`	DATE COMMENT "date|99-99-99|Valid From|From|Valid from|",
	`HostTable`	CHAR(16) COMMENT "character|x(16)|Host Table|Table|Host table|",
	`InvoiceTargetID`	INT DEFAULT "0" COMMENT "integer|>>>>>>>>9|Invoice Target ID|Target ID|Unique id for invoice target|",
	`ITGroupID`	INT DEFAULT "0" COMMENT "integer|>>>>>>>>>>9|Target Group ID|IT Group|Unique ID for target group|",
	`KeyValue`	CHAR(16) COMMENT "character|x(16)|Key Value|Key|Key value|",
	`MsSeq`	INT DEFAULT "0" COMMENT "integer|>>>>>>>>9|Subscription ID|Subscr.ID|Subscription ID|",
	`ToDate`	DATE COMMENT "date|99-99-99|Valid To|To|Valid to|",
	PRIMARY KEY	(`InvoiceTargetID`),
	KEY	`HostTable` (
				`HostTable`,
				`KeyValue`,
				`ToDate`),
## The PROGRESS database primary index
	KEY	`InvoiceTargetID` (
				`InvoiceTargetID`),
	KEY	`ITGroupID` (
				`ITGroupID`,
				`ToDate`),
	KEY	`MsSeq` (
				`MsSeq`,
				`ToDate`))
	COMMENT = "Invoice target";
DROP TABLE IF EXISTS `rbs_InvoiceTargetGroup`;
CREATE TABLE `rbs_InvoiceTargetGroup`(
	`AgrCust`	INT DEFAULT "0" COMMENT "integer|>>>>>>>9|Agreement Customer|Agr.Cust|Agreement customer|",
	`BillingPerm`	TINYINT(1) DEFAULT "1" COMMENT "logical|Yes/No|Billing Permission|Bill.Perm.|Billing permission|",
	`Brand`	CHAR(8) COMMENT "character|x(8)|Brand|?|Code of brand|",
	`CustNum`	INT DEFAULT "0" COMMENT "integer|>>>>>>>9|Invoice Customer|Inv.Cust|Invoice customer|",
	`DefaultGroup`	TINYINT(1) DEFAULT "0" COMMENT "logical|Yes/No|Default Group|Default|Default group for new targets|",
	`FromDate`	DATE COMMENT "date|99-99-99|Valid From|From|Valid from|",
	`InterestPerm`	TINYINT(1) DEFAULT "1" COMMENT "logical|Yes/No|Interest Permission|Int.Perm.|Calculate penalty interest for late payments|",
	`IntType`	INT DEFAULT "1" COMMENT "integer|9|Interest type|Int.Type|Interest type (rate) ID|",
	`ITGroupID`	INT DEFAULT "0" COMMENT "integer|>>>>>>>>>>9|Target Group ID|IT Group|Unique ID for target group|",
	`ServiceNbrItemPerm`	TINYINT(1) DEFAULT "1" COMMENT "logical|Yes/No|Service Number Itemization|Serv.Itemization|Print service number itemization|",
	`ToDate`	DATE COMMENT "date|99-99-99|Valid To|To|Valid to|",
	PRIMARY KEY	(`ITGroupID`),
	KEY	`CustNum` (
				`CustNum`,
				`ToDate`),
	KEY	`DefaultGroup` (
				`Brand`,
				`AgrCust`,
				`CustNum`,
				`DefaultGroup`),
## The PROGRESS database primary index
	KEY	`ITGroupID` (
				`ITGroupID`))
	COMMENT = "Invoice target group";
DROP TABLE IF EXISTS `rbs_InvSect`;
CREATE TABLE `rbs_InvSect`(
	`Brand`	CHAR(8) COMMENT "character|x(8)|Brand|Brand|Code Of Brand|",
	`InvSect`	CHAR(8) COMMENT "character|x(8)|Invoice Section|Invoice Section|Code of an Invoice Section|",
	`ISName`	CHAR(40) COMMENT "character|x(40)|Section Name|Section Name|Name of an Invoice Section|",
	`ISValue`	TINYINT(1) DEFAULT "0" COMMENT "logical|Calls/Others|Contains|Contains|Does this section contain (C)alls or (O)ther fees|",
	`PrintHead`	TINYINT(1) DEFAULT "0" COMMENT "logical|Yes/No|Print to Invoice|Print|Print header text to invoice|",
	PRIMARY KEY	(`Brand`,`InvSect`),
## The PROGRESS database primary index
	KEY	`InvSect` (
				`Brand`,
				`InvSect`),
	KEY	`ISName` (
				`Brand`,
				`ISName`,
				`InvSect`))
	COMMENT = "?";
DROP TABLE IF EXISTS `rbs_InvSeq`;
CREATE TABLE `rbs_InvSeq`(
	`AgrCust`	INT DEFAULT "0" COMMENT "integer|>>>>>>>9|Agreement Customer|Agr.Cust|Agreement customer|",
	`Billed`	TINYINT(1) DEFAULT "0" COMMENT "logical|yes/no|Billed|Billed|Is this item billed (y/n)|",
	`CustNum`	INT DEFAULT "0" NOT NULL COMMENT "integer|ZZZZZZZZ9|CustNo|CustNo|Customer's number|",
	`FromDate`	DATE COMMENT "date|99-99-99|DateFrom|DateFrom|FROM date for sequence|",
	`InvNum`	INT DEFAULT "0" COMMENT "integer|zzzzzzz9|InvNo|InvNo|Consecutive Invoice Number, 1 ... 99999999|",
	`InvSeq`	INT DEFAULT "0" COMMENT "integer|>>>>>>9|InvSeq|InvSeq|Calls invoice sequence|",
	`MsSeq`	INT DEFAULT "0" COMMENT "integer|>>>>>>>>9|Subscription ID|MobSub|Mobile subscription ID|",
	`State`	INT DEFAULT "0" COMMENT "integer|9|Status|?|Status of sequence|",
	`SubInvNum`	INT DEFAULT "0" COMMENT "integer|>>9|SubInvoice Number|SubInv|Sequential nbr of the subinvoice within the combined invoice|",
	`ToDate`	DATE COMMENT "date|99-99-99|DateTo|DateTo|TO date for sequence|",
	`UserCust`	INT DEFAULT "0" COMMENT "integer|>>>>>>>9|User Customer|User|User customer|",
	PRIMARY KEY	(`CustNum`,`FromDate`,`ToDate`,`Billed`),
## The PROGRESS database primary index
	KEY	`CustNum` (
				`CustNum`,
				`FromDate`,
				`ToDate`,
				`Billed`),
	KEY	`InvSeq` (
				`InvSeq`),
	KEY	`MsSeq` (
				`MsSeq`,
				`CustNum`,
				`Billed`,
				`ToDate`),
	KEY	`State` (
				`CustNum`,
				`State`))
	COMMENT = "Customers invoice sequences";
DROP TABLE IF EXISTS `rbs_InvSeqDB`;
CREATE TABLE `rbs_InvSeqDB`(
	`CustNum`	INT DEFAULT "0" COMMENT "integer|ZZZZZZZZ9|CustNum|CustNum||",
	`DBSeq`	INT DEFAULT "0" COMMENT "integer|>>>>9|DBSeq|DBSeq||",
	`InvSeq`	INT DEFAULT "0" COMMENT "integer|>>>>>>>>9|InvSeq|InvSeq||",
	PRIMARY KEY	(`CustNum`,`InvSeq`),
	KEY	`DBSeq` (
				`InvSeq`,
				`DBSeq`),
## The PROGRESS database primary index
	KEY	`InvSeq` (
				`CustNum`,
				`InvSeq`))
	COMMENT = "?";
DROP TABLE IF EXISTS `rbs_InvText`;
CREATE TABLE `rbs_InvText`(
	`Brand`	CHAR(8) COMMENT "character|x(8)|Brand|Brand|Code Of Brand|",
	`FromDate`	DATE COMMENT "date|99-99-99|From Date|From|First effective date|",
	`InfoType`	CHAR(8) COMMENT "character|x(8)|Information Type|Type|Type of information text|",
	`InvText`	CHAR(255) COMMENT "character|x(255)|Text|Text|Information text|",
	`ITNum`	INT DEFAULT "0" COMMENT "integer|>>>>>>9|Seq|Seq|Internal sequenco no. of an Invoice Text element|",
	`KeyValue`	CHAR(16) NOT NULL COMMENT "character|x(16)|KeyValue|KeyValue|Unique value of hosting record|Key value of hosting rec converted into formatted string expression",
	`Language`	INT DEFAULT "0" COMMENT "integer|>>9|Language|Language|Text language code|",
	`MainTitle`	CHAR(50) COMMENT "character|x(50)|Main Title|?|Main title for letter|",
	`Position`	INT DEFAULT "1" COMMENT "integer|9|Pos|Pos|Position on invoice 1:InvStart 2:InvEnd 3:SectStart 4:SectEnd|",
	`PrintOnce`	TINYINT(1) DEFAULT "0" COMMENT "logical|Yes/No|Print Only Once|Once|Use this text only once per customer|",
	`Report`	INT DEFAULT "0" COMMENT "integer|>>9|Printed To|Printed|Where to print; 0=invoice, 1=reminder, 2=eMail|",
	`Target`	CHAR(16) COMMENT "character|x(16)|Target|Target|Target into which this text element belongs to|One of pre-defined targets (hard-coded by programmer)",
	`ToDate`	DATE COMMENT "date|99-99-99|To Date|To|Last effective date|",
	`TxtTitle`	CHAR(40) COMMENT "character|x(40)|Title|Title|Short header/description of message (not to be printed)|",
	PRIMARY KEY	(`Brand`,`Target`,`KeyValue`,`FromDate`),
	KEY	`FromDate` (
				`Brand`,
				`FromDate`,
				`Target`,
				`KeyValue`),
	KEY	`ITNum` (
				`ITNum`),
## The PROGRESS database primary index
	KEY	`target` (
				`Brand`,
				`Target`,
				`KeyValue`,
				`FromDate`))
	COMMENT = "Texts to be printed to invoices";
DROP TABLE IF EXISTS `rbs_ITSendLog`;
CREATE TABLE `rbs_ITSendLog`(
	`Brand`	CHAR(8) COMMENT "character|x(8)|Brand|Brand|Code Of Brand|",
	`CustNum`	INT DEFAULT "0" NOT NULL COMMENT "integer|>>>>>>>>9|Customer|Cust|Customer's number|",
	`InvNum`	INT DEFAULT "0" COMMENT "integer|>>>>>>>9|Invoice Nbr|Invoice|Invoice number|",
	`ITNum`	INT DEFAULT "0" COMMENT "integer|>>>>>>9|Seq|Seq|Internal sequenco no. of an Invoice Text element|",
	`RepType`	CHAR(8) COMMENT "character|x(8)|Report Type|Report|Report Type|",
	`SendInfo`	CHAR(50) COMMENT "character|x(50)|Info|?|Info|",
	`SendMethod`	INT DEFAULT "0" COMMENT "integer|9|Send Method|Method|Send method|1=email, 2=epl",
	`SendStamp`	DECIMAL DEFAULT "0" COMMENT "decimal|>>>>>>>9.99999|Sending time|Sent|Time when text was sent to customer|",
	`TxtType`	INT DEFAULT "0" COMMENT "integer|9|Text Type|Text|Text type|1=IT, 2=memo",
	`UserCode`	CHAR(8) COMMENT "character|x(8)|User|User|Id of the TMS User|",
	PRIMARY KEY	(`CustNum`,`SendStamp`),
	KEY	`CustNum` (
				`Brand`,
				`CustNum`,
				`SendStamp`),
## The PROGRESS database primary index
	KEY	`CustNum_s` (
				`CustNum`,
				`SendStamp`),
	KEY	`InvNum` (
				`InvNum`,
				`RepType`),
	KEY	`RepType` (
				`Brand`,
				`RepType`,
				`SendStamp`),
	KEY	`TxtType` (
				`TxtType`,
				`ITNum`,
				`CustNum`))
	COMMENT = "?";
DROP TABLE IF EXISTS `rbs_Limit`;
CREATE TABLE `rbs_Limit`(
	`Active`	INT DEFAULT "1" COMMENT "integer|->>9|Active|Active|Is limit active (0=no, 1=yes)|",
	`Brand`	CHAR(8) COMMENT "character|x(8)|Brand|Brand|Code Of Brand|",
	`CustNum`	INT DEFAULT "0" NOT NULL COMMENT "integer|>>>>>>>9|Customer|Cust|Customer number|",
	`DefValue`	TINYINT(1) DEFAULT "1" COMMENT "logical|Yes/No|Default Value|Default|Limit has the default value|",
	`FromDate`	DATE COMMENT "date|99-99-99|From|?|Date when rule becomes effective|",
	`LimitAmt`	DECIMAL DEFAULT "0" COMMENT "decimal|->>>>>>9.99|Limit Amount|Amount|Limit amount|",
	`LimitID`	INT DEFAULT "0" COMMENT "integer|>>9|Limit ID|ID|Limit ID|",
	`LimitPerc`	DECIMAL DEFAULT "0" COMMENT "decimal|>>9.99|Limit Percent|Percent|Limit percent|",
	`LimitType`	INT DEFAULT "0" COMMENT "integer|>9|Limit Type|Type|Type of limit|",
	`MsSeq`	INT DEFAULT "0" COMMENT "integer|>>>>>>>>9|Subscription ID|MobSub|Mobile subscription ID|",
	`TMRuleSeq`	INT DEFAULT "0" COMMENT "integer|>>>>>>>>9|Rule Sequence|Seq|Rule ID|",
	`ToDate`	DATE COMMENT "date|99-99-99|To|?|Date when rule expires|",
	`ValueType`	INT DEFAULT "0" COMMENT "integer|>9|Value Type|Type|Type of limit value|",
	PRIMARY KEY	(`CustNum`,`LimitType`,`TMRuleSeq`,`LimitID`,`ToDate`),
## The PROGRESS database primary index
	KEY	`CustNum` (
				`CustNum`,
				`LimitType`,
				`TMRuleSeq`,
				`LimitID`,
				`ToDate`),
	KEY	`LimitType` (
				`Brand`,
				`LimitType`,
				`LimitID`,
				`ToDate`),
	KEY	`MsSeq` (
				`MsSeq`,
				`LimitType`,
				`TMRuleSeq`,
				`ToDate`),
	KEY	`TMRuleSeq` (
				`TMRuleSeq`,
				`LimitID`,
				`ToDate`))
	COMMENT = "Limits for customer and subscription";
DROP TABLE IF EXISTS `rbs_Matrix`;
CREATE TABLE `rbs_Matrix`(
	`Brand`	CHAR(8) DEFAULT "1" COMMENT "character|X(8)|Brand|Brand||Brand",
	`MXKey`	CHAR(8) COMMENT "character|x(8)|MXKey|MXKey|Matrix key|Matrix Key",
	`MXName`	CHAR(30) COMMENT "character|x(30)|Name of the Matrix|Matrix Name||",
	`MXRes`	INT COMMENT "integer|>9|MXRes|MXRes|Matrix Response|Matrix Response",
	`MXSeq`	INT DEFAULT "0" COMMENT "integer|>>>>>>>>9|MXSeq|MXSeq|Matrix Sequence|Matrix Key",
	`Prior`	INT DEFAULT "0" COMMENT "integer|>>9|Prior|Prior|Matrix Prior|Matrix Prior",
	PRIMARY KEY	(`Brand`,`MXKey`,`Prior`),
## The PROGRESS database primary index
	KEY	`Brand` (
				`Brand`,
				`MXKey`,
				`Prior`))
	COMMENT = "?";
DROP TABLE IF EXISTS `rbs_Memo`;
CREATE TABLE `rbs_Memo`(
	`Brand`	CHAR(8) COMMENT "character|x(8)|Brand|Brand|Code Of Brand|",
	`CreStamp`	DECIMAL DEFAULT "0" COMMENT "decimal|99999999.99999|Created|Created|Date and time when this memo record was CREATED|Time Stamp yyyymmdd.time (sec)",
	`CreUser`	CHAR(8) COMMENT "character|X(8)|Created By|Created by|User who CREATED this memo record|",
	`CustNum`	INT DEFAULT "0" NOT NULL COMMENT "integer|>>>>>>>>9|Customer|Customer|Customer's number|",
	`HostTable`	CHAR(12) NOT NULL COMMENT "character|x(12)|HostTable|HostTable|Name of table where this memo record is assigned|",
	`KeyValue`	CHAR(16) NOT NULL COMMENT "character|x(16)|KeyValue|KeyValue|Unique value of hosting record|Key value of hosting rec converted into formatted string expression",
	`MemoSeq`	INT DEFAULT "0" NOT NULL COMMENT "integer|>>>>>>>>>>9|Seq|Seq|Unique, consecutive sequence no. of memo record|sequence from memoSeq sequence",
	`MemoText`	CHAR(0) COMMENT "character|x(900)|MemoText|MemoText|MemoText|",
	`MemoTitle`	CHAR(40) COMMENT "character|x(40)|Title|Title/topic|Title or topic of this memo|",
	`MemoType`	CHAR(12) COMMENT "character|x(12)|MemoType|MemoType|Type of memo|",
	PRIMARY KEY	(`Brand`,`HostTable`,`KeyValue`,`MemoSeq`),
	KEY	`CustNum` (
				`Brand`,
				`CustNum`,
				`HostTable`,
				`KeyValue`),
	KEY	`CustOrder` (
				`Brand`,
				`CustNum`,
				`MemoSeq`),
## The PROGRESS database primary index
	KEY	`HostTable` (
				`Brand`,
				`HostTable`,
				`KeyValue`,
				`MemoSeq`),
	KEY	`MemoSeq` (
				`MemoSeq`),
	KEY	`MemoType` (
				`Brand`,
				`MemoType`,
				`CustNum`))
	COMMENT = "This file is a common storage area for all kind of memos
assigned to different tables/records";
DROP TABLE IF EXISTS `rbs_MinConsumption`;
CREATE TABLE `rbs_MinConsumption`(
	`FromDate`	DATE COMMENT "date|99-99-99|From|?|Period begin|",
	`InvNum`	INT DEFAULT "0" COMMENT "integer|>>>>>>>9|Invoice|?|Invoice on which minimum consumption was handled|",
	`MSSeq`	INT DEFAULT "0" NOT NULL COMMENT "integer|>>>>>>>9|Subscription ID|Subs.ID|Sequence for a subscription|",
	`ToDate`	DATE COMMENT "date|99-99-99|To|?|Period end|",
	PRIMARY KEY	(`MSSeq`,`ToDate`),
	KEY	`InvNum` (
				`InvNum`),
## The PROGRESS database primary index
	KEY	`MsSeq` (
				`MSSeq`,
				`ToDate`))
	COMMENT = "Minimum consumption for a period";
DROP TABLE IF EXISTS `rbs_MobSub`;
CREATE TABLE `rbs_MobSub`(
	`ActivationDate`	DATE COMMENT "date|99-99-99|Activation Date|Activation|Date when subscription is to be activated in HLR|",
	`ActivationTS`	DECIMAL DEFAULT "0" COMMENT "decimal|999999.99999|Activated|?|Time when subscription was activated in TMS (HLR response OK)|",
	`AgrCust`	INT DEFAULT "0" NOT NULL COMMENT "integer|>>>>>>>>9|Agr.Customer|AgrCust|Agreement customer's number|",
	`BillTarget`	INT DEFAULT "0" COMMENT "integer|>9|Bill.Target|BT|Customer's billing target|",
	`Brand`	CHAR(8) COMMENT "character|x(8)|BrCode|BrCode|Code Of Brand|",
	`ClaimState`	DECIMAL DEFAULT "0" COMMENT "decimal|>9.99|Claiming Status|ClaimSt|Claiming status|",
	`CLI`	CHAR(11) COMMENT "character|X(11)|MSISDN|MSISDN No|MSISDN Subscriber No|",
	`CliType`	CHAR(8) COMMENT "character|x(8)|MType|Mtype|Type Of Mobsub|",
	`CMCreatedTS`	DECIMAL DEFAULT "0" COMMENT "decimal|99999999.99999|CM creation time|CM creation time|Time when contract was created in CM|",
	`Contract`	TINYINT(1) DEFAULT "0" COMMENT "logical|Yes/No|ContSign|ContSign|Contract signed|",
	`CreationDate`	DATE COMMENT "date|99-99-99|Created|?|Date when subscription was created (from order)|",
	`CustNum`	INT DEFAULT "0" NOT NULL COMMENT "integer|>>>>>>>>9|Customer|Customer|Customer's number|",
	`DeliveryType`	CHAR(16) COMMENT "character|x(16)|Delivery Type|Delivery|Delivery type|",
	`ExperimentDate`	DATE COMMENT "date|99-99-99|Experiment Date|Experiment|Date when experiment period expires|",
	`ForeignKey`	DECIMAL DEFAULT "0" COMMENT "decimal|9999999999999999|?|ForeignKey|ForeignKey from another system|",
	`IMSI`	CHAR(18) COMMENT "character|x(18)|IMSI Number|IMSI Number|IMSI Number|",
	`InvCust`	INT DEFAULT "0" NOT NULL COMMENT "integer|>>>>>>>>9|Inv.Customer|InvCust|Invoicing customer's number|",
	`MainContractID`	INT DEFAULT "0" COMMENT "integer|>>>>>>9|Parent contractid|Parent contractid|Parent contractid|",
	`MNPChannel`	INT DEFAULT "0" COMMENT "integer|>9|MNP Channel|MNPChannel|MNP Channel|",
	`MsSeq`	INT DEFAULT "0" NOT NULL COMMENT "integer|>>>>>>>9|SubSeq|SubSeq|Sequence for a Subscription|",
	`MsStatus`	INT DEFAULT "1" COMMENT "integer|9|Status|Status|Status Code, 1 ... 9|",
	`NickName`	CHAR(16) COMMENT "character|x(16)|Subscription NickName|Sub NickName|Subscription NickName|",
	`OrderId`	CHAR(16) COMMENT "character|x(16)|Order Id|Order Id|Order Id of the mobile subscription|",
	`PayType`	TINYINT(1) DEFAULT "0" COMMENT "logical|PrePaid/PostPaid|PayType|PayType|PayType|",
	`Reseller`	CHAR(8) COMMENT "character|x(8)|Reseller|Reseller|An unique code for a reseller|",
	`Salesman`	CHAR(8) COMMENT "character|x(8)|Salesman|Salesman|Salesman's code|",
	PRIMARY KEY	(`MsSeq`),
	KEY	`AgrCust` (
				`Brand`,
				`AgrCust`,
				`CLI`),
	KEY	`CLI` (
				`Brand`,
				`CLI`),
	KEY	`CLIType` (
				`Brand`,
				`CliType`,
				`CLI`),
	KEY	`CLI_u` (
				`CLI`),
	KEY	`CustNum` (
				`Brand`,
				`CustNum`,
				`BillTarget`,
				`CLI`),
	KEY	`CustNum_u` (
				`CustNum`,
				`BillTarget`,
				`CLI`),
	KEY	`ForeignKey` (
				`ForeignKey`),
	KEY	`idx_MainCtr` (
				`MainContractID`),
	KEY	`IMSI` (
				`Brand`,
				`IMSI`),
	KEY	`InvCust` (
				`Brand`,
				`InvCust`,
				`CLI`),
	KEY	`MNPChannel` (
				`Brand`,
				`MNPChannel`,
				`MsStatus`),
## The PROGRESS database primary index
	KEY	`MsSeq` (
				`MsSeq`),
	KEY	`MsStatus` (
				`Brand`,
				`MsStatus`,
				`ActivationDate`),
	KEY	`MsStatus_u` (
				`MsStatus`,
				`ActivationDate`))
	COMMENT = "Mobile Subscription";
DROP TABLE IF EXISTS `rbs_MSOwner`;
CREATE TABLE `rbs_MSOwner`(
	`AgrCust`	INT DEFAULT "0" NOT NULL COMMENT "integer|>>>>>>>>9|Agr.Customer|AgrCust|Agreement customer's number|",
	`BillTarget`	INT DEFAULT "0" COMMENT "integer|z9|InvTarg|IT|Invoicing Target No|",
	`Brand`	CHAR(8) COMMENT "character|x(8)|BrCode|BrCode|Code Of Brand|",
	`CLI`	CHAR(11) COMMENT "character|X(11)|MSISDN|MSISDN No|MSISDN Subscriber No|",
	`CliEvent`	CHAR(1) COMMENT "character|x(1)|Type|Type|Type of MSISDN number|",
	`Clitype`	CHAR(8) COMMENT "character|x(8)|MType|Mtype|Type Of Mobsub (connection type)|",
	`Contract`	CHAR(8) COMMENT "character|x(8)|ContractID|ContrID|Contract ID|",
	`CustNum`	INT DEFAULT "0" NOT NULL COMMENT "integer|>>>>>>>>9|Customer|Customer|Customer's number|",
	`ForeignKey`	DECIMAL DEFAULT "0" COMMENT "decimal|9999999999999999|?|ForeignKey|ForeignKey from another system|",
	`IMSI`	CHAR(18) COMMENT "character|x(18)|IMSI Number|IMSI Number|IMSI Number|",
	`InvCust`	INT DEFAULT "0" NOT NULL COMMENT "integer|>>>>>>>>9|Inv.Customer|InvCust|Invoicing customer's number|",
	`MsSeq`	INT DEFAULT "0" NOT NULL COMMENT "integer|>>>>>>>9|SubSeq|SubSeq|Sequence for a Subscription|Id of a mobsub record. Note that mobsub can have been deleted",
	`PayType`	TINYINT(1) DEFAULT "0" COMMENT "logical|PrePaid/PostPaid|PayType|PayType|PayType|",
	`TsBegin`	DECIMAL DEFAULT "0" COMMENT "decimal|99999999.99999|Usage begun|Usage begun|Time Stamp: when usage begun|",
	`TsEnd`	DECIMAL DEFAULT "99999999.99999" COMMENT "decimal|99999999.99999|Usage ended|Usage ended|Time Stamp, when usage ended|",
	PRIMARY KEY	(`Brand`,`CLI`,`TsEnd`),
	KEY	`AgrCust` (
				`AgrCust`,
				`CLI`,
				`TsEnd`),
	KEY	`BillTarget` (
				`Brand`,
				`CustNum`,
				`BillTarget`),
## The PROGRESS database primary index
	KEY	`CLI` (
				`Brand`,
				`CLI`,
				`TsEnd`),
	KEY	`CLIEvent` (
				`CLI`,
				`TsBegin`,
				`TsEnd`,
				`CliEvent`),
	KEY	`CLI_s` (
				`CLI`,
				`TsEnd`),
	KEY	`Contract` (
				`Brand`,
				`Contract`),
	KEY	`CustNum` (
				`Brand`,
				`CustNum`,
				`CLI`,
				`TsEnd`),
	KEY	`CustNum_s` (
				`CustNum`,
				`CLI`,
				`TsEnd`),
	KEY	`ForeignKey` (
				`ForeignKey`,
				`TsEnd`),
	KEY	`imsi` (
				`Brand`,
				`IMSI`,
				`TsBegin`),
	KEY	`imsi_s` (
				`IMSI`,
				`TsBegin`),
	KEY	`InvCust` (
				`InvCust`,
				`CLI`,
				`TsEnd`),
	KEY	`MsSeq` (
				`MsSeq`,
				`TsBegin`))
	COMMENT = "";
DROP TABLE IF EXISTS `rbs_MXItem`;
CREATE TABLE `rbs_MXItem`(
	`MXName`	CHAR(16) COMMENT "character|x(16)|Name MXItem|Matrix item||",
	`MXSeq`	INT DEFAULT "0" COMMENT "integer|>>>>>>>>9|MXSeq|MXSeq|Matrix Sequence|Matrix Key",
	`MXValue`	CHAR(18) COMMENT "character|X(18)|MXValue|MXValue|Matrix Value|Matrix Value",
	PRIMARY KEY	(`MXSeq`,`MXName`),
## The PROGRESS database primary index
	KEY	`MXSeq` (
				`MXSeq`,
				`MXName`))
	COMMENT = "?";
DROP TABLE IF EXISTS `rbs_OPLog`;
CREATE TABLE `rbs_OPLog`(
	`Amt`	DECIMAL DEFAULT "0" COMMENT "decimal|-z,zzz,zz9.99|Sum|Sum|Sum (amount of money)|",
	`BalTarget`	CHAR(16) COMMENT "character|x(16)|Target|Target|Balance target|",
	`CLI`	CHAR(15) COMMENT "character|x(15)|MSISDN|?||",
	`CreStamp`	DECIMAL DEFAULT "0" COMMENT "decimal|99999999.99999|TStamp|TStamp|TimeStamp; when created|",
	`CustNum`	INT DEFAULT "0" NOT NULL COMMENT "integer|ZZZZZZZZ9|CustNo|CustNo|Customer's number|",
	`EventDate`	DATE COMMENT "date|99-99-99|Date|Date|Date of transaction/event|",
	`EventType`	INT DEFAULT "0" COMMENT "integer|9|Type|Type|Transaction Type Code|",
	`Info`	CHAR(30) COMMENT "character|x(30)|Info|?|Info|",
	`InvNum`	INT DEFAULT "0" COMMENT "integer|zzzzzzz9|InvNo|InvNo|Number of Associated Invoice|",
	`SubInvNum`	INT DEFAULT "0" COMMENT "integer|>>9|SubInvoice Number|SubInv|Sequential nbr of the subinvoice within the combined invoice|",
	`TargetType`	CHAR(16) COMMENT "character|x(16)|Target Type|Type|Target type|",
	`UserCode`	CHAR(8) COMMENT "character|x(8)|User|User|Id of the TMS User|",
	`Voucher`	INT DEFAULT "0" COMMENT "integer|zzzzzz9|VoucherNo|VoucherNo|Voucher Number of Associated Payment (if any)|",
	PRIMARY KEY	(`CustNum`,`CreStamp`),
	KEY	`CLI` (
				`CLI`),
	KEY	`CustDate` (
				`CustNum`,
				`EventDate`,
				`Voucher`),
	KEY	`CustInv` (
				`CustNum`,
				`InvNum`,
				`EventDate`),
## The PROGRESS database primary index
	KEY	`CustNum` (
				`CustNum`,
				`CreStamp`),
	KEY	`InvNum` (
				`InvNum`,
				`EventDate`),
	KEY	`SubInvNum` (
				`InvNum`,
				`SubInvNum`,
				`EventDate`),
	KEY	`Voucher` (
				`Voucher`))
	COMMENT = "Overpayment Transaction Log";
DROP TABLE IF EXISTS `rbs_PaymCfg`;
CREATE TABLE `rbs_PaymCfg`(
	`Brand`	CHAR(8) COMMENT "character|x(8)|Brand|Brand|Code Of Brand|",
	`ConvMod`	CHAR(12) COMMENT "character|x(12)|Conversion program|ConvMod|Name of the program that performs conversion (without '.p')|",
	`Origin`	CHAR(30) COMMENT "character|x(30)|Name|?|Name of the ocr-file's origin|",
	`PaymAccNum`	INT DEFAULT "0" COMMENT "integer|>>>>>9|Acct|Acct|Account nbr for posting the payment|",
	`PaymCfg`	CHAR(8) COMMENT "character|x(8)|Origin Id|OrigId|Id of the ocr-file's origin|used also as a log prefix",
	`PaymFile`	CHAR(50) COMMENT "character|x(50)|Ocr-File|File|Name of the file containing ocr payments|",
	PRIMARY KEY	(`Brand`,`PaymCfg`),
	KEY	`Origin` (
				`Brand`,
				`Origin`),
## The PROGRESS database primary index
	KEY	`PaymCfg` (
				`Brand`,
				`PaymCfg`))
	COMMENT = "Configuration for payment files";
DROP TABLE IF EXISTS `rbs_PaymConfig`;
CREATE TABLE `rbs_PaymConfig`(
	`Brand`	CHAR(8) COMMENT "character|x(8)|Brand|?|Code of brand|",
	`CreditAccNum`	INT DEFAULT "0" COMMENT "integer|>>>>>>>9|Credit Account|Credit|Account for credit posting|",
	`DebitAccNum`	INT DEFAULT "0" COMMENT "integer|>>>>>>>9|Debit Account|Debit|Account for debit posting|",
	`Description`	CHAR(50) COMMENT "character|x(50)|Description|?|Description of where to rule is used|",
	`FromDate`	DATE COMMENT "date|99-99-99|Valid From|From|Date when rule becomes effective|",
	`PaymConfig`	INT DEFAULT "0" COMMENT "integer|>>>>>>>>>9|Configuration ID|ID|Configuration ID, used in links|",
	`PaymSrc`	CHAR(8) COMMENT "character|x(8)|Payment Source|Source|Source of payment|",
	`PaymType`	INT DEFAULT "0" COMMENT "integer|>9|Payment Type|PType|Payment type|",
	`TaxRules`	TINYINT(1) DEFAULT "0" COMMENT "logical|Yes/No|Tax Rules|Tax|Are there rules for tax accounts|",
	`ToDate`	DATE COMMENT "date|99-99-99|To|?|Date when usage of this rule ends|",
	PRIMARY KEY	(`Brand`,`PaymType`,`PaymSrc`,`ToDate`),
	KEY	`PaymConfig` (
				`PaymConfig`),
	KEY	`PaymSrc` (
				`Brand`,
				`PaymSrc`,
				`PaymType`,
				`ToDate`),
## The PROGRESS database primary index
	KEY	`PaymType` (
				`Brand`,
				`PaymType`,
				`PaymSrc`,
				`ToDate`))
	COMMENT = "Configuration rules for payments";
DROP TABLE IF EXISTS `rbs_Region`;
CREATE TABLE `rbs_Region`(
	`Region`	CHAR(8) COMMENT "character|x(8)|Region|?|Region code|",
	`RgName`	CHAR(30) COMMENT "character|x(30)|Name|?|Region name|",
	`TaxZone`	CHAR(8) COMMENT "character|x(8)|Tax Zone|Zone|Tax Zone|",
	PRIMARY KEY	(`Region`),
## The PROGRESS database primary index
	KEY	`Region` (
				`Region`),
	KEY	`RgName` (
				`RgName`))
	COMMENT = "Customer region";
DROP TABLE IF EXISTS `rbs_RepLog`;
CREATE TABLE `rbs_RepLog`(
	`EventTimeStamp`	DATETIME COMMENT "datetime-tz|99-99-9999 HH:MM:SS.SSS+HH:MM|Event's Timestamp|Event TS||",
	`EventType`	CHAR(6) COMMENT "character|x(6)|Event type|EventType||",
	`KeyValue`	CHAR(30) COMMENT "character|x(30)|KeyValue|KeyValue||",
	`RowID`	CHAR(18) COMMENT "character|x(18)|RowID|RowID||RowID in character format",
	`TableName`	CHAR(15) COMMENT "character|x(15)|Table name|TableName||",
	PRIMARY KEY	(`EventTimeStamp`),
	KEY	`idx_eventype` (
				`EventType`,
				`TableName`,
				`EventTimeStamp`),
## The PROGRESS database primary index
	KEY	`idx_timestamp` (
				`EventTimeStamp`))
	COMMENT = "This is the replication log table for replicating the record";
DROP TABLE IF EXISTS `rbs_ReportConf`;
CREATE TABLE `rbs_ReportConf`(
	`Brand`	CHAR(8) COMMENT "character|x(8)|Brand|?|Code of Brand|",
	`ReportID`	CHAR(12) COMMENT "character|x(12)|Report ID|ID|Report ID|",
	`ReportName`	CHAR(30) COMMENT "character|x(30)|Report Name|Name|Report name|",
	PRIMARY KEY	(`Brand`,`ReportID`),
## The PROGRESS database primary index
	KEY	`ReportID` (
				`Brand`,
				`ReportID`))
	COMMENT = "Report configuration";
DROP TABLE IF EXISTS `rbs_ReportConfRow`;
CREATE TABLE `rbs_ReportConfRow`(
	`Brand`	CHAR(8) COMMENT "character|x(8)|Brand|?|Code of Brand|",
	`CharValue`	CHAR(12) COMMENT "character|x(12)|Character Value|Char|Character value|",
	`ConfRowID`	INT DEFAULT "0" COMMENT "integer|>>>>>>>>>>9|Row ID|ID|Unique row ID|",
	`DecValue`	DECIMAL DEFAULT "0" COMMENT "decimal|->>>>>>>>9.9999|Decimal Value|Dec|Decimal value|",
	`FromDate`	DATE COMMENT "date|99-99-99|Valid From|From|Date when configuration becomes effective|",
	`IntValue`	INT DEFAULT "0" COMMENT "integer|->>>>>>>9|Integer Value|Int|Integer value|",
	`LogicValue`	TINYINT(1) DEFAULT "0" COMMENT "logical|Yes/No|Logical Value|Logic|Logical value|",
	`ReportID`	CHAR(12) COMMENT "character|x(12)|Report ID|ID|Report ID|",
	`RowType`	CHAR(8) COMMENT "character|x(8)|Row Type|Type|Row type|",
	`ToDate`	DATE COMMENT "date|99-99-99|To|?|Date when configuration expires|",
	PRIMARY KEY	(`ConfRowID`),
## The PROGRESS database primary index
	KEY	`ConfRowID` (
				`ConfRowID`),
	KEY	`ReportID` (
				`Brand`,
				`ReportID`,
				`RowType`,
				`ToDate`))
	COMMENT = "Report configuration row";
DROP TABLE IF EXISTS `rbs_RepText`;
CREATE TABLE `rbs_RepText`(
	`Brand`	CHAR(8) COMMENT "character|x(8)|Brand|Brand|Code Of Brand|",
	`FromDate`	DATE COMMENT "date|99-99-99|From|?|Date when text becomes effective|",
	`Language`	INT DEFAULT "0" COMMENT "integer|>9|Language|Language|Code of Language|",
	`LinkCode`	CHAR(30) COMMENT "character|x(30)|Char|Char|Character code value|",
	`RepText`	CHAR(35) COMMENT "character|x(35)|Text|Text|Text|",
	`TextType`	INT DEFAULT "0" COMMENT "integer|>9|InvType|InvType|Invoice Language Type|",
	`ToDate`	DATE COMMENT "date|99-99-99|To|?|Date when text expires|",
	PRIMARY KEY	(`Brand`,`TextType`,`LinkCode`,`Language`,`ToDate`),
	KEY	`Language` (
				`Brand`,
				`TextType`,
				`Language`,
				`LinkCode`),
## The PROGRESS database primary index
	KEY	`LinkCode` (
				`Brand`,
				`TextType`,
				`LinkCode`,
				`Language`,
				`ToDate`))
	COMMENT = "Report texts";
DROP TABLE IF EXISTS `rbs_Reseller`;
CREATE TABLE `rbs_Reseller`(
	`Address[1]`	CHAR(30) COMMENT "character|x(30)|Address|Address|Resellers address|",
	`Address[2]`	CHAR(30) COMMENT "character|x(30)|Address|Address|Resellers address|",
	`Address[3]`	CHAR(30) COMMENT "character|x(30)|Address|Address|Resellers address|",
	`Brand`	CHAR(8) COMMENT "character|x(8)|Brand|Brand|Code Of Brand|",
	`Chain`	CHAR(8) COMMENT "character|x(8)|Chain|Chain|Chain number (Internal ID)|",
	`EMail`	CHAR(40) COMMENT "character|x(40)|Email|Email|Resellers Email address|",
	`Reseller`	CHAR(8) COMMENT "character|x(8)|Code|Code|An unique code for a reseller; maximum 8 characters|",
	`ResellerID`	INT DEFAULT "0" COMMENT "integer|>>>>>>>9|Reseller ID|Reseller|Reseller ID|",
	`RsName`	CHAR(30) COMMENT "character|x(30)|Name|Name|Reseller's name|",
	`Salesman`	CHAR(8) COMMENT "character|x(8)|Salesman|Salesman|Code of that salesman who is responsible of this reseller|",
	PRIMARY KEY	(`Brand`,`Reseller`),
## The PROGRESS database primary index
	KEY	`Reseller` (
				`Brand`,
				`Reseller`),
	KEY	`ResellerID` (
				`ResellerID`),
	KEY	`RsName` (
				`Brand`,
				`RsName`,
				`Reseller`),
	KEY	`Salesman` (
				`Brand`,
				`Salesman`,
				`Reseller`))
	COMMENT = "Resellers";
DROP TABLE IF EXISTS `rbs_Salesman`;
CREATE TABLE `rbs_Salesman`(
	`Active`	TINYINT(1) DEFAULT "1" COMMENT "logical|Yes/No|Active|?|Is salesman active|",
	`Brand`	CHAR(8) COMMENT "character|x(8)|Brand|Brand|Code Of Brand|",
	`CustNum`	INT DEFAULT "0" NOT NULL COMMENT "integer|>>>>>>>9|Customer|Cust|Customer that is related to this salesman|",
	`EMail`	CHAR(40) COMMENT "character|x(40)|E-mail|E-mail|Salesman's e-mail address|",
	`FirstName`	CHAR(16) COMMENT "character|x(16)|First Name|FirstName|Salesman First Name|",
	`LastName`	CHAR(16) COMMENT "character|x(16)|Last Name|LastName|Salesman Last Name|",
	`Reseller`	CHAR(8) COMMENT "character|x(8)|Reseller|Resell|Reseller code|",
	`RsLevel`	INT DEFAULT "0" COMMENT "integer|>9|Reseller Level|RSLevel|Salesman's level in reseller's organization|",
	`Salesman`	CHAR(8) COMMENT "character|x(8)|Salesman|Salesman|Salesman's code|",
	`SalesOffice`	CHAR(8) NOT NULL COMMENT "character|x(8)|SalesOffice|SalesOffice|Sales office code|",
	`SmName`	CHAR(30) COMMENT "character|x(30)|Salesman Name|Salesman Name|Salesman's name|",
	PRIMARY KEY	(`Brand`,`Salesman`,`SmName`,`Reseller`),
	KEY	`CustNum` (
				`Brand`,
				`CustNum`,
				`Salesman`),
	KEY	`LastName` (
				`Brand`,
				`LastName`,
				`FirstName`),
	KEY	`Reseller` (
				`Brand`,
				`Reseller`,
				`RsLevel`,
				`Salesman`),
## The PROGRESS database primary index
	KEY	`Salesman` (
				`Brand`,
				`Salesman`,
				`SmName`,
				`Reseller`),
	KEY	`SmName` (
				`Brand`,
				`SmName`,
				`SalesOffice`))
	COMMENT = "Salesman";
DROP TABLE IF EXISTS `rbs_ServAttr`;
CREATE TABLE `rbs_ServAttr`(
	`Brand`	CHAR(8) COMMENT "character|x(8)|BrCode|BrCode|Code Of Brand|",
	`DefValue`	CHAR(8) COMMENT "character|x(8)|Default Value|Value|Default value|",
	`isMandatory`	TINYINT(1) DEFAULT "0" COMMENT "logical|Yes/No|?|Mandatory|is this mandatory while creating service in HLR|",
	`SAName`	CHAR(60) COMMENT "character|x(60)|SAName|SAttrName|Name of Service Component attribute|",
	`SaParameter`	TINYINT(1) DEFAULT "0" COMMENT "logical|yes/no|Parameter?|Parameter?|Does this service contain a subscriber-specific parameter ?|",
	`ScChgable`	TINYINT(1) DEFAULT "1" COMMENT "logical|Yes/No|Changeable|ChgAble|Changeable on subscription level|",
	`ServAttr`	CHAR(14) COMMENT "character|x(14)|Service Attribute|Attribute|Attribute of a service component|",
	`ServCom`	CHAR(12) COMMENT "character|x(12)|Service Component|Service Component|Code of Service Component|",
	PRIMARY KEY	(`Brand`,`ServCom`,`ServAttr`),
	KEY	`SaName` (
				`Brand`,
				`ServCom`,
				`SAName`),
	KEY	`ServAttr` (
				`Brand`,
				`ServAttr`,
				`ServCom`),
## The PROGRESS database primary index
	KEY	`ServCom` (
				`Brand`,
				`ServCom`,
				`ServAttr`))
	COMMENT = "Service Component";
DROP TABLE IF EXISTS `rbs_ServCom`;
CREATE TABLE `rbs_ServCom`(
	`ActType`	INT DEFAULT "0" COMMENT "integer|9|Activation Type|Activ.|Activation method type|",
	`Brand`	CHAR(8) COMMENT "character|x(8)|BrCode|BrCode|Code Of Brand|",
	`ChgSMSTxt`	CHAR(12) COMMENT "character|x(12)|SMS Text For Changing|Change SMS|Key value of the information text for SMS for changing value|",
	`ClSMSTxt`	CHAR(12) COMMENT "character|x(12)|SMS Text For Closing|Close SMS|Key value of the information text for SMS for closing|",
	`ScChgable`	TINYINT(1) DEFAULT "1" COMMENT "logical|Yes/No|Changeable|ChgAble|Changeable on subscription level|",
	`ScLocalName`	CHAR(60) COMMENT "character|x(60)|Local Name|Local Name|Name in Local Language|",
	`ScName`	CHAR(60) COMMENT "character|x(60)|Component Name|Name|Name of Service Component|",
	`ScParameter`	TINYINT(1) DEFAULT "0" COMMENT "logical|yes/no|Parameter?|Parameter?|Does this service contain a subscriber-specific parameter ?|",
	`ScValueRange[2]`	INT DEFAULT "0" COMMENT "integer|>>>9|Range|Range|Value Range for a Service Parameter in HLR|",
	`SepHLR`	TINYINT(1) DEFAULT "0" COMMENT "logical|Yes/No|Separate Command|SepHLR|Separate command line to HLR|",
	`ServAttrL`	TINYINT(1) DEFAULT "0" COMMENT "logical|yes/no|Service Attributes|Attributes|Does component contain attributes|",
	`ServCom`	CHAR(12) COMMENT "character|x(12)|Service Component|Component|Code of Service Component|",
	`Service`	CHAR(8) COMMENT "character|x(8)|Service Group|Service|Code of service group|",
	`SMSTxt`	CHAR(12) COMMENT "character|x(12)|SMS Text|SMS|Key value of the information text for SMS|",
	`Target`	INT DEFAULT "0" COMMENT "integer|9|Target|Target|This Service belongs to|",
	PRIMARY KEY	(`Brand`,`ServCom`),
	KEY	`SCName` (
				`Brand`,
				`ScName`),
## The PROGRESS database primary index
	KEY	`ServCom` (
				`Brand`,
				`ServCom`),
	KEY	`Service` (
				`Brand`,
				`Service`,
				`ServCom`))
	COMMENT = "Service Component";
DROP TABLE IF EXISTS `rbs_ServEl`;
CREATE TABLE `rbs_ServEl`(
	`Brand`	CHAR(8) COMMENT "character|x(8)|BrCode|BrCode|Code Of Brand|",
	`ServCom`	CHAR(12) COMMENT "character|x(12)|Service Component|Component|Code of Service Component (a single service)|",
	`ServPac`	CHAR(12) COMMENT "character|x(12)|Service Package|ServPac|Code of ServPack|",
	PRIMARY KEY	(`Brand`,`ServPac`,`ServCom`),
	KEY	`ServCom` (
				`Brand`,
				`ServCom`,
				`ServPac`),
## The PROGRESS database primary index
	KEY	`ServPac` (
				`Brand`,
				`ServPac`,
				`ServCom`))
	COMMENT = "Service elements (service component group)";
DROP TABLE IF EXISTS `rbs_ServFee`;
CREATE TABLE `rbs_ServFee`(
	`Brand`	CHAR(8) COMMENT "character|x(8)|Brand|?|Code Of Brand|",
	`EventSource`	CHAR(8) COMMENT "character|x(8)|Event Source|Source|Event source|",
	`EventType`	INT DEFAULT "0" COMMENT "integer|9|Event Type|Event|Event type|",
	`FeeModel`	CHAR(16) COMMENT "character|x(16)|Fee Model|FModel|Fees that are created when this event occurs|",
	`FromDate`	DATE COMMENT "date|99-99-99|From|?|Valid from|",
	`InterAct`	TINYINT(1) DEFAULT "0" COMMENT "logical|yes/no|InterAct|InterAct|Ask before create new billing event|",
	`ServKey`	CHAR(12) COMMENT "character|x(12)|Service Key|Key|Key value of service|e.g. report number",
	`ServType`	CHAR(8) COMMENT "character|x(8)|Service Type|Type|Type of service|e.g. Report",
	`ToDate`	DATE COMMENT "date|99-99-99|To|?|Valid to|",
	PRIMARY KEY	(`Brand`,`ServType`,`ServKey`,`EventSource`,`EventType`,`ToDate`),
## The PROGRESS database primary index
	KEY	`ServKey` (
				`Brand`,
				`ServType`,
				`ServKey`,
				`EventSource`,
				`EventType`,
				`ToDate`))
	COMMENT = "Fees from activating services";
DROP TABLE IF EXISTS `rbs_Service`;
CREATE TABLE `rbs_Service`(
	`Brand`	CHAR(8) COMMENT "character|x(8)|BrCode|BrCode|Code Of Brand|",
	`SEName`	CHAR(40) COMMENT "character|x(40)|ServName|Name Of Service|Name of Service(group)|",
	`Service`	CHAR(8) COMMENT "character|x(8)|Service Group|Service|Code of Service (group)|",
	PRIMARY KEY	(`Brand`,`Service`),
	KEY	`SEName` (
				`Brand`,
				`SEName`,
				`Service`),
## The PROGRESS database primary index
	KEY	`Service` (
				`Brand`,
				`Service`))
	COMMENT = "";
DROP TABLE IF EXISTS `rbs_ServiceNum`;
CREATE TABLE `rbs_ServiceNum`(
	`AddInfo`	CHAR(10) COMMENT "character|x(10)|AddInfo|AddInfo|Additional Info|",
	`Brand`	CHAR(8) COMMENT "character|x(8)|BrCode|BrCode|Code Of Brand|",
	`CustService`	CHAR(10) COMMENT "character|x(10)|CustService|CustService|Customer service|",
	`EndTS`	DECIMAL DEFAULT "0" COMMENT "decimal|99999999.99999|EndTime|EndTime|End timestamp|",
	`InvInfo`	INT DEFAULT "0" COMMENT "integer|9|InvInfo|InvInfo|Invoice's display identifier|",
	`MarketingName`	CHAR(10) COMMENT "character|x(10)|MarketingName|MarketingName|Marketing Name|",
	`PayeeName`	CHAR(40) COMMENT "character|x(40)|PayeeName|Payee name|Payee's Name|",
	`ServClass`	INT DEFAULT "0" COMMENT "integer|9|ServClass|ServClass|Service Class identifier|",
	`ServiceNum`	CHAR(10) COMMENT "character|x(10)|Service Number|ServiceNum|Service Number|",
	`StartTS`	DECIMAL DEFAULT "0" COMMENT "decimal|99999999.99999|StartTime|StartTime|Start time|",
	PRIMARY KEY	(`Brand`,`ServiceNum`,`StartTS`),
## The PROGRESS database primary index
	KEY	`ServiceNum` (
				`Brand`,
				`ServiceNum`,
				`StartTS`),
	KEY	`StartTS` (
				`Brand`,
				`StartTS`))
	COMMENT = "Service number details";
DROP TABLE IF EXISTS `rbs_ServPac`;
CREATE TABLE `rbs_ServPac`(
	`Brand`	CHAR(8) COMMENT "character|x(8)|BrCode|BrCode|Code Of Brand|",
	`ServPac`	CHAR(12) COMMENT "character|x(12)|Service Package|ServPack|Service Package Code|",
	`SPName`	CHAR(40) COMMENT "character|x(40)|Service Pack Name|Name|Name of Service Package|",
	PRIMARY KEY	(`Brand`,`ServPac`),
## The PROGRESS database primary index
	KEY	`ServPac` (
				`Brand`,
				`ServPac`),
	KEY	`SPName` (
				`Brand`,
				`SPName`,
				`ServPac`))
	COMMENT = "";
DROP TABLE IF EXISTS `rbs_SingleFee`;
CREATE TABLE `rbs_SingleFee`(
	`Active`	TINYINT(1) DEFAULT "1" COMMENT "logical|Yes/No|Active|?|Is fee active (i.e. billable)|",
	`AgrCust`	INT DEFAULT "0" COMMENT "integer|>>>>>>>>9|Agr. Customer|Agr.Cust|Agreement customer number|",
	`Amt`	DECIMAL DEFAULT "0" COMMENT "decimal|->,>>>,>>9.9999|Amount|Amount|Payable Amount ex VAT|",
	`BillCode`	CHAR(16) COMMENT "character|x(16)|Product|Product|Product code|",
	`Billed`	TINYINT(1) DEFAULT "0" COMMENT "logical|yes/no|Billed|Billed|Is this item billed (y/n)|",
	`BillPeriod`	INT DEFAULT "0" COMMENT "integer|999999|Period|Period|Period YYYYMM (month when this item shall be BILLED)|",
	`BillTarget`	INT DEFAULT "0" COMMENT "integer|z9|No|No|Consecutive No. for Customer's Invoicing Target|",
	`BillType`	CHAR(8) COMMENT "character|x(8)|Billing Type|Billing Type|Billing type|",
	`Brand`	CHAR(8) COMMENT "character|x(8)|Brand|Brand|Code Of Brand|",
	`CalcObj`	CHAR(16) COMMENT "character|x(16)|CalcObject|CalcObject|Calculation Object Within Customer/InvTarg/Billing Level|",
	`Concerns[1]`	INT DEFAULT "0" COMMENT "integer|999999|Concerns|Concerns|Period that this fee concerns|",
	`Concerns[2]`	INT DEFAULT "0" COMMENT "integer|999999|Concerns|Concerns|Period that this fee concerns|",
	`Contract`	CHAR(8) COMMENT "character|x(8)|Contract ID|ContrID|Contract ID|",
	`CustNum`	INT DEFAULT "0" NOT NULL COMMENT "integer|>>>>>>>>9|Customer|Customer|Customer number|",
	`FeeModel`	CHAR(8) COMMENT "character|x(8)|BEvent|BEvent|Code of Billing Event|",
	`FeeQuantity`	DECIMAL DEFAULT "0" COMMENT "decimal|>9.999|Quantity|Qty|Quantity|",
	`FMItemId`	INT DEFAULT "0" COMMENT "integer|zzzzzzzz9|ItemNo|ItemNo|Individual invisible sequence for this item|",
	`HostTable`	CHAR(16) COMMENT "character|x(16)|HostTable|HostTable|HostTable|",
	`InvNum`	INT DEFAULT "0" COMMENT "integer|zzzzzzzzz|InvNo|InvNo|Number of an invoice where this item was billed|",
	`ITGroupID`	INT DEFAULT "0" COMMENT "integer|>>>>>>>>9|Invoice Target Group|ITGroup|Invoice target group ID|",
	`KeyValue`	CHAR(20) COMMENT "character|x(20)|KeyValue|KeyValue|KeyValue|",
	`MainContractID`	INT DEFAULT "0" COMMENT "integer|>>>>>>9|Parent contractid|Parent contractid|Parent contractid|",
	`Memo[1]`	CHAR(60) COMMENT "character|x(60)|Explanation|Explanation|Individual Explanation Text for the invoice|",
	`SubInvNum`	INT DEFAULT "0" COMMENT "integer|>>9|SubInvoice Number|SubInv|Sequential nbr of the subinvoice within the combined invoice|",
	`UnitPrice`	DECIMAL DEFAULT "0" COMMENT "decimal|->>>>>>9.9999|Unit Price|U.Price|Unit price|",
	`UserCust`	INT DEFAULT "0" COMMENT "integer|>>>>>>>9|User Customer|User|User customer|",
	`VATCode`	INT DEFAULT "1" COMMENT "integer|z9|VAT code|VAT code|VAT code 1 ... 10|",
	`VatIncl`	TINYINT(1) DEFAULT "1" COMMENT "logical|Included/Excluded|VAT Included|VAT|Is VAT included or excluded in prices|",
	PRIMARY KEY	(`CustNum`,`BillPeriod`,`Billed`),
	KEY	`AgrCust` (
				`AgrCust`,
				`BillPeriod`,
				`Billed`),
	KEY	`BillCode` (
				`Brand`,
				`BillCode`,
				`CustNum`),
	KEY	`CalcObj` (
				`Brand`,
				`CalcObj`),
	KEY	`Contract` (
				`Brand`,
				`Contract`,
				`BillCode`),
	KEY	`CustNum` (
				`Brand`,
				`CustNum`,
				`HostTable`,
				`KeyValue`,
				`BillPeriod`),
## The PROGRESS database primary index
	KEY	`CustNum_s` (
				`CustNum`,
				`BillPeriod`,
				`Billed`),
	KEY	`FMItemId` (
				`Brand`,
				`FMItemId`),
	KEY	`HostTable` (
				`Brand`,
				`HostTable`,
				`KeyValue`),
	KEY	`idx_MainCtr` (
				`MainContractID`),
	KEY	`InvNum_s` (
				`InvNum`),
	KEY	`ITGroupId` (
				`ITGroupID`,
				`Billed`))
	COMMENT = "Single billable fee";
DROP TABLE IF EXISTS `rbs_SOLog`;
CREATE TABLE `rbs_SOLog`(
	`ActivationTS`	DECIMAL DEFAULT "0" COMMENT "decimal|99999999.99999|Activated|Activated|Time Stamp: Intended Activation|",
	`Brand`	CHAR(8) COMMENT "character|x(8)|BrCode|BrCode|Code Of Brand|",
	`CLI`	CHAR(11) COMMENT "character|X(11)|MSISDN|MSISDN No|MSISDN Subscriber No|",
	`CommLine`	CHAR(255) COMMENT "character|x(255)|Command Line|Command Line|Service Order Command Line as sent via SOG GWY|",
	`CreatedTS`	DECIMAL DEFAULT "0" COMMENT "decimal|99999999.99999|Created|Created|Time Stamp: When Created|",
	`MsRequest`	INT DEFAULT "0" COMMENT "integer|->,>>>,>>9|Request ID|Request|Unique ID for request|",
	`MsSeq`	INT DEFAULT "0" NOT NULL COMMENT "integer|>>>>>>>9|SubSeq|SubSeq|Sequence for a Subscription|",
	`SoLog`	INT DEFAULT "0" NOT NULL COMMENT "integer|>>>>>>>9|Order Seq|Order Seq|Sequence for a Service Order|",
	`Stat`	INT DEFAULT "0" COMMENT "integer|9|Status|St|Status Code 0 ... 9|",
	`TimeSlotTMS`	DECIMAL DEFAULT "0" COMMENT "decimal|99999999.99999|ActTime|ActTime|Time Slot for activation|",
	PRIMARY KEY	(`MsSeq`,`Stat`,`ActivationTS`),
	KEY	`CLI` (
				`Brand`,
				`CLI`,
				`Stat`,
				`ActivationTS`),
	KEY	`CLI_s` (
				`CLI`,
				`Stat`,
				`ActivationTS`),
## The PROGRESS database primary index
	KEY	`MsSeq` (
				`MsSeq`,
				`Stat`,
				`ActivationTS`),
	KEY	`SoLog` (
				`Brand`,
				`SoLog`),
	KEY	`Solog_s` (
				`SoLog`),
	KEY	`Stat` (
				`Brand`,
				`Stat`,
				`ActivationTS`,
				`SoLog`),
	KEY	`TimeSlotTMS` (
				`Brand`,
				`Stat`,
				`TimeSlotTMS`,
				`SoLog`))
	COMMENT = "";
DROP TABLE IF EXISTS `rbs_SubSer`;
CREATE TABLE `rbs_SubSer`(
	`MsSeq`	INT DEFAULT "0" NOT NULL COMMENT "integer|>>>>>>>9|SubSeq|SubSeq|Sequence for a Subscription|",
	`ServCom`	CHAR(12) COMMENT "character|x(12)|Service Component|Service Component|Code of Service Component|",
	`ServPac`	CHAR(8) COMMENT "character|x(8)|ServPackage|ServPack|Code of ServPack|",
	`SSDate`	DATE COMMENT "date|99-99-99|Date|Date|Date When Activated|",
	`SSParam`	CHAR(24) COMMENT "character|x(24)|Parameter|Parameter|Service-oriented, subscriber-specific parameter|",
	`SSStat`	INT DEFAULT "0" COMMENT "integer|>>>9|Status|Status|Service Status|",
	PRIMARY KEY	(`MsSeq`,`ServCom`,`SSDate`),
## The PROGRESS database primary index
	KEY	`ServCom` (
				`MsSeq`,
				`ServCom`,
				`SSDate`),
	KEY	`ServPac` (
				`MsSeq`,
				`ServPac`,
				`ServCom`,
				`SSDate`))
	COMMENT = "Services of mobile subscribers";
DROP TABLE IF EXISTS `rbs_SubSerPara`;
CREATE TABLE `rbs_SubSerPara`(
	`MsSeq`	INT DEFAULT "0" NOT NULL COMMENT "integer|>>>>>>>9|SubSeq|SubSeq|Sequence for a Subscription|",
	`ParaName`	CHAR(25) COMMENT "character|x(25)|ParaName|ParaName|Name of the Subscription parameter name|",
	`ParaValue`	CHAR(25) COMMENT "character|x(25)|Value|Value|Value of Subscription service parameter|",
	`ServCom`	CHAR(12) COMMENT "character|x(12)|Service Component|Service Component|Code of Service Component|",
	`SSDate`	DATE COMMENT "date|99-99-99|Activation Date|Date|Date when activated|",
	PRIMARY KEY	(`MsSeq`,`ServCom`,`ParaName`,`SSDate`),
## The PROGRESS database primary index
	KEY	`MSSeq` (
				`MsSeq`,
				`ServCom`,
				`ParaName`,
				`SSDate`))
	COMMENT = "?";
DROP TABLE IF EXISTS `rbs_SubsParam`;
CREATE TABLE `rbs_SubsParam`(
	`Activated`	DATE COMMENT "date|99-99-99|activated|?|Activated|",
	`MSSeq`	INT DEFAULT "0" NOT NULL COMMENT "integer|>>>>>>>>9|SubscriptionId|SubscriptionID|SubscriptionId (msseq)|",
	`ParamName`	CHAR(16) COMMENT "character|x(16)|Name||Name of Subscription parameter|",
	`ParamValue`	CHAR(16) COMMENT "character|x(16)|Value||Value of Subscription parameter|",
	PRIMARY KEY	(`MSSeq`,`ParamName`),
## The PROGRESS database primary index
	KEY	`ParamName` (
				`MSSeq`,
				`ParamName`),
	KEY	`ParamValue` (
				`MSSeq`,
				`ParamValue`))
	COMMENT = "Subscription parameters";
DROP TABLE IF EXISTS `rbs_SubsTerminal`;
CREATE TABLE `rbs_SubsTerminal`(
	`Brand`	CHAR(8) COMMENT "character|x(8)|Brand|?|Code of brand|",
	`ContractType`	CHAR(16) COMMENT "character|x(16)|Contract Type|Contr.Type|Contract type|",
	`DeliveryType`	CHAR(16) COMMENT "character|x(16)|Delivery Type|Delivery|Delivery type|",
	`DeviceType`	CHAR(10) COMMENT "character|x(10)|Device Type|Device Type|Device Type|",
	`FeeID`	INT DEFAULT "0" COMMENT "integer|>>>>>>>9|Fee ID|Fee|Fee ID|",
	`Manufacturer`	CHAR(30) COMMENT "character|x(30)|Manufacturer|Manufacturer|Terminal manufacturer|",
	`Model`	CHAR(30) COMMENT "character|x(30)|Model|Model|Terminal model|",
	`MSSeq`	INT DEFAULT "0" COMMENT "integer|>>>>>>>9|Subscription ID|Subs.ID|Subscription ID|",
	`OrderId`	CHAR(16) COMMENT "character|x(16)|Order ID|Order|Terminal Order ID|",
	`PerContractID`	INT DEFAULT "0" COMMENT "integer|>>>>>>>>>9|Periodical Contract ID|Per.Contr.|Periodical contract ID|DCCLI",
	`ProductCode`	CHAR(16) COMMENT "character|x(16)|Product Code|Product|Product code|",
	`PurchaseTS`	DECIMAL DEFAULT "0" COMMENT "decimal|99999999.99999|Purchased|?|Time of purchase|",
	`SerialNumber`	CHAR(16) COMMENT "character|x(16)|Serial Number|Serial Number|Serial Number|",
	`SerialNumType`	CHAR(10) COMMENT "character|x(10)|SNo. Type|SNo. Type|Serial Number Type|",
	`SIMChecked`	TINYINT(1) DEFAULT "0" COMMENT "logical|Yes/No|SIM Checked|SIMCheck|SIM checked|",
	`TerminalID`	INT DEFAULT "0" COMMENT "integer|>>>>>>>>>9|Terminal ID|Term.ID|Terminal ID|unique sequence nbr",
	PRIMARY KEY	(`TerminalID`),
	KEY	`FeeID` (
				`FeeID`),
	KEY	`MsSeq` (
				`MSSeq`,
				`PurchaseTS`),
	KEY	`PerContractID` (
				`PerContractID`),
## The PROGRESS database primary index
	KEY	`TerminalID` (
				`TerminalID`))
	COMMENT = "Terminal of a subscription";
DROP TABLE IF EXISTS `rbs_SubventionRate`;
CREATE TABLE `rbs_SubventionRate`(
	`BillCode`	CHAR(16) COMMENT "character|x(16)|Billing Item|Bill.Item|Billing item for invoice rows|",
	`RateType`	CHAR(8) COMMENT "character|x(8)|Rate Type|?|Rate type|",
	`SalesChannel`	CHAR(16) COMMENT "character|x(16)|Sales Channel|?|Sales channel|",
	`SubvGroup`	CHAR(16) COMMENT "character|x(16)|Subvention Group|Subv.Group|Subvention group|",
	`SubvRate`	DECIMAL DEFAULT "0" COMMENT "decimal|->>>>>>9.99|Rate|?|Subvention rate|",
	`SubvRateID`	INT DEFAULT "0" COMMENT "integer|>>>>>>>9|Rate ID|?|Subvention rate ID|",
	`SubvRuleID`	INT DEFAULT "0" COMMENT "integer|>>>>>>>9|Rule ID|Rule|Subvention rule ID|",
	`SubvTarget`	CHAR(16) COMMENT "character|x(16)|Subvention Target|Target|Subvention target|",
	`ValidFrom`	DATE COMMENT "date|99-99-9999|Valid From|From|Effective from date|",
	`ValidTo`	DATE COMMENT "date|99-99-9999|Valid To|To|Effective to date|",
	`VATIncl`	TINYINT(1) DEFAULT "1" COMMENT "logical|Incl/Excl|Tax Included|Tax|Is tax Included/Excluded in amounts|",
	PRIMARY KEY	(`SubvRuleID`,`SalesChannel`,`SubvTarget`,`SubvGroup`,`ValidTo`),
	KEY	`SubvRateID` (
				`SubvRateID`),
## The PROGRESS database primary index
	KEY	`SubvRuleID` (
				`SubvRuleID`,
				`SalesChannel`,
				`SubvTarget`,
				`SubvGroup`,
				`ValidTo`))
	COMMENT = "Subvention rate";
DROP TABLE IF EXISTS `rbs_SubventionRule`;
CREATE TABLE `rbs_SubventionRule`(
	`DeliveryType`	CHAR(16) COMMENT "character|x(16)|Delivery Type|Delivery|Delivery type|",
	`SRName`	CHAR(30) COMMENT "character|x(30)|Name|?|Rule name|",
	`SubvClass`	CHAR(8) COMMENT "character|x(8)|Class|?|Subvention class|",
	`SubvRuleID`	INT DEFAULT "0" COMMENT "integer|>>>>>>>9|Rule ID|Rule|Subvention rule ID|",
	`SubvType`	CHAR(16) COMMENT "character|x(16)|Type|?|Subvention type|",
	`ValidFrom`	DATE COMMENT "date|99-99-9999|Valid From|From|Effective from date|",
	`ValidTo`	DATE COMMENT "date|99-99-9999|Valid To|To|Effective to date|",
	PRIMARY KEY	(`SubvRuleID`),
	KEY	`SubvClass` (
				`SubvClass`,
				`ValidTo`),
## The PROGRESS database primary index
	KEY	`SubvRuleID` (
				`SubvRuleID`),
	KEY	`SubvType` (
				`SubvType`,
				`ValidTo`))
	COMMENT = "Subvention rule";
DROP TABLE IF EXISTS `rbs_TaxClass`;
CREATE TABLE `rbs_TaxClass`(
	`TaxClass`	CHAR(8) COMMENT "character|x(8)|Tax Class|Class|Tax class|",
	`TCName`	CHAR(30) COMMENT "character|x(30)|Class Name|Name|Tax class name|",
	PRIMARY KEY	(`TaxClass`),
## The PROGRESS database primary index
	KEY	`TaxClass` (
				`TaxClass`))
	COMMENT = "Tax classes";
DROP TABLE IF EXISTS `rbs_TaxZone`;
CREATE TABLE `rbs_TaxZone`(
	`TaxZone`	CHAR(8) COMMENT "character|x(8)|Tax Zone|Zone|Tax Zone|",
	`TZName`	CHAR(30) COMMENT "character|x(30)|Zone Name|Name|Tax zone name|",
	PRIMARY KEY	(`TaxZone`),
## The PROGRESS database primary index
	KEY	`TaxZone` (
				`TaxZone`))
	COMMENT = "Tax zones";
DROP TABLE IF EXISTS `rbs_TermMobSub`;
CREATE TABLE `rbs_TermMobSub`(
	`ActivationDate`	DATE COMMENT "date|99-99-99|Activation Date|Activation|Date when subscription is to be activated in HLR|",
	`ActivationTS`	DECIMAL DEFAULT "0" COMMENT "decimal|999999.99999|Activated|?|Time when subscription was activated in TMS (HLR response OK)|",
	`AgrCust`	INT DEFAULT "0" NOT NULL COMMENT "integer|>>>>>>>>9|Agr.Customer|AgrCust|Agreement customer's number|",
	`BillTarget`	INT DEFAULT "0" COMMENT "integer|>9|Bill.Target|BT|Customer's billing target|",
	`Brand`	CHAR(8) COMMENT "character|x(8)|BrCode|BrCode|Code Of Brand|",
	`CLI`	CHAR(11) COMMENT "character|X(11)|MSISDN|MSISDN No|MSISDN Subscriber No|",
	`CliType`	CHAR(8) COMMENT "character|x(8)|MType|Mtype|Type Of TermMobSub|",
	`CMCreatedTS`	DECIMAL DEFAULT "0" COMMENT "decimal|99999999.99999|CM creation time|CM creation time|Time when contract was created in CM|",
	`Contract`	TINYINT(1) DEFAULT "0" COMMENT "logical|Yes/No|ContSign|ContSign|Contract signed|",
	`CreationDate`	DATE COMMENT "date|99-99-99|Created|?|Date when subscription was created (from order)|",
	`CustNum`	INT DEFAULT "0" NOT NULL COMMENT "integer|>>>>>>>>9|Customer|Customer|Customer's number|",
	`DeliveryType`	CHAR(16) COMMENT "character|x(16)|Delivery Type|Delivery|Delivery type|",
	`ExperimentDate`	DATE COMMENT "date|99-99-99|Experiment Date|Experiment|Date when experiment period expires|",
	`IMSI`	CHAR(18) COMMENT "character|x(18)|IMSI Number|IMSI Number|IMSI Number|",
	`InvCust`	INT DEFAULT "0" NOT NULL COMMENT "integer|>>>>>>>>9|Inv.Customer|InvCust|Invoicing customer's number|",
	`MainContractID`	INT DEFAULT "0" COMMENT "integer|>>>>>>9|Parent contractid|Parent contractid|Parent contractid|",
	`MNPChannel`	INT DEFAULT "0" COMMENT "integer|>9|MNP Channel|MNPChannel|MNP Channel|",
	`MsSeq`	INT DEFAULT "0" NOT NULL COMMENT "integer|>>>>>>>9|SubSeq|SubSeq|Sequence for a Subscription|",
	`MsStatus`	INT DEFAULT "1" COMMENT "integer|9|Status|Status|Status Code, 1 ... 9|",
	`OrderId`	CHAR(16) COMMENT "character|x(16)|Order Id|Order Id|Order Id of the mobile subscription|",
	`PayType`	TINYINT(1) DEFAULT "0" COMMENT "logical|PrePaid/PostPaid|PayType|PayType|PayType|",
	`Reseller`	CHAR(8) COMMENT "character|x(8)|Reseller|Reseller|An unique code for a reseller|",
	`Salesman`	CHAR(8) COMMENT "character|x(8)|Salesman|Salesman|Salesman's code|",
	PRIMARY KEY	(`MsSeq`),
	KEY	`AgrCust` (
				`Brand`,
				`AgrCust`,
				`CLI`),
	KEY	`CLI` (
				`Brand`,
				`CLI`),
	KEY	`CLIType` (
				`Brand`,
				`CliType`,
				`CLI`),
	KEY	`CLI_u` (
				`CLI`),
	KEY	`CustNum` (
				`Brand`,
				`CustNum`,
				`BillTarget`,
				`CLI`),
	KEY	`CustNum_u` (
				`CustNum`,
				`BillTarget`,
				`CLI`),
	KEY	`idx_MainCtr` (
				`MainContractID`),
	KEY	`IMSI` (
				`Brand`,
				`IMSI`),
	KEY	`InvCust` (
				`Brand`,
				`InvCust`,
				`CLI`),
	KEY	`MNPChannel` (
				`Brand`,
				`MNPChannel`,
				`MsStatus`),
## The PROGRESS database primary index
	KEY	`MsSeq` (
				`MsSeq`),
	KEY	`MsStatus` (
				`Brand`,
				`MsStatus`,
				`ActivationDate`),
	KEY	`MsStatus_u` (
				`MsStatus`,
				`ActivationDate`))
	COMMENT = "Mobile Subscription";
DROP TABLE IF EXISTS `rbs_TMRItemValue`;
CREATE TABLE `rbs_TMRItemValue`(
	`CounterItemValues`	CHAR(40) COMMENT "character|x(40)|Item Values|Values|List of item values used to collect the counter|",
	`FromDate`	DATE COMMENT "date|99-99-99|From|?|Date when rule becomes effective|",
	`TMRuleSeq`	INT DEFAULT "0" COMMENT "integer|>>>>>>>>9|Rule Sequence|Seq|Rule ID|",
	`ToDate`	DATE COMMENT "date|99-99-99|To|?|Date when rule expires|",
	PRIMARY KEY	(`TMRuleSeq`,`CounterItemValues`,`ToDate`),
## The PROGRESS database primary index
	KEY	`CounterItemValues` (
				`TMRuleSeq`,
				`CounterItemValues`,
				`ToDate`),
	KEY	`ToDate` (
				`TMRuleSeq`,
				`ToDate`))
	COMMENT = "TM rule item values";
DROP TABLE IF EXISTS `rbs_TMRLimit`;
CREATE TABLE `rbs_TMRLimit`(
	`Action`	INT DEFAULT "0" COMMENT "integer|>>9|Action|?|Action to be taken when limit is exceeded|",
	`ActionParam`	CHAR(30) COMMENT "character|x(30)|Action Parameters|Parameters|Parameters for the chosen action|",
	`FromDate`	DATE COMMENT "date|99-99-99|From|?|Date when rule becomes effective|",
	`LimitAmt`	DECIMAL DEFAULT "0" COMMENT "decimal|->>>>>>9.99|Limit Amount|Amount|Limit amount|",
	`LimitID`	INT DEFAULT "0" COMMENT "integer|>>9|Limit ID|ID|Limit ID|",
	`LimitPerc`	DECIMAL DEFAULT "0" COMMENT "decimal|>>9.99|Limit Percent|Percent|Limit percent|",
	`SMSText`	CHAR(12) COMMENT "character|x(12)|SMS Text|SMS|SMS text that is sent when limit is exceeded|",
	`TMRuleSeq`	INT DEFAULT "0" COMMENT "integer|>>>>>>>>9|Rule Sequence|Seq|Rule ID|",
	`ToDate`	DATE COMMENT "date|99-99-99|To|?|Date when rule expires|",
	`ValueType`	INT DEFAULT "0" COMMENT "integer|>9|Value Type|Type|Type of limit value|",
	PRIMARY KEY	(`TMRuleSeq`,`LimitID`,`ToDate`),
## The PROGRESS database primary index
	KEY	`LimitID` (
				`TMRuleSeq`,
				`LimitID`,
				`ToDate`),
	KEY	`ToDate` (
				`TMRuleSeq`,
				`ToDate`,
				`LimitID`))
	COMMENT = "TM rule limit";
DROP TABLE IF EXISTS `rbs_TMRule`;
CREATE TABLE `rbs_TMRule`(
	`Brand`	CHAR(8) COMMENT "character|x(8)|Brand|?|Code Of Brand|",
	`CounterAmount`	CHAR(15) COMMENT "character|x(15)|Counter Amount|Amount|Amount that is collected to counter|",
	`CounterItems`	CHAR(40) COMMENT "character|x(40)|Counter Items|Items|Items that are used in counter collection|",
	`CounterPeriod`	INT DEFAULT "0" COMMENT "integer|>9|Counter Period|Period|Period of counter|",
	`CounterType`	INT DEFAULT "0" COMMENT "integer|>9|Counter Type|Type|Type of counter|",
	`FromDate`	DATE COMMENT "date|99-99-99|From|?|Date when rule becomes effective|",
	`LimitCompare`	INT DEFAULT "1" COMMENT "integer|9|Limit Comparison|Compare|Limit comparison method|",
	`LimitSource`	INT DEFAULT "1" COMMENT "integer|>9|Limit Source|LimitSrc|Which limit is used in analysis|",
	`Name`	CHAR(40) COMMENT "character|x(40)|Name|?|Name|",
	`NewCustomer`	TINYINT(1) DEFAULT "1" COMMENT "logical|yes/no|New Customers|New Cust|Copy rule automatically to new customers|",
	`PayType`	INT DEFAULT "0" COMMENT "integer|9|Payment Type|PayType|Payment type|",
	`TicketType`	INT DEFAULT "0" COMMENT "integer|>9|Ticket Type|TicketType|Type of tickets/cdrs|",
	`TMRuleSeq`	INT DEFAULT "0" COMMENT "integer|>>>>>>>>9|Rule Sequence|Seq|Rule ID|",
	`ToDate`	DATE COMMENT "date|99-99-99|To|?|Date when rule expires|",
	PRIMARY KEY	(`TMRuleSeq`),
	KEY	`CounterType` (
				`Brand`,
				`CounterType`,
				`TMRuleSeq`),
	KEY	`Name` (
				`Brand`,
				`Name`),
## The PROGRESS database primary index
	KEY	`TMRuleSeq` (
				`TMRuleSeq`),
	KEY	`ToDate` (
				`Brand`,
				`ToDate`))
	COMMENT = "Ticket management rule";
DROP TABLE IF EXISTS `rbs_UnregPaym`;
CREATE TABLE `rbs_UnregPaym`(
	`AccDate`	DATE COMMENT "date|99.99.9999|Book day|Book day|Bookkeeping day|",
	`ArchiveId`	CHAR(16) COMMENT "character|x(16)|Arch.ID|Arch.ID|Archive ID|",
	`BankAcc`	CHAR(20) COMMENT "character|x(20)|Bank Acc.|Bank Acc.|Bank account number|",
	`Brand`	CHAR(8) COMMENT "character|x(8)|Brand|Brand|Code Of Brand|",
	`CustName`	CHAR(12) COMMENT "character|x(12)|Cust.name|Cust.name|Customer name|",
	`InvNum`	CHAR(8) DEFAULT "0" COMMENT "character|x(8)|Inv.Num.|Inv.Num.|Invoice's number|",
	`PaidAmt`	DECIMAL DEFAULT "0" COMMENT "decimal|->>,>>9.99|Payment|Payment|Payment|",
	`PaymDate`	DATE COMMENT "date|99.99.9999|Payment day|Payment day|Date of invoice payment|",
	`PaymSrc`	CHAR(8) COMMENT "character|x(8)|Payment source|Source|Source of payment|empty=manual, dd=direct debit, rf=reference file, ca=collection agency",
	`RefNum`	CHAR(20) COMMENT "character|x(20)|Ref.Num.|Ref.Num.|Reference Number|",
	`State`	INT DEFAULT "0" COMMENT "integer|9|State|State|0 - not processed, 1 - deleted|",
	`UrSeq`	INT DEFAULT "0" COMMENT "integer|->,>>>,>>9|?|?|Sequence|",
	PRIMARY KEY	(`Brand`,`ArchiveId`),
## The PROGRESS database primary index
	KEY	`archiveID` (
				`Brand`,
				`ArchiveId`),
	KEY	`bankacc` (
				`Brand`,
				`State`,
				`BankAcc`,
				`PaymDate`),
	KEY	`custname` (
				`Brand`,
				`State`,
				`CustName`),
	KEY	`PaidAmt` (
				`Brand`,
				`State`,
				`PaidAmt`),
	KEY	`PaymDate` (
				`Brand`,
				`State`,
				`PaymDate`),
	KEY	`RefNum` (
				`Brand`,
				`State`,
				`RefNum`),
	KEY	`Urseq` (
				`UrSeq`))
	COMMENT = "Unregistered payments";
DROP TABLE IF EXISTS `rbs_VATCode`;
CREATE TABLE `rbs_VATCode`(
	`AccNum`	INT DEFAULT "0" COMMENT "integer|>>>>>9|Number|Number|Account number|",
	`FromDate`	DATE COMMENT "date|99-99-99|Valid From|From|Date when VAT becomes effective|",
	`TaxClass`	CHAR(8) COMMENT "character|x(8)|Tax Class|Class|Tax class|",
	`TaxZone`	CHAR(8) COMMENT "character|x(8)|Tax Zone|Zone|Tax Zone|",
	`ToDate`	DATE COMMENT "date|99-99-99|Valid To|To|Date when VAT expires|",
	`VATCode`	INT DEFAULT "0" COMMENT "integer|z9|VAT code|VAT code|VAT code|",
	`VATPerc`	DECIMAL DEFAULT "0" COMMENT "decimal|z9.99|%|%|Amount of VAT (%)|",
	`VCName`	CHAR(40) COMMENT "character|x(40)|Explanation|Explanation|Explanation for this VAT code|",
	PRIMARY KEY	(`VATCode`),
	KEY	`TaxClass` (
				`TaxClass`,
				`TaxZone`,
				`ToDate`),
	KEY	`TaxZone` (
				`TaxZone`,
				`TaxClass`,
				`ToDate`),
## The PROGRESS database primary index
	KEY	`VatCode` (
				`VATCode`),
	KEY	`VatPerc` (
				`VATPerc`,
				`VATCode`,
				`ToDate`))
	COMMENT = "VAT Code";
