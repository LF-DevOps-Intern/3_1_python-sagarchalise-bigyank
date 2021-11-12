import argparse
import requests
from pywebcopy import save_webpage
import subprocess
import os
import sys
from pathlib import Path



def verifyUrl(address):
    try:
        response = requests.get(address, timeout=5) 
    except requests.ConnectionError as connection_error:
        raise SystemExit(connection_error)

    except requests.TooManyRedirects as toomany_request:
        raise SystemExit(toomany_requests)

    except requests.Timeout as time_out:
        raise SystemExit(time_out)

    except requests.HTTPError as generic_error:
        raise SystemExit(generic_error)

    except Exception as e:
        raise SystemExit(e)


def downloadContents(url, download_folder_name):
    verifyUrl(url) 
    content_path = str(Path(__file__).parent.absolute())
    kwargs = {'bypass_robots': True, 'project_name': download_folder_name}
    save_webpage(url, content_path, **kwargs)

def parseArgs():
    parser = argparse.ArgumentParser()

    parser.add_argument('--url', type=str, required=True)
    parser.add_argument('--http_server', action='store_true')
    args = parser.parse_args()
    return args

def main():
    download_folder_name = 'webcontents'
    args = parseArgs()
    if args.http_server:
        downloadContents(args.url, download_folder_name)
        subprocess.run(list(f'python3 -m http.server -d {download_folder_name} '.split()))
    else:
        downloadContents(args.url, download_folder_name)
   


if __name__ == '__main__':
    try:
        main()
    except KeyboardInterrupt:
        print('Keyboard Interruption')
        try:
            sys.exit(0)
        except SystemExit:
            os._exit(0)
       
