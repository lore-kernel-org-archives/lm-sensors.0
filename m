From: gilbertd@treblig.org (Dr. David Gilbert)
Date: Thu, 19 May 2005 06:23:26 +0000
Subject: lm-sensors - hangs on Tyan Tiger S2460 motherboard
Message-Id: <Pine.LNX.4.33.0111270938090.30031-100000@springhead.px.uk.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20011125202705.A612@gallifrey>
In-Reply-To: <20011125202705.A612@gallifrey>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 25 Nov 2001, Mark D. Studebaker wrote:

> get lm_sensors-2.6.2 and try 'modprobe w83781d init=0'

Thanks Mark,
  That partially seems to have done the trick. It now doesn't die, but the 
output of sensors is mostly bogus; see the results below. The 75degC 
corresponds to the value shown in the BIOS for the two processors (scary 
isn't it....but it does seem to be normal for Athlon MP).  The BIOS does 
show some fan speeds and the results of sensors for all the voltages looks 
very dodgy.

Also the sensors-detect program is finding three eeproms (also in the 
sensors output) - I only have two DIMMs though; so I don't know what the 
other one is.  Is there some nice program to dump the eeprom contents?

A change from 2.6.1 is that sensors_detect now suspects it has either an 
LM75 or Dallas DS???? (sorry forgot) at location 0x47 and 0x48; (both with 
confidence 3) - 2.6.2 just thought it might be a LM75.  I guess that means 
there is something there we just don't know what?

Dave

P.S. Someone on the sensors@stimpy list seems to have a broken fetchmail; 
I got some bounce messages from an ill procmail.  It was difficult to 
figure out exactly where from, but I think the machine is called frodo and 
is somewhere on chello.nl

eeprom-i2c-0-50
Adapter: SMBus AMD7X6 adapter at 80e0
Algorithm: Non-I2C SMBus adapter

eeprom-i2c-0-51
Adapter: SMBus AMD7X6 adapter at 80e0
Algorithm: Non-I2C SMBus adapter

eeprom-i2c-0-54
Adapter: SMBus AMD7X6 adapter at 80e0
Algorithm: Non-I2C SMBus adapter

w83782d-i2c-0-2d
Adapter: SMBus AMD7X6 adapter at 80e0
Algorithm: Non-I2C SMBus adapter
VCore 1:   +1.72 V  (min =  +1.74 V, max =  +1.93 V)       ALARM  
VCore 2:   +1.76 V  (min =  +1.74 V, max =  +1.93 V)       ALARM  
+3.3V:     +1.53 V  (min =  +3.13 V, max =  +3.45 V)              
+5V:       +4.75 V  (min =  +4.72 V, max =  +5.24 V)              
+12V:      +4.60 V  (min = +10.79 V, max = +13.19 V)              
-12V:      -2.16 V  (min = -10.90 V, max = -13.21 V)              
-5V:       +2.68 V  (min =  -4.76 V, max =  -5.26 V)              
V5SB:      +4.23 V  (min =  +4.72 V, max =  +5.24 V)              
VBat:      +3.26 V  (min =  +2.40 V, max =  +3.60 V)              
fan1:        0 RPM  (min = 3000 RPM, div = 2)                     
fan2:        0 RPM  (min = 3000 RPM, div = 2)                     
fan3:        0 RPM  (min = 3000 RPM, div = 2)                     
temp1:     +75.0?C  (limit =  +60?C, hysteresis =  +50?C) sensor = thermistor           
temp2:       +75?C  (limit =  +80?C, hysteresis =  +75?C) sensor = thermistor           
temp3:       +76?C  (limit =  +80?C, hysteresis =  +75?C) sensor = thermistor           
vid:      +1.85 V
alarms:   Chassis intrusion detection                      ALARM  
beep_enable:
          Sound alarm enabled
-- 
/------------------------------------------------------------------\
| Dr. David Alan Gilbert |                                         |
| -------- G7FHJ --------|---------------------------------------- |
| Home: dave @ treblig.org          http://www.treblig.org         |
\------------------------------------------------------------------/
