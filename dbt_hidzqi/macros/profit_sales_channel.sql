{% macro profit_sales_channel(sales_channel) %}
    SELECT
        SalesChannel,
        SUM(OrderQuantity * UnitCost) AS cost,
        SUM(OrderQuantity * UnitPrice) AS revenue,
        SUM(OrderQuantity * (UnitPrice - UnitCost)) AS profit
    FROM 
        {{ ref("sales_data_stg") }}
    WHERE 
        SalesChannel IN (
            {% for col in sales_channel %}
                '{{ col }}'{% if not loop.last %}, {% endif %}
            {% endfor %}
        )
    GROUP BY
        SalesChannel
{% endmacro %}
