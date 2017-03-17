drop database if exists rbsall;
create database rbsall;
use rbsall;
DROP TABLE IF EXISTS `mcdr_MobCDR`;
CREATE TABLE `mcdr_MobCDR`(
	`AddBPref`	CHAR(8) COMMENT "character|x(8)|AddBPref|AddBPref||",
	`Amount`	DECIMAL DEFAULT "0" COMMENT "decimal|zzz,zz9.99|NetPrice|NetPrice|Net (billed) Price of Call|",
	`AType`	INT DEFAULT "0" COMMENT "integer|>9|AType|AType|A-Type|",
	`BDest`	CHAR(12) COMMENT "character|x(12)|Destin|Destin|Call's destination, recognised from B-sub. number|",
	`BillCode`	CHAR(16) COMMENT "character|x(16)|ProdCode|ProdCode|Product code, (call is billed with this product code)|",
	`BillDur`	INT DEFAULT "0" COMMENT "integer|zzzzz9|BillDur|BillDur|Billable Duration of call, seconds|",
	`BillTarget`	INT DEFAULT "0" COMMENT "integer|z9|No|No|Consecutive No. for Customer's Invoicing Target|",
	`BNET`	CHAR(5) COMMENT "character|x(5)|Bnet|Bnet|Mobile Operator/Service Provider|",
	`BPref`	CHAR(5) COMMENT "character|x(5)|BPref|BPref|B-Prefix|",
	`BType`	INT DEFAULT "0" COMMENT "integer|>9|BType|BType|B-Type|",
	`CaseType`	CHAR(2) COMMENT "character|x(2)|CaseType|CT|CaseType|",
	`Ccharge`	DECIMAL DEFAULT "0" COMMENT "decimal|>>,>>9.999|CCharge|CCharge|Call Charge|",
	`CCN`	INT DEFAULT "0" NOT NULL COMMENT "integer|zz9|CCN|CCN|Consecutive country/service number of call's  destination|",
	`Charge`	DECIMAL DEFAULT "0" COMMENT "decimal|>>>,>>9.999|Charge|Charge|Charge|",
	`CLI`	CHAR(18) COMMENT "character|x(18)|GSMANR|GSMANR|Calling Party Number|",
	`CLIType`	CHAR(12) COMMENT "character|x(12)|CLIType|CLIType|Code of Subscription Type|",
	`Currency`	CHAR(4) COMMENT "character|x(4)|CUR|CUR||",
	`CurrUnit`	TINYINT(1) COMMENT "logical|Full/Sub|CurrUnit|CurrUnit|Currency FULL (1) or SUB (1/100)|",
	`CustNum`	INT DEFAULT "0" COMMENT "integer|zzzzzz9|CustNum|CustNum|Customer No .|",
	`DataIn`	DECIMAL DEFAULT "0" COMMENT "decimal|>>>>>>>>>9|DataIn|DataIn|Data Amount Incoming|",
	`DataOut`	DECIMAL DEFAULT "0" COMMENT "decimal|>>>>>>>>>9|DataOut|DataOut|Data Amount Outgoing|",
	`DateSt`	DATE COMMENT "date|99.99.99|CallDate|CallDate|Date When call started|",
	`DCEvent`	CHAR(12) COMMENT "character|x(12)|Periodical Contract|P.Contract|Periodical contract|",
	`DCType`	CHAR(8) COMMENT "character|x(8)|Contract Type|CType|Contract type|",
	`DialType`	INT DEFAULT "0" COMMENT "integer|>>9|Dialling Type|DialType|Dialling Type|",
	`DtlSeq`	INT DEFAULT "0" COMMENT "integer|>>>>>>9|?|?||",
	`ErrorCode`	INT DEFAULT "0" COMMENT "integer|zzz9|ErrC|ErrC|Rating Error Code 1 ... 9999|",
	`EventSubType`	CHAR(8) COMMENT "character|x(8)|EventSubType|EventSubType||",
	`EventType`	CHAR(8) COMMENT "character|x(8)|?|?||",
	`GrossAmt`	DECIMAL DEFAULT "0" COMMENT "decimal|>>,>>9.999|GrossAmt|GrossAmt|GrossAmoun|",
	`GsmBnr`	CHAR(18) COMMENT "character|x(18)|GSMBNR|GSMBNR|Called Party Number (with country code or 0: Sweden)|",
	`IMEI`	CHAR(15) COMMENT "character|x(15)|x(15)|IMEI||",
	`IMEI2`	CHAR(15) COMMENT "character|x(15)|IMEI2|IMEI2||",
	`IMSI`	CHAR(15) COMMENT "character|x(15)|IMSI|IMSI|IMSI|",
	`IMSI2`	CHAR(15) COMMENT "character|x(15)|IMSI2|IMSI2||",
	`InvCust`	INT DEFAULT "0" COMMENT "integer|zzzzzz9|CustInv|CustInv|Customer who is being invoiced|",
	`InvSeq`	INT DEFAULT "0" COMMENT "integer|>>>>>>>>>>9|?|?|Invoice sequence|",
	`MPMAmt`	DECIMAL DEFAULT "0" COMMENT "decimal|zzz,zz9.999|MPM Amount|MPM|MPM Amount|",
	`MSCID`	CHAR(4) COMMENT "character|x(4)|MSCID|MSCID||",
	`MsSeq`	INT DEFAULT "0" NOT NULL COMMENT "integer|>>>>>>>9|SubSeq|SubSeq|Sequence for a Subscription|Id of a mobsub record. Note that mobsub can have been deleted",
	`OrigRecordType`	INT COMMENT "integer|>9|OrigRecordType|OrigRecordType|Original Record Type|",
	`Pulses`	INT DEFAULT "0" COMMENT "integer|>>>>>9|Pulses|Pulses|Pulses|",
	`RateCCN`	INT DEFAULT "0" COMMENT "integer|>>9|RateCCN|RateCCN|Rating CCN|",
	`RatingPulses`	INT DEFAULT "0" COMMENT "integer|>>>>>9|Rating Pulses|Rating Pulses|Rating Pulses|",
	`ReadDate`	DATE COMMENT "date|99-99-99|Read In Date|Read|Read in date|",
	`ReadinTS`	DECIMAL DEFAULT "0" COMMENT "decimal|99999999.99999|ReadinTS|ReadinTS||",
	`RefPrice`	DECIMAL DEFAULT "0" COMMENT "decimal|zzz,zz9.99|RefPrice|RefPrice|Reference Price (gen. rate without any discounts)|",
	`RerateID`	INT DEFAULT "0" COMMENT "integer|>>>>>>>>9|RerateID|RerateID||Rerating run ID",
	`RerateTS`	DECIMAL DEFAULT "0" COMMENT "decimal|99999999.99999|RerateTS|RerateTS||Date and time when rerating was done",
	`RoamingInd`	INT DEFAULT "0" COMMENT "integer|9|RoamingIND|RoamingInd||",
	`RoutingNumber`	CHAR(15) COMMENT "character|x(15)|RoutingNumber|RoutingNumber|Routing Number|",
	`ServiceAddress`	CHAR(15) COMMENT "character|x(15)|ServiceAddress|ServiceAddress|Service Address|",
	`ServiceName`	CHAR(20) COMMENT "character|x(20)|ServiceName|ServiceName|Service Name|",
	`SPOcmt`	INT DEFAULT "0" COMMENT "integer|>9|Scmt|Scmt|SPO Call Module type|",
	`StartCharge`	DECIMAL DEFAULT "0" COMMENT "decimal|zz9.999|StFee|StFee|Start Fee|",
	`SubsType`	CHAR(1) COMMENT "character|x(1)|SubsType|SubsType|Subscription type|",
	`tariffClass`	CHAR(2) COMMENT "character|x(2)|TaC|Tac|Tariff Class|",
	`TariffNum`	INT DEFAULT "0" COMMENT "integer|>>>>>>>>>9|rateid|rateid|ID of rate  record being used|ID of nnhinta record",
	`TariffZone`	CHAR(2) COMMENT "character|x(2)|TariffZone|TariffZone|TariffZone|",
	`TaxClass`	CHAR(5) COMMENT "character|X(5)|TaxClass|TaxClass|TaxClass Code|",
	`TaxRate`	INT DEFAULT "0" COMMENT "integer|>>>9|TaxRate|TaxRate|TaxRate|",
	`TimeStart`	INT DEFAULT "0" COMMENT "integer|zzzzz9|TimeSt|TimeSt|Time when call  started (in terms of seconds from midnight)|",
	`VatIncl`	TINYINT(1) DEFAULT "0" COMMENT "logical|Yes/No|VAT Included|VAT|Is VAT included in call's price|",
	`xSub`	CHAR(12) COMMENT "character|x(12)|Xsub|Xsub||",
	PRIMARY KEY	(`DateSt`,`TimeStart`),
	KEY	`CLI` (
				`CLI`,
				`DateSt`,
				`TimeStart`),
	KEY	`CustNum` (
				`CustNum`,
				`DateSt`,
				`TimeStart`),
## The PROGRESS database primary index
	KEY	`Date` (
				`DateSt`,
				`TimeStart`),
	KEY	`ErrorCode` (
				`ErrorCode`),
	KEY	`gsmbnr` (
				`DateSt`,
				`GsmBnr`),
	KEY	`InvCust` (
				`InvCust`,
				`DateSt`,
				`TimeStart`),
	KEY	`invseq` (
				`InvCust`,
				`InvSeq`),
	KEY	`ReadDate` (
				`ReadDate`),
	KEY	`spocmt` (
				`SPOcmt`))
	COMMENT = "?";
DROP TABLE IF EXISTS `mcdr_RepLog`;
CREATE TABLE `mcdr_RepLog`(
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
