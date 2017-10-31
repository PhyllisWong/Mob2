import requests

with open('sales.txt') as f:
    raw_data = f.readlines()

print(raw_data[:9])


# We are going to clean this data and we are passing in the raw data
def clean_data(raw_data):
    cleaned_lines = []
    for line in raw_data:
        # We have to replace then split because once we replace the characters we dont want then we can split that makes an array
        cleaned_line = line.replace('$', '').replace('\n', '')
        cleaned_line = cleaned_line.replace('\n', '')
        # At the occurence of \t a new array is made
        cleaned_line = cleaned_line.split('\t')
        cleaned_line[3] = float(cleaned_line[3])
        cleaned_lines.append(cleaned_line)
    return cleaned_lines


cleaned_data = clean_data(raw_data)
print(cleaned_data[:4])

all_phillie_sales = [i for i in cleaned_data if i[0] == "Philadelphia"]
# print(all_phillie_sales)

# Give the total of every sale

# So essentially what we are doing is that we are is making a list comprehension
total_sales = sum([i[3] for i in cleaned_data])
print(total_sales)


# API requests

start_date = '2017-10-21'
end_date = '2017-10-22'

nasa_response = requests.get('https://api.nasa.gov/neo/rest/v1/feed?start_date={}&end_date={}&api_key=DEMO_KEY'.format(start_date,end_date))
print(nasa_response.text)
