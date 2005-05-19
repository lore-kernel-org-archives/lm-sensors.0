From: kirill_smelkov@mail.ru (Kirill Smelkov)
Date: Thu, 19 May 2005 06:23:28 +0000
Subject: I would like to subscribe to your mailing list & other
Message-Id: <E16QQ4h-000Ldi-00@f6.mail.ru>
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

Hello. I would like to subscribe to lm_sensors mailing list.
Could it be possible?

Also i include my first question. If someone could help -- it will be great.

Hi Folks.

Recently we tried to get lm_sensors 2.6.2 working on our i810e motherboard but
unfortunately a problem occured.

------------------------------------
Here follows the problem description:

We want to get an I2C driver for graphics related stuff found in intel boards
such as DDC bus & I2C bus which is usually
connected to tv encoders.

the kernel driver related to this stuff (as i suppose) is named i2c-i810.c and
supports only next pci sub id's:
0x7121
0x7123
0x1132

As i think we have the next version of 0x7123 chip (CGC rev 03). Here is a part
of lspci & lspci -n output

00:00.0 Host bridge: Intel Corporation 82810E GMCH [Graphics Memory Controller
Hub] (rev 03)
00:01.0 VGA compatible controller: Intel Corporation 82810E CGC [Chipset
Graphics Controller] (rev 03)

00:00.0 Class 0600: 8086:7124 (rev 03)
00:01.0 Class 0300: 8086:7125 (rev 03)

the problem is that this hardware is not supported by driver.

I've tried to add 7125 support to the driver -- it loads, operates, but no
devices are found on any bus
(though monitor & tv encoder should respond) by the program "i2cdetect":


Script started on Tue Jan 15 11:48:02 2002
]0;root@smolensk:
/opt/terminus/src/i810-tv/related/lm_sensors-2.6.2/prog/detect[root@smolensk
detect]# ./i2cdetect 
Error: No i2c-bus specified!
Syntax: i2cdetect I2CBUS
  I2CBUS is an integer
  Installed I2C busses:
    i2c-0	smbus    	SMBus I801 adapter at 5000      	Non-I2C SMBus adapter

    i2c-1	i2c       	I810/I815 I2C Adapter           	Bit-shift algorithm

    i2c-2	i2c       	I810/I815 DDC Adapter           	Bit-shift algorithm

]0;root@smolensk:
/opt/terminus/src/i810-tv/related/lm_sensors-2.6.2/prog/detect[root@smolensk
detect]# ./i2cdetect 1
  WARNING! This program can confuse your I2C bus, cause data loss and worse!
  I will probe file /dev/i2c-1
  You have five seconds to reconsider and press CTRL-C!

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX 
10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX 
20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX 
30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX 
40: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX 
50: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX 
60: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX 
70: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX 

[...]

and the same for i2c-2 bus

Script done on Tue Jan 15 11:57:18 2002

Note that an i2cdetect scan takes about 5 minutes with 100% cpu load.

Accoring to intel documentation the driver preforms (to my unexpirienced view)
right operations
(i mean GPIOA & GPIOB are correct & other constants are ok)

PLEASE CONSIDER HELP WITH OUR PROBLEM


     Regards Kirr.
