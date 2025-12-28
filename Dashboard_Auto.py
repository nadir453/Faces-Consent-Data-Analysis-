# -*- coding: utf-8 -*-
"""
Created on Mon Mar 24 00:55:10 2025

@author: nadir
"""

import pandas as pd 
import numpy as np
import matplotlib as mp 
import matplotlib.pyplot as plt
import dash
from dash import Dash, html, dash_table, dcc
import pandas_bokeh






#Reading the Excel file and the sheet name
file_name = 'D:\Faces Test documents\FacesApp.xlsx'
faces_df = pd.read_excel(file_name)
print(faces_df)

df_barchart_1 = pd.pivot_table(faces_df, 
                          values="Products_Purchased", 
                          index="user_type", 
                          columns="Location_Country", 
                          aggfunc=np.sum)

df_barchart_2 = pd.pivot_table(faces_df, 
                          values="Products_Viewed", 
                          index="Location_City", 
                          columns="Services_Used", 
                          aggfunc=np.sum)

df_barchart_1.plot.bar()
df_barchart_2.plot.bar()


