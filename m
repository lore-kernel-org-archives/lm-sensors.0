From: rolf@winmutt.com (Rolf)
Date: Wed, 10 Aug 2005 17:03:08 +0000
Subject: [lm-sensors] Using i2c for inventory/asset management.
Message-Id: <42FA1706.8010608@winmutt.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

My company is starting to implement an auto provisioning mechanism for 
web servers, I want to keep track of memory serial numbers by the data 
in the SPD EEPROM on the sdram.  I can access this fairly easily from 
i2cdump. However, our kernels do not support module loading (for 
security) and I have to compile all the drivers into the kernel. sensors 
exec shows the i2c bus and sensor information from it but i2cdetect 
returns :


Error: No i2c-bus specified!
Syntax: i2cdetect [-y] [-a] [-q|-r] I2CBUS [FIRST LAST]
        i2cdetect -l
        i2cdetect -V
  I2CBUS is an integer
  With -a, probe all addresses (NOT RECOMMENDED)
  With -q, uses only quick write commands for probing (NOT RECOMMENDED)
  With -r, uses only read byte commands for probing (NOT RECOMMENDED)
  If provided, FIRST and LAST limit the probing range.
  With -l, lists installed busses only
Error: No I2C busses found!
Be sure you have done 'modprobe i2c-dev'
and also modprobed your i2c bus drivers


This is on debian with a vanilla kernal recompiled for i2c support. Are 
my i2c tools out of date?
