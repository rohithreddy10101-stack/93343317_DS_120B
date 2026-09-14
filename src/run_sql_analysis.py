import sqlite3
from pathlib import Path
import pandas as pd


# Project paths
BASE_DIR = Path(__file__).resolve().parent.parent

db_path = BASE_DIR / "data" / "processed" / "hotel_bookings.db"
sql_path = BASE_DIR / "sql" / "hotel_analysis.sql"
output_dir = BASE_DIR / "data" / "processed" / "sql_results"

output_dir.mkdir(parents=True, exist_ok=True)


# Read SQL file
sql_text = sql_path.read_text(encoding="utf-8")


# Connect to database
connection = sqlite3.connect(db_path)


# Split SQL file into individual queries
queries = [
    query.strip()
    for query in sql_text.split(";")
    if query.strip()
]


print("=" * 60)
print("HOTEL BOOKING SQL ANALYSIS")
print("=" * 60)

for i, query in enumerate(queries, start=1):

    try:
        result = pd.read_sql_query(query, connection)

        output_file = output_dir / f"query_{i:02d}.csv"
        result.to_csv(output_file, index=False)

        print(f"\nQuery {i}: SUCCESS")
        print(f"Rows returned: {len(result)}")
        print(f"Saved: {output_file.name}")

        print(result.head(5).to_string(index=False))

    except Exception as e:
        print(f"\nQuery {i}: FAILED")
        print(e)


connection.close()

print("\n" + "=" * 60)
print("SQL ANALYSIS COMPLETE")
print("=" * 60)