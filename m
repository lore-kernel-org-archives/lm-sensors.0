From: randhol@pvv.org (Preben Randhol)
Date: Thu, 19 May 2005 06:24:17 +0000
Subject: A7V8X-X and lm sensors
Message-Id: <20030918153623.GA3679@pvv.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi

I have a A7V8X-X motherboard and I'm running kernel 2.4.21. I downloaded
and tried the lm sensors 2.8.0.

I get the same wrong results as I saw somebody had reported already.
However I played a bit with the temp_type setting of it87. 


I'm ignoring Temp3: 

If it do:

modprobe it87 temp_type=0x1c

or

modprobe it87 temp_type=0x38

I get:

   sensors
   eeprom-i2c-0-50
   Adapter: SMBus Via Pro adapter at e800
   Algorithm: Non-I2C SMBus adapter
   Memory type:            DDR SDRAM DIMM SPD
   Memory size (MB):       256

   it87-isa-0290
   Adapter: ISA adapter
   Algorithm: ISA algorithm
   VCore 1:   +1.68 V  (min =  +1.53 V, max =  +1.87 V)   
   VCore 2:   +0.00 V  (min =  +2.25 V, max =  +2.75 V)   ALARM
   +3.3V:     +6.58 V  (min =  +2.96 V, max =  +3.60 V)   ALARM
   +5V:       +4.77 V  (min =  +4.50 V, max =  +5.48 V)   
   +12V:     +12.32 V  (min = +11.36 V, max = +13.80 V)   
   -12V:     -27.36 V  (min = -15.86 V, max = -13.40 V)   ALARM
   -5V:      -13.64 V  (min = -10.13 V, max =  -9.44 V)   ALARM
   Stdby:     +4.99 V  (min =  +4.50 V, max =  +5.48 V)   
   VBat:      +4.08 V
   fan1:     2800 RPM  (min = 3000 RPM, div = 2)          ALARM
   fan2:        0 RPM  (min = 3000 RPM, div = 2)          ALARM
   fan3:        0 RPM  (min = 3000 RPM, div = 2)          ALARM
   Temp1/MB:    +49?C  (min =  +20?C, max =  +60?C) 
   Temp2/CPU:   +30?C  (min =  +20?C, max =  +60?C) 
   Temp3:      +127?C  (min =  +20?C, max =  +60?C) 

BIOS reports that my MB temperature is about 30C and that the CPU is
about 59C. So here is actually looks like Temp1 and Temp2 should be
swapped. I don't know if this makes sense though. But when I tested I
first checked with sensors some times and I saw it gave a stable
temperature. Then I ran glxgears as this uses 100% cpu more or less. I
could see that the temperature rose. Then I stopped it and opened the
window as it was only 14C outside. I could now see that the Temperature
was dropping again. After some time I saw that Temp2 dropped a couple of
degrees too which makes sense as I hace also seen in the BIOS that the
MB temp drops a bit when I open the window and air out well.

So what is looks like is that the temperature are swappend and that the
CPU temperature needs adjustment to fit with the BIOS readings. 

The fan1 speed looks right to me. I think the Voltage readings are
correct too except for the +3.3V.

Hope this helps. If there is anything I can do to give you more
information please let me know. I would like to be able to monitor the
CPU temp on my computer form linux :-)

Keep up the good work.

Preben Randhol
