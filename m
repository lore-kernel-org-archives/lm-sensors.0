From: andrex@alumni.utexas.net (Andrew Schulman)
Date: Thu, 19 May 2005 06:24:25 +0000
Subject: testing on kernel 2.6
Message-Id: <200311181008.19323.andrex@alumni.utexas.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello.  I just saw your answer to ticket # 1442, http://www2.lm-sensors.nu/
~lm78/readticket.cgi?ticket42.  I didn't file that ticket, but I'd like to 
help test lm-sensors on kernel 2.6.

I have an Abit IS7 mobo with Intel 865 chipset.  The i2c hardware bus is Intel 
801 (i2c-801 kernel module), and the monitoring chip is a Winbond W83627HF.  
sensors-detect successfully detects and loads i2c-801 and i2c-dev, before 
failing with "Couldn't open /proc/bus/i2c?!?".  

I'm running kernel 2.6.0-test9 and using the Debian package lm-sensors.  sysfs 
is mounted on /sys.

I'll check out CVS and see if I can get it running.  If there's anything else 
I should know for testing, please let me know.

Andrew Schulman.
