# Data Modeling and Analysis

## Introduction

Welcome, to the Data Modeling and Analysis project, a comprehensive initiative aimed at leveraging the power of <u>**Python, PostgreSQL, SQL, and Power BI**</u> to extract valuable insights from your data. 

In this project, the primary goal is to seamlessly insert data into a **PostgreSQL database using python**, conduct insightful data analysis using **SQL queries**, and present the findings through visually compelling **Power BI** dashboards.

## Data Insertion
### <u> Process of inserting data into PostgreSQL using Python scripts </u>

> [!NOTE]
>
> If you dont have the following ***Python, JupyterNoteBook, PostgreSQL, PowerBI*** refer to the link below :point_down:

<details>

<summary> Installations </summary>

### Process of downloading Vscode, JupyterNotebook, Python, Psycopg2, PostgreSQL, PoweBI.
 
 - Here's a youtube guide on how to download [**Vscode**](https://youtu.be/CPmQwlycfGI?si=fWDdtgYkQLGIQL9P)
 - After that follow this guide on how to install [**JupyterNotebook** ](https://youtu.be/h1sAzPojKMg?si=VM8kpZffPJY-EIT2)
 > [!NOTE]
 >
 > Its important to use JupyterNotebook for this process to work.

- Here's a guide on how to download [**Python3.0**](https://youtu.be/cUAK4x_7thA?si=j18U8pBYBrXh1KZi)
- If you dont have this module its best to first install it using either **command prompt** or **Vscode's** built in Terminal.

```
 #installing psycopg2 module for connecting to sql
!pip install psycopg2
```
- Heres a guide on how to install [**PostgreSQL**](https://youtu.be/0n41UTkOBb0?si=84lvAZMWqk4HSzUi)
- Here's a guide on how to install [**PowerBI**](https://youtu.be/GT2NcTE6UEo?si=Hbxqt0muBuYw4tZ9)

</details>

#### The Python Script
- #### <u>First you have to create a DataBase in PostgreSQL Server using a connector from python.</u>
```
#Creating a function that will create a DB 
def create_database():
    
    #connecting to default database
    con = psycopg2.connect("host=127.0.0.1 dbname=postgres user=postgres password='Your_own_password")
    con.set_session(autocommit=True)
    cur = con.cursor()
    
    #creating a new database to store tables in.
    cur.execute("DROP DATABASE IF EXISTS ecommerce")
    cur.execute("CREATE DATABASE ecommerce")
    
    #close connection to default DB
    con.close()
    
    #connecting to ecommerce database
    con = psycopg2.connect("host=127.0.0.1 dbname=ecommerce user=postgres password=Root")
    cur=con.cursor()
    
    return cur, con 
```
- Notice the DataBase credentials were stored in a variable called con.
- ```con = psycopg2.connect("host=127.0.0.1 dbname=postgres user=postgres password='Your_own_password")```
- This makes it easy to connect and add modifications to the DB right from python.

- #### Quick cleaning using Pandas module 
- It was easier making some obvious changes to the Data before inserting it to reduce errors and time consumption while cleaning using SQL

![replacing_column_names](https://github.com/captin01/Data_Engineering_Projects/assets/114471010/92485199-e639-4d78-aa84-d8d44be149a5)

![renaming_customer_column](https://github.com/captin01/Data_Engineering_Projects/assets/114471010/857cd0bd-da89-4a20-9e8a-454ffe031a68)

- #### <u>Seond is creating the table</u>
- Here's an example of the many CREATE TABLE syntax that was used.
![creating_customer_table](https://github.com/captin01/Data_Engineering_Projects/assets/114471010/fb99a786-1df3-4fa1-89b0-042070e4d6fc)

- #### <u>Lastly is to insert data into the created tables</u>
![inserting_data](https://github.com/captin01/Data_Engineering_Projects/assets/114471010/4605b319-3c96-4f2c-b5ca-dc4f890c966b)

>[!NOTE]
>
>I used a for loop to extract the rows of the specific columns names from the actual data itself.
>
> Hence ```for i, row in customer_dim_cols.iterrows():
    cur.execute(customer_table_insert, list(row))```

#### SQL Confirmation

- After running the python script go to SQL server and confirm that all row have been inserted.
- below is an image example

![ecommerce_DB](https://github.com/captin01/Data_Engineering_Projects/assets/114471010/e547e952-317f-427b-8917-00d9c72f3485)


- The model should look like this
![ecom_ERD](https://github.com/captin01/Data_Engineering_Projects/assets/114471010/d785c814-519a-493f-8de7-40a47646751d)

#### Reseach question and Analysis using SQL queries.
- The queries are stored in an sql file which you van go through and see questions that were ansered.
- Here are some examples you'll find

![sql_query](https://github.com/captin01/Data_Engineering_Projects/assets/114471010/0476e36a-7ca5-47fe-8b5d-f48221be603d)

![sql_query2](https://github.com/captin01/Data_Engineering_Projects/assets/114471010/12e474d2-96da-45c7-8d0e-e2f0b3156e40)

#### PowerBI visualization 
- lastly the visualization.
- Not much can be described here since this part is more action based than reader friendly, so ill let you look for Youtube videos showing how to create charts for your queries.
- Heres the final product.

![ecommerce_visual_graph](https://github.com/captin01/Data_Engineering_Projects/assets/114471010/41bfeddd-8e32-4fe9-8e2c-2d9212eb221d)

![ecommerce_visual_graph2](https://github.com/captin01/Data_Engineering_Projects/assets/114471010/daf41b45-64d5-415b-ba81-26bb5af60a40)

## The end till next time 
![Craziest Fruit Seller of India](https://i.makeagif.com/media/1-27-2023/rhgJ7o.gif)