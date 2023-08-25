import mysql.connector

def print_describe(host, user, password, database):
    # Connect to the MySQL database
    connection = mysql.connector.connect(
        host=host,
        user=user,
        password=password,
        database=database
    )

    # Create a cursor
    cursor = connection.cursor()

    # Get a list of table names in the specified database
    cursor.execute("SHOW TABLES")
    tables = cursor.fetchall()
    table_names = [table[0] for table in tables]

    # Open the file for writing
    with open("describes.txt", "w") as f:
        # Loop over each table and print the DESCRIBE statement
        for table_name in table_names:
            f.write(f"DESCRIBE {table_name}\n")
            cursor.execute(f"DESCRIBE {table_name}")
            describe_results = cursor.fetchall()
            for column_info in describe_results:
                f.write(str(column_info) + "\n")
            f.write("\n")  # Add a blank line after each table

    # Close the cursor and connection
    cursor.close()
    connection.close()

# Example usage
print_describe("localhost", "root", "hidden_pwd", "swe")


def calculate_max_width(headers, rows):
    max_widths = [len(header) for header in headers]
    for row in rows:
        for i, value in enumerate(row):
            max_widths[i] = max(max_widths[i], len(str(value)))
    return max_widths

def print_tables(host, user, password, database):
    # Connect to the MySQL database
    connection = mysql.connector.connect(
        host=host,
        user=user,
        password=password,
        database=database
    )

    # Create a cursor
    cursor = connection.cursor()

    # Get a list of table names in the specified database
    cursor.execute("SHOW TABLES")
    tables = cursor.fetchall()
    table_names = [table[0] for table in tables]

    # Open the file for writing
    with open("first_five_rows.txt", "w") as f:
        # Loop over each table and fetch the first 5 rows
        for table_name in table_names:
            query = f"SELECT * FROM {table_name} LIMIT 5"
            cursor.execute(query)
            rows = cursor.fetchall()

            f.write(f"Table: {table_name}\n")

            # Print column headers
            cursor.execute(f"DESCRIBE {table_name}")
            headers = [column[0] for column in cursor.fetchall()]
            max_widths = calculate_max_width(headers, rows)
            header_format = "\t".join(f"{{:<{width}}}".format(header) for header, width in zip(headers, max_widths))
            f.write(header_format + "\n")

            # Print first 5 rows
            for row in rows:
                row_format = "\t".join(f"{{:<{width}}}".format(str(value)) for value, width in zip(row, max_widths))
                f.write(row_format + "\n")
            f.write("\n")

    # Close the cursor and connection
    cursor.close()
    connection.close()

# Example usage
print_tables("localhost", "root", "hidden_pwd", "swe")
