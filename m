From: jhg@jhmg.net (Jim Garrison)
Date: Thu, 19 Oct 2006 21:07:09 +0000
Subject: [lm-sensors] Intel DG965WH (ICH8) question
Message-Id: <4537E8FD.6060202@jhmg.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Is this combination one of the ones that's not yet
available?  sensors-detect seems to work, but sensors
says it can't find anything.

Here's some output:

> [jhg at athena ~]$ lsmod|grep i2c
> i2c_i801               11981  0
> i2c_dev                13509  0
> i2c_ec                  9537  1 sbs
> i2c_core               25793  3 i2c_i801,i2c_dev,i2c_ec
> 
> [jhg at athena ~]$ lsmod |grep sbs
> sbs                    20353  0
> i2c_ec                  9537  1 sbs
> 
> [jhg at athena ~]$ lsmod |grep eeprom
> eeprom                 11473  0
> i2c_core               25793  4 eeprom,i2c_i801,i2c_dev,i2c_ec
> 
> [jhg at athena ~]$ i2cdetect -l
> i2c-0   unknown         SMBus I801 adapter at 2000              Algorithm unavailable
> 
> [jhg at athena ~]$ sensors -s
> No sensors found!
> Make sure you loaded all the kernel drivers you need.
> Try sensors-detect to find out which these are.

-- 
Jim Garrison (jhg at acm.org)
PGP Keys at http://www.jhmg.net RSA 0x04B73B7F DH 0x70738D88


