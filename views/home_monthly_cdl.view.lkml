view: home_monthly_cdl {

  derived_table: {
    sql:
    select plh_event_type_sent,
    plh_name_of_policy_product,
    aa_affinity,
    insurer_nb_rb,
    cover_type,
    inforce_30_months_ago,
    inforce_29_months_ago,
    inforce_28_months_ago,
    inforce_27_months_ago,
    inforce_26_months_ago,
    inforce_25_months_ago,
    inforce_24_months_ago,
    inforce_23_months_ago,
    inforce_22_months_ago,
    inforce_21_months_ago,
    inforce_20_months_ago,
    inforce_19_months_ago,
    inforce_18_months_ago,
    inforce_17_months_ago,
    inforce_16_months_ago,
    inforce_15_months_ago,
    inforce_14_months_ago,
    inforce_13_months_ago,
    inforce_12_months_ago,
    inforce_11_months_ago,
    inforce_10_months_ago,
    inforce_9_months_ago,
    inforce_8_months_ago,
    inforce_7_months_ago,
    inforce_6_months_ago,
    inforce_5_months_ago,
    inforce_4_months_ago,
    inforce_3_months_ago,
    inforce_2_months_ago,
    inforce_at_end_of_last_month
    from aapricing.cdl_aauicl_in_force_polices_summary ;;}



    dimension: policy_cover {
      label: "Policy Cover"
      type: number
      sql: ${TABLE}.cover_type ;;
    }

    dimension: event_type_sent {
      label: "Event type sent"
      type: number
      sql: ${TABLE}.plh_event_type_sent ;;
    }

    dimension: tier {
      label: "Tier"
      type: number
      sql: ${TABLE}.plh_name_of_policy_product ;;
    }

    dimension: AA_Affinity{
      label: "AA Affinity"
      type: number
      sql: ${TABLE}.aa_affinity ;;
    }

    dimension: insurer_nb_rb{
      label: "Insurer NB or RB"
      type: number
      sql: ${TABLE}.insurer_nb_rb ;;
    }

    measure: inforce_policies {
      label: "inforce_policies"
      type: number
      sql: ${TABLE}.sum_inforce_policies ;;
    }


  }
