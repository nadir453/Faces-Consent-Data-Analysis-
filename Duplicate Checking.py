# -*- coding: utf-8 -*-
"""
Spyder Editor

This is a temporary script file.
"""


import pandas as pd 
import csv
import datetime
  
df = pd.read_csv("D:\Faces Test documents\Faces_Modify.csv" ,sep=',', dayfirst=True)
print(df)

df = df.drop_duplicates()
print(df)

duplicates = df[df.duplicated()]
print(duplicates)

#df['Last_Login'] =   pd.to_datetime (df['Last_Login'], format='%Y-%m-%d')
#df['Signup_Date'] =   pd.to_datetime (df['Signup_Date'], format='%Y-%m-%d')
#print(df.dtypes)

df.to_csv('faces_dt.csv', sep=',' ,  index=False)
