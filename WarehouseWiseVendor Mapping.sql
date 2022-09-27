select  w.Id [WID],
		w.name [Warehouse],
		v.id [VID],
		v.Name [VendorName],
		pv.id [PVID],
		pv.Name [Product],
		pvp.CostPrice [CostPrice],
		pvp.CachedListPrice [ListPrice],
		pv.Mrp [MRP]


from ThingRequest tr
join Shipment s on s.Id = tr.ShipmentId 
join ProductVariant pv on pv.Id = tr.ProductVariantId 
join ProductVariantPricing pvp on pv.Id = pvp.ProductVariantId 
join Warehouse w on w.Id = s.WarehouseId 
join ProductVariantVendorMapping pvvm on pv.Id = pvvm.ProductVariantId 
and (w.SourcesPerishablesFromWarehouseId = pvvm.WarehouseId or w.SourcesNonPerishablesFromWarehouseId = pvvm.WarehouseId)
join Vendor v on v.Id = pvvm.VendorId 

where tr.IsCancelled = 0
and tr.IsReturned = 0
and tr.HasFailedBeforeDispatch = 0
and tr.IsMissingAfterDispatch = 0
and w.DistributionNetworkId = 1
and v.Id in (988)

group by w.Id,
		w.name,
		v.id,
		v.Name ,
		pv.id ,
		pv.Name ,
		pvp.CostPrice ,
		pvp.CachedListPrice ,
		pv.Mrp 