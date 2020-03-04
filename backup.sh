#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd $SCRIPT_DIR
# Import environment from .env file
export $(egrep -v '^#' .env | xargs)
# Parse list of apps to an array
IFS=';' read -ra APPS <<< "$APPS_TO_BACKUP"
# Write email subject
echo "Subject: $BACKUP_NAME Backup Report"
DRC_PART_START="docker run --rm -v $HOME/.ssh:/root/.ssh:ro -v $SCRIPT_DIR/borg.yml:/etc/borgmatic/config.yaml:ro -v /etc/localtime:/etc/localtime:ro"
# Run backup for each app
for APP in "${APPS[@]}"
do
  start=`date +%s`
  echo $APP" backup..."
  cd $SCRIPT_DIR/$APP
  DRC_PART_CUSTOM="monachus/borgmatic borgmatic --override location.repositories=[$BORG_REPO_HOST:$BORG_REPO_DIR/$APP.borg] storage.encryption_passphrase=$BORG_KEY"
  # Initialize repo
  BACKUP_INIT="$DRC_PART_START $DRC_PART_CUSTOM init --encryption repokey"
  eval $BACKUP_INIT
  # Stop containers
  docker-compose stop && echo "  Stopped Containers."
  # Get volume names
  APP_VOLUMES=$(docker volume ls -q -f "name=$APP")
  # Convert string to array
  APP_VOLUMES_ARRAY=($APP_VOLUMES)
  # Prepare backup command
  BACKUP_VOLUMES=""
  for APP_VOLUME in "${APP_VOLUMES_ARRAY[@]}"
  do
    BACKUP_VOLUMES="$BACKUP_VOLUMES -v $APP_VOLUME:/backup_data/$APP_VOLUME:ro"
  done
  BACKUP_CREATE="$DRC_PART_START $BACKUP_VOLUMES $DRC_PART_CUSTOM create"
  eval $BACKUP_CREATE
  # Start containers
  docker-compose start && echo "  Started Containers."
  # Finish mesuring time and display
  end=`date +%s`
  echo "  "$(date -d@$((end-start)) -u +%H:%M:%S)
done
echo ""
# Execute rclone
echo "---"
start=`date +%s`
ssh $BORG_REPO_HOST "rclone sync $BORG_REPO_DIR $RCLONE_DESTINATION --transfers 32"
end=`date +%s`
echo "rclone... "$(date -d@$((end-start)) -u +%H:%M:%S)
echo ""
# Display repo sizes
echo "---"
echo $(ssh $BORG_REPO_HOST "cd $BORG_REPO_DIR && du -sh *")
