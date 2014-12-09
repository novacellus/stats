source("cooc.R")

shinyServer(function(input, output) {
  
  
  #corpusName <-  input$corpusName
  #pivot <- input$query
  #attribute <- input$attribute
  #date <- "text_periode"
  
  output$plot_freqlem <- renderPlot({
    if (input$query != "") {
      freqlem(corp = input$corpusName , lm = input$query , date = "text_periode")
    }
    
  })
  output$plot_freqlem2 <- renderPlot({
    if (input$query != "") {
      freqlem2(corp = input$corpusName , lm = input$query , date = "text_periode")
    }
    
  })
  
  output$plot_stablem <- renderPlot({
    if (input$query != "") {
      stablem(corp = input$corpusName , lm = input$query )
    }
  })
  output$plot_freqfrm <- renderPlot({
    if (input$query != "") {
      freqfrm(corp = input$corpusName , frm = input$query )
    }
    
  })
  
  #Działa tylko, gdy input$query jest już zdefiniowane
  cooca <-  reactive ({
    validate(
      need( input$query != "", "Please type the word you want to look up") 
    )
    coocA(corp = input$corpusName, piv = input$query)
  })
  
  coocb <- reactive ({
    validate(
      need( input$query != "", "Please type the word you want to look up") 
    )
    coocB( cooca() )$plot2()
    
  })
  output$wordFreq_coocA <- renderDataTable({
    #outputOptions(output, "wordFreq_coocA", priority = 1)
    if (input$coocButton == 0) return ()
    #isolate ( {coocA(corp = input$corpusName, piv = input$query)$cooc1}  )
    #     isolate ({ cooca()$cooc1 })
    dev.new()
    titranal <- "ACP sur tableau des distances de Dice entre co-cooccurrents (corpus cible entier) + distances de Dice"
    opar <- par(mar=par("mar"))
    on.exit(par(opar))
    par(mar=c(0.5,0.5,1.7,0.5))
    (plot(T0[,1], T0[,2], type="n", xlab="", ylab="", axes=FALSE, frame.plot=TRUE))
    axis(side=1, labels=FALSE, tick=0)
    axis(side=2, labels=FALSE, tick=0)
    title(main = txtitr, line=1, cex.main=.8, font.main=1, adj = 0)
    mtext(titranal, 3, line=0,cex=.8, font=1, adj=0)
    segments(discor1[,4], discor1[,5], discor1[,6], discor1[,7], lwd=1.5, col="grey")
    segments(discor2[,4], discor2[,5], discor2[,6], discor2[,7], lwd=.4, col="grey")
    
    text(T0[,1], T0[,2], labels=row.names(T0), col=T0[,6], cex=cex)
    
    # calcul des points-lignes
    ttabsup <- t(tabsup)
    suplignes <- supcol(tab.pca, ttabsup)
    dev.off()
  })
  
  
  output$plot_coocB <- renderPlot({
    #if (input$query != "") {return()}
    #validate(need(exists(coocb),message = "coocb doesnt exist"))
    #png()
    isolate ({coocb()})
    #dev.off()
    #isolate ({ coocb() })
    #    isolate({
    #       b <- coocB( cooca() )
    #       outfile <- tempfile(fileext='.png')
    #       png(outfile, width=400, height=300)
    #       b$plot1()
    #       dev.off()
    #       list(src = outfile,
    #            contentType = 'image/png',
    #            width = 400,
    #            height = 300,
    #            alt = "This is alternate text")
    #       
    #     }) , deleteFile = FALSE
  })
  
  output$xxx <-renderPlot({
    #cooca()$xxx
  })
  #outputOptions(output, "wordFreq_coocA", priority = 1)
  #outputOptions(output, "plot_coocB", priority = 2)
})
