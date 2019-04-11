from flask import Flask, render_template, redirect
from flask_pymongo import PyMongo
import scrape_craigslist

app = Flask(__name__)

# Use flask_pymongo to set up mongo connection