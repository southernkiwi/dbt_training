with 

source as (

    select * from {{ source('stripe', 'payment') }}

),

transformed as (

  select

    id as payment_id,
    orderid as order_id,
    created as payment_created_at,
    status as payment_status,
       -- amount is stored in cents, convert it to dollars
    {{ cents_to_dollars('amount', 4) }} as payment_amount,
    created as created_at

   from source

)

select * from transformed

