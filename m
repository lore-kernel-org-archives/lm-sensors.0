From: phil@edgedesign.us (Philip Edelbrock)
Date: Thu, 19 May 2005 06:25:20 +0000
Subject: [Fwd: problem with lm_sensors]
Message-Id: <417E8238.8060109@edgedesign.us>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



-------- Original Message --------
Date: Tue, 26 Oct 2004 16:59:54 +0200
From: Dario Ciriminna <dario@deskservice.com>
X-Mailer: The Bat! (v2.00.6) Business
Reply-To: Dario Ciriminna <dario@deskservice.com>
To: phil@netroedge.com
CC: mdsxyz123@yahoo.com
Subject: problem with lm_sensors

Hello boys,

i have installed your package and everything goes OK... including
sensor detect....
i've choose option 1 (separately)
My linuxbox is running with kernel 2.4.27 on an Athlon 2.8ghz 1 gb

well... when i lauch sensors this is the output....

[root@server root]# sensors
eeprom-i2c-1-50
Adapter: SMBus Via Pro adapter at 5000
Memory type:            DDR SDRAM DIMM
Memory size (MB):       512

eeprom-i2c-1-52
Adapter: SMBus Via Pro adapter at 5000
Memory type:            DDR SDRAM DIMM
Memory size (MB):       512

it87-isa-0290
Adapter: ISA adapter
VCore 1:   +1.60 V  (min =  +1.42 V, max =  +1.57 V)   ALARM
VCore 2:   +2.66 V  (min =  +2.40 V, max =  +2.61 V)   ALARM
+3.3V:     +4.00 V  (min =  +3.14 V, max =  +3.46 V)   ALARM
+5V:       +2.60 V  (min =  +4.74 V, max =  +5.24 V)   ALARM
+12V:      +2.76 V  (min = +11.40 V, max = +12.60 V)   ALARM
-12V:     -27.36 V  (min = -12.63 V, max = -11.41 V)   ALARM
-5V:      -13.64 V  (min =  -5.24 V, max =  -4.76 V)   ALARM
Stdby:     +0.00 V  (min =  +4.74 V, max =  +5.24 V)   ALARM
VBat:      +3.20 V
fan1:     4218 RPM  (min =    0 RPM, div = 8)
fan2:        0 RPM  (min = 3013 RPM, div = 8)          ALARM
fan3:        0 RPM  (min = 3013 RPM, div = 8)
M/B Temp:   +127?C  (low  =   +15?C, high =   +40?C)   sensor = thermistor
CPU Temp:    +33?C  (low  =   +15?C, high =   +45?C)   sensor = diode
Temp3:      +127?C  (low  =   +15?C, high =   +45?C)   sensor = thermistor

Everything is on alarm...

please don't tell me to check the bios value because the server is not
phisically here.... it's a little bit strange (My Server is perfect...i've
checked everything before to leave it in a webfarm, 1 week ago)

Thanks for helping and waiting 4 reply !

Saluti,

Dario Ciriminna

----------------------------------------------------

Desk s.r.l.
Via G.B.Vaccarini n?36
90143 Palermo
Italy

E-Mail : dario@deskservice.com
Web : http://www.deskservice.com
ICQ : UIN n? 3986985
Tel.  +39-091-6262332
Fax   +39-091-6262424
----------------------------------------------------

