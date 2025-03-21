not_null_date.sql
{% test not_null_date(model,column_name) %}
    SELECT *                                  
    FROM  {{ model }}                                       
    WHERE  {{ column_name }} IS NULL                                 
{% endtest %}