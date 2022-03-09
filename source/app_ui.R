# shiny app ui

library("shiny")
library("shinythemes")
library(tidyverse)
library(ggplot2)
library(maps)
library(plotly)

intro_page <- tabPanel(
  "Introduction",
  titlePanel(h1("Life Expectancy")),
  br(),
  sidebarLayout(
    sidebarPanel(
      img(src = "education.jpg"),
      img(src = "vaccine.png"),
      img(src = "gdp.png")
    ),
    mainPanel(
      h3("What is Life Expectancy?"),
      hr(),
      p("Life expectancy is a measure of how long the average person lives, and is a 
        different recorded number globally. Different factors can be contributed to this, 
        such as, health, social class, and economic status."),
      
      br(),
      
      h3("Why is Life Expectancy Important?"),
      hr(),
      p("The importance of researching what contributes to life expectancy is due to the fact
        that this information can be applied to improve quality of life and ultimately, 
        life expectancy. This can be seen as expectionally crucial when observing countries
        that have to yet to surpass a life expectancy of 65 years in some developing countries."),
    
      br(),
      
      
      h3("What is Being Specifically Answering?"),
      hr(),
      p("Through data collected by ", tags$a(href = "https://www.who.int/", "WHO"), ", which was then gathered into a dataset on ", 
        tags$a(href = "https://www.kaggle.com/kumarajarshi/life-expectancy-who", "Kaggle"), " by 
        Kumar Rajarshi, we decided to focus on more global factors - including years of
        education, population vaccinations, and the GDP of the country. The questions driving 
        the report and its calculations are whether these factors have an effect on the life 
        expectancy of a population, and if so, how great is the association?"),
    
      br(),
      
      h3("How are these Questions Going to be Answered"),
      hr(),
      p("Our research questions will be answered through comparisons made within the Kaggle
        dataset. Values such as the life expectancy of a country and its respecitive average
        years of education, vaccination throughout the population, and GDP will be used."),
    
      br(),
      
      h3("What can be Achieved Through This?"),
      hr(),
      p("With the results found, actions towards increasing life expectancy in places suffering
        with low expectancies can be aided to improve such factors. Realizations can also be
        made about what and how these factors impact life expectancy, instead of pinning it
        mainly on personal health and diet."),
    ),
  ),
)

schooling_page <- tabPanel(
  "Education",
  titlePanel(h2("Years of Schooling and Life Expectancy")),
  br(),
  sidebarLayout(
    sidebarPanel(
      selectInput(
        inputId = "color_input",
        label = h3("Graph Color"),
        choices = c("Red" = "#bf877e", "Blue" = "#8b95c9", "Green" = "#8DB996", 
                    "Purple" = "#7D5BA6", "Pink" = "#D65780", "Black" = "#3E3F3A"),
      ),
      sliderInput(
        inputId = "restrict",
        label = h3("Years Selected"), min = 1, max = 20, value = c(1, 20)
      ),
      
      hr(),
      h3("About the Plot"),
      p("We chose to use a scatterplot to compare the number of schooling years and 
        life expectancy across the world to showcase the correlation whether it be a
        negative or positive correlation. As a result of the scatterplot, you can 
        see the x-axis being schooling and y-axis being life expectancy, and the dots
        representing the data. For each year add of schooling and gaining an education
        the life expectancy increases. Users will be able to interact with the chart 
        but using the slider widget to see the change in years of schooling and see
        the decrease or increase in life expectancy.")
    ),
    mainPanel(
      h3("Amount of Years of Schooling vs. Life Expectancy"),
      plotlyOutput(outputId = "education_output")
      
    ),
  ),
)


vaccine_page <- tabPanel(
  "Vaccinations",
  titlePanel(h2("Vaccinations and Life Expectancy")),
  br(),
  sidebarLayout(
    sidebarPanel(
      selectInput("vaccine", label = h3("Select vaccination"), 
                  choices = list("Hepatitis B" = "Hepatitis.B",
                                 "Polio" = "Polio", 
                                 "Diphtheria" = "Diphtheria"),
                  selected = "Hepatitis B"),
      
      hr(),
      h3("About the Plot"),
      p("To compare the vaccination coverage for the chosen vaccine for one year olds 
        and infant mortality rates, we used overlaying density charts. The different
        vaccines to choose from are Hepatits B, Polio, and Diphtheria. We choose this
        type of visualization because it was an easy way to visualize all the data for 
        all the countries within the data set. These charts allow us to see how 
        vaccination rates are able to affect life expectancies/infant mortality. From
        the chart, we can see that the trends of density for vaccine coverage vs. 
        infant mortality rates. We can conclude that since most countries are able to
        cover the vaccine for infants for a good amount of their population, infant 
        mortality rates decrease.")
    ),
    mainPanel(
      h3("Average Immunization Coverage vs. Infant Mortality Rates"),
      plotlyOutput("vaccination_plot")
    ),
  ),
)


gdp_page <- tabPanel(
  "GDP",
  titlePanel(h2("Countries' GDP and Life Expectancy")),
  br(),
  sidebarLayout(
    sidebarPanel(
      sliderInput("slider1", label = h3("Year"), min = 2000, 
                  max = 2015, value = 2015),
      hr(),
      h3("About the Plot"),
      p("This is a visualization of global life expectancies since 2000. 
        Adjusting the slider to the year desired visualizes the data. As 
        life expectancy was not significantly altered worldwide between 
        2000 and 2015, it is important to note that the color changes are 
        subtle in the chart. It is possible overall to see a general 
        overall increase in life expectancy between 2000 and 2015. 
        Hovering over each nation provides detailed information for each 
        year and can illustrate this pattern effectively."),
    ),
    
    mainPanel(
      h3("Global Life Expectancies Since 2000"), 
      br(),
      plotlyOutput(outputId = "maplife"),
      
    ),
  ),
)

visualization_page <- tabPanel(
  "Visualizations",
  titlePanel(h1("Data Visualizations")),
  br(),
  tabsetPanel(
    schooling_page,
    vaccine_page,
    gdp_page
  )
)

report_page <- tabPanel(
  "Report",
  titlePanel(h1("About Life Expectancy")),
  br(),
  sidebarLayout(
    sidebarPanel(
      p(strong("Authors")),
      p("Grant Branstetter:", em("gbrans@uw.edu")),
      p("Ysabelle Olairez:", em("ylmo@uw.edu")),
      p("Kayla Tounalom:", em("kaymtoun@uw.edu")),
      p("Lizeth Velderrain-Lopez:", em("lizethvl@uw.edu")),
      
      p(strong("Affiliation")),
      p("INFO-201: Technical Foundations of Informatics - ", 
        tags$a(href="https://ischool.uw.edu/", "The Information School"), " - University of Washington"),
  
      p(strong("Date")),
      p("March 9th, 2022"),
  
      p(strong("Keywords")),
      p("life expectancy; global; health; GDP; education"),
      
      br(),
      
      h3("Abstract"),
      p("Our main question is how outside factors from the economic situation 
        and health can affect the life expectancy in certain questions, which will 
        be addressed by the social and health data gathered from countries globally. 
        We are concerned with this topic because we have prior knowledge of how more 
        underdeveloped countries had shorter life expectancies due to health crises 
        and wanted to find out what other major factors impact the average life 
        expectancy of a country. Considering that some factors and events target 
        certain countries more than others, it is important to limit this effect by 
        focusing on global factors that affect most countries' populations."),
      
      br(),
      
      h3("Research Questions"),
      p(em(strong("Is the level of schooling worldwide related to life expectancy?"))),
      p("Countries vary in their ability to provide immunizations due to many factors
        such as cost, their location, laws, etc. It is important to recognize how a 
        country's ability or inability to get these resources affect their overall health."),
      
      p(em(strong("Is there an association between immunization coverage and life expectancy in the nations surveyed?"))),
      p("Educational levels and opportunities to obtain an education varies between 
        different populations, we want to know how this effects life expectancy worldwide
        and what educational resources do people need to survive."),
      
      p(em(strong("Is there a correlation between the incomes and economic outputs of countries and 
                  their respective life expectancies?"))),
      p("The development index of certain nations can be indicative of their health
        expenditures, access to medical resources, and availability of essential 
        resources. It is important to understand whether these factors play a role 
        in life expectancy to address critical public health issues worldwide."),
      
      br(),
    ),
    
    mainPanel(
      h3("Design Situation"),
      hr(),
      h4("Project Framing"),
      p("Our concern is life expectancy varies across our global population but why
        and what can we do to learn more about the factors using data and evidence. 
        Our key elements when analyzing the topic are the social, cultural and 
        economic factors. The key questions we want to focus on are how different 
        economies, policies, and social factors can affect life expectancy within 
        the country and compared globally."),
      
      h4("Human Values"),
      p("The human values connected to our topic of concern consist of awareness 
        in understanding and learning about life expectancy, compassion to help 
        the global populations, and lastly highlight and empathize concerns and 
        research on how to increase life expectancy."),
      
      h4("Direct and Indirect Stakeholders"),
      p("The direct stakeholders are researchers, health care providers, governments, 
        advocates, and the United Nations. These stakeholders hold the value of 
        commitment to learning, researching, and implementing new ideas and change
        to benefit people worldwide. The indirect stakeholders are those who are 
        most affected from life expectancy, such as the general population."),
      
      br(),
      
      h3("Possible Benefits and Harms"),
      hr(),
      h4("Benefits"),
      tags$ul(
        tags$li("People will be aware of what effects life expectancy and the reasons, 
        this may result in more funding and resources to countries where life 
        expectancy is low, such as from the findings in Our World in Data wherein 
        the lowest life expectancy of 54 years is from Central African Republic, 
        whereas multiple countries like Canada, Japan, and France exhibit the highest
        range of life expectancy of 86 years (Roser, Ortiz-Ospina, & Ritchie, 2013)."), 
        tags$li("Countries with higher life expectancy may be models for countries with 
        lower life expectancy which would result in new developed polices."),
        tags$li("Global life expectancy data and especially visual data ensures we are 
        aware of humans' health over the course of their life span. This world map
        for example shows life expectancy data as recent of 2019 and the number 
        of years an individual would live specific to each country."),
        tags$li("Visually seeing data can help people learn, interpret, and discuss data
        (Roser, Ortiz-Ospina, & Ritchie, 2013).")),
      
      h4("Harms"),
      tags$ul(
        tags$li("Stereotyping is a potential harm because countries following behind in 
        life expectancy may have a negative connotation surrounding their peoples, 
        governments, and way of life."), 
        tags$li("Life expectancy data may not include all populations. According to the 
        American Journal of Public Health, incarcerated individuals in the United 
        States on average have a lower life expectancy (Patterson, 2013). This example
        proves a potential harm because there may be missing data on populations such 
        as incarcerated individuals."), 
        tags$li("Data may not be the most updated to follow possible natural disasters, 
        global pandemics, and much more. As of recently starting in 2019, COVID-19 
        began spreading globally across the world with millions of infections and 
        new deaths daily. From the research journal, Direct and Indirect effects on
        COVID-19 on life expectancy and poverty in Indonesia, the authors discussed 
        how life expectancy is affected by both health and income shocks (Gibson & Olivia, 2020). 
        These shocks to our global population may come abruptly without warning and 
        could lead to a long term effect on life expectancy data.")),
      
      br(),
      
      h3("The Dataset"),
      hr(),
      p("Our data table contains 2938 rows and 22 columns. It provides data on 193 
        different countries with data ranging from 2000-2015. This data represents 
        the multiple countries and their life expectancies and allows us to see the 
        effects of health-related or economic factors for each country throughout 
        those 15 years. The columns range from a variety of topics such as the development
        status of a country, life expectancy, adult mortality, infant deaths, GDP, 
        immunization coverage, population, amount of schooling, etc. Based on these factors,
        the life expectancy for each country is estimated for each of the years. The data 
        about life expectancy and health-related data comes from the Global Health Observatory (GHO),
        a data repository under the World Health Organization (WHO). While the economic 
        data was from the United Nations website. These are two well-known and credible 
        sources for information about countries around the world. The funding for these 
        organizations are usually done through voluntary contributions or assessed contributions.
        The countries within the data set and its people can benefit from this source as
        they can see what factors are most detrimental towards their life expectancy and work 
        to fix them. It was found that in the past, lots of data about life expectancy 
        did not take the effects of immunization and human development index into account. 
        Therefore causing lots of past research to be done by considering linear regression 
        based on a data set of one year for the country. This data set strives to consider 
        these factors over the course of 15 years to get better data on how these factors
        affect life expectancy and the health of a country. This data set was also created 
        over six years ago, therefore it is not the most recent data set when talking about 
        life expectancies. Especially now while we have factors like COVID-19 also impacting 
        the world's health. We obtained this data from Kaggle. Kaggle is a database with 
        datasets on thousands of different topics. This dataset in particular is highly 
        valued within the site with almost 700 upvotes and a gold medal attached to it. 
        There are some missing data from less known countries like Vanuatu, Tonga, etc. 
        as well as population sizes. But overall, this data set contains tons of 
        information and has good usability."),
      
      br(),
      
      h3("Expected Implications"),
      hr(),
      p("Factors like healthcare, GDP, education, and substance abuse may play an important
        role in the average life expectancies of nations worldwide. Since life expectancy
        is tied to these certain conditions, the implications are clear to policymakers 
        and others that in order to improve quality of life around the world, the root 
        issues facing countries with lagging life expectancies need to be addressed. 
        Countries that have particularly high life expectancies might be models for 
        addressing issues in the United States and in other places as well. Considering 
        many of the nations in the data with the highest life expectancies have different 
        healthcare systems, greater expenditures on schooling, and healthier average lifestyles,
        it might be important to adopt the policies that work for them. Technologists, 
        designers, and policymakers are all involved in this effort to improve worldwide 
        health, because of their potential ability to improve the systems we have."),
      
      br(),
      
      h3("Limitations"),
      hr(),
      p("Limitations from the data stem from outside factors that could affect life expectancy,
         such as car accidents, could sway the data. Because of this, the correlations
         may not be completely accurate, however, by using various categories and data
         for the major factors that affect whole populations, this limitation is mitigated.
         Additionally, policies from different countries may heavily affect the data. 
         For example, vaccine mandates and alcohol laws could contribute to the data observed,
         but it would be too difficult to know and research each countries' policies
         concerning this and later find out how those policies impact the issue at hand. 
         There is missing data from smaller countries which increases the limitations 
         from the dataset, as well as the fact that the data is gathered from 2000 to 2015. 
         Because the data is not up-to-date and does not include the pandemic which certainly 
         impacted many deaths worldwide, important factors like economic status and policies 
         and their heightened impact cannot be observed."),
      br(),
    ),
  ),
)


conclusion_page <- tabPanel(
  "Summary",
  titlePanel(h1("Our Takeaways")),
  br(),
  h3("Education"),
  p("The summary statistics for life expectancy and schooling consists of first 
     finding the countries with the most and minimum number of years of schooling. 
     What we found was the country with most number of schooling was", 
     span(textOutput("high_schooling", inline = TRUE), style = "color:#D65780"), "The country with the lowest number of 
     schooling years was", span(textOutput("low_schooling", inline = TRUE), style = "color:#D65780"), 
    "The minimum average years of schooling in the world is", 
    span(textOutput("min_schooling", inline = TRUE), style = "color:#D65780"), "and the 
    maximum average years  of schooling in the world is", span(textOutput("max_schooling", inline = TRUE),
                                                               style = "color:#D65780"),
    ". We wanted to find the minimum and maximum for years of schooling and compare the countries to find a correlation."),

  br(),
  h3("Vaccinations"),
  p("From the data set we are able to see summary statistics of averages for 
    vaccination coverages and infant mortality rates around the world. Around the
    world, the average percentage of vaccine coverage for 1 year old is",
    span(textOutput("avg_vaccine_coverage", inline = TRUE), style = "color:#D65780"), "for vaccines such as
    Hepatitis B, Polio, and Diphtheria. This relates to the average of", 
    span(textOutput("avg_infant_deaths", inline = TRUE), style = "color:#D65780"), "infant deaths per 1000 
    population. Since the average vaccine coverage is relatively high, the 
    average infant mortality rates are low."),
  br(),
  h3("GDP"),
  p("Hovering over each nation provides detailed information for each 
    year and can illustrate this pattern effectively. In order to see
    some general patterns pertinent to the United States, the years 
    of maximum and minimum life expectancies were calculated, to see 
    if the the trend toward increased life expectancy has been 
    present here as well. The results follow:"),
  p("Year with the lowest US life expectancy - ", span(textOutput("minlifeexpectancyus", inline = TRUE), style = "color:#D65780")),
  p("Year with the highest US life expectancy - ", span(textOutput("maxlifeexpectancyus", inline = TRUE), style = "color:#D65780")),
  p("Considering the data set for life expectancy ranges between the 
              years of 2000 and 2015, it is clear that the trend is present in 
              the US population as well.")
)


resources_page <- tabPanel(
  "Resources",
  titlePanel(h1("Resources")),
  br(),
  h3("Works Cited"),
  hr(),
  p("Centers for Disease Control and Prevention. (2021, October 13). NVSS - life expectancy. 
    Centers for Disease Control and Prevention. Retrieved February 4, 2022, from 
    https://www.cdc.gov/nchs/nvss/life-expectancy.htm"),
  p("Gibson, J., & Olivia, S. (2020). Direct and Indirect Effects of Covid-19 On Life 
    Expectancy and Poverty in Indonesia. Bulletin of Indonesian Economic Studies, 56(3), 
    325-344. https://doi.org/10.1080/00074918.2020.1847244"),
  p("GBD 2015 Mortality and Causes of Death Collaborators (2016). Global, regional, and
    national life expectancy, all-cause mortality, and cause-specific mortality for 249 
    causes of death, 1980-2015: a systematic analysis for the Global Burden of Disease 
    Study 2015. Lancet (London, England), 388(10053), 1459-1544. https://doi.org/10.1016/S0140-6736(16)31012-1"),
  p("Patterson, E. J. (2013). The Dose-Response of Time Served in Prison on Mortality: 
    New York State, 1989-2003. American Journal of Public Health, 103(3), 523-528. 
    https://doi.org/10.2105/ajph.2012.301148"),
  p("Rajarshi, Kumar (2018). Life Expectancy (WHO): Statistical Analysis on factors 
    influencing Life Expectancy. Kaggle. https://www.kaggle.com/kumarajarshi/life-expectancy-who"),
  p("Roser, M., Ortiz-Ospina, E., & Ritchie, H. (2013). Life Expectancy. Our World in Data.
    https://ourworldindata.org/life-expectancy"),
  
  br(),
  
  h3("Links"),
  hr(),
  
  p(tags$a(href = "https://github.com/info-201a-wi22/final-project-starter-life-expectancy",
           "GitHub Repository containing all project files")),
  p(tags$a(href = "https://www.kaggle.com/kumarajarshi/life-expectancy-who", "Kaggle Dataset")),
  )

nav_page <- navbarPage(
  "Life Expectancy Factors",
  intro_page,
  visualization_page,
  conclusion_page,
  report_page,
  resources_page
)

ui <- fluidPage(includeCSS("styles.css"), theme = shinytheme("sandstone"),
  tags$head(
    tags$style(HTML("")),
    nav_page
  )
)