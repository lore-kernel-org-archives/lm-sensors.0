From: cli@aproimage.com (Calvin Li)
Date: Thu, 19 May 2005 06:23:40 +0000
Subject: more questions about Ticket # 1003
Message-Id: <004b01c26676$2a955900$fb00a8c0@cli>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

I posted a ticket #1003 regarding lm_snesors.  After reinstall a RedHat 7.3
and I2C / Lm_sensor 2.6.5.

The only response I got after " sensors " command is :

"
eeprom-i2c-0-54
Adapter : SMBus I801 adaptor at 1400
Algorithm : Non-I2C SMBus adapter
Memory Type : SDRAM DIMM SPD
SDRAM size (MB ) : 512

fscpos-i2c-o-73
Adapter : SMBus I801 adapter at 1400
Algorithm : Non-I2C SMBus adapter
"
There is no temperature reading at all!


in ticket 1003 , I got the following response :
"
did the driver find the chip (look in dmesg/syslog)
is there an fscpos entry in /proc/sys/dev/sensors?
Are you running the latest version of ?sensors? from 2.6.5?
It should work.
If you need more help email us, ref. your ticket number.
"
1. " /bin/dmesg " : it responded : fscpos.o version 2.6.5 ( 20020915 )
2. in /proc/sys/dev/sensors, there is an entry "fscpos-i2c-o-73"
3. both the sensors and i2c are ver. 2.6.5.

Regards,

Calvin Li, American ProImage
cli@aproimage.com
