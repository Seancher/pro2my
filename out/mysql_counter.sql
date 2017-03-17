drop database if exists rbsall;
create database rbsall;
use rbsall;
DROP TABLE IF EXISTS `counter_DCCounter`;
CREATE TABLE `counter_DCCounter`(
	`Amount`	DECIMAL DEFAULT "0" COMMENT "decimal|>>9.99999|Amount|Amount|Used amount|",
	`BillCode`	CHAR(16) COMMENT "character|x(16)|Billing Item|BillCode|Billing item code|",
	`CalcMethod`	INT DEFAULT "0" COMMENT "integer|9|Calculation Method|Method|Calculation method|",
	`CCN`	INT DEFAULT "0" COMMENT "integer|>>>9|CCN|?|Report CCN that is marked to CDRs|",
	`DCDate`	DATE COMMENT "date|99-99-9999|Date|Date|Day of the daily campaign|",
	`DCEvent`	CHAR(12) COMMENT "character|x(12)|Periodical Term|Term|ID of periodical term|",
	`DCTarget`	CHAR(12) COMMENT "character|x(12)|Target|Target|Target (allowed billing item)|",
	`DCType`	CHAR(8) COMMENT "character|x(8)|Campaign Type|Type|Campaign type|",
	`InclUnit`	INT DEFAULT "0" COMMENT "integer|>9|Included Unit|Incl.Unit|Unit of included material|",
	`MaxCharge`	DECIMAL DEFAULT "0" COMMENT "decimal|->>,>>9.999|Max. Charge|MaxCharge|Max. charge|",
	`MSSeq`	INT DEFAULT "0" NOT NULL COMMENT "integer|>>>>>>>9|Subscription ID|Sub.ID|Sequence for a subscription|",
	PRIMARY KEY	(`MSSeq`,`DCDate`,`DCTarget`),
	KEY	`DCEvent` (
				`DCEvent`,
				`DCDate`),
## The PROGRESS database primary index
	KEY	`MSSeq` (
				`MSSeq`,
				`DCDate`,
				`DCTarget`))
	COMMENT = "?";
DROP TABLE IF EXISTS `counter_InvRowCounter`;
CREATE TABLE `counter_InvRowCounter`(
	`Amount`	DECIMAL DEFAULT "0" COMMENT "decimal|->>>>>>>9.99|Amount|Amt|Amount|",
	`BillCode`	CHAR(16) COMMENT "character|x(16)|Billing Item|Bill.Item|Billing item ID|",
	`CCN`	INT DEFAULT "0" COMMENT "integer|>>>>9|Report CCN|CCN|Reporting CCN|",
	`CLI`	CHAR(12) COMMENT "character|x(12)|MSISDN|?|MSISDN|",
	`DataAmt`	DECIMAL DEFAULT "0" COMMENT "decimal|->>>>>>>>>>>9.99|Data Amount|Data|Data amount|",
	`DCEvent`	CHAR(16) COMMENT "character|x(16)|Service Package ID|Service|Service package ID|",
	`Duration`	INT DEFAULT "0" COMMENT "integer|>>>>>>>>9|Duration|?|Duration|",
	`ExtraAmount`	DECIMAL DEFAULT "0" COMMENT "decimal|->>>>>>>9.99|Extra Amount|Extra|Extra amount|",
	`FromDate`	DATE COMMENT "date|99-99-99|Events From|From|Beginning of event period|",
	`InvCust`	INT DEFAULT "0" COMMENT "integer|>>>>>>>9|Invoice Customer|Inv.Cust|Invoice customer|",
	`InvNum`	INT DEFAULT "0" COMMENT "integer|>>>>>>>9|Invoice Number|Invoice|Invoice number (internal)|",
	`InvSeq`	INT DEFAULT "0" COMMENT "integer|>>>>>>>>9|EDR Sequence|EDR Seq.|EDR sequence|",
	`MPMAmt`	DECIMAL DEFAULT "0" COMMENT "decimal|>>>>>9.999|MPM Amount|MPM|MPM amount|",
	`MsSeq`	INT DEFAULT "0" COMMENT "integer|>>>>>>>>9|Subscription ID|Subscr.ID|Subscription ID|",
	`Pulses`	INT DEFAULT "0" COMMENT "integer|>>>>>9|Pulses|Pulses|Pulses|",
	`Quantity`	INT DEFAULT "0" COMMENT "integer|->>>>>>>>9|Quantity|Qty|Quantity|",
	`RefPrice`	DECIMAL DEFAULT "0" COMMENT "decimal|->>>>>>>>9.99|Reference Price|Ref.Price|Reference price amount|",
	`StartCharge`	DECIMAL DEFAULT "0" COMMENT "decimal|>>9.999|Starting Fee|St.Fee|Starting fee|",
	`SubInvNum`	INT DEFAULT "0" COMMENT "integer|>>9|SubInvoice Number|SubInv|Sequential nbr of the subinvoice within the combined invoice|",
	`TariffNum`	INT DEFAULT "0" COMMENT "integer|>>>>>>>>9|Tariff ID|Tariff|Tariff ID|",
	`TariffZone`	CHAR(2) COMMENT "character|x(2)|Tariff Zone|TZ|Tariff zone|",
	`ToDate`	DATE COMMENT "date|99-99-99|Events To|To|Events to date|",
	`VATIncl`	TINYINT(1) DEFAULT "0" COMMENT "logical|Incl/Excl|Tax Included|Tax|Is tax Included/Excluded in amounts|",
	PRIMARY KEY	(`InvCust`,`InvSeq`,`BillCode`,`CCN`,`ToDate`),
	KEY	`BillCode` (
				`BillCode`,
				`ToDate`),
## The PROGRESS database primary index
	KEY	`InvCust` (
				`InvCust`,
				`InvSeq`,
				`BillCode`,
				`CCN`,
				`ToDate`),
	KEY	`InvNum` (
				`InvNum`,
				`SubInvNum`),
	KEY	`MsSeq` (
				`MsSeq`,
				`ToDate`))
	COMMENT = "Invoice row counter";
DROP TABLE IF EXISTS `counter_MServiceLimit`;
CREATE TABLE `counter_MServiceLimit`(
	`CustNum`	INT DEFAULT "0" COMMENT "integer|>>>>>>>>9|Customer|Customer|Customer number|",
	`DialType`	INT DEFAULT "0" COMMENT "integer|>>9|Dialling Type|DT|Dialling type code|",
	`EndTS`	DECIMAL DEFAULT "0" COMMENT "decimal|99999999.99999|EndTS|EndTS|End TimeStamp|",
	`ForeignKey`	DECIMAL DEFAULT "0" COMMENT "decimal|999999999999|?|ForeignKey|Bix|Bix",
	`FromTS`	DECIMAL DEFAULT "0" COMMENT "decimal|99999999.99999|ValidFromTS|ValidFromTS|Valid From TimeStamp|",
	`InclAmt`	DECIMAL DEFAULT "0" COMMENT "decimal|->>>>>9.99|Included Amount|Incl.Amt|Amount of billable material that is included in this fee|",
	`InclUnit`	INT DEFAULT "0" COMMENT "integer|>9|Included Unit|Incl.Unit|Unit of included material|",
	`MsSeq`	INT DEFAULT "0" COMMENT "integer|->,>>>,>>9|Mobsub|Msub|Link to mobsub-table|",
	`SLSeq`	INT DEFAULT "0" COMMENT "integer|>>>>>>9|SLSeq|SLseq|Sequence for Servicelimit|",
	PRIMARY KEY	(`MsSeq`,`DialType`,`SLSeq`,`EndTS`),
	KEY	`Active` (
				`MsSeq`,
				`DialType`,
				`FromTS`,
				`EndTS`),
	KEY	`CSlSeq` (
				`CustNum`,
				`SLSeq`),
	KEY	`CustNum` (
				`CustNum`,
				`DialType`,
				`EndTS`),
	KEY	`ForeignKey` (
				`ForeignKey`),
## The PROGRESS database primary index
	KEY	`msseq` (
				`MsSeq`,
				`DialType`,
				`SLSeq`,
				`EndTS`),
	KEY	`slseq` (
				`SLSeq`,
				`DialType`))
	COMMENT = "?";
DROP TABLE IF EXISTS `counter_ServiceLCounter`;
CREATE TABLE `counter_ServiceLCounter`(
	`Amt`	DECIMAL DEFAULT "0" COMMENT "decimal|>>>>>>>>>>>>9.999|?|?||",
	`CustNum`	INT DEFAULT "0" COMMENT "integer|>>>>>>>>9|CustNum|?|Customer number|",
	`invseq`	INT DEFAULT "0" COMMENT "integer|>>>>>>>>>>9|?|?||",
	`MsSeq`	INT DEFAULT "0" COMMENT "integer|->,>>>,>>9|Mobsub|Msub|Link to mobsub-table|",
	`Period`	INT DEFAULT "0" COMMENT "integer|999999|Period|?|Period what Servicecounter is to be|",
	`SLSeq`	INT DEFAULT "0" COMMENT "integer|>>>>>>9|SLSeq|SLseq|Sequence for Servicelimit|",
	PRIMARY KEY	(`MsSeq`,`Period`,`SLSeq`),
	KEY	`CustNum` (
				`CustNum`,
				`Period`,
				`SLSeq`),
## The PROGRESS database primary index
	KEY	`MSSeq` (
				`MsSeq`,
				`Period`,
				`SLSeq`))
	COMMENT = "?";
DROP TABLE IF EXISTS `counter_TMCounter`;
CREATE TABLE `counter_TMCounter`(
	`Amount`	DECIMAL DEFAULT "0" COMMENT "decimal|->>>>>>9.99999|Amount|Amt|Amount|",
	`CustNum`	INT DEFAULT "0" NOT NULL COMMENT "integer|>>>>>>>9|Customer|Cust|Customer number|",
	`FromDate`	DATE COMMENT "date|99-99-99|From|?|Date when rule becomes effective|",
	`LimitID`	INT DEFAULT "0" COMMENT "integer|>>9|Limit ID|ID|Limit that has been exceeded|",
	`MsSeq`	INT DEFAULT "0" COMMENT "integer|>>>>>>>>9|Subscription ID|MobSub|Mobile subscription ID|",
	`Qty`	INT DEFAULT "0" COMMENT "integer|>>>>>>>9|?|Qty|Quantity|",
	`TMRuleSeq`	INT DEFAULT "0" COMMENT "integer|>>>>>>>>9|Rule Sequence|Seq|Rule ID|",
	`ToDate`	DATE COMMENT "date|99-99-99|To|?|Date when rule expires|",
	PRIMARY KEY	(`MsSeq`,`TMRuleSeq`,`ToDate`),
	KEY	`CustNum` (
				`CustNum`,
				`TMRuleSeq`,
				`ToDate`),
## The PROGRESS database primary index
	KEY	`MsSeq` (
				`MsSeq`,
				`TMRuleSeq`,
				`ToDate`),
	KEY	`TMRuleSeq` (
				`TMRuleSeq`,
				`MsSeq`,
				`ToDate`))
	COMMENT = "TM counter";
