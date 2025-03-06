set -e

mongo <<EOF
db = db.getSiblingDB('graylog')

db.createUser({
  user: 'graylog',
  pwd: '$MONGO_GRAYLOG_PASSWORD',
  roles: [{ role: 'readWrite', db: 'graylog' }],
});

EOF