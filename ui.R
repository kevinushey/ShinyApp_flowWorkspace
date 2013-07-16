##/loc/no-backup/remote_fred_hvtn/RV144/CD4\ Cytokine\
##100 subjects 20 placebo (need to get study variables csv)
##query by and condition on study variables and plot sepcific populations
library(shinyIncubator)

shinyUI( bootstrapPage(
  
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
        div( class="sidebar",
          
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
        
        div( class="column-separator", '' ),
        
        ## main panel of displays
        div( class="mainpanel",
          
          div( class="subcontainer",
            
            div( class="left",
              
              ## gates
              div( id="gates",
                h4("Gates"),
                checkboxInput("stats", "Show Proportions?", value=TRUE),
                checkboxInput("isOverlay", "Overlay", value=FALSE),
                conditionalPanel("input.isOverlay == true",
                  uiOutput("overlayPopCntrol")
                ),
                actionButton("actPlotGate", "plot"),
                plotOutput("gate_plot")
              )
              
            ),
            
            div( class="column-separator", '' ),
            
            div( class="right",
              
              ## gate hierarchy
              div( id="gates",
                h4("Gate Hierarchy"),
                uiOutput("rootCntrol"),
                plotOutput("gh_plot")
              )
              
            )
            
          ),
          
          div( class="row-separator", '' ),
          
          div( class="subcontainer",
            
            div( class="left",
              
              div( id="stats",
                
                ## stats
                h4("Stats"),
                checkboxInput("boxplot", "boxplot", value=TRUE),
                uiOutput("axisCntrol"),
                actionButton("actPlotStats", "plot"),
                plotOutput("stats_plot", height="auto")
                
              )
            ),
            
            div( class="column-separator", '' ),
            
            div( class="right",
              div( id="summary",
                
                ## summary
                h4("Summary"),
                htmlOutput("summary")
                
              )
            )
            
            
          )
          
        ) ## span10
        
      )
      
    )
    
  )
  
) )