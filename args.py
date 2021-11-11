import argparse
import requests
from pywebcopy import save_webpage



def verifyUrl(address):
    try:
        response = requests.get(address, timeout=5) 
    except requests.ConnectionError as connection_error:
        raise SystemExit(connection_error)

    except requests.TooManyRedirects as toomany_request:
        raise SystemExit(toomany_requests)

    except requests.Timeout as time_out:
        raise SystemExit(time_out)

    except request.HTTPError as generic_error:
        raise SystemExit(generic_error)

    except Exception as e:
        raise SystemExit(e)

parser = argparse.ArgumentParser()

parser.add_argument('--url', type=str, required=True)
parser.add_argument('--http_server', action='store_true')
args = parser.parse_args()


if args.http_server:
  print(args.url, 'will be servered through web server')
  url = args.url
  verifyUrl(url)
  download_folder = './'    

  kwargs = {'bypass_robots': True, 'project_name': 'recognisable-name'}

  save_webpage(url, download_folder, **kwargs)

else:
  print(args.url, 'file from this url will be downloaded')

