##/loc/no-backup/remote_fred_hvtn/RV144/CD4\ Cytokine\
##100 subjects 20 placebo (need to get study variables csv)
##query by and condition on study variables and plot sepcific populations
library(shinyIncubator)
library(shinyGridster)

width <- 500
height <- 250

marginx <- 16
marginy <- 16

shinyUI( bootstrapPage(
  
  ## fancybox
  includeCSS("www/fancybox/jquery.fancybox.css"),
  includeScript("www/fancybox/jquery.fancybox.pack.js"),
  includeScript("www/js/fancybox_scripts.js"),
  
  ## personal styles
  includeCSS("www/css/styles.css"),
  
  with( tags,
    
    div( class="cont",
      
      ## title
      div( class="header",
        h1( textOutput("titleCntrol") )
      ),
      
      ## main part of the app
      div( class="main",
        
        ## left sidebar -- filters and things
        div( class="sidebar", style=paste0("margin-top: ", marginy, "px;"),
          
          ## select a study to visualize
          selectInput("study", "Studies:",
            choices=studies,
            selected=studies[1]
          ),
          
          uiOutput("FilterControls"),
          uiOutput("popCntrol"),
          uiOutput("groupCntrol"),
          checkboxInput("oneLevel", "Convert to one level:",
            value=FALSE
          ),
          uiOutput("condCntrol"),
          checkboxInput("custlayout", "Custom grid layout", value=FALSE),
          conditionalPanel("input.custlayout == true",
            uiOutput("rowsControl"),
            uiOutput("columnsControl")
          ),
          
          checkboxInput("custWinSize", "Custom Plot Size", value=FALSE),
          
          conditionalPanel("input.custWinSize == true",
            #uiOutput("widthControl"),
            uiOutput("heightControl")
          )
          
        ), ## end filters
        
        div( class="gridster-container",
          gridster( width=width, height=height, marginx=marginx, marginy=marginy,
            
            ## Gates
            gridsterItem(row=1, col=1, sizex=1, sizey=3, 
              
              checkboxInput("stats", "Show Proportions?", value=TRUE),
              checkboxInput("isOverlay", "Overlay", value=FALSE),
              conditionalPanel( "input.isOverlay == true",
                uiOutput("overlayPopCntrol")
              ),
              actionButton("actPlotGate", "plot"),
              div(
                plotOutput("gate_plot", width=width, height=height*3-70)
              )
            ),
            
            ## Gate Hierarchy
            gridsterItem(row=1, col=2, sizex=1, sizey=1,
              uiOutput("rootCntrol"),
              plotOutput("gh_plot", width=width, height=height-70) ## compenstate for uiOutput
            ),
            
            ## Stats
            gridsterItem(row=2, col=2, sizex=1, sizey=1,
              
              div(
                div( id="stats-controls",
                  checkboxInput("boxplot", "boxplot", value=TRUE),
                  uiOutput("axisCntrol"),
                  actionButton("actPlotStats", "plot")
                ),
                plotOutput("stats_plot", width=width, height=height-70)
              )
            ),
            
            ## Summary
            gridsterItem(row=3, col=2, sizex=1, sizey=1,
              htmlOutput("summary")
            )
            
          ) ## end gridster
          
        ) ## end gridster-container
        
      )
      
    )
    
  ) 
  
) )