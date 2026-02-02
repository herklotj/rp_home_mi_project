view: home_monthly_cdl {
  sql_table_name: aapricing.cdl_aauicl_in_force_polices_summary ;;

  dimension: inforce_year {
    label: "Inforce Year"
    type: number
    sql: ${TABLE}.inforce_year ;;
  }

  dimension: policy_cover {
    label: "Policy Cover"
    type: number
    sql: ${TABLE}.policy_cover ;;
  }

  measure: inforce_policies {
    label: "inforce_policies"
    type: number
    sql: ${TABLE}.sum_inforce_policies ;;
  }


  }
