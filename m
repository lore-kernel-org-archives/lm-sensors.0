From: laytonjb@bellsouth.net (Jeffrey B. Layton)
Date: Thu, 19 May 2005 06:23:49 +0000
Subject: Problem with SiS950 on ECS MB
Message-Id: <3E6BEDA8.4050009@bellsouth.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <3E6265CB.6030005@bellsouth.net>
In-Reply-To: <3E6265CB.6030005@bellsouth.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Mark D. Studebaker wrote:

> it87 alarm handling was changed long ago in sensors 2.6.2. You have a 
> 'sensors'/libsensors mismatch,
> one of them is very very old. Check /usr/lib for old libsensors files.
> This may or may not fix your temps too.


You're good. That was the problem (installed lm-sensors with RH 7.3
and forgot to rpm -e them). So I rebuilt i2c and lm-sensors 2.7.0.
Finished off all of the steps and here is what "sensors" produces:

eeprom-i2c-0-50
Adapter: SMBus SIS630 adapter at 5080
Algorithm: Non-I2C SMBus adapter
Memory type:            SDRAM DIMM SPD
Memory size (MB):       256

eeprom-i2c-0-51
Adapter: SMBus SIS630 adapter at 5080
Algorithm: Non-I2C SMBus adapter
Memory type:            SDRAM DIMM SPD
Memory size (MB):       256

it87-isa-0290
Adapter: ISA adapter
Algorithm: ISA algorithm
VCore 1:   +2.00 V  (min =  +1.53 V, max =  +1.87 V)   ALARM
VCore 2:   +2.49 V  (min =  +2.25 V, max =  +2.75 V)
+3.3V:     +6.80 V  (min =  +2.96 V, max =  +3.60 V)   ALARM
+5V:       +5.04 V  (min =  +4.50 V, max =  +5.48 V)
+12V:     +12.28 V  (min = +11.36 V, max = +13.80 V)
-12V:      -1.36 V  (min = -15.86 V, max = -13.40 V)   ALARM
-5V:       -9.01 V  (min = -10.13 V, max =  -9.44 V)   ALARM
Stdby:     +4.89 V  (min =  +4.50 V, max =  +5.48 V)
VBat:      +3.32 V
fan1:     4787 RPM  (min = 3000 RPM, div = 2)
fan2:        0 RPM  (min = 3000 RPM, div = 2)          ALARM
fan3:     3552 RPM  (min = 3000 RPM, div = 2)
Temp1/MB:    -55?C  (min =  +20?C, max =  +60?C)
Temp2/CPU:  -118?C  (min =  +20?C, max =  +60?C)
Temp3:       -16?C  (min =  +20?C, max =  +60?C)


The temps look off again. Do I have to modify /etc/sensors.conf
from the stock for the SiS630 or perhaps load the it87 modules
with a 'temp_type' option? (I'm not sure for the ECS MB I have).

Thanks for all of the help!

Jeff


