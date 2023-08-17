#!/bin/bash

ps -eo pid,ppid,cmd,%cpu,%mem,time --sort=-time | head -n 3