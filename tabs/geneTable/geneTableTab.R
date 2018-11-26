geneTableTab <- function (input, output, session, geneTable, filteredCallTable) {

  callModule(tableDownload, "geneDownload", geneTable, "genes-")

  output$geneTable <- DT::renderDataTable({
    req(geneTable())

    return(DT::datatable(geneTable(),
                         selection = "single",
                         style = "bootstrap",
                         class = DT:::DT2BSClass(c("hover", "stripe")))
    )
  })

  observeEvent(input$geneTable_rows_selected,
               geneExpressionModal(
                 geneTable()[input$geneTable_rows_selected, Symbol],
                 filteredCallTable,
                 input,
                 output,
                 "geneTableTab")
  )

  observeEvent(input$modalOkBtn, {
    removeModal()
  })

}