select
    payment_id,
    order_id,
    transaction_date,
    sum(order_value) as order_value_sum
from (select
        id as payment_id,
        orderid as order_id,
        created as transaction_date,
        amount as order_value

    from raw.stripe.payment
    where
        STATUS = 'success')
group by payment_id, order_id, transaction_date