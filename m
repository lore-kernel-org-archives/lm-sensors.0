From: sascha@akv-soft.de (Sascha Volkenandt)
Date: Thu, 19 May 2005 06:24:05 +0000
Subject: Update: SAA1064
Message-Id: <200307162122.07079.sascha@akv-soft.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello folks, hi Jean,

I've updated my i2c-machine to 2.4.21 with an i2c layer from yesterday's 
CVS, as well as lm_sensors2 from yesterday. All checked out like suggested 
on your download page.

I have adapted the SAA1064 driver code to that version of lm_sensors (again 
using pcf8574.c as a template to what has changed), and I've also fixed 
some bugs, specifically:

- enhanced functionality test in saa1064_detect
- fixed handling of kind in saa1064_detect
- always force saa1064, since no real autodetection possible (yet)
- used i2c_smbus_write_data instead of i2c_master_send
+ added reading the status byte (sysctl PWRLOSS indicates LED power loss 
since last readout)

Greetings,
Sascha
-------------- next part --------------
A non-text attachment was scrubbed...
Name: saa1064.c
Type: text/x-csrc
Size: 16783 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20030716/e5dfc1cc/saa1064.bin
