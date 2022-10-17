import cx_Oracle
import config
import csv

username = ''
password = ''

try:
    conn = cx_Oracle.connect(username, password, 'oracle12c.hua.gr:1521/orcl')
except Exception as err:
    print('Connection error:')
    print(err)
else:
    print(conn.version)
    try:


        cur = conn.cursor()
        sql_insert = """INSERT INTO COUNTRIES VALUES (:1, :2)"""
        with open('Countries.csv') as csv_file:
            csv_reader = csv.reader(csv_file, delimiter=',')
            header = next(csv_reader)
            for row in csv_reader:
                row[0] = int(row[0])
                cur.execute(sql_insert, row)

        sql2_insert = """INSERT INTO Vaccine_Companies VALUES (:1, :2, :3, :4)"""
        with open('Vaccine Companies.csv') as csv_file:
            csv_reader = csv.reader(csv_file, delimiter=',')
            header = next(csv_reader)
            for row in csv_reader:
                row[0] = int(row[0])
                cur.execute(sql2_insert, row)

        sql3_insert = """INSERT INTO Vaccination_Centers VALUES (:1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12, :13, :14)"""
        data = list()
        with open('Vaccination Centers.csv', encoding="utf8") as csv_file:
            csv_reader = csv.reader(csv_file, delimiter=',')
            header = next(csv_reader)
            for row in csv_reader:
                row[0] = int(row[0])
                row[1] = int(row[1])
                row[6] = int(row[6])
                row[9] = int(row[9])
                row[10] = float(row[10])
                row[11] = float(row[11])
                data.append(tuple(row))
            cur.executemany(sql3_insert, data)

        sql4_insert = """INSERT INTO Population VALUES (:1, :2, :3, :4, to_date(:5, 'YYYY-MM-DD'), :6, :7, :8, :9, :10, :11)"""
        data_1 = list()
        with open('Population.csv', encoding="utf8") as csv_file:
            csv_reader = csv.reader(csv_file, delimiter=',')
            header = next(csv_reader)
            for row in csv_reader:
                row[4] = "-".join(row[4].split('/')[::-1])
                row[7] = int(row[7])
                row[10] = int(row[10])
                data_1.append(tuple(row))
            cur.executemany(sql4_insert, data_1)

        sql5_insert = """INSERT INTO Vaccinations VALUES (:1, :2, :3, :4, to_date(:5, 'YYYY-MM-DD'), :6, to_date(:7, 'YYYY-MM-DD'), :8)"""
        data_2 = list()
        with open('Vaccinations.csv', encoding="utf8") as csv_file:
            csv_reader = csv.reader(csv_file, delimiter=',')
            header = next(csv_reader)
            count = 1
            for row in csv_reader:

                row.insert(0, count)
                if row[2] == '':
                    row[2] = None
                else:
                    row[2] = int(row[2])
                
                if row[4] == '':
                    row[4] = None
                else:
                    row[4] = "-".join(row[4].split('/')[::-1])

                if row[6] == '':
                    row[6] = None
                else:
                    row[6] = "-".join(row[6].split('/')[::-1])

                if row[7] == '':
                    row[7] = None
                else:
                    row[7] = int(row[7])

                data_2.append(tuple(row))
                count+=1
            cur.executemany(sql5_insert, data_2)

    except Exception as err:
        print('Error while inserting the data')
        print(err)
    else:
        print('Data added')
finally: 
    conn.commit()
    cur.close()
    conn.close()