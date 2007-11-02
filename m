From: Michael Brian Willis <willis@arlut.utexas.edu>
Date: Fri, 02 Nov 2007 21:30:13 +0000
Subject: [lm-sensors] LM75: "ERROR: Can't get temperature data!"
Message-Id: <1194039013.25315.2.camel@louie>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello, 

I am having trouble getting my LM75 temp sensor to work on a custom
embedded system. I have two MAX1619 chips that appear to be recognized
by the "sensors" command. Also, "sensors-detect" seems to find
everybody. However, I get "ERROR: Can't get temperature data" for the
LM75 when I run the "sensors" command (see below).  

--------
[root@myboard]# sensors
max1619-i2c-0-19
Adapter: MPC adapter
M/B Temp: 33.00 (temp1)
CPU Temp: 0.00 (temp2)

max1619-i2c-0-1a
Adapter: MPC adapter
M/B Temp: 30.00 (temp1)
CPU Temp: 127.00 (temp2)

lm75-i2c-0-48
Adapter: MPC adapter
ERROR: Can't get temperature data!

Here are some relevant version numbers: 
Denx Linux kernel: 2.6.21
libsensors: 2.10.5
sysfsutils: 2.1.0
i2ctools: 3.0.0
--------

I have the LM75 kernel module loaded: 
[root@myboard]# lsmod
Module                  Size  Used by
lm75                    4592  0
max1619                 5776  0

Any help anybody can provide is greatly appreciated, 

Regards, 

Michael Willis
Applied Research Labs - University of Texas
willis <at> arlut . utexas . edu







_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
