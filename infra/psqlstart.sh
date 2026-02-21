#!/bin/bash

sudo systemctl enable postgresql
sudo systemctl start postgresql
sudo systemctl restart postgresql
sudo systemctl status postgresql
