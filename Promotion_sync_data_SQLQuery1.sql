/****** Script for SelectTopNRows command from SSMS  ******/
SELECT b.userName, b.firstName,a.[outletCode] ,c.outletName,a.[activityname] ,a.[question] ,a.[answer] ,[responsedate] ,a.[created]
  FROM [SimplyAmplify].[dbo].[MobiSyncActivity] a
	left join [dbo].[MobiUser] b on ( a.userid=b.userID)
	left join [dbo].[apOutlet] c on (a.outletCode=c.outletCode)
  where a.clientID=15 and a.created>='2019-06-12' and a.activityname='PROMOTION'