install.packages("ropenaq")
library(ropenaq)
library(ggplot2)
library(dplyr)
library(scales)
library(viridis)
library(plotly)
Chennai<-aq_locations(city = "Chennai")
Chennai_pm25<-aq_measurements(city = "Chennai",date_from = "2016-01-01", date_to = "2018-06-29", parameter = "pm25")
waste<-filter(Chennai_pm25,value == "-999")

new_data<-Chennai_pm25%>% filter(!value=="-999")
data<-Chennai_pm25 %>%
  filter(value != - 999) %>%
  group_by(day = as.Date(dateLocal), location) %>%
  summarize(average = mean(value))

data1<-data%>%filter(location=="Alandur Bus Depot, Chennai - CPCB")
p<-ggplot(data1) +
  geom_line(aes(x = day, y = average, col = location)) +
  scale_color_viridis(discrete = TRUE) +
  theme(legend.position = "none",
        strip.text.y = element_text(angle=0))+
  ylab(expression(paste("Average daily PM2.5 concentration (", mu, "g/",m^3,")"))) +
  xlab("Time (days)")
ggplotly(p)
