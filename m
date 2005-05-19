From: Edwin.van.Opstal@SE-Technology.com (Edwin van Opstal)
Date: Thu, 19 May 2005 06:24:01 +0000
Subject: lm80 settings
Message-Id: <45898.192.168.0.1.1056436807.squirrel@server.setech>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

I have installed the lm_sensors package for temperature monitoring of my
ABIT KG7 mainboard, but when I ran "sensors" I got bogus output (see
attached text). I looked into the /etc/sensors.conf file which suggested I
contact you for LM80 settings.
How can I find these out myself or do you happen to have the necessary
settings from another user?

Thanks for your time.

Best regards,
Edwin

-- 
Edwin van Opstal
S.E. Technology
-------------- next part --------------
lm80-i2c-0-2d
Adapter: SMBus Via Pro adapter at 5000
Algorithm: Non-I2C SMBus adapter
+5V:       +4.03 V  (min =  +4.50 V, max =  +3.00 V)   ALARM
VTT:       +1.85 V  (min =  +1.71 V, max =  +2.09 V)   ALARM
+3.3V:     +2.55 V  (min =  +2.97 V, max =  +3.63 V)   ALARM
+Vcore:    +3.26 V  (min =  +2.52 V, max =  +3.08 V)   ALARM
+12V:     +13.64 V  (min = +10.80 V, max = +13.20 V)   ALARM
-12V:      -7.09 V  (min =  -8.68 V, max =  -6.60 V)   
-5V:       -2.70 V  (min =  -3.44 V, max =  -2.22 V)   ALARM
fan1:     10546 RPM  (min = 6000 RPM, div = 1)          
fan2:     5465 RPM  (min = 6000 RPM, div = 1)          
temp:     -128.00 ?C (hot:limit =  +6?C,  hysteresis =  +5?C) ALARM
         (os: limit =  +6?C,  hysteresis =  +5?C) ALARM
alarms:   Board temperature input (LM75)               ALARM

eeprom-i2c-0-52
Adapter: SMBus Via Pro adapter at 5000
Algorithm: Non-I2C SMBus adapter
Memory type:            DDR SDRAM DIMM SPD
SDRAM Size (MB):        256

eeprom-i2c-0-53
Adapter: SMBus Via Pro adapter at 5000
Algorithm: Non-I2C SMBus adapter
Memory type:            DDR SDRAM DIMM SPD
SDRAM Size (MB):        256
