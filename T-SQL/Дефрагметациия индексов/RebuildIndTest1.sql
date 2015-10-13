alter index [Car.ixSalesman] on [AutoSales].[dbo].[Car] REBUILD
go
alter index [Car.pk] on [AutoSales].[dbo].[Car] REBUILD
go
alter index [CarAddOnContact.pk] on [AutoSales].[dbo].[CarAddOnContact] REBUILD
go
alter index [CarAddOnService.ixUnique] on [AutoSales].[dbo].[CarAddOnService] REBUILD
go
alter index [CarVinItem.ixDate] on [AutoSales].[dbo].[CarVinItem] REBUILD
go
alter index [ClientRepresent.pk] on [AutoSales].[dbo].[ClientRepresent] REBUILD
go
alter index [CVLValuation.ixSaleOrder] on [AutoSales].[dbo].[CVLValuation] REBUILD
go
alter index [Depart.ixHrBusiness] on [AutoSales].[dbo].[Depart] REBUILD
go
alter index [Depart.ixTerOrder] on [AutoSales].[dbo].[Depart] REBUILD
go
alter index [Depart.pk] on [AutoSales].[dbo].[Depart] REBUILD
go
alter index [Doc.pk] on [AutoSales].[dbo].[Doc] REBUILD
go
alter index [DocCarOrder.ixCar] on [AutoSales].[dbo].[DocCarOrder] REBUILD
go
alter index [DocCarOrderClose.ixOrder] on [AutoSales].[dbo].[DocCarOrderClose] REBUILD
go
alter index [DocCarOrderClose.pk] on [AutoSales].[dbo].[DocCarOrderClose] REBUILD
go
alter index [HrEmployeeWork.ixStaff] on [AutoSales].[dbo].[HrEmployeeWork] REBUILD
go
alter index [HrPosition.ixName] on [AutoSales].[dbo].[HrPosition] REBUILD
go
alter index [HrStaff.ixDepart] on [AutoSales].[dbo].[HrStaff] REBUILD
go
alter index [INSCar.ixVIN] on [AutoSales].[dbo].[INSCar] REBUILD
go
alter index [INSPolicy.ixINSCar] on [AutoSales].[dbo].[INSPolicy] REBUILD
go
alter index [INSPolicy.pk] on [AutoSales].[dbo].[INSPolicy] REBUILD
go
alter index [MenuItem.ixAction] on [AutoSales].[ui].[MenuItem] REBUILD
go
alter index [CarModification.pk] on [AutoSales].[dbo].[CarModification] REBUILD
go
alter index [CarStateHistory.ixDate] on [AutoSales].[dbo].[CarStateHistory] REBUILD
go
alter index [DocCarOrder.pk] on [AutoSales].[dbo].[DocCarOrder] REBUILD
go
/*
alter index [RSMPhone.ixEmplyeePhoneType] on [AutoSalesSBD].[dbo].[RSMPhone] REBUILD
go
alter index [SIOWarranty.pk] on [AutoSalesSBD].[dbo].[SIOWarranty] REBUILD
go
alter index [SIOWarranty.ixCar] on [AutoSalesSBD].[dbo].[SIOWarranty] REBUILD
go
alter index [SIOCarLnkCar.ixCar] on [AutoSalesSBD].[dbo].[SIOCarLnkCar] REBUILD
go
alter index [SSUBill.ixCalc] on [AutoSalesSS].[dbo].[SSUBill] REBUILD
go
alter index [SSUBill.pk] on [AutoSalesSS].[dbo].[SSUBill] REBUILD
go
alter index [SSUCalc.ixClient] on [AutoSalesSS].[dbo].[SSUCalc] REBUILD
go
alter index [SSUCalc.pk] on [AutoSalesSS].[dbo].[SSUCalc] REBUILD
go
*/