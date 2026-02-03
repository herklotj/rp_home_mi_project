view: v_home_claims_fca {
 derived_table: {
   sql:

    select source,
    claim_no,
    uw_policy_no,
    policy_platform,
    policy_product,
    policy_cover,
    policy_inception_dttm,
    policy_start_dttm,
    uw_year,
    fuw_year,
    chargeable_incident,
    claim_stage,
    claim_status,
    claim_cover,
    claim_peril,
    incident_dttm,
    notification_dttm,
    latest_closure_reason,
    first_closed_dttm,
    latest_closed_dttm,
    reopened_ind,
    postcode,
    total_incurred,
    fca_incident_ind,
    fca_registered_claim,
    fca_walkaway,
    fca_fraud,
    fca_voidance,
    fca_accepted_paid,
    fca_rejected,
    fca_not_reported,
    fca_accepted_paid_amount,
    fca_rejected_reason,
    grumble_ind,
    grumble_count,
    grumble_upheld,
    informal_complaint_ind,
    informal_complaint_count,
    informal_complaint_upheld,
    formal_complaint_ind,
    formal_complaint_count,
    formal_complaint_upheld,
    fos_complaint_ind,
    fos_complaint_count,
    fos_complaint_upheld,
    fca_complaint_ind,
    fca_complaint_count,
    fca_complaint_upheld
    from aapricing.v_home_claims_fca;;
 }

  dimension: claim_source {
    label: "Claim Source"
    type: string
    sql: ${TABLE}.source ;;
  }

  dimension: uw_year {
    label: "Policy UW Year"
    type: number
    sql: ${TABLE}.uw_year;;
  }

  dimension: fuw_year{
    label: "Policy FUW Year"
    type: number
    sql: ${TABLE}.fuw_year ;;
  }

  dimension: chargeable_incident {
    label: "Chargeable Incident"
    type: number
    sql:  ${TABLE}.chargeable_incident ;;
  }

  dimension: claim_status {
    label: "Status"
    type: string
    sql: ${TABLE}.claim_status ;;
  }

  dimension: claim_cover {
    label: "Cover Type"
    type: string
    sql: ${TABLE}.claim_cover ;;
  }

  dimension: claim_peril {
    label: "Peril"
    type: string
    sql: ${TABLE}.claim_peril ;;
  }

  dimension_group: notificationmonth {
    label: "FNOL Month"
    type: time
    timeframes: [
      month,
      quarter,
      year
    ]
    sql: CAST(${TABLE}.notificationmonth AS TIMESTAMP WITHOUT TIME ZONE) ;;
    group_label: "Dates"
  }

  dimension: claim_fee_rate {
    type: number
    sql: case when (CAST(${TABLE}.notificationmonth AS TIMESTAMP WITHOUT TIME ZONE)  < (TIMESTAMP '2020-02-01')) then 175
              when (CAST(${TABLE}.notificationmonth AS TIMESTAMP WITHOUT TIME ZONE)  < (TIMESTAMP '2021-07-01')) then 210
              when (CAST(${TABLE}.notificationmonth AS TIMESTAMP WITHOUT TIME ZONE)  < (TIMESTAMP '2024-02-01')) then 200 else
              220 end ;;
    hidden: no
    value_format_name: decimal_0
  }

  measure: claims_handing_fee {
    label: "Claims Handling Fee"
    type: sum
    sql: ${claim_fee_rate}*${chargeable_incident} ;;
    value_format_name: gbp_0
    group_label: "Incurred"
    }

  }
