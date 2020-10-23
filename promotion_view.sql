USE [SimplyAmplifyDWH]
GO

/****** Object:  View [dbo].[dim_CCS_vw]    Script Date: 19-06-2019 19:45:36 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

--ALTER View [dbo].[dim_PROMOTION_vw]
--As
Select * From (
SELECT a.clientID,a.userid As DBUserID,c.userName As UserID,a.outletCode As StoreCode,d.outletName As StoreName, 
		c.firstName As UserName,c.position As Position,c.fmName As FMName,a.questioncode,a.question As
		PromotionQuestion,a.answer As Answer,b.questionCategory As Brand,a.responsedate As ResponseDate,f.DateKey, f.MonthKey, f.Year,f.MonthName,
		ROW_NUMBER() OVER(PARTITION BY a.userid,a.questioncode, a.responsedate  ORDER BY a.responsedate) AS RowNumberRank,
		g.answer as datat

From [SimplyAmplify].[dbo].[MobiSyncActivity] a
Left Join [SimplyAmplify].[dbo].[MobiActivityList] b on (a.activityID=b.activityID And a.activityname=b.activityName 
And a.activitytype=b.activityType And a.questioncode=b.questionID And a.clientID=b.clientID And a.question=b.question )
Left Join [SimplyAmplify].[dbo].[MobiUser] c on(a.userid=c.userID)
Left Join [SimplyAmplify].[dbo].[apOutlet] d on(a.outletCode=d.outletCode)
Left Join [SimplyAmplifyDWH].[dbo].[dim_Date] f On f.DateKey=replace(convert(varchar,a.responsedate,23),'-','')
Left Join (
Select *, 'Variance' as datakey
from [SimplyAmplify].[dbo].[MobiSyncActivity]
where clientID=15 and activityname='PROMOTION' and responsedate>='2019-06-13' And answer Not In('Yes', 'No', 'Variance')
) g on (a.answer=g.datakey and a.userid=g.userid and a.clientID=g.clientID and a.outletCode=g.outletCode and a.activityID=g.activityID and a.activitytype=g.activitytype and a.activityname=g.activityname and a.responsedate=g.responsedate)
where a.clientID=15 And a.activityname='PROMOTION' And a.responsedate>='2019-06-13' And a.answer In ('Yes', 'No', 'Variance')
)a where RowNumberRank=1

--GO


