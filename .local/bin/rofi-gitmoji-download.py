#!/usr/bin/env python3

import json
import os
import requests
import sys

def create_data_file():
    data_file_folder = sys.argv[1]
    if not os.path.exists(data_file_folder):
        os.mkdir(data_file_folder)
    data_file_name = data_file_folder + '/gitmojis.csv'
    if not os.path.exists(data_file_name):
        r = requests.get('https://gitmoji.dev/api/gitmojis')
        gitmojis = json.loads(r.content)['gitmojis']
        csv = '\n'.join(['"' + gitmoji['emoji'] + '","' + gitmoji['description'] + '"' for gitmoji in gitmojis])
        file = open(data_file_name, 'wb')
        file.write(csv.encode())
        file.close()


if __name__ == '__main__':
    create_data_file()
