# Automatic File Sorter in File Explorer

import os, shutil

path = r"C:\Users\Reina\github\portfolioproject\Python\Data/"

file_names =os.listdir(path)

folder_names = ['xlsx files', 'image files', 'text files']

for loop in range(0,3):
    if not os.path.exists(path + folder_names[loop]):
        print(path + folder_names[loop])
        os.makedirs((path + folder_names[loop]))

for file in file_names:
    if ".xlsx" in file and not os.path.exists(path + "xlsx files/" + file):
        shutil.move(path + file, path + "xlsx files/" + file)
    elif ".jpg" in file and not os.path.exists(path + "image files/" + file):
        shutil.move(path + file, path + "image files/" + file)
    if ".txt" in file and not os.path.exists(path + "text files/" + file):
        shutil.move(path + file, path + "text files/" + file)
    else:
        pass
print("Done!")