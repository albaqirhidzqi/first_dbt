SELECT
    OrderNumber,
    SalesChannel,
    SL.WarehouseCode,
    WarehouseName,
    STR_TO_DATE(ProcuredDate, "%d/%m/%y") ProcuredDate,
    STR_TO_DATE(OrderDate, "%d/%m/%y") OrderDate,
    STR_TO_DATE(ShipDate, "%d/%m/%y") ShipDate,
    STR_TO_DATE(DeliveryDate, "%d/%m/%y") DeliveryDate,
    CurrencyCode,
    SL.SalesTeamID,
    SalesTeamName,
    CustomerID,
    StoreID,
    ProductID,
    OrderQuantity,
    DiscountApplied,
    CAST(SUBSTRING(UnitCost,2) AS DOUBLE) UnitCost,
    CAST(SUBSTRING(UnitPrice,2) AS DOUBLE) UnitPrice
FROM 
    {{ source('sale', 'sales') }} SL
LEFT JOIN {{ ref("sales_team_with_names")}} ST
    ON SL.SalesTeamID = ST.SalesTeamID
LEFT join {{ ref('warehouse_with_names')}} WH
    ON SL.WarehouseCode = WH.WarehouseCode