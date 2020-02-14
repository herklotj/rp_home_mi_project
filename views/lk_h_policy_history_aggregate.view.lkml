view: lk_h_policy_history_aggregates {

  derived_table: {
      sql: SELECT
          *
          from
         lk_h_policy_history
        where schedule_cover_start_dttm = annual_cover_start_dttm and status = 'P' and cfi_ind = 0

     ;;
    }

  measure: aauicl_sum_insured_total {
    label: "AAUICL Sum Insured Total"
    type: sum
    sql: ${TABLE}.aauicl_sum_insured_tot ;;
    value_format_name: decimal_0
  }

  measure: broker_sum_insured_total {
    label: "Broker Sum Insured Total"
    type: sum
    sql: ${TABLE}.broker_sum_insured_tot ;;
    value_format_name: decimal_0
  }

  measure: aauicl_avg_sum_insured_share {
    label: "AAUICL Average Sum Insured Share"
    type: number
    sql:  ${aauicl_sum_insured_total}/nullif(${broker_sum_insured_total},0) ;;
    value_format_name: percent_0
  }


}
