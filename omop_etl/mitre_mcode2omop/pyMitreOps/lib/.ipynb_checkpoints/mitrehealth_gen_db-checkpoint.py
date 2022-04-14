# import modules
from sqlalchemy import create_engine
import pymysql
import pandas as pd
import json
import yaml

# ********** FUNCTIONS ***********

def config_init(db_config_filename):
    try:
        with open(db_config_filename, 'r') as config_file:
            db_config_dict = {} # create the empty dictionary for populating config parameters
            fhir_config_dict = {}
            config_info = yaml.safe_load(config_file) # read in the yaml file
            db_config_dict["dbservertype"] = config_info['dbConfig']['dbtype']
            db_config_dict["dbservername"] = config_info['dbConfig']['host']
            db_config_dict["dbport"] = config_info['dbConfig']['port']
            db_config_dict["username"] = config_info['dbConfig']['username']
            db_config_dict["dbpassword"] = config_info['dbConfig']['password']
            db_config_dict["dbname"] = config_info['dbConfig']['dbname']
            fhir_config_dict["fhir_endpoint"] = config_info['fhirServer']['url']
            fhir_config_dict["fhir_port"] = config_info['fhirServer']['port']
        return(db_config_dict, fhir_config_dict);
    except Exception as e:
        print (f"Error: {e}")
        
def db_connect(config_info):
    dbtypename = config_info["dbservertype"]
    print(f"dbservertype: {dbtypename}")
    if config_info["dbservertype"] == "mysql":
        try:  
            # pass in the dictionary from config_init and populate the pymysql.connect() call with these fields
            # print(f"inside db_connect (mysql) - config_info: {d_config_info}")
            connection = pymysql.connect(host = config_info["dbservername"],
                                         user = config_info["username"],
                                         password = config_info["dbpassword"],
                                         # port='3306',
                                         db = config_info["dbname"],
                                         charset='utf8mb4',
                                         cursorclass=pymysql.cursors.DictCursor) 
            print("connect successful!!")
            return connection
        except Exception as e:
            print (f"Error: {e}")
    elif config_info["dbservertype"] == "psql":
        # print(f"inside db_connect (psql) - d_config_info: {d_config_info}")
        try:  
            # pass in the dictionary from config_init and populate the pymysql.connect() call with these fields
            print(f"inside db_connect (psql) - config_info: {config_info}")
            connection = "postgresql://" + config_info["username"] + ":" + config_info["dbpassword"] + "@" + config_info["dbservername"] + ":" + config_info["dbport"] + "/" + config_info["dbname"]
            # print(f"psql connection string: {connection}")
            return connection
        except Exception as e:
            print (f"Error: {e}")
    else:
        print("unknown DB server type. Specify mysql or psql")


def db_disconnect(connection,config_info):
    if config_info["dbservertype"] == "mysql":
        try:
            # Close connection.
            connection.close()
            print("db connection closed")
        except Exception as e:
            print (f"Error: {e}")        