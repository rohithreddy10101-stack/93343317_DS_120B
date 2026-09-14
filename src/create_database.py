import sqlite3
import pandas as pd
from pathlib import Path


# Project paths
BASE_DIR = Path(__file__).resolve().parent.parent

csv_path = BASE_DIR / "data" / "processed" / "hotel_bookings_clean.csv"
db_path = BASE_DIR / "data" / "processed" / "hotel_bookings.db"


# Load cleaned dataset
df = pd.read_csv(csv_path)


# Connect to SQLite database
connection = sqlite3.connect(db_path)


# Create database table
df.to_sql(
    "hotel_bookings",
    connection,
    if_exists="replace",
    index=False
)


# Close connection
connection.close()


print("Database created successfully!")
print(f"Records loaded: {len(df):,}")
print(f"Database: {db_path}")