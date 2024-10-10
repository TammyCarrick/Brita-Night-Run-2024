from bs4 import BeautifulSoup
from pathlib import Path
import csv

# columns with relevant info
COL_NUM = [1, 2, 3, 4, 5, 8]
FIELD_NAMES = ['racer_id', 'name', 'overall place', 'chip time', 'gun time', 'division']


def get_results(html_file, new_file_path):
    data = []

    # reading and parsing through html file for info
    with open(html_file, 'r') as pg:
        content = pg.read()
        soup = BeautifulSoup(content, 'lxml')
        rows = soup.find_all('tr')

        for row in rows:
            columns = row.find_all('td')

            for i in COL_NUM:
                if i == 1:
                    place = columns[i].text.strip()

                elif i == 2:
                    gun_time = columns[i].text.strip()
                
                elif i == 3:
                    racer_id = columns[i].text.strip()

                elif i == 4:
                    name = columns[i].a.text.strip()
                    name = name.split(",")

                    # reformmating name
                    # regular first and last name
                    if len(name) >= 2:
                        first_name = name[1].strip().title()
                        last_name = name[0].strip().title()

                    # single name
                    elif len(name) == 1:
                        first_name = name[0].strip().title()
                        last_name = ""

                    # no name    
                    else:
                        first_name == ""
                        last_name == ""

                    name = first_name + " " + last_name

                elif i == 5:
                    division = columns[i].a.text.strip()
                
                elif i == 8:
                    chip_time = columns[i].text.strip()

            print(f"Racer ID: {racer_id}")
            print(f"Racer: {name}")
            print(f"Overall place: {place}")
            print(f"Chip time: {chip_time} min")   
            print(f"Gun time: {gun_time} min")
            print(f"Division: {division}")
            print("")

            racer_info = {'racer_id': racer_id, 'name': name, "overall place": place, "chip time": chip_time,
                        "gun time": gun_time, "division": division }
        
            data.append(racer_info)

    # write page to a csv file    
    with open(new_file_path, 'w', newline = '') as csvfile:
        writer = csv.DictWriter(csvfile, fieldnames= FIELD_NAMES)

        if csvfile.tell() == 0:
                writer.writeheader()
        writer.writerows(data)

    