view: lk_h_cancel_history {
  derived_table: {
    sql:

    SELECT tia_reference,
       tia_customer_no,
       tia_transaction_no,
       uw_policy_no,
       status,
       policy_year,
       provenance_code,
       installment_flag,
       channel,
       broked_ind,
       inception_dt,
       tia_combined_reference,
       merlin_reference,
       membership_no,
       cover_type,
       cover_type_requested,
       annual_cover_start_dttm,
       annual_cover_end_dttm,
       schedule_cover_start_dttm,
       schedule_cover_end_dttm,
       renewal_date,
       transaction_dttm,
       original_inception_dttm,
       home_cover_level,
       nb_sw_flag,
       cfi_status,
       cfi_dttm,
       cfi_reason,
       cfi_ind_lapse_dttm,
       cfi_ind,
       cfi_ind_lapse,
       cfi_ind_lapse_bds,
       cfi_ind_lapse_cts,
       transaction_date,
       policy_start_date,
       policy_start_wk,
       policy_start_mth,
       policy_start_yr,
       policy_written_wk,
       policy_written_mth,
       policy_written_yr,
       broker_ind_bds,
       broker_ind_cts,
       broker_flag_joint,
       aauicl_ind_bds,
       aauicl_ind_cts,
       aauicl_flag_joint,
       aauicl_scheme,
       broker_nb_rb,
       insurer_nb_rb,
       aa_tenure,
       uw_tenure,
       aa_membership,
       addon_ind_hle,
       addon_commission_hle,
       addon_ind_hec,
       addon_commission_hec,
       addon_ind_her,
       addon_commission_her,
       mta_dttm,
       mta_ind,
       mta_add_net_written_premium,
       mta_add_undiscounted_commission,
       mta_add_ipt_amount,
       mta_add_flex_discount_amount,
       mta_add_woff_discount_amount,
       mta_add_iaf_commission_discount,
       mta_cov_bds,
       mta_cov_cts,
       mta_add_net_premium_bds,
       mta_add_net_premium_cts,
       mta_add_commission_bds,
       mta_add_commission_cts,
       net_written_premium,
       undiscounted_commission,
       ipt_amount,
       flex_discount_amount,
       woff_discount_amount,
       ipt_rate,
       iaf_amount_t AS iaf_amount,
       iaf_commission_discount,
       sect1_net_written_premium,
       sect2_net_written_premium,
       sect3_net_written_premium,
       sect3a_net_written_premium,
       sect4_net_written_premium,
       policy_mta_date,
       policy_mta_mth,
       policy_mta_yr,
       cover_type_customer,
       broker_iaf,
       broker_commission_t AS broker_commission,
       broker_commission_xfees_t AS broker_commission_xfees,
       broker_commission_woff,
       broker_commission_disc,
       broker_iaf_ipt,
       broker_lapse_disc,
       net_written_premium_bds,
       net_written_premium_cts,
       broker_commission_bds,
       broker_commission_cts,
       broker_lapse_disc_bds,
       broker_lapse_disc_cts,
       mta_add_broker_iaf,
       mta_add_broker_commission,
       mta_add_broker_commission_xfees,
       mta_add_broker_commission_woff,
       mta_add_broker_commission_disc,
       mta_add_broker_iaf_ipt,
       mta_add_broker_commission_bds,
       mta_add_broker_commission_cts,
       perc_broker_commission,
       perc_broker_commission_xfees,
       net_written_premium_aauicl,
       broker_commission_aauicl,
       mta_add_net_premium_aauicl,
       mta_add_commission_aauicl,
       mta_cov_aauicl_bds,
       mta_cov_aauicl_cts,
       net_premium_aauicl_bds,
       net_premium_aauicl_cts,
       broker_commission_aauicl_bds,
       broker_commission_aauicl_cts,
       mta_add_premium_aauicl_bds,
       mta_add_premium_aauicl_cts,
       mta_add_commission_aauicl_bds,
       mta_add_commission_aauicl_cts,
       net_written_premium_other,
       broker_commission_other,
       mta_add_net_premium_other,
       mta_add_commission_other,
       mta_cov_other_bds,
       mta_cov_other_cts,
       net_premium_other_bds,
       net_premium_other_cts,
       broker_commission_other_bds,
       broker_commission_other_cts,
       mta_add_premium_other_bds,
       mta_add_premium_other_cts,
       mta_add_commission_other_bds,
       mta_add_commission_other_cts,
       load_dttm,
       cancel_effective_dttm_t AS cancel_effective_dttm,
       cancel_reason,
       CASE
         WHEN cancel_reason = 0 THEN 'Not Cancelled'
         WHEN cancel_reason = 1 THEN 'Sold Property'
         WHEN cancel_reason = 3 THEN 'Autocancel - policy lines only'
         WHEN cancel_reason = 4 THEN 'Adjustment Decline - AQ Accepted'
         WHEN cancel_reason = 5 THEN 'Adjustment Decline - AQ Refused'
         WHEN cancel_reason = 10 THEN 'Policyholder Deceased'
         WHEN cancel_reason = 13 THEN 'Auto renewed in error'
         WHEN cancel_reason = 15 THEN 'Complaint'
         WHEN cancel_reason = 16 THEN 'Free Insurance'
         WHEN cancel_reason = 20 THEN 'Sold to wrong insurer'
         WHEN cancel_reason = 21 THEN 'Cheaper quote obtained'
         WHEN cancel_reason = 22 THEN 'Non-receipt of payment/documents'
         WHEN cancel_reason = 24 THEN '14-day cooling off'
         WHEN cancel_reason = 25 THEN 'Void Insurance'
         WHEN cancel_reason = 26 THEN 'NTU'
         WHEN cancel_reason = 27 THEN 'Lapse'
         WHEN cancel_reason = 29 THEN 'Unpaid Direct Debit'
         WHEN cancel_reason = 30 THEN 'Unpaid CC payment'
         WHEN cancel_reason = 36 THEN 'CC Policy Cancelled at Renewal'
         WHEN cancel_reason = 40 THEN 'Chargeback'
         WHEN cancel_reason = 57 THEN 'PolicyLine Cancel due to Upgrade'
         WHEN cancel_reason = 58 THEN 'Standard policy cancelled to setup an Enhanced Home policy'
         WHEN cancel_reason = 59 THEN 'Enhanced policy cancelled to setup an Standard Home policy'
         WHEN cancel_reason = 60 THEN 'Enhanced policy cancelled to setup an Home Plus policy'
         WHEN cancel_reason = 61 THEN 'Cancelled by Insurer'
         WHEN cancel_reason = 62 THEN 'Non-receipt of documents'
         WHEN cancel_reason = 63 THEN 'Non-receipt of payment'
         WHEN cancel_reason = 64 THEN 'Panel decline'
         WHEN cancel_reason IS NULL THEN 'No reason given'
         ELSE 'Unknown'
       END AS cancel_reason_desc_raw,
       CASE
         WHEN cancel_reason = 24 THEN '14-day cooling off'
         WHEN cancel_reason = 13 THEN 'Auto-renewed in error'
         WHEN cancel_reason in(25,61) THEN 'Cancelled by insurer'
         WHEN cancel_reason = 21 THEN 'Cheaper quote obtained'
         WHEN cancel_reason in(4,5,64) THEN 'MTA decline'
         WHEN cancel_reason is null THEN 'No payment made (CFI)'
         WHEN cancel_reason in(29,22,62,63) THEN 'Non-receipt of payment/documents'
         WHEN cancel_reason = 26 THEN 'NTU'
         WHEN cancel_reason in(3,15,16,20,27,55,57,58,59,60) THEN 'Other'
         WHEN cancel_reason = 10 THEN 'Policyholder deceased'
         WHEN cancel_reason = 1 THEN 'Sold property'
         ELSE 'Unknown'
       END AS cancel_reason_desc,
       CASE
         WHEN cancel_reason = 21 THEN 'Better terms elsewhere'
         WHEN cancel_reason = 25 THEN 'Cancelled by firm (fraud)'
         WHEN cancel_reason in(61,62) THEN 'Cancelled by firm (misinterpretation)'
         WHEN cancel_reason in(4,5,64) THEN 'Cancelled by firm (significant change in risk)'
         WHEN cancel_reason in(22,29,30,37,63) or cancel_reason is null THEN 'Cancelled by firm (unpaid premium)'
         WHEN cancel_reason = 10 THEN 'Deceased'
         WHEN cancel_reason = 15 THEN 'Dissatisfication with service'
         WHEN cancel_reason in(1,24,26) THEN 'No longer required'
         WHEN cancel_reason in(3,16,20,40,57,58,59,60) THEN 'Other'
         WHEN cancel_reason in(13,27,36) THEN 'Unwanted renewal'
         ELSE 'Unknown'
       END AS cancel_reason_gfsc,
      CASE
         WHEN cancel_reason = 24 or cancel_reason is null then 'Yes'
         ELSE 'No'
       END AS cancel_coolingoff_gfsc,
       policy_cancel_date_t AS policy_cancel_date,
       policy_cancel_mth_t AS policy_cancel_mth,
       policy_cancel_yr_t AS policy_cancel_yr,
       policy_cancel_notified_mth_t AS policy_cancel_notified_mth,
       policy_cancel_notified_yr_t AS policy_cancel_notified_yr,
       cancel_cooling,
       cancel_cooling_bds,
       cancel_cooling_cts,
       time_on_risk,
       broker_ind_bds*time_on_risk AS broker_tor_bds,
       broker_ind_cts*time_on_risk AS broker_tor_cts,
       aauicl_ind_bds*time_on_risk AS aauicl_tor_bds,
       aauicl_ind_cts*time_on_risk AS aauicl_tor_cts,
       case when cancel_reason in(13,25,26,27,30,36,40) then net_written_premium else net_written_premium*(1 - time_on_risk) end AS net_cancelled_premium,
       case when cancel_reason in(13,25,26,27,30,36,40) then net_written_premium_bds else net_written_premium_bds*(1 - time_on_risk) end AS net_cancelled_premium_bds,
       case when cancel_reason in(13,25,26,27,30,36,40) then net_written_premium_cts else net_written_premium_cts*(1 - time_on_risk) end AS net_cancelled_premium_cts,
       case when cancel_reason in(13,25,26,27,30,36,40) then net_written_premium_aauicl else net_written_premium_aauicl*(1 - time_on_risk) end AS net_cancelled_premium_aauicl,
       case when cancel_reason in(13,25,26,27,30,36,40) then net_premium_aauicl_bds else net_premium_aauicl_bds*(1 - time_on_risk) end AS net_can_premium_aauicl_bds,
       case when cancel_reason in(13,25,26,27,30,36,40) then net_premium_aauicl_cts else net_premium_aauicl_cts*(1 - time_on_risk) end AS net_can_premium_aauicl_cts,
       case when cancel_reason in(13,25,26,27,30,36,40) then broker_commission_xfees_t else broker_commission_xfees_t*(1 - time_on_risk) end AS cancelled_broker_commission_xfees

FROM (SELECT c.*,
             CASE
               WHEN cfi_ind_lapse = 1 THEN annual_cover_start_dttm
               ELSE cancel_effective_dttm
             END AS cancel_effective_dttm_t,
             CASE
               WHEN cfi_ind_lapse = 1 THEN CAST(cfi_ind_lapse_dttm,ansidate)
               ELSE policy_cancel_date
             END AS policy_cancel_date_t,
             CASE
               WHEN cfi_ind_lapse = 1 THEN CAST(DATE_TRUNC ('MONTH',cfi_ind_lapse_dttm),ansidate)
               ELSE policy_cancel_mth
             END AS policy_cancel_mth_t,
             CASE
               WHEN cfi_ind_lapse = 1 THEN date_part ('year',cfi_ind_lapse_dttm)
               ELSE policy_cancel_yr
             END AS policy_cancel_yr_t,
             CASE
               WHEN cfi_ind_lapse = 1 THEN CAST(DATE_TRUNC ('MONTH',cfi_ind_lapse_dttm),ansidate)
               ELSE policy_cancel_notified_mth
             END AS policy_cancel_notified_mth_t,
             CASE
               WHEN cfi_ind_lapse = 1 THEN date_part ('year',cfi_ind_lapse_dttm)
               ELSE policy_cancel_notified_yr
             END AS policy_cancel_notified_yr_t,
             CASE
               WHEN cfi_ind_lapse = 1 THEN 0
               ELSE broker_commission
             END AS broker_commission_t,
             CASE
               WHEN cfi_ind_lapse = 1 THEN 0
               ELSE broker_commission_xfees
             END AS broker_commission_xfees_t,
             CASE
               WHEN cfi_ind_lapse = 1 THEN 0
               ELSE iaf_amount
             END AS iaf_amount_t,
             ((CASE
               WHEN cfi_ind_lapse = 1 THEN annual_cover_start_dttm
               ELSE cancel_effective_dttm
             END) - annual_cover_start_dttm) /(annual_cover_end_dttm - annual_cover_start_dttm) AS time_on_risk
      FROM (SELECT a.*,
                   b.cancel_effective_dttm,
                   b.cancel_reason,
                   b.policy_cancel_date,
                   b.policy_cancel_mth,
                   b.policy_cancel_yr,
                   b.policy_cancel_notified_mth,
                   b.policy_cancel_notified_yr,
                   b.cancel_cooling,
                   b.cancel_cooling_bds,
                   b.cancel_cooling_cts
            FROM (SELECT *
                  FROM actian.lk_h_policy_history
                  WHERE schedule_cover_start_dttm = annual_cover_start_dttm
                  AND   cfi_ind = 0) a
              LEFT JOIN actian.lk_h_cancel_history b
                     ON a.tia_reference = b.tia_reference
                    AND a.annual_cover_start_dttm = b.annual_cover_start_dttm) c) d
WHERE cancel_effective_dttm_t IS NOT NULL

    ;; }

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

  dimension: cancel_reason_desc {
    type: string
    sql: ${TABLE}.cancel_reason_desc ;;
  }

  dimension: cancel_reason_gfsc {
    type: string
    sql: ${TABLE}.cancel_reason_gfsc ;;
  }

  dimension: cancel_coolingoff_gfsc {
    type: string
    sql: ${TABLE}.cancel_coolingoff_gfsc ;;
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
    type: string
    sql: ${TABLE}.tia_customer_no ;;
  }

  dimension: tia_reference {
    type: string
    sql: ${TABLE}.tia_reference ;;
  }

  dimension: tia_transaction_no {
    type: string
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

  dimension: cfi_ind_lapse {
    type: number
    sql: ${TABLE}.cfi_ind_lapse ;;
  }

  dimension: cfi_ind {
    type: number
    sql: ${TABLE}.cfi_ind ;;
  }

  dimension: time_on_risk_banded {
    label: "Time on Risk (Banded)"
    type: tier
    tiers: [0.05,0.1,0.15,0.2,0.25,0.3,0.35,0.4,0.45,0.5,0.55,0.6,0.65,0.7,0.75,0.8,0.85,0.9,0.95,1]
    style: classic
    sql: ${TABLE}.time_on_risk ;;
  }

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

  measure: broker_tor_bds {
    label: "Broker TOR BDS"
    type: sum
    sql: ${TABLE}.broker_tor_bds ;;
    value_format_name: decimal_0
  }

  measure: broker_tor_cts {
    label: "Broker TOR CTS"
    type: sum
    sql: ${TABLE}.broker_tor_cts ;;
    value_format_name: decimal_0
  }

  measure: broker_tor_tot {
    label: "Broker TOR TOT"
    type: sum
    sql: ${TABLE}.broker_tor_bds + ${TABLE}.broker_tor_cts ;;
    value_format_name: decimal_0
  }

  measure: aauicl_tor_bds {
    label: "AAUICL TOR BDS"
    type: sum
    sql: ${TABLE}.aauicl_tor_bds ;;
    value_format_name: decimal_0
  }

  measure: aauicl_tor_cts {
    label: "AAUICL TOR CTS"
    type: sum
    sql: ${TABLE}.aauicl_tor_cts ;;
    value_format_name: decimal_0
  }

  measure: aauicl_tor_tot {
    label: "AAUICL TOR TOT"
    type: sum
    sql: ${TABLE}.aauicl_tor_bds + ${TABLE}.aauicl_tor_cts ;;
    value_format_name: decimal_0
  }

  measure: aauicl_net_can_prem_bds {
    label: "AAUICL Net Cancelled Premium BDS"
    type: sum
    sql: -1.0*${TABLE}.NET_CAN_PREMIUM_AAUICL_BDS ;;
    value_format_name: decimal_0
  }

  measure: aauicl_net_can_prem_cts {
    label: "AAUICL Net Cancelled Premium CTS"
    type: sum
    sql: -1.0*${TABLE}.NET_CAN_PREMIUM_AAUICL_CTS ;;
    value_format_name: decimal_0
  }

  measure: aauicl_net_can_prem_tot {
    label: "AAUICL Net Cancelled Premium TOT"
    type: sum
    sql: -1.0*${TABLE}.net_cancelled_premium_aauicl ;;
    value_format_name: decimal_0
  }

  measure: aauicl_net_written_prem_tot {
    label: "AAUICL Net Written Premium TOT"
    type: sum
    sql: ${TABLE}.net_premium_aauicl_bds + ${TABLE}.net_premium_aauicl_cts ;;
    value_format_name: decimal_0
  }

  measure: broker_canc_commission_xfees {
    label: "Broker Cancelled Commission (exc. Fees)"
    type: sum
    sql: -1.0*${TABLE}.cancelled_broker_commission_xfees ;;
    value_format_name: decimal_0
  }

  measure: cancelled_gross_premium_xfees  {
    label: "Cancelled Gross Premium (exc. Fees)"
    type: sum
    sql: -1.0*(${TABLE}.net_cancelled_premium_aauicl+${TABLE}.cancelled_broker_commission_xfees) ;;
    value_format_name: decimal_0
  }

  measure: cancelled_transaction_premium_xfees  {
    label: "Cancelled Transaction Premium (exc. Fees)"
    type: sum
    sql: -1.0*(${TABLE}.net_cancelled_premium_aauicl+${TABLE}.cancelled_broker_commission_xfees)*(1+${TABLE}.ipt_rate) ;;
    value_format_name: decimal_0
  }





  measure: count {
    type: count
    drill_fields: []
  }
}
