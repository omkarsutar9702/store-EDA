library(shiny)
library(shinydashboard)
source("data.R")


server <- function(input, output) {
  
  thematic::thematic_shiny()
  
  output$plot1 <- renderPlot({
    ggplot(train , aes(x=sales))+
      geom_histogram(fill="#e384d1")+
      labs(x=NULL , y=NULL)+theme_void()
  })
  output$plot2 <- renderPlot({
    ggplot(train , aes(x=item))+
      geom_histogram(fill="#e384d1")+
      labs(x=NULL , y=NULL)+theme_void()
    })
  output$plot3 <- renderPlot({
    ggplot(train , aes(x=year))+
      geom_histogram(fill="#e384d1")+
      labs(x=NULL , y=NULL)+theme_void()
  })
  output$plot4 <- renderPlot({
    ggplot(train , aes(x=month))+
      geom_histogram(fill="#e384d1")+
      labs(x=NULL , y=NULL)+theme_void()
  })
  output$plot5 <- renderPlot({
      ggplot(train , aes(x=sales))+
        geom_density(fill="#22521b")+
        labs(x=NULL , y=NULL)+theme_void()
    })
    output$plot6 <- renderPlot({
      ggplot(train , aes(x=item))+
        geom_density(fill="#22521b")+
        labs(x=NULL , y=NULL)+theme_void()
  })
    output$plot7 <- renderPlot({
      ggplot(train , aes(x=year))+
        geom_density(fill="#22521b")+
        labs(x=NULL , y=NULL)+theme_void()
    })
    output$plot8 <- renderPlot({
      ggplot(train , aes(x=month))+
        geom_density(fill="#22521b")+
        labs(x=NULL , y=NULL)+theme_void()
    })
    output$plot9 <- renderPlot({
      plot(train %>% plot_intro()+theme_minimal())
    })
    output$plot10 <- renderPlot({
      growth1 <- ggplot(msp , aes(x=as.factor(date) , y=sales))+
        geom_line(color="#6c92b8",aes(group=1), size=1.5)+
        geom_point(color="#5d256b" , size=3)+
        labs(x= NULL , y="sales price")+
        theme_void()
      growth1
    })
    output$plot11 <- renderPlot({
      growth2 <- ggplot(msp , aes(x=as.factor(date) , y=rate))+
        geom_line(color="#6c92b8",aes(group=1), size=1.5)+
        geom_point(color="#5d256b" , size=3)+
        geom_hline(yintercept = 0)+
        labs(x =NULL , y="sales price")+theme_minimal()
      growth2
    })
    output$plot12 <- renderPlot({
      monthgro <- ggplot(msp2 , aes(x=as.factor(month) , y=sales))+
        geom_line(color="#193ea6" , size=1.5, aes(group=1))+
        geom_point(color="#f4fc05" , size=3)+
        labs(x=NULL,y="sales price")+
        theme_minimal()+theme(axis.text.x = element_text(angle = 90, vjust = 1, hjust=1))
      monthgro  
    })
    output$plot13 <- renderPlot({
      monthgro2 <-ggplot(msp2 , aes(x=as.factor(month) , y=rate))+
        geom_line(color="#e64747" , size=1.5 ,aes(group=1))+
        labs( x=NULL , y="sales price")+
        geom_hline(yintercept = 0)+theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))
      monthgro2
    })
    output$plot14 <- renderPlot({
      yeargro <- ggplot(msp3 , aes(x=as.factor(year) , y=sales))+
        geom_line(color="#e64747" , aes(group=1) , size=1.5)+
        geom_point(color="#5d256b" , size=3)+
        labs( x=NULL , y="sales price")+
        theme_minimal()
      yeargro
    })
    output$plot15 <- renderPlot({
      yeargro2 <- ggplot(msp3 , aes(x=as.factor(year) , y=rate))+
        geom_line(color="#181ec9" , aes(group=1) , size=1.5)+
        geom_point(color="#e64747" , size=3)+
        labs( x="Year", y="rate of change")+
        geom_hline(yintercept = 0)+theme_minimal()
      yeargro2
    })
    output$plot16 <- renderPlot({
      storegro <- ggplot(year_state , aes(group=store))+
        geom_line(aes(x=year , y=sales , color=store) , show.legend =F)+
        labs(x=NULL)+
        theme_minimal()
      storegro
    })
    output$plot17 <- renderPlot({
      itemgro <- ggplot(year_state2 , aes(group=item))+
        geom_line(aes(x=year , y=sales , color=item ) , show.legend = F)+
        labs( x= NULL)+
        theme_minimal()
      itemgro
    })
    output$plot18 <- renderPlot({
      plot(model , forecast)
    })
}









