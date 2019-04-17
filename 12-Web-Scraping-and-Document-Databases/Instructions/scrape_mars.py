from flask import Flask, render_template, redirect
from flask_pymongo import PyMongo
import pymongo
# import scrape_craigslist
app = Flask(__name__)


# Use flask_pymongo to set up mongo connection

conn = "mongodb://localhost:27017"
client = pymongo.MongoClient(conn)

# Select database and collection to use
db = client.mission_to_mars_db
collection = db.mars


def scrape_mars():
    mars_data = {}
    # URL of page to be scraped
    url = 'https://mars.nasa.gov/news/?page=0&per_page=40&order=publish_date+desc%2Ccreated_at+desc&search=&category=19%2C165%2C184%2C204&blank_scope=Latest'
    response = requests.get(url)
    soup = bs(response.text, 'html.parser')
    results = soup.find('div', class_ = 'slide')
    content_title = soup.find_all('div', class_ = "content_title")
    title = []

    for ct in content_title:
        if (ct.a):
            if (ct.a.text):
                    title.append(ct.text)


        title_text = title[0]
        title_text = title_text.replace("\n\n", "")
    description = soup.find('div', class_ = "rollover_description_inner")
    desc = []
    for dc in description:
        if (dc):
            desc.append(dc)
            
        description_ = dc.replace("\n","")
    print(description_)


if __name__ == '__main__':
    app.run(debug=True)
scrape()


