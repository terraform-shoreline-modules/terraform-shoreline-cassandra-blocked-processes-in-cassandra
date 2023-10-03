

#!/bin/bash



# set variables

LOG_FILE=${PATH_TO_LOG_FILE}

PERF_METRICS=${PATH_TO_PERF_METRICS}



# analyze system logs

grep -i "blocked" $LOG_FILE



# monitor performance metrics

sar -u 1 10 > $PERF_METRICS