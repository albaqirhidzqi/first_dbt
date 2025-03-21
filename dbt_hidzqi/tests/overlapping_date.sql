SELECT
    OrderDate,
    ShipDate
FROM {{ ref("sales_data_stg")}}
WHERE OrderDate < ShipDate 