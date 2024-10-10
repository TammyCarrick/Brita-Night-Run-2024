
from get_racers import get_results

#html files to read from
TORONTO_FILES = ["C:\\Users\\tammy\\Desktop\\Webscraping\\race stats\\html_files\\toronto10k_pg1.html",
              "C:\\Users\\tammy\\Desktop\\Webscraping\\race stats\\html_files\\toronto10k_pg2.html",
              "C:\\Users\\tammy\\Desktop\\Webscraping\\race stats\\html_files\\toronto10k_pg3.html",
              "C:\\Users\\tammy\\Desktop\\Webscraping\\race stats\\html_files\\toronto10k_pg4.html",
              "C:\\Users\\tammy\\Desktop\\Webscraping\\race stats\\html_files\\toronto10k_pg5.html"              
 ] 
new_file_paths = ["C:\\Users\\tammy\\Desktop\\Webscraping\\race stats\\data_csv\\" + html_file[-19:-5] +".csv" for html_file in TORONTO_FILES]
anon_count = 0

for i in range(len(TORONTO_FILES)):
    get_results(TORONTO_FILES[i], new_file_paths[i], anon_count)
    anon_count +=400

        

