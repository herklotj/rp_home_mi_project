view: lk_h_forecast {
  sql_table_name: actian.lk_h_forecast ;;

  dimension: aauicl_written_nb {
    type: number
    sql: ${TABLE}.aauicl_written_nb ;;
  }

  dimension: aauicl_written_ren {
    type: number
    sql: ${TABLE}.aauicl_written_ren ;;
  }

  dimension: aauicl_written_sw {
    type: number
    sql: ${TABLE}.aauicl_written_sw ;;
  }

  dimension: broker_written_nb {
    type: number
    sql: ${TABLE}.broker_written_nb ;;
  }

  dimension: broker_written_rb {
    type: number
    sql: ${TABLE}.broker_written_rb ;;
  }

  dimension_group: inception_month {
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
    sql: ${TABLE}.inception_month ;;
  }

  dimension_group: load_dttm {
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
    sql: ${TABLE}.load_dttm ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
