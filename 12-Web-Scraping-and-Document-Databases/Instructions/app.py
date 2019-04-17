from flask import Flask, jsonify
import scrape from scrape_mars.py





# Create root/index route to query mongoDB and pass mars data to HTML template to display data
@app.route('/')
def index():
    mars_d = db.mars.find_one()
#    return render_template('index.html', marsdata=mars_d)






# Create route called /scrape
@app.route('/scrape')
def scrape():
    data = scrape_mars()
#     marsdata = db.marsdata.insert_many(data)
#     db.marsdata.update(
#         {},
#         data,
#         upsert=True
#     )
#     return "Scraping successful!"



if __name__ == '__main__':
    app.run(debug=True)
    