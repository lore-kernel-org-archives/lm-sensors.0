From: donj@asaca.com (Don Jessup)
Date: Thu, 19 May 2005 06:24:30 +0000
Subject: min max values
Message-Id: <20031215192501.16119.qmail@web14522.mail.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



  I was wondering if someone could suggest good min and max values to put
into the sensors.conf file or a place to find this information. 

  I'm  running a dual xeon motherboard.   Here is the current output
 from  sensors.

Adapter: SMBus PIIX4 adapter at 0580
Algorithm: Non-I2C SMBus adapter
Board:       +26?C  (low  =   -55?C, high =  +127?C)
CPU:         +29?C  (low  =    +0?C, high =   +85?C)

max1617-i2c-0-29
Adapter: SMBus PIIX4 adapter at 0580
Algorithm: Non-I2C SMBus adapter
Board:       +26?C  (low  =   -55?C, high =  +127?C)
CPU:         +27?C  (low  =    +0?C, high =   +85?C)

lm87-i2c-0-2d
Adapter: SMBus PIIX4 adapter at 0580
Algorithm: Non-I2C SMBus adapter

lm87-i2c-0-2e
Adapter: SMBus PIIX4 adapter at 0580
Algorithm: Non-I2C SMBus adapter
2.5V:      +2.52 V  (min =  +2.12 V, max =  +2.87 V)
Vccp1:     +1.47 V  (min =  +0.98 V, max =  +1.99 V)
3.3V:      +3.26 V  (min =  +2.80 V, max =  +3.78 V)
5V:        +4.94 V  (min =  +4.24 V, max =  +5.75 V)
12V:      +12.00 V  (min = +10.18 V, max = +13.81 V)
Vccp2:     +1.50 V  (min =  +1.26 V, max =  +1.71 V)
fan1:     5314 RPM  (min = 2848 RPM, div = 2)
fan2:     5357 RPM  (min = 2848 RPM, div = 2)
temp1:       +30?C  (low  =    +0?C, high =   +65?C)
vid:       +1.35 V




==Don Jessup
Asaca/Shibasoku Corp. of America
400 Corporate Circle, Unit G
Golden, CO  80401
303-278-1111 X232
donj@asaca.com
http://www.asaca.com
