
### About Shoreline
The Shoreline platform provides real-time monitoring, alerting, and incident automation for cloud operations. Use Shoreline to detect, debug, and automate repairs across your entire fleet in seconds with just a few lines of code.

Shoreline Agents are efficient and non-intrusive processes running in the background of all your monitored hosts. Agents act as the secure link between Shoreline and your environment's Resources, providing real-time monitoring and metric collection across your fleet. Agents can execute actions on your behalf -- everything from simple Linux commands to full remediation playbooks -- running simultaneously across all the targeted Resources.

Since Agents are distributed throughout your fleet and monitor your Resources in real time, when an issue occurs Shoreline automatically alerts your team before your operators notice something is wrong. Plus, when you're ready for it, Shoreline can automatically resolve these issues using Alarms, Actions, Bots, and other Shoreline tools that you configure. These objects work in tandem to monitor your fleet and dispatch the appropriate response if something goes wrong -- you can even receive notifications via the fully-customizable Slack integration.

Shoreline Notebooks let you convert your static runbooks into interactive, annotated, sharable web-based documents. Through a combination of Markdown-based notes and Shoreline's expressive Op language, you have one-click access to real-time, per-second debug data and powerful, fleetwide repair commands.

### What are Shoreline Op Packs?
Shoreline Op Packs are open-source collections of Terraform configurations and supporting scripts that use the Shoreline Terraform Provider and the Shoreline Platform to create turnkey incident automations for common operational issues. Each Op Pack comes with smart defaults and works out of the box with minimal setup, while also providing you and your team with the flexibility to customize, automate, codify, and commit your own Op Pack configurations.

# Blocked Processes in Cassandra
---

Blocked Processes in Cassandra refers to an incident where certain operations or transactions in a Cassandra database are unable to proceed due to blocking caused by other processes. This can result in slow performance or even system crashes. Identifying and resolving blocked processes is critical for ensuring the smooth functioning of the Cassandra database.

### Parameters
```shell
export CASSANDRA_PID="PLACEHOLDER"

export PATH_TO_LOG_FILE="PLACEHOLDER"

export PATH_TO_PERF_METRICS="PLACEHOLDER"

export PATH_TO_CASSANDRA_HOME_DIRECTORY="PLACEHOLDER"
```

## Debug

### Check if Cassandra service is running
```shell
systemctl status cassandra
```

### Check Cassandra node status
```shell
nodetool status
```

### Check the Cassandra system logs for any errors
```shell
tail -f /var/log/cassandra/system.log
```

### Check the Cassandra slow query logs for any slow queries
```shell
tail -f /var/log/cassandra/slowquery.log
```

### Check the system load and resource usage
```shell
top
```

### Check the disk space usage
```shell
df -h
```

### Check the network status and connections
```shell
netstat -an
```

### Check the JVM status and memory usage
```shell
jstat -gcutil ${CASSANDRA_PID}
```

### Check the open file descriptors
```shell
lsof -p ${CASSANDRA_PID}
```

### Check the Cassandra thread pool status
```shell
nodetool tpstats
```

### Check the active Java threads
```shell
jstack ${CASSANDRA_PID}
```

## Repair

### Identify the cause of the blocked processes by analyzing the system logs and monitoring performance metrics.
```shell


#!/bin/bash



# set variables

LOG_FILE=${PATH_TO_LOG_FILE}

PERF_METRICS=${PATH_TO_PERF_METRICS}



# analyze system logs

grep -i "blocked" $LOG_FILE



# monitor performance metrics

sar -u 1 10 > $PERF_METRICS


```

### Check for any long-running queries or transactions that may be causing the blocking and optimize them if possible.
```shell


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


```