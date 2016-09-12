#
# This is a Shiny web application for plotting 3D data sets. You can run the application by clicking
# the 'Run App' button above.
#

#Disable warnings
options(warn=-1)

library(shiny)
library(rgl)

# Window Resize for Plot3D
par3d(windowRect = c(25, 25, 800, 800))

# Manual import for data -- if using this, change nodes$xcoord to data$xcoord
data <- read.csv(file = "/Users/gui/Desktop/Fear199localeq.nodes.csv", sep = ",")
data2 <- read.csv(file = "/Users/gui/Desktop/examplenode2.csv", sep = ",")

# Define UI for application that draws the 3D plot
ui <- shinyUI(fluidPage(
   
   # Application title
   titlePanel("3D Plotted Data in Shiny"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
         fileInput('nodesCSV','Choose nodes CSV',
                   accept =c('text/csv',
                             'text/comma-separated-values, text/plain',
                             '.csv'))
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
         plotOutput("ThreeDPlot"),
         textOutput("dynamic")
      )
   )
))

# Define server logic required to draw the 3D image
server <- shinyServer(function(input, output) {
   myNodes <- reactive({
     inFile <- input$nodesCSV
     if (is.null(inFile)) { return(NULL) }
     fromCSV <- read.csv(inFile$datapath)
   })
   
   output$previewTable <- renderTable({
   }) #unused, debugger
  
   output$ThreeDPlot <- renderPlot({
      x0 <- 0
      y0 <- 0
      z0 <- 0
      
      nodes <- as.data.frame(myNodes())
      
      # generate ThreeDPlot based on input$nodes from ui.R
      x0 <- nodes$xcoord
      y0 <- nodes$ycoord
      z0 <- nodes$zcoord
      
      # x1 <- data2$xcoord  UNUSED
      # y1 <- data2$ycoord  UNUSED
      # z1 <- data2$zcoord  UNUSED
       
      # draw the ThreeDPlot with the specified edges
      plot3d(x0, y0, z0)

   })
   
   output$dynamic <- renderText({
   })
})

# Run the application 
shinyApp(ui = ui, server = server)

