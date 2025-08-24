#!/bin/bash
set -e

RDS_HOST=$1
RDS_USERNAME=$2
RDS_PASSWORD=$3

RDS_HOST_CLEAN="${RDS_HOST%%:*}"

echo "🔍 Checking if 'devops' database exists on $RDS_HOST_CLEAN..."

DB_EXISTS=$(mysql -h "$RDS_HOST_CLEAN" -P 3306 -u"$RDS_USERNAME" -p"$RDS_PASSWORD" -e "SHOW DATABASES LIKE 'devops';" | grep devops || true)

if [ -z "$DB_EXISTS" ]; then
    echo "⚠️ 'devops' database not found. Creating it now..."
    mysql -h "$RDS_HOST_CLEAN" -P 3306 -u"$RDS_USERNAME" -p"$RDS_PASSWORD" -e "CREATE DATABASE devops;"
else
    echo "✅ 'devops' database already exists."
fi

echo "📋 Tables in 'devops':"
mysql -h "$RDS_HOST_CLEAN" -P 3306 -u"$RDS_USERNAME" -p"$RDS_PASSWORD" -e "USE devops; SHOW TABLES;"
