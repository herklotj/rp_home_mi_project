view: lk_h_forecast {
  sql_table_name: actian.lk_h_forecast ;;



  dimension_group: inception_month {
    type: time
    timeframes: [
      date,
      month,
      quarter,
      year,
      fiscal_year
    ]
    sql: cast(${TABLE}.inception_month as timestamp) ;;
  }

  dimension: uw_year {
    type: number
    sql: case when ${inception_month_date} >= (TIMESTAMP '2016-08-01') AND ${inception_month_date} < (TIMESTAMP '2017-08-01') then 1
              when ${inception_month_date} >= (TIMESTAMP '2017-08-01') AND ${inception_month_date} < (TIMESTAMP '2018-08-01') then 2
              when ${inception_month_date} >= (TIMESTAMP '2018-08-01') AND ${inception_month_date} < (TIMESTAMP '2019-08-01') then 3
              when ${inception_month_date} >= (TIMESTAMP '2019-08-01') AND ${inception_month_date} < (TIMESTAMP '2020-08-01') then 4
              when ${inception_month_date} >= (TIMESTAMP '2020-08-01') AND ${inception_month_date} < (TIMESTAMP '2021-08-01') then 5
              when ${inception_month_date} >= (TIMESTAMP '2021-08-01') AND ${inception_month_date} < (TIMESTAMP '2022-08-01') then 6
              when ${inception_month_date} >= (TIMESTAMP '2022-08-01') AND ${inception_month_date} < (TIMESTAMP '2023-08-01') then 7
              when ${inception_month_date} >= (TIMESTAMP '2023-08-01') AND ${inception_month_date} < (TIMESTAMP '2024-08-01') then 8
              when ${inception_month_date} >= (TIMESTAMP '2024-08-01') AND ${inception_month_date} < (TIMESTAMP '2025-08-01') then 9
              when ${inception_month_date} >= (TIMESTAMP '2025-08-01') AND ${inception_month_date} < (TIMESTAMP '2026-08-01') then 10
         else null end   ;;
    label: "UW Year"
  }


  measure: aauicl_written_premium_budget {
    label: "AAUICL Written Premium Budget"
    type: sum
    sql: ${TABLE}.budget_written_premium_bds_nb + ${TABLE}.budget_written_premium_bds_rb_sw + ${TABLE}.budget_written_premium_cts_nb + ${TABLE}.budget_written_premium_cts_rb_sw + ${TABLE}.budget_written_premium_bds_rb_ren + ${TABLE}.budget_written_premium_cts_rb_ren ;;
    value_format_name: decimal_0
    group_label: "Budget - Premium"
  }

  measure: aauicl_cancelled_premium_budget {
    label: "AAUICL Cancelled Premium Budget"
    type: sum
    sql: ${TABLE}.budget_cancelled_premium_nb + ${TABLE}.budget_cancelled_premium_rb_sw + ${TABLE}.budget_cancelled_premium_rb_ren ;;
    value_format_name: decimal_0
    group_label: "Budget - Premium"
  }

  measure: aauicl_gwp_budget {
    label: "AAUICL GWP Budget"
    type: sum
    sql: (${TABLE}.budget_written_premium_bds_nb + ${TABLE}.budget_written_premium_bds_rb_sw + ${TABLE}.budget_written_premium_cts_nb + ${TABLE}.budget_written_premium_cts_rb_sw + ${TABLE}.budget_written_premium_bds_rb_ren + ${TABLE}.budget_written_premium_cts_rb_ren)
          - (${TABLE}.budget_cancelled_premium_nb + ${TABLE}.budget_cancelled_premium_rb_sw + ${TABLE}.budget_cancelled_premium_rb_ren) ;;
    value_format_name: decimal_0
    group_label: "Budget - Premium"
  }


  measure: broker_written_volumes_budget {
    label: "Broker Written Volumes Budget"
    type: sum
    sql: ${TABLE}.budget_panel_volumes_bds_nb + ${TABLE}.budget_panel_volumes_cts_nb + ${TABLE}.budget_panel_volumes_bds_rb + ${TABLE}.budget_panel_volumes_cts_rb ;;
    value_format_name: decimal_0
    group_label: "Budget - Volumes"
  }

  measure: aauicl_written_volumes_budget {
    label: "AAUICL Written Volumes Budget"
    type: sum
    sql: ${TABLE}.budget_aauicl_volumes_bds_nb + ${TABLE}.budget_aauicl_volumes_cts_nb + ${TABLE}.budget_aauicl_volumes_bds_rb_sw + ${TABLE}.budget_aauicl_volumes_cts_rb_sw + + ${TABLE}.budget_aauicl_volumes_bds_rb_ren + ${TABLE}.budget_aauicl_volumes_cts_rb_ren ;;
    value_format_name: decimal_0
    group_label: "Budget - Volumes"
  }

  measure: aauicl_cancelled_volumes_budget {
    label: "AAUICL Cancelled Volumes Budget"
    type: sum
    sql: ${TABLE}.budget_cancelled_volumes_nb + ${TABLE}.budget_cancelled_volumes_rb_sw + ${TABLE}.budget_cancelled_volumes_rb_ren ;;
    value_format_name: decimal_0
    group_label: "Budget - Volumes"
  }

  measure: aauicl_volumes_budget {
    label: "AAUICL Volumes Budget"
    type: sum
    sql:(${TABLE}.budget_aauicl_volumes_bds_nb + ${TABLE}.budget_aauicl_volumes_cts_nb + ${TABLE}.budget_aauicl_volumes_bds_rb_sw + ${TABLE}.budget_aauicl_volumes_cts_rb_sw + + ${TABLE}.budget_aauicl_volumes_bds_rb_ren + ${TABLE}.budget_aauicl_volumes_cts_rb_ren)
      - (${TABLE}.budget_cancelled_volumes_nb + ${TABLE}.budget_cancelled_volumes_rb_sw + ${TABLE}.budget_cancelled_volumes_rb_ren);;
    value_format_name: decimal_0
    group_label: "Budget - Volumes"
  }

  measure: aauicl_written_premium_forecast {
    label: "AAUICL Written Premium Forecast"
    type: sum
    sql: ${TABLE}.forecast_written_premium_bds_nb + ${TABLE}.forecast_written_premium_bds_rb_sw + ${TABLE}.forecast_written_premium_cts_nb + ${TABLE}.forecast_written_premium_cts_rb_sw + ${TABLE}.forecast_written_premium_bds_rb_ren + ${TABLE}.forecast_written_premium_cts_rb_ren ;;
    value_format_name: decimal_0
    group_label: "Forecast - Premium"
  }

  measure: aauicl_cancelled_premium_forecast {
    label: "AAUICL Cancelled Premium Forecast"
    type: sum
    sql: ${TABLE}.forecast_cancelled_premium_nb + ${TABLE}.forecast_cancelled_premium_rb_sw + ${TABLE}.forecast_cancelled_premium_rb_ren ;;
    value_format_name: decimal_0
    group_label: "Forecast - Premium"
  }

  measure: aauicl_gwp_forecast {
    label: "AAUICL GWP Forecast"
    type: sum
    sql: (${TABLE}.forecast_written_premium_bds_nb + ${TABLE}.forecast_written_premium_bds_rb_sw + ${TABLE}.forecast_written_premium_cts_nb + ${TABLE}.forecast_written_premium_cts_rb_sw + ${TABLE}.forecast_written_premium_bds_rb_ren + ${TABLE}.forecast_written_premium_cts_rb_ren)
      - (${TABLE}.forecast_cancelled_premium_nb + ${TABLE}.forecast_cancelled_premium_rb_sw + ${TABLE}.forecast_cancelled_premium_rb_ren) ;;
    value_format_name: decimal_0
    group_label: "Forecast - Premium"
  }


  measure: broker_written_volumes_forecast {
    label: "Broker Written Volumes Forecast"
    type: sum
    sql: ${TABLE}.forecast_panel_volumes_bds_nb + ${TABLE}.forecast_panel_volumes_cts_nb + ${TABLE}.forecast_panel_volumes_bds_rb + ${TABLE}.forecast_panel_volumes_cts_rb ;;
    value_format_name: decimal_0
    group_label: "Forecast - Volumes"
  }

  measure: aauicl_written_volumes_forecast {
    label: "AAUICL Written Volumes Forecast"
    type: sum
    sql: ${TABLE}.forecast_aauicl_volumes_bds_nb + ${TABLE}.forecast_aauicl_volumes_cts_nb + ${TABLE}.forecast_aauicl_volumes_bds_rb_sw + ${TABLE}.forecast_aauicl_volumes_cts_rb_sw + + ${TABLE}.forecast_aauicl_volumes_bds_rb_ren + ${TABLE}.forecast_aauicl_volumes_cts_rb_ren ;;
    value_format_name: decimal_0
    group_label: "Forecast - Volumes"
  }

  measure: aauicl_cancelled_volumes_forecast {
    label: "AAUICL Cancelled Volumes Forecast"
    type: sum
    sql: ${TABLE}.forecast_cancelled_volumes_nb + ${TABLE}.forecast_cancelled_volumes_rb_sw + ${TABLE}.forecast_cancelled_volumes_rb_ren ;;
    value_format_name: decimal_0
    group_label: "Forecast - Volumes"
  }

  measure: aauicl_volumes_forecast {
    label: "AAUICL Volumes Forecast"
    type: sum
    sql:(${TABLE}.forecast_aauicl_volumes_bds_nb + ${TABLE}.forecast_aauicl_volumes_cts_nb + ${TABLE}.forecast_aauicl_volumes_bds_rb_sw + ${TABLE}.forecast_aauicl_volumes_cts_rb_sw + + ${TABLE}.forecast_aauicl_volumes_bds_rb_ren + ${TABLE}.forecast_aauicl_volumes_cts_rb_ren)
      - (${TABLE}.forecast_cancelled_volumes_nb + ${TABLE}.forecast_cancelled_volumes_rb_sw + ${TABLE}.forecast_cancelled_volumes_rb_ren);;
    value_format_name: decimal_0
    group_label: "Forecast - Volumes"
  }


  measure: qs_premium_limit{
    label: "Quota Share GWP Limit"
    type: sum
    sql: ${TABLE}.qs_gwp_limit ;;
    value_format_name: decimal_0
  }


}
