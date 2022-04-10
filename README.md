# 2022 SOA Research Challenge - Team Justin
 
### By Justin Gonzaga, Hillary Ngo, Steven Lim, Zilin Shao, Edward Santoso

## Project Outline

We aim to a competitive national football team as requested by the Commissioner of Sport for Rarita. The team selection criteria is divided into the different positions and scored using the Composition of Probabilistic Preferences (CPP) method. This relies on the players statistics derived from data provided by Valani Global and the assumptions made to alleviate the data limitations. The implementation plan for the national team is subject to a funding constraint that will be mainly distributed to cover staff and player expenditures and receive revenues from matchdays, broadcasts and commercials. The key metrics on FSA rankings, net revenue and GDP per capita will be reviewed yearly for the next 10 years to monitor the implementation plan.

## Team Seletion

Before assembling a competitive national football team, we must define what constitutes a competitive team. The recommended definition of a ‘competitive’ team for this scenario is as follows:
•	Ranking within the top ten members of the FSA for the season within the next five years, with
•	High probability of achieving an FSA championship within the next 10 years.

For the actual player selection, statistics from the player data that are most relevant to each of the four positions (FW, MF, DF, GK). that this ‘ability to contribute’ into a list of key performance indicators (KPIs) that are most relevant to each playing style/position. Once these KPIs are obtained, the CPP method (Gavião et. al. 2019; Gavião et. al. 2021) is used to rank the players. The team selection is as follows,

![image](https://user-images.githubusercontent.com/103007945/161655407-b4ffeb9c-1dbf-4329-aa5e-2eeccd21ba79.png)

## Economic Impacts

To analyze the impact of having a “competitive” team on a country’s revenue and expenses, linear regression was performed for Nganion and Sobianitedrucy. Those countries are chosen because based on the aggregate ranking of 2020 and 2021 Tournament, Nganion’s place averaged 2.5 and Sobianitedrucy’s place averaged 2. The top 2 highest in the tournament. These 2 countries perfectly fit the definition of a “competitive” team as they are always ranked in the top 10 and has a high chance of winning the championship due to their consistent high rank. The following figure indicates how a competitive will impact on Rarita's GDP over the next decade.

![image](https://user-images.githubusercontent.com/103007945/161655041-8f670459-3e93-4339-b8d4-8a9f657fc062.png)

## Risk Consideration

The risks associated with building a national football team to promote economic prosperity include strategic, financial and operational risks. These predominately result from players inability to perform or barriers in Rarita’s economy that will prevent significant long-term growth. Fortunately, many of the risks can be mitigated albeit with additional costs. Nevertheless, these risks can have a profound effect on the implementation plan as evidenced in the sensitivity analysis conducted using the Monte Carlo simulation model. The average profit tended towards –$3800 doubloons during unfavourably tail risk events. Due to the lack of data, it is unlikely that the above risks can be quantified. A risk map is generated to shed light on the potential size and likelihood of the loss that may occur. The effective of the risk mitigation approach is indicated by the shape size. More effective approach is indicated by a larger shape.

![image](https://user-images.githubusercontent.com/103007945/161654903-f2c28e44-7375-4a68-a9cc-d5d8dfb8f649.png)

Monte Carlo sensitivity analysis is conducted to account for the unexpected fluctuations in the external conditions, especially in the period of global pandemic recovery. The external conditions will directly or indirectly affect the team revenue and expense in the following decade. This analysis incorporates an additional annual increase or decrease of revenue and expense (in percentage point and assumes to be normally distributed). Average profit is generated for each combination of percentage change by running 5,000 iterations. The results are shown in the following table.

![image](https://user-images.githubusercontent.com/102514184/162616859-2f213487-95cb-4844-a707-a3a6a2b57cee.png)



