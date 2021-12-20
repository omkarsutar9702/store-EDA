library(shinydashboard)
library(shinydashboardPlus)

ui <- dashboardPage(skin = "midnight",
  dashboardHeader(title = "STORE EDA",
                  dropdownMenu(type = "messages",
                               messageItem(
                                 from = "Created By",
                                 message = "Omkar Sutar"
                               ))),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Home", tabName = "dashboard", icon = icon("home")),
      menuItem("Tab - 1" ,tabName = "tab2",icon = icon("chart-pie")),
      menuItem("Tab - 2", tabName = "tab3",icon = icon("chart-line"))
  )),
  dashboardBody(
    tags$style(
      '
        @media (min-width: 768px){
          .sidebar-mini.sidebar-collapse .main-header .logo {
              width: 230px; 
          }
          .sidebar-mini.sidebar-collapse .main-header .navbar {
              margin-left: 230px;
          }
        }
        '),
    tabItems(
      tabItem(tabName = "dashboard",
              fluidRow(
                tabBox(
                  title = "Histogram",
                  id = "tabset1",
                  tabPanel("Sales",plotOutput("plot1")),
                  tabPanel("Item", plotOutput("plot2")),
                  tabPanel("Year",plotOutput("plot3")),
                  tabPanel("Month",plotOutput("plot4"))),
                tabBox(
                  title = "Density Plot",
                  id = "tabset2",
                  tabPanel("Sales",plotOutput("plot5")),
                  tabPanel("Item", plotOutput("plot6")),
                  tabPanel("Year",plotOutput("plot7")),
                  tabPanel("Month",plotOutput("plot8"))),
                box(title = "Data Info" , solidHeader = T,
                    collapsible = T , plotOutput("plot9")),
                box(title = "Growth Of Sales Price By Date" , solidHeader = T,
                    collapsible = T , plotOutput("plot10"))
      )),
      tabItem(tabName = "tab2",
              fluidRow(
                box(title = "Rate Of Change Of Sales Price" , solidHeader = T,
                    collapsible = T , plotOutput("plot11")),
                box(title="The Growth of Sale Prices by Month of Year" , solidHeader = T,
                    collapsible = T , plotOutput("plot12")),
                box(title = "change of rate of sales price" , solidHeader = T,
                    collapsible = T , plotOutput("plot13")),
                box(title="The Growth of Sale Prices by Year" , solidHeader = T,
                    colllapsible=T , plotOutput("plot14"))
              )),
      tabItem(tabName = "tab3" , 
              fluidRow(
                box(solidHeader = T , collapsible = T , plotOutput("plot15"),
                    title = "Change rate of Sale Price"),
                box(solidHeader = T , collapsible = T , plotOutput("plot16"),
                    title = "The Growth of Sales Price by Store from 2013 - 2017"),
                box(solidHeader = T , collapsible = T , plotOutput("plot17"),
                    title = "The Growth of Sales Price by Store from 2013 - 2017"),
                box(solidHeader = T , collapsible = T , plotOutput("plot18"),
                    title = "Predictions")
              ))
    )
  )
)



