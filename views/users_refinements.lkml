include: "/views/users.view.lkml"

view: +users {

  dimension_group: user_created {
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
    sql: ${original_user_created_date} ;;
  }


}
