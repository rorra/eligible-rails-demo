$(document).ready ->
  $("#eligible_demographic_payer_id").select2
    allowClear: true
    blurOnChange: true
    placeholder: "Select a Payer"
    minimumInputLength: 3
    ajax:
      url: "/payers.json"
      dataType: "json"
      data: (term) ->
        q: term

      results: (data) ->
        results: data
    multile: false
    initSelection: (element, callback) ->
      callback(payer_id: $(element).val())
    formatResult: (payer) ->
      payer_names = null
      i = 0
      while i < payer.payer_names.length
        if payer_names
          payer_names += " | " + payer.payer_names[i].name
        else
          payer_names = payer.payer_names[i].name
        i++
      '<p style="margin-bottom: 4px;border-bottom: solid 1px;">' + payer.payer_id + ": " + payer_names + "</p>"

    formatSelection: (object) ->
      object.payer_id

    id: (object) ->
      object.payer_id

