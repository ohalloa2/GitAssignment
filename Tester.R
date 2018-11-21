install.packages("plotly")
library(plotly)

#Large Data Visualisation

trace1 <- list(
  x = c("C", "C++", "Haskell", "HTML", "JavaScript", "Python", "Ruby"), 
  y = c("51950.8032407407", "42883.8586956522", "3999.08417041912", "21935.3890020367", "8082.99825935596", "10083.0232240437", "8368.81355932203"), 
  marker = list(
    cauto = TRUE, 
    cmax = 7, 
    cmin = 1, 
    colorscale = list(c(0, "rgb(220,220,220)"),list(0.2, "rgb(245,195,157)"),list(0.4, "rgb(245,160,105)"),list(1, "rgb(178,10,28)"))
  ), 
  name = "average_size", 
  text = c("432", "460", "2887", "491", "3447", "732", "413"), 
  textsrc = "reillyp6:0:7e98de", 
  type = "bar", 
  uid = "b20b17", 
  xcalendar = "chinese", 
  xsrc = "reillyp6:0:4f61e5", 
  ysrc = "reillyp6:0:77a8ed"
)
data <- list(trace1)
layout <- list(
  autosize = TRUE, 
  boxmode = "group", 
  hovermode = "closest", 
  ternary = list(aaxis = list(title = "")), 
  title = "Average size in KB of repositories across a number of languages (large data-set)", 
  xaxis = list(
    autorange = TRUE, 
    range = c(-0.5, 6.5), 
    title = "Programming Language", 
    type = "category"
  ), 
  yaxis = list(
    autorange = TRUE, 
    range = c(0, 54685.0560429), 
    title = "Average size of Repository", 
    type = "linear"
  )
)
p <- plot_ly()
p <- add_trace(p, x=trace1$x, y=trace1$y, marker=trace1$marker, name=trace1$name, text=trace1$text, textsrc=trace1$textsrc, type=trace1$type, uid=trace1$uid, xcalendar=trace1$xcalendar, xsrc=trace1$xsrc, ysrc=trace1$ysrc)
p <- layout(p, autosize=layout$autosize, boxmode=layout$boxmode, hovermode=layout$hovermode, ternary=layout$ternary, title=layout$title, xaxis=layout$xaxis, yaxis=layout$yaxis)

#Medium Data Visualiasation

library(plotly)
trace1 <- list(
  x = c("C", "CSS", "HTML", "Java", "JavaScript", "Objective-C", "Python", "R", "Ruby"), 
  y = c("24683.6036036036", "19450.8611111111", "28819.3945945946", "40631.4106280193", "16206.3790426908", "31141.9115044248", "10264.5115207373", "22247", "4446.20353982301"), 
  name = "average_size", 
  type = "bar", 
  uid = "fcb2a5", 
  xsrc = "reillyp6:2:b563cd", 
  ysrc = "reillyp6:2:0ad154"
)
data <- list(trace1)
layout <- list(
  hovermode = "closest", 
  title = "Average size in KB of repositories across a number of languages (medium data-set)", 
  xaxis = list(
    autorange = TRUE, 
    range = c(-0.5, 8.5), 
    title = "Programming Language", 
    type = "category"
  ), 
  yaxis = list(
    autorange = TRUE, 
    range = c(0, 42769.9059242), 
    title = "Average size of Repository", 
    type = "linear"
  )
)
p <- plot_ly()
p <- add_trace(p, x=trace1$x, y=trace1$y, name=trace1$name, type=trace1$type, uid=trace1$uid, xsrc=trace1$xsrc, ysrc=trace1$ysrc)
p <- layout(p, hovermode=layout$hovermode, title=layout$title, xaxis=layout$xaxis, yaxis=layout$yaxis)

#Small Data Visualisation

library(plotly)
trace1 <- list(
  x = c("C", "C++", "Java", "JavaScript", "Python"), 
  y = c("337478", "395288", "781245", "325042", "753430"), 
  name = "total_kb", 
  type = "bar", 
  uid = "0468cb", 
  xsrc = "reillyp6:4:dde139", 
  ysrc = "reillyp6:4:a0b50d"
)
data <- list(trace1)
layout <- list(
  hovermode = "closest", 
  title = "Average size in KB of repositories across a number of languages (small data_set)", 
  xaxis = list(
    autorange = TRUE, 
    range = c(-0.5, 4.5), 
    title = "Programming Language", 
    type = "category"
  ), 
  yaxis = list(
    autorange = TRUE, 
    range = c(0, 822363.157895), 
    title = "Average Size of Repository", 
    type = "linear"
  )
)
p <- plot_ly()
p <- add_trace(p, x=trace1$x, y=trace1$y, name=trace1$name, type=trace1$type, uid=trace1$uid, xsrc=trace1$xsrc, ysrc=trace1$ysrc)
p <- layout(p, hovermode=layout$hovermode, title=layout$title, xaxis=layout$xaxis, yaxis=layout$yaxis)