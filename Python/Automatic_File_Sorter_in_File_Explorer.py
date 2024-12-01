# Automatic File Sorter in File Explorer

import os, shutil

path = r"C:\Users\Reina\github\portfolioproject\Python\Data/"

os.listdir(path)

folder_names = ['xlsx files', 'image files', 'text files']

for loop in range(0,3):
    if not os.path.exists(path + folder_names[loop]):
        print(path + folder_names[loop])
        os.makedirs((path + folder_names[loop]))