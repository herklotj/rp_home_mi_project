view: lk_h_policy_history {
  derived_table: {
    sql:

    SELECT *
    FROM actian.lk_h_policy_history_scored
    WHERE SCHEDULE_COVER_START_DTTM = ANNUAL_COVER_START_DTTM
    AND   CFI_IND = 0
    ;;
  }

  dimension_group: policy_written_date {
    label: "Policy Written"
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year,
      fiscal_year
    ]
    sql: ${TABLE}.transaction_dttm ;;
  }


  dimension_group: policy_start_date {
    label: "Policy Start"
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year,
      fiscal_year
    ]
    sql: ${TABLE}.policy_start_date ;;
  }

  dimension_group: inception_date {
    label: "Inception"
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year,
      fiscal_year
    ]
    sql: ${TABLE}.inception_dt ;;
  }

  dimension_group: _original_inception_date {
    label: "Original Inception"
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.original_inception_dttm ;;
  }


  dimension: cfi_ind_lapse {
    label: "CFI IND Lapse"
    type: number
    sql: ${TABLE}.cfi_ind_lapse ;;
  }

  dimension: mta_ind {
    label: "MTA IND"
    type: number
    sql: ${TABLE}.mta_ind ;;
  }

  dimension: broker_nb_rb {
    label: "Broker NB/RB"
    type: string
    sql: ${TABLE}.broker_nb_rb ;;
  }

  dimension: insurer_nb_rb {
    label: "Insurer NB/RB"
    type: string
    sql: ${TABLE}.insurer_nb_rb ;;
  }

  dimension: channel {
    label: "Channel"
    type: string
    sql: ${TABLE}.channel ;;
  }

  dimension: cover_type {
    label: "Cover Type"
    type: string
    sql: ${TABLE}.cover_type ;;
  }

  dimension: cover_type_customer {
    label: "Cover Type Customer"
    type: string
    sql: ${TABLE}.cover_type_customer ;;
  }

  dimension: home_cover_level {
    label: "Home Cover Level"
    type: string
    sql: ${TABLE}.home_cover_level ;;
  }

  dimension: aa_tenure {
    label: "AA Tenure (3+)"
    type: tier
    tiers: [0,1,2,3]
    style: integer
    sql: ${TABLE}.aa_tenure ;;
  }

  dimension: uw_tenure {
    label: "UW Tenure (3+)"
    type: tier
    tiers: [0,1,2,3]
    style: integer
    sql: ${TABLE}.uw_tenure ;;
  }


  dimension: aauicl_modelled_loss_ratio_inf {
    description: "Modelled Net Loss Ratio INF"
    type: tier
    style:  interval
    tiers: [0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1.0]
    value_format_name: percent_0
    sql: (${TABLE}.buildings_aauicl_rpm_inf + ${TABLE}.contents_aauicl_rpm_inf)/
                (nullif((${TABLE}.net_premium_aauicl_bds + ${TABLE}.net_premium_aauicl_cts),0));;
  }

  dimension: aauicl_modelled_loss_ratio_wlc {
    description: "Modelled Net Loss Ratio WLC"
    type: tier
    style:  interval
    tiers: [0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1.0]
    value_format_name: percent_0
    sql: (${TABLE}.buildings_aauicl_rpm_wlc + ${TABLE}.contents_aauicl_rpm_wlc)/
                (nullif((${TABLE}.net_premium_aauicl_bds + ${TABLE}.net_premium_aauicl_cts),0));;
  }

  dimension: aauicl_modelled_gross_loss_ratio_inf {
    description: "Modelled Gross Loss Ratio INF"
    type: tier
    style:  interval
    tiers: [0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1.0]
    value_format_name: percent_0
    sql: (${TABLE}.buildings_aauicl_rpm_inf + ${TABLE}.contents_aauicl_rpm_inf)/
                (nullif((${TABLE}.net_premium_aauicl_bds + ${TABLE}.net_premium_aauicl_cts + ${TABLE}.broker_commission_aauicl),0));;
  }

  dimension: aauicl_modelled_gross_loss_ratio_wlc {
    description: "Modelled Gross Loss Ratio WLC"
    type: tier
    style:  interval
    tiers: [0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1.0]
    value_format_name: percent_0
    sql: (${TABLE}.buildings_aauicl_rpm_wlc + ${TABLE}.contents_aauicl_rpm_wlc)/
                (nullif((${TABLE}.net_premium_aauicl_bds + ${TABLE}.net_premium_aauicl_cts + ${TABLE}.broker_commission_aauicl),0));;
  }

  dimension: commission_as_percent_of_gross_premium {
    description: "Commission as % of Gross Premium"
    type: tier
    style:  interval
    tiers: [0.1,0.2,0.3,0.4,0.5,0.6,0.7]
    value_format_name: percent_0
    sql: (${TABLE}.broker_commission_aauicl)/
      (nullif((${TABLE}.net_premium_aauicl_bds + ${TABLE}.net_premium_aauicl_cts + ${TABLE}.broker_commission_aauicl),0));;
  }

  ### Measures

  measure: broker_covers_bds {
    label: "Broker Covers BDS"
    type: sum
    sql: ${TABLE}.broker_ind_bds ;;
    value_format_name: decimal_0
  }

  measure: broker_covers_cts {
    label: "Broker Covers CTS"
    type: sum
    sql: ${TABLE}.broker_ind_cts ;;
    value_format_name: decimal_0
  }

  measure: broker_covers_tot {
    label: "Broker Covers TOT"
    type: sum
    sql: ${TABLE}.broker_ind_bds + ${TABLE}.broker_ind_cts ;;
    value_format_name: decimal_0
  }

  measure: aauicl_covers_bds {
    label: "AAUICL Covers BDS"
    type: sum
    sql: ${TABLE}.aauicl_ind_bds ;;
    value_format_name: decimal_0
  }

  measure: aauicl_covers_cts {
    label: "AAUICL Covers CTS"
    type: sum
    sql: ${TABLE}.aauicl_ind_cts ;;
    value_format_name: decimal_0
  }

  measure: aauicl_covers_tot {
    label: "AAUICL Covers TOT"
    type: sum
    sql: ${TABLE}.aauicl_ind_bds + ${TABLE}.aauicl_ind_cts ;;
    value_format_name: decimal_0
  }

  measure: aauicl_policy_count {
    label: "AAUICL Policy Count"
    type: sum
    sql: greatest(${TABLE}.aauicl_ind_bds,${TABLE}.aauicl_ind_cts) ;;
    value_format_name: decimal_0
  }

  measure: cover_share_bds {
    label: "Cover Share BDS"
    type: number
    sql:  1.0*${aauicl_covers_bds}/nullif(${broker_covers_bds},0) ;;
    value_format_name: percent_1
  }

  measure: cover_share_cts {
    label: "Cover Share CTS"
    type: number
    sql:  1.0*${aauicl_covers_cts}/nullif(${broker_covers_cts},0) ;;
    value_format_name: percent_1
  }

  measure: cover_share_tot {
    label: "Cover Share TOT"
    type: number
    sql:  1.0*${aauicl_covers_tot}/nullif(${broker_covers_tot},0) ;;
    value_format_name: percent_1
  }

  measure: aauicl_net_premium_bds {
    label: "AAUICL Net Written Premium BDS"
    type: sum
    sql:  ${TABLE}.net_premium_aauicl_bds ;;
    value_format_name: decimal_0
  }

  measure: aauicl_net_premium_cts {
    label: "AAUICL Net Written Premium CTS"
    type: sum
    sql:  ${TABLE}.net_premium_aauicl_cts ;;
    value_format_name: decimal_0
  }

  measure: aauicl_net_premium_tot {
    label: "AAUICL Net Written Premium TOT"
    type: sum
    sql:  ${TABLE}.net_premium_aauicl_bds + ${TABLE}.net_premium_aauicl_cts ;;
    value_format_name: decimal_0
  }

  measure: aauicl_commission_bds {
    label: "Commission BDS"
    type: sum
    sql:  ${TABLE}.broker_commission_aauicl_bds ;;
    value_format_name: decimal_0
  }

  measure: aauicl_commission_cts {
    label: "Commission CTS"
    type: sum
    sql:  ${TABLE}.broker_commission_aauicl_cts ;;
    value_format_name: decimal_0
  }

  measure: aauicl_commission_tot {
    label: "Commission TOT"
    type: sum
    sql:  ${TABLE}.broker_commission_aauicl ;;
    value_format_name: decimal_0
  }

  measure: aauicl_rpm_buildings {
    label: "AAUICL RPM Buildings"
    type: sum
    sql:  ${TABLE}.buildings_aauicl_rpm ;;
    value_format_name: decimal_0
  }

  measure: aauicl_rpm_inf_buildings {
    label: "AAUICL RPM INF Buildings"
    type: sum
    sql:  ${TABLE}.buildings_aauicl_rpm_inf ;;
    value_format_name: decimal_0
  }

  measure: aauicl_rpm_wlc_buildings {
    label: "AAUICL RPM WLC Buildings"
    type: sum
    sql:  ${TABLE}.buildings_aauicl_rpm_wlc ;;
    value_format_name: decimal_0
  }

  measure: aauicl_rpm_wlu_buildings {
    label: "AAUICL RPM WLU Buildings"
    type: sum
    sql:  ${TABLE}.buildings_aauicl_rpm_wlu ;;
    value_format_name: decimal_0
  }

  measure: aauicl_rpm_contents {
    label: "AAUICL RPM Contents"
    type: sum
    sql:  ${TABLE}.contents_aauicl_rpm ;;
    value_format_name: decimal_0
  }

  measure: aauicl_rpm_inf_contents {
    label: "AAUICL RPM INF Contents"
    type: sum
    sql:  ${TABLE}.contents_aauicl_rpm_inf ;;
    value_format_name: decimal_0
  }

  measure: aauicl_rpm_wlc_contents {
    label: "AAUICL RPM WLC Contents"
    type: sum
    sql:  ${TABLE}.contents_aauicl_rpm_wlc ;;
    value_format_name: decimal_0
  }

  measure: aauicl_rpm_wlu_contents {
    label: "AAUICL RPM WLU Contents"
    type: sum
    sql:  ${TABLE}.contents_aauicl_rpm_wlu ;;
    value_format_name: decimal_0
  }

  measure: aauicl_rpm_total {
    label: "AAUICL RPM Total"
    type: sum
    sql:  ${TABLE}.buildings_aauicl_rpm + ${TABLE}.contents_aauicl_rpm ;;
    value_format_name: decimal_0
  }

  measure: aauicl_rpm_inf_total {
    label: "AAUICL RPM INF Total"
    type: sum
    sql:  ${TABLE}.buildings_aauicl_rpm_inf + ${TABLE}.contents_aauicl_rpm_inf ;;
    value_format_name: decimal_0
  }

  measure: aauicl_rpm_wlc_total {
    label: "AAUICL RPM WLC Total"
    type: sum
    sql:  ${TABLE}.buildings_aauicl_rpm_wlc + ${TABLE}.contents_aauicl_rpm_wlc ;;
    value_format_name: decimal_0
  }

  measure: aauicl_rpm_wlu_total {
    label: "AAUICL RPM WLU Total"
    type: sum
    sql:  ${TABLE}.buildings_aauicl_rpm_wlu + ${TABLE}.contents_aauicl_rpm_wlu ;;
    value_format_name: decimal_0
  }

  measure: average_rpm_buildings {
    label: "AAUICL Average RPM BDS"
    type: number
    sql:  ${aauicl_rpm_buildings}/nullif(${aauicl_covers_bds},0) ;;
    value_format_name: decimal_0
  }

  measure: average_rpm_contents {
    label: "AAUICL Average RPM CTS"
    type: number
    sql:  ${aauicl_rpm_contents}/nullif(${aauicl_covers_cts},0) ;;
    value_format_name: decimal_0
  }

  measure: average_rpm_total {
    label: "AAUICL Average RPM TOT"
    type: number
    sql:  ${aauicl_rpm_total}/nullif(${aauicl_covers_tot},0) ;;
    value_format_name: decimal_0
  }



  measure: net_loss_ratio {
    label: "AAUICL Net Modelled Loss Ratio"
    type: number
    sql:  1.0*${aauicl_rpm_total}/nullif(${aauicl_net_premium_tot},0) ;;
    value_format_name: percent_1

  }

  measure: gross_loss_ratio {
    label: "AAUICL Gross Modelled Loss Ratio"
    type: number
    sql:  1.0*${aauicl_rpm_total}/nullif((${aauicl_net_premium_tot}+${aauicl_commission_tot}),0) ;;
    value_format_name: percent_1
  }

  measure: net_loss_ratio_inf {
    label: "AAUICL Net Modelled Loss Ratio INF"
    type: number
    sql:  1.0*${aauicl_rpm_inf_total}/nullif(${aauicl_net_premium_tot},0) ;;
    value_format_name: percent_1

  }

  measure: gross_loss_ratio_inf {
    label: "AAUICL Gross Modelled Loss Ratio INF"
    type: number
    sql:  1.0*${aauicl_rpm_inf_total}/nullif((${aauicl_net_premium_tot}+${aauicl_commission_tot}),0) ;;
    value_format_name: percent_1
  }

  measure: net_loss_ratio_wlc {
    label: "AAUICL Net Modelled Loss Ratio WLC"
    type: number
    sql:  1.0*${aauicl_rpm_wlc_total}/nullif(${aauicl_net_premium_tot},0) ;;
    value_format_name: percent_1

  }

  measure: gross_loss_ratio_wlc {
    label: "AAUICL Gross Modelled Loss Ratio WLC"
    type: number
    sql:  1.0*${aauicl_rpm_wlc_total}/nullif((${aauicl_net_premium_tot}+${aauicl_commission_tot}),0) ;;
    value_format_name: percent_1
  }

  measure: net_loss_ratio_wlu {
    label: "AAUICL Net Modelled Loss Ratio WLU"
    type: number
    sql:  1.0*${aauicl_rpm_wlu_total}/nullif(${aauicl_net_premium_tot},0) ;;
    value_format_name: percent_1

  }

  measure: gross_loss_ratio_wlu {
    label: "AAUICL Gross Modelled Loss Ratio WLU"
    type: number
    sql:  1.0*${aauicl_rpm_wlu_total}/nullif((${aauicl_net_premium_tot}+${aauicl_commission_tot}),0) ;;
    value_format_name: percent_1
  }

  #### Plan Loss Ratio

  measure: record_ind {
    label: "record ind"
    type: sum
    sql: 1 ;;
    value_format_name: decimal_0
    hidden: yes
  }

  measure: plan_risk_score {
    label: "Plan Loss Ratio"
    type: sum
    sql: case when lk_h_policy_history.transaction_dttm  < (TIMESTAMP '2017-10-01') THEN 0.635 else 0.615 end ;;
    value_format_name: percent_1
    hidden: yes
  }

  measure: plan_loss_ratio {
    label: "Plan Loss Ratio"
    type: number
    sql:  ${plan_risk_score}/nullif(${record_ind},0);;
    value_format_name: percent_1
  }

}
