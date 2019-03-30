import numpy as np

import sqlalchemy
from sqlalchemy.ext.automap import automap_base
from sqlalchemy.orm import Session
from sqlalchemy import create_engine, func

from flask import Flask, jsonify

# Dictionary 
engine = create_engine("sqlite:///Resources/hawaii.sqlite")

Base = automap_base()
Base.prepare(engine, reflect=True)
Measurement = Base.classes.measurement
Station = Base.classes.station
session = Session(engine)


app = Flask(__name__)
@app.route("/")
def home():
    """List all available api routes."""
    return(
        f"<strong>Welcome to my Climate Analytics!</strong><br/><br/>"
        f"List of all available api routes:<br/>"
        f"/api/v1.0/precipitation<br/>"
        f"/api/v1.0/stations<br/>"
        f"/api/v1.0/tobs<br/>"
        f"/api/v1.0/<start><br/>"
        f"/api/v1.0/<start>/<end><br/>"
    )


@app.route("/api/v1.0/precipitation")
def date_prcp():
    """Return list of date and prcp date"""
    results = session.query(Measurement).\
        order_by(Measurement.date.desc()).all()
    all_date_prcp = []
    for record in results:
        record_dict = {}
        record_dict["Date"] = record.date
        record_dict["Precipitation"] = record.prcp
        all_date_prcp.append(record_dict)

    return jsonify(all_date_prcp)


# ("/api/v1.0/stations")
@app.route("/api/v1.0/stations")
def stations():
    results = session.query(Station.station).all()
    all_station = list(np.ravel(results))
    return jsonify(all_station)

@app.route("/api/v1.0/tobs")
def tobs():
    results = session.query(Measurement)\
        .filter(Measurement.date.between('2016-08-01','2017-08-01'))\
        .order_by(Measurement.date.desc()).all()

    all_tobs = []
    for record in results:
        record_dict = {}
        record_dict['date'] = record.date
        record_dict['Temperature'] = record.tobs
        all_tobs.append(record_dict)
    return jsonify(all_tobs)


# @app.route("/api/v1.0/<start>")
start_date = "2016-08-01"
end_date = "2017-08-01"
@app.route("/api/v1.0/<start>/<end>")
def calc_temps(start_date, end_date):
        results = session.query((func.min(Measurement.tobs).label("max"),\
                                func.avg(Measurement.tobs).label("avg"),\
                                func.max(Measurement.tobs).label("max")).
                                filter(Measurement.date.between(start, end))) 
        
        Temp = []
        TMIN = results.max
        TAVG = results.avg
        TMAX = results.max
        Temp.append(TMIN)
        Temp.append(TAVG)
        Temp.append(TMAX)

        return jsonify(Temp)
        
        
        
        
     
    
    # return session.query(func.min(Measurement.tobs), func.avg(Measurement.tobs), func.max(Measurement.tobs)).\
    #     filter(Measurement.date >= start_date).filter(Measurement.date <= end_date).all()



if __name__ == "__main__":
    app.run(debug=True)