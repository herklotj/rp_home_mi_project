view: lk_h_cancel_history {
  sql_table_name: actian.lk_h_cancel_history ;;

  dimension: aauicl_flag_joint {
    type: number
    sql: ${TABLE}.aauicl_flag_joint ;;
  }

  dimension: aauicl_ind_bds {
    type: number
    sql: ${TABLE}.aauicl_ind_bds ;;
  }

  dimension: aauicl_ind_cts {
    type: number
    sql: ${TABLE}.aauicl_ind_cts ;;
  }

  dimension: aauicl_scheme {
    type: string
    sql: ${TABLE}.aauicl_scheme ;;
  }

  dimension_group: annual_cover_end_dttm {
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
    sql: ${TABLE}.annual_cover_end_dttm ;;
  }

  dimension_group: annual_cover_start_dttm {
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
    sql: ${TABLE}.annual_cover_start_dttm ;;
  }

  dimension: broker_flag_joint {
    type: number
    sql: ${TABLE}.broker_flag_joint ;;
  }

  dimension: broker_ind_bds {
    type: number
    sql: ${TABLE}.broker_ind_bds ;;
  }

  dimension: broker_ind_cts {
    type: number
    sql: ${TABLE}.broker_ind_cts ;;
  }

  dimension: broker_nb_rb {
    type: string
    sql: ${TABLE}.broker_nb_rb ;;
  }

  dimension: cancel_cooling {
    type: number
    sql: ${TABLE}.cancel_cooling ;;
  }

  dimension: cancel_cooling_bds {
    type: number
    sql: ${TABLE}.cancel_cooling_bds ;;
  }

  dimension: cancel_cooling_cts {
    type: number
    sql: ${TABLE}.cancel_cooling_cts ;;
  }

  dimension_group: cancel_dttm {
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
    sql: ${TABLE}.cancel_dttm ;;
  }

  dimension_group: cancel_effective_dttm {
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
    sql: ${TABLE}.cancel_effective_dttm ;;
  }

  dimension: cancel_reason {
    type: number
    sql: ${TABLE}.cancel_reason ;;
  }

  dimension: cover_type {
    type: string
    sql: ${TABLE}.cover_type ;;
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

  dimension: nb_sw_flag {
    type: string
    sql: ${TABLE}.nb_sw_flag ;;
  }

  dimension_group: policy_cancel {
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
    sql: ${TABLE}.policy_cancel_date ;;
  }

  dimension_group: policy_cancel_mth {
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
    sql: ${TABLE}.policy_cancel_mth ;;
  }

  dimension_group: policy_cancel_notified_mth {
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
    sql: ${TABLE}.policy_cancel_notified_mth ;;
  }

  dimension: policy_cancel_notified_yr {
    type: number
    sql: ${TABLE}.policy_cancel_notified_yr ;;
  }

  dimension: policy_cancel_yr {
    type: number
    sql: ${TABLE}.policy_cancel_yr ;;
  }

  dimension_group: schedule_cover_end_dttm {
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
    sql: ${TABLE}.schedule_cover_end_dttm ;;
  }

  dimension_group: schedule_cover_start_dttm {
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
    sql: ${TABLE}.schedule_cover_start_dttm ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: tia_customer_no {
    type: number
    sql: ${TABLE}.tia_customer_no ;;
  }

  dimension: tia_reference {
    type: number
    sql: ${TABLE}.tia_reference ;;
  }

  dimension: tia_transaction_no {
    type: number
    sql: ${TABLE}.tia_transaction_no ;;
  }

  dimension_group: transaction {
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
    sql: ${TABLE}.transaction_date ;;
  }

  dimension_group: transaction_dttm {
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
    sql: ${TABLE}.transaction_dttm ;;
  }

  dimension: uw_policy_no {
    type: string
    sql: ${TABLE}.uw_policy_no ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
