SELECT
    OrderNumber,
    SalesChannel,
    SL.WarehouseCode,
    WarehouseName,
    STR_TO_DATE(ProcuredDate, "%d/%m/%y") ProcuredDate,
    STR_TO_DATE(OrderDate, "%d/%m/%y") OrderDate,
    STR_TO_DATE(ShipDate, "%d/%m/%y") ShipDate,
    STR_TO_DATE(DeliveryDate, "%d/%m/%y") DeliveryDate,
    DeliveryStatus,
    CurrencyCode,
    SL.SalesTeamID,
    SalesTeamName,
    CustomerID,
    StoreID,
    ProductID,
    OrderQuantity,
    DiscountApplied,
    {% for col in ['UnitCost', 'UnitPrice'] %}
        CAST(REPLACE(SL.{{ col }}, '$', '') AS DECIMAL(10, 2)) AS {{ col | replace(' ', '_') | lower }}{% if not loop.last %}, {% endif %}
    {% endfor %}
FROM 
    {{ source('sale', 'sales') }} SL
LEFT JOIN {{ ref("sales_team_with_names")}} ST  
    ON SL.SalesTeamID = ST.SalesTeamID
LEFT join {{ ref('warehouse_with_names')}} WH
    ON SL.WarehouseCode = WH.WarehouseCode