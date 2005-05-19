From: jdrew@somanetworks.com (Joe Drew)
Date: Thu, 19 May 2005 06:23:44 +0000
Subject: Ticket #1078 followup - i2c bus returns all ones
Message-Id: <1040309944.1738.127.camel@albatross.yyz.somanetworks.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

It seems that the i2c bus has somehow been screwed up into returning all
ones for everything on this board. I am still not sure what causes it,
and nothing shows up in dmesg or the syslog. This is using a piix4 i2c
controller.

Is there any way to reset the i2c bus manually? Do you have any insight
on what could be causing these problems?

The following are the relevant bits from a sensors call on a board on
which it seems the i2c bus has been pooched:

ds1780-i2c-0-2f
Adapter: SMBus PIIX4 adapter at 1040
Algorithm: Non-I2C SMBus adapter
V_CPU:     +3.32 V  (min =  +3.32 V, max =  +3.32 V)   ALARM
VTT:       +3.58 V  (min =  +3.58 V, max =  +3.58 V)   ALARM
3.3V:      +4.38 V  (min =  +4.38 V, max =  +4.38 V)   ALARM
5V:        +6.64 V  (min =  +6.64 V, max =  +6.64 V)   ALARM
12V:      +15.93 V  (min = +15.93 V, max = +15.93 V)   ALARM
-12V:      -4.79 V  (min =  -4.79 V, max =  -4.79 V)   ALARM
temp:       -0.5?C  (limit =   -1?C, hysteresis =   -1?C) ALARM

adm1021-i2c-0-4e
Adapter: SMBus PIIX4 adapter at 1040
Algorithm: Non-I2C SMBus adapter
temp:         -1?C  (min =   -1?C, max =   -1?C)ALARM (LOW,HIGH)
remote_temp:
              -1?C  (min =   -1?C, max =   -1?C)ALARM (N/A,LOW)
die_code:  255



And the same from a normal board (same model):


ds1780-i2c-0-2f
Adapter: SMBus PIIX4 adapter at 1040
Algorithm: Non-I2C SMBus adapter
V_CPU:     +1.49 V  (min =  +1.38 V, max =  +1.58 V)   
VTT:       +1.49 V  (min =  +1.37 V, max =  +1.58 V)   
3.3V:      +3.24 V  (min =  +2.93 V, max =  +3.59 V)   
5V:        +4.97 V  (min =  +4.45 V, max =  +5.44 V)   
12V:      +12.06 V  (min = +10.68 V, max = +13.06 V)   
-12V:     -12.65 V  (min = -13.68 V, max = -10.58 V)   
temp:      +35.0?C  (limit =  +45?C, hysteresis =  +40?C) 

adm1021-i2c-0-4e
Adapter: SMBus PIIX4 adapter at 1040
Algorithm: Non-I2C SMBus adapter
temp:        +41?C  (min =  +20?C, max =  +80?C)
remote_temp:
             +34?C  (min =  +20?C, max =  +44?C)
die_code:    5
