From: jb@sourceillustrated.com (John Wells)
Date: Thu, 19 May 2005 06:23:39 +0000
Subject: KT333 || VT8233A || GA-7VRX
Message-Id: <1032405369.4065.7.camel@margar1taville>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi guys.  

I'm new to lm_sensors, but got it installed yesterday on one of my 
systems.  The system contains an Gigabyte GA-7VRX, which in turn has a
Via KT333 and a VT8233A (among other chips).

Anyway, the modules the install told me to try were:
i2c-viapro
adm1021
eeprom

However, this was after quite a bit of mucking around with a few install
sequences on my part, and *before* I read the online documentation (I
know, I know ;-)).

When I run sensors now, I get the following output:

max1617-i2c-0-4c
Adapter: SMBus Via Pro adapter at 0400
Algorithm: Non-I2C SMBus adapter
temp:        +41?C  (min =  +20?C, max =  +60?C)
remote_temp:
             +42?C  (min =  +20?C, max =  +60?C)

eeprom-i2c-0-50
Adapter: SMBus Via Pro adapter at 0400
Algorithm: Non-I2C SMBus adapter
Memory type:            DDR SDRAM DIMM SPD
SDRAM Size (MB):        512


That's it.  Temperature and memory size. 

Does anyone have experience with this board or the VT8233A(CE)?  Is this
all the info I can get, or am I missing something here.

Any pointers in the right direction will be greatly appreciated.

Thanks!
John


