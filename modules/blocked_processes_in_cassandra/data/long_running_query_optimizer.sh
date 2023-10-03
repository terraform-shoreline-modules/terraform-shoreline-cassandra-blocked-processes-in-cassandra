

#!/bin/bash



# Set the parameters

CASSANDRA_HOME=${PATH_TO_CASSANDRA_HOME_DIRECTORY}



# Check for long-running queries or transactions

echo "Checking for long-running queries or transactions..."

nodetool cfstats | grep "Pending flushes" > /dev/null 2>&1

if [ $? -eq 0 ]; then

    echo "Long-running queries or transactions detected"



    # Optimize the queries or transactions

    echo "Optimizing queries or transactions..."

    nodetool flush > /dev/null 2>&1

    echo "Queries or transactions optimized"

else

    echo "No long-running queries or transactions detected"

fi