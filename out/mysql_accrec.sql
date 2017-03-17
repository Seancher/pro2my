drop database if exists rbsall;
create database rbsall;
use rbsall;
DROP TABLE IF EXISTS `accrec_ClaimHist`;
CREATE TABLE `accrec_ClaimHist`(
	`Brand`	CHAR(8) COMMENT "character|x(8)|Brand|Brand|Code Of Brand|",
	`Claim`	INT DEFAULT "0" COMMENT "integer|>>9|Claim nbr|Claim|Claim number|How many times have been claimed",
	`ClaimAmt`	DECIMAL DEFAULT "0" COMMENT "decimal|->>>>>>9.99|Claimed Amount|Amount|Claimed amount (invoice's open balance)|",
	`ClaimDate`	DATE COMMENT "date|99-99-99|Claiming Date|Date|Claiming date|",
	`ClaimStamp`	DECIMAL DEFAULT "0" COMMENT "decimal|99999999.99999|Claimed|?|Date and time when claimed|",
	`ClaimState`	DECIMAL DEFAULT "0" COMMENT "decimal|>9.99|Claiming Status|Claimed|Claiming status|",
	`CustNum`	INT DEFAULT "0" NOT NULL COMMENT "integer|>>>>>>>>9|Customer|Customer|Customer's number|",
	`Handler`	CHAR(20) COMMENT "character|x(20)|Handler|?|User id of the claim event handler|",
	`HostTable`	CHAR(12) NOT NULL COMMENT "character|x(12)|Host Table|Host|Name of table which this address is assigned to|",
	`InvNum`	INT DEFAULT "0" COMMENT "integer|zzzzzzz9|InvNo|InvNo|Invoice Number|",
	`KeyValue`	CHAR(16) NOT NULL COMMENT "character|x(16)|Key Value|Key|Key value of the record related to the address|",
	`Memo`	CHAR(30) COMMENT "character|x(30)|Info|?|Info|",
	`ServiceDebt`	DECIMAL DEFAULT "0" COMMENT "decimal|->>>>>>9.99|Service Debt|Service|Service debt|",
	`SubInvNum`	INT DEFAULT "0" COMMENT "integer|>>9|SubInvoice Number|SubInv|Sequential nbr of the subinvoice within the combined invoice|",
	`TeleDebt`	DECIMAL DEFAULT "0" COMMENT "decimal|->>>>>>9.99|Tele Debt|Tele|Tele debt|",
	PRIMARY KEY	(`Brand`,`HostTable`,`KeyValue`,`ClaimStamp`),
	KEY	`ClaimDate` (
				`Brand`,
				`ClaimDate`,
				`InvNum`),
	KEY	`CustNum` (
				`Brand`,
				`CustNum`,
				`ClaimDate`),
## The PROGRESS database primary index
	KEY	`HostTable` (
				`Brand`,
				`HostTable`,
				`KeyValue`,
				`ClaimStamp`),
	KEY	`InvNum` (
				`Brand`,
				`InvNum`,
				`ClaimState`,
				`SubInvNum`),
	KEY	`InvNum_s` (
				`InvNum`,
				`SubInvNum`,
				`ClaimState`,
				`ClaimStamp`))
	COMMENT = "Claiming history of invoice";
DROP TABLE IF EXISTS `accrec_Payment`;
CREATE TABLE `accrec_Payment`(
	`AccDate`	DATE COMMENT "date|99-99-99|BookDate|BookDate|Date, when payment has been registered in bank|",
	`BankAcc`	CHAR(20) COMMENT "character|x(20)|Bank Acc.|Bank Acc.|Bank account number|",
	`Brand`	CHAR(8) COMMENT "character|x(8)|Brand|Brand|Code Of Brand|",
	`CustName`	CHAR(30) COMMENT "character|x(30)|CustName|Customer name|Customer's name|",
	`CustNum`	INT DEFAULT "0" NOT NULL COMMENT "integer|>>>>>>>>9|Customer|Customer|Customer number, 1 - 999999|",
	`Discount`	DECIMAL DEFAULT "0" COMMENT "decimal|ZZZ9.99-|Discount|Discount|Total discount with in this payment|",
	`DueDate`	DATE COMMENT "date|99-99-99|DueDay|DueDay|Invoice's due day|",
	`ExpUser`	CHAR(8) COMMENT "character|x(8)|Export User|User|User who exported payment|",
	`ExtInvID`	CHAR(12) COMMENT "character|x(12)|External Invoice ID|Ext.ID|External invoice ID|",
	`ExtVoucher`	CHAR(12) COMMENT "character|x(12)|External Voucher|Ext.Voucher|External voucher|",
	`ImportStamp`	DECIMAL DEFAULT "0" COMMENT "decimal|99999999.99999|Imported|Imported|Date and time when payment is imported into TMS|",
	`InvAmt`	DECIMAL DEFAULT "0" COMMENT "decimal|>>>>>>9.99-|Invoice Amount|Invoice Amt|Invoice's amount (payable)|",
	`InvDate`	DATE COMMENT "date|99-99-99|Invoice date|Invoice date|Invoice date|",
	`InvNum`	INT DEFAULT "0" COMMENT "integer|zzzzzzz9|InvoiceNo|InvoiceNo|Invoice's number|",
	`PaymAmt`	DECIMAL DEFAULT "0" COMMENT "decimal|ZZZZZZ9.99-|Payment|Payment|Payment|",
	`PaymArc`	CHAR(30) COMMENT "character|x(30)|ArchiveId|ArcId|Archive id|",
	`PaymCase`	CHAR(16) COMMENT "character|x(16)|Payment Case|Case|Payment case|",
	`PaymDate`	DATE COMMENT "date|99-99-99|Payment Date|Payment Date|Date of Invoice Payment|",
	`PaymEntryDate`	DATE COMMENT "date|99-99-9999|Payment Entry Date|Entry Date|Payment entry date on external AR|",
	`PaymFile`	CHAR(8) COMMENT "character|x(8)|File|File|Name of input file|",
	`PaymSrc`	CHAR(8) COMMENT "character|x(8)|Payment source|Source|Source of payment|empty=manual, dd=direct debit, rf=reference file, ca=collection agency",
	`PaymType`	INT DEFAULT "0" COMMENT "integer|>9|Payment Type|PaymType|Payment type|",
	`PPBatch`	INT DEFAULT "0" COMMENT "integer|>9|Payment Plan Batch|PP Batch|Payment plan batch number|",
	`PPlanID`	INT DEFAULT "0" COMMENT "integer|>>>>>>>9|Payment Plan ID|PP ID|Payment plan ID|",
	`RefNum`	CHAR(20) COMMENT "character|x(20)|Reference Nbr|Reference|Reference number|",
	`TotAmt`	DECIMAL DEFAULT "0" COMMENT "decimal|ZZZZZZ9.99-|Total|Total|Total payment|",
	`Voucher`	INT DEFAULT "0" COMMENT "integer|ZZZZZZ9|VoucherNo|VoucherNo|Voucher number of payment|",
	PRIMARY KEY	(`Brand`,`CustNum`,`InvNum`,`Voucher`),
	KEY	`AccDate` (
				`Brand`,
				`AccDate`,
				`Voucher`),
## The PROGRESS database primary index
	KEY	`CustNum` (
				`Brand`,
				`CustNum`,
				`InvNum`,
				`Voucher`),
	KEY	`CustNum_s` (
				`CustNum`,
				`InvNum`,
				`Voucher`),
	KEY	`ExtInvID` (
				`Brand`,
				`ExtInvID`),
	KEY	`ExtVoucher` (
				`Brand`,
				`ExtVoucher`),
	KEY	`InvNum` (
				`Brand`,
				`InvNum`),
	KEY	`InvNum_s` (
				`InvNum`),
	KEY	`PaymArc` (
				`Brand`,
				`PaymArc`),
	KEY	`PaymSrc` (
				`Brand`,
				`PaymSrc`,
				`PaymAmt`),
	KEY	`PaymType` (
				`Brand`,
				`PaymType`,
				`AccDate`),
	KEY	`PPlanID` (
				`PPlanID`,
				`PPBatch`),
	KEY	`RefNum` (
				`Brand`,
				`RefNum`),
	KEY	`Voucher` (
				`Brand`,
				`Voucher`),
	KEY	`Voucher_s` (
				`Voucher`))
	COMMENT = "Payments";
DROP TABLE IF EXISTS `accrec_PaymLog`;
CREATE TABLE `accrec_PaymLog`(
	`BookDate`	DATE COMMENT "date|99-99-99|BookDate|BookDate|Date When a Payment File was Booked|",
	`Brand`	CHAR(8) COMMENT "character|x(8)|Brand|Brand|Code Of Brand|",
	`PaymFile`	CHAR(24) COMMENT "character|x(24)|File Identifier|FileId|Identifier of Payment File|",
	`UserCode`	CHAR(8) NOT NULL COMMENT "character|x(8)|User ID|User ID|User ID of log event|",
	PRIMARY KEY	(`Brand`,`BookDate`,`PaymFile`),
## The PROGRESS database primary index
	KEY	`bookdate` (
				`Brand`,
				`BookDate`,
				`PaymFile`),
	KEY	`PaymFile` (
				`Brand`,
				`PaymFile`,
				`BookDate`))
	COMMENT = "Payment log";
DROP TABLE IF EXISTS `accrec_PaymPlan`;
CREATE TABLE `accrec_PaymPlan`(
	`Amount`	DECIMAL DEFAULT "0" COMMENT "decimal|->>>>>>9.99|Amount|?|Total debt of invoices that belong to payment plan|",
	`BankDays`	INT DEFAULT "0" COMMENT "integer|>>9|Bank Days|BankDays|Bank days, that will be waited after due date for payment|",
	`Brand`	CHAR(8) COMMENT "character|x(8)|Brand|?|Code Of Brand|",
	`CLI`	CHAR(15) COMMENT "character|x(15)|MSISDN|?||",
	`CustNum`	INT DEFAULT "0" NOT NULL COMMENT "integer|>>>>>>>9|Customer|Cust|Customer's number|",
	`Orderer`	INT DEFAULT "0" COMMENT "integer|>>>>>>>9|Orderer|?|Customer who ordered the plan (confirmation letter receiver)|",
	`PPDate`	DATE COMMENT "date|99-99-99|Creation Date|Date|Date when payment plan was done|",
	`PPlanID`	INT DEFAULT "0" COMMENT "integer|>>>>>>>9|Payment Plan ID|PP ID|Payment plan ID|sequence pplan",
	`PPStatus`	INT DEFAULT "0" COMMENT "integer|9|Status|?|Status of payment plan|e.g. sent, accepted, cancelled, paid",
	`PPType`	INT DEFAULT "0" COMMENT "integer|9|Type|?|Type of payment plan|e.g. rem(inder), cc (cust.care)",
	PRIMARY KEY	(`PPlanID`),
	KEY	`CLI` (
				`Brand`,
				`CLI`,
				`PPDate`),
	KEY	`CustNum` (
				`Brand`,
				`CustNum`,
				`PPDate`),
	KEY	`PPDate` (
				`Brand`,
				`PPDate`,
				`CustNum`),
## The PROGRESS database primary index
	KEY	`PPlanID` (
				`PPlanID`),
	KEY	`PPStatus` (
				`Brand`,
				`PPStatus`,
				`CustNum`))
	COMMENT = "Payment plan for unpaid invoices";
DROP TABLE IF EXISTS `accrec_PaymRow`;
CREATE TABLE `accrec_PaymRow`(
	`AccNum[1]`	INT DEFAULT "0" COMMENT "integer|>>>>>9|Account Number|Account|Account number|",
	`AccNum[2]`	INT DEFAULT "0" COMMENT "integer|>>>>>9|Account Number|Account|Account number|",
	`AccNum[3]`	INT DEFAULT "0" COMMENT "integer|>>>>>9|Account Number|Account|Account number|",
	`AccNum[4]`	INT DEFAULT "0" COMMENT "integer|>>>>>9|Account Number|Account|Account number|",
	`AccType[1]`	INT DEFAULT "0" COMMENT "integer|>9|Account Type|Type|Account type|",
	`AccType[2]`	INT DEFAULT "0" COMMENT "integer|>9|Account Type|Type|Account type|",
	`AccType[3]`	INT DEFAULT "0" COMMENT "integer|>9|Account Type|Type|Account type|",
	`AccType[4]`	INT DEFAULT "0" COMMENT "integer|>9|Account Type|Type|Account type|",
	`InvNum`	INT DEFAULT "0" COMMENT "integer|>>>>>>>9|Invoice Number|Invoice|Invoice number|",
	`Posting[1]`	DECIMAL DEFAULT "0" COMMENT "decimal|->>>>>>>9.99|?|?|Posting amount|",
	`Posting[2]`	DECIMAL DEFAULT "0" COMMENT "decimal|->>>>>>>9.99|?|?|Posting amount|",
	`Posting[3]`	DECIMAL DEFAULT "0" COMMENT "decimal|->>>>>>>9.99|?|?|Posting amount|",
	`Posting[4]`	DECIMAL DEFAULT "0" COMMENT "decimal|->>>>>>>9.99|?|?|Posting amount|",
	`SubInvNum`	INT DEFAULT "0" COMMENT "integer|>>9|SubInvoice Number|SubInv|Sequential nbr of the subinvoice within the combined invoice|",
	`Voucher`	INT DEFAULT "0" COMMENT "integer|>>>>>>>9|Voucher Number|Voucher|Voucher number of payment|",
	PRIMARY KEY	(`Voucher`,`InvNum`,`SubInvNum`),
	KEY	`InvNum` (
				`InvNum`,
				`SubInvNum`,
				`Voucher`),
## The PROGRESS database primary index
	KEY	`Voucher` (
				`Voucher`,
				`InvNum`,
				`SubInvNum`))
	COMMENT = "Payment row";
DROP TABLE IF EXISTS `accrec_PPBatch`;
CREATE TABLE `accrec_PPBatch`(
	`Amount`	DECIMAL DEFAULT "0" COMMENT "decimal|->>>>>>9.99|Amount|?|Amount of batch|",
	`DueDate`	DATE COMMENT "date|99-99-99|Due Date|DueDate|Batche's due date|",
	`PaidAmt`	DECIMAL DEFAULT "0" COMMENT "decimal|->>>>>>9.99|Paid Amount|Paid|Paid amount|",
	`PBStatus`	INT DEFAULT "0" COMMENT "integer|9|Status|?|Status of batch|e.g. unpaid, partly paid, paid",
	`PPBatch`	INT DEFAULT "0" COMMENT "integer|>9|Batch|?|Batch number|",
	`PPlanID`	INT DEFAULT "0" COMMENT "integer|>>>>>>>9|Payment Plan ID|PP ID|Payment plan ID|",
	`RefNum`	CHAR(20) COMMENT "character|x(20)|Reference Nbr|RefNum|Reference Number|",
	PRIMARY KEY	(`PPlanID`,`PPBatch`),
## The PROGRESS database primary index
	KEY	`PPlanID` (
				`PPlanID`,
				`PPBatch`))
	COMMENT = "Payment plan's batches";
DROP TABLE IF EXISTS `accrec_PPInv`;
CREATE TABLE `accrec_PPInv`(
	`Amount`	DECIMAL DEFAULT "0" COMMENT "decimal|->>>>>>9.99|Amount|?|Invoice's debt when it was added to payment plan|",
	`InvNum`	INT DEFAULT "0" COMMENT "integer|>>>>>>>9|Invoice|InvNum|Invoice number|",
	`PPlanID`	INT DEFAULT "0" COMMENT "integer|>>>>>>>9|Payment Plan ID|PP ID|Payment plan ID|",
	`SubInvNum`	INT DEFAULT "0" COMMENT "integer|>>9|SubInvoice Number|SubInv|Sequential nbr of the subinvoice within the combined invoice|",
	PRIMARY KEY	(`PPlanID`,`InvNum`,`SubInvNum`),
	KEY	`InvNum` (
				`InvNum`,
				`SubInvNum`),
## The PROGRESS database primary index
	KEY	`PPlanID` (
				`PPlanID`,
				`InvNum`,
				`SubInvNum`))
	COMMENT = "Payment plan's invoices";
