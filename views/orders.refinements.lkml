include: "/views/orders.view.lkml"

view: +orders {

    dimension_group: created {
      type: time
      timeframes: [
        raw,
        time,
        date,
        week,
        month,
        quarter,
        year
      ]
      sql: ${original_created_date} ;;

  }
}
