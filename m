From: perezmeyer@infovia.com.ar (Lisandro =?ISO-8859-1?Q?Dami=E1n?= Nicanor =?ISO-8859
Date: Fri, 23 Sep 2005 00:23:20 +0000
Subject: [lm-sensors] Difference in a statement in sensors.conf and my
Message-Id: <1127427705.16229.0.camel@localhost.localdomain>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I found the following:

# The A7V8X-X has temperatures inverted, and needs a conversion for
# CPU temp. Thanks to Preben Randhol for the formula.
   label temp1       "CPU Temp"
   label temp2       "M/B Temp"
  #compute temp1     (-15.096+1.4893*@), (@+15.096)/1.4893

The last commented formula is not true (or at least comparing it to the
BIOS one). In fact, if I uncomment it, I get more than 10? of difference
between mother and CPU (which is not the case in the BIOS, and I also
found it rather extrange).

More info:

ASUS A7V8X-X, Debian Sarge, libsensors3-2.8.8-7, lm-sensors-2.8.8-7, and
idem for sensord.

lisandro@dumbledore:~$ uname -a
Linux dumbledore 2.6.8-1-k7 #1 Thu Nov 25 04:13:37 UTC 2004 i686
GNU/Linux

lisandro@dumbledore:~$ sensors
it87-isa-0290
Adapter: ISA adapter
VCore 1:   +1.60 V  (min =  +1.42 V, max =  +1.58 V)   ALARM
VCore 2:   +0.00 V  (min =  +2.40 V, max =  +2.61 V)   ALARM
+3.3V:     +3.22 V  (min =  +3.14 V, max =  +3.47 V)
+5V:       +4.78 V  (min =  +4.76 V, max =  +5.24 V)
+12V:     +12.10 V  (min = +11.39 V, max = +12.61 V)
-12V:     -27.36 V  (min = -12.63 V, max = -11.41 V)   ALARM
-5V:      -13.64 V  (min =  -5.26 V, max =  -4.77 V)   ALARM
Stdby:     +4.92 V  (min =  +4.76 V, max =  +5.24 V)
VBat:      +4.08 V
fan1:     3013 RPM  (min =    0 RPM, div = 2)
fan2:        0 RPM  (min = 3000 RPM, div = 2)          ALARM
fan3:        0 RPM  (min = 3000 RPM, div = 2)          ALARM
CPU Temp:    +44?C  (low  =   +15?C, high =   +40?C)   sensor thermistor
M/B Temp:    +40?C  (low  =   +15?C, high =   +45?C)   sensor thermistor
Temp3:        -1?C  (low  =   +15?C, high =   +45?C)   sensor = disabled

eeprom-i2c-0-50
Adapter: SMBus Via Pro adapter at e800
Memory type:            DDR SDRAM DIMM
Memory size (MB):       512


Cheers, Damian.-


