view: home_monthly_cdl {

  derived_table: {
    sql:
    select inforce_date,value
    from aapricing.home_monthly_cdl ;;}



    dimension: inforce_date {
      label: "Inforce Date"
      type: number
      sql: ${TABLE}.inforce_date;;
    }


    measure: inforce_policies {
      label: "Inforce Policies"
      type: number
      sql: ${TABLE}.value ;;
    }


  }
