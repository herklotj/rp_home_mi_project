view: lk_h_forecast {
  sql_table_name: actian.lk_h_forecast ;;



  dimension_group: inception_month {
    type: time
    timeframes: [
      month,
      quarter,
      year,
      fiscal_year
    ]
    sql: cast(${TABLE}.inception_month as timestamp) ;;
  }

  measure: aauicl_nb_forecast {
    label: "AAUICL NB Written Forecast"
    type: sum
    sql: ${TABLE}.aauicl_written_nb ;;
  }

  measure: aauicl_ren_forecast {
    label: "AAUICL Ren Written Forecast"
    type: sum
    sql: ${TABLE}.aauicl_written_ren ;;
  }

  measure: aauicl_sw_forecast {
    label: "AAUICL XQ Written Forecast"
    type: sum
    sql: ${TABLE}.aauicl_written_sw ;;
  }

  measure: broker_nb_forecast {
    label: "Broker NB Written Forecast"
    type: sum
    sql: ${TABLE}.broker_written_nb ;;
  }

  measure: broker_rb_forecast {
    label: "Broker RB Written Forecast"
    type: sum
    sql: ${TABLE}.broker_written_rb ;;
  }


}
