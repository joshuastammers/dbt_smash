with customers as (

    select * from {{ ref('customers') }}

),

payments as (

    select * from {{ ref('stg_payments') }}

),

orders as (

select * from {{ ref('stg_orders') }}

),

orders_paid as (

select
    payments.payment_id,
    payments.order_id,
    orders.customer_id,
    payments.transaction_date,
    payments.order_value_sum

from payments

inner join orders using (order_id) 

),

final as (

    select
        orders_paid.payment_id,
        orders_paid.order_id,
        orders_paid.customer_id,
        customers.first_name,
        customers.last_name,
        orders_paid.transaction_date,
        orders_paid.order_value_sum as order_value
    
    from orders_paid

    inner join customers using (customer_id)

    order by order_id, transaction_date
)

select * from final