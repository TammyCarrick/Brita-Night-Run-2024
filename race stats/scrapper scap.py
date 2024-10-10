from bs4 import BeautifulSoup
import requests
import csv
import random
from random_header_generator import HeaderGenerator

url = "https://www.startlinetiming.com/en/races/2024/nr_toronto/event/10K/page" 

# attempt using user_agents
user_agents = [
    'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36',
    'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36',
    'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:130.0) Gecko/20100101 Firefox/130.0',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36'
]

# #grabbing website html
# html_text = requests.get(url, headers={'User=Agent': random.choice(user_agents)})

# print(html_text)

# attempt using request headers
generator = HeaderGenerator()

headers   = generator(
  country     = 'us', 
  device      = 'desktop', 
  browser     = 'chrome',
  httpVersion = 1,
  cookies     = {'cookie_ID_1': 'cookie_Value_1', 'cookie_ID_2': 'cookie_value_2'},
)

html_text = requests.get(url, headers=headers)

print(html_text)