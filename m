From: filip.tsachev@gmail.com (Filip Tsachev)
Date: Fri, 18 Nov 2005 12:46:37 +0000
Subject: [lm-sensors] +5V line... and Stdby fixable?
Message-Id: <ea9ff50b0511180346s58c38f67p465b9e2adad74bc@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

I'd like to ask just one question about my +5V line.

so I made the following modification for my it8712 chip on GB-7N400E-l
board (AMD k7 TB 2GHz):
1. I uncommented compute in2( 3.3V was x2)
2. set sensor 1 2,
set sensor 2 3
3. I need to fix my +5V line, please any help will be really appreciated!

I have a fortron 300W (390W p.m.p.o.) so my+ 5V should be really stable ~

This are the results: (pretty sharp except for +5V and - lines...)

Every 1.0s: sensors
                                                            Fri Nov 18
13:03:26 2005

it8712-isa-0290
Adapter: ISA adapter
VCore 1:   +1.65 V  (min =  +1.57 V, max =  +1.73 V)
VCore 2:   +2.61 V  (min =  +2.46 V, max =  +2.74 V)
+3.3V:     +3.25 V  (min =  +3.14 V, max =  +3.47 V)
+5V:       +4.22 V  (min =  +4.76 V, max =  +5.24 V)   ALARM
+12V:     +11.90 V  (min = +11.39 V, max = +12.61 V)
-12V:     -15.82 V  (min = -12.63 V, max = -11.41 V)   ALARM
-5V:       -8.10 V  (min =  -5.26 V, max =  -4.77 V)   ALARM
Stdby:     +4.52 V  (min =  +4.76 V, max =  +5.24 V)   ALARM
VBat:      +4.08 V
fan1:     2596 RPM  (min = 2410 RPM, div = 8)
fan2:        0 RPM  (min =    0 RPM, div = 8)
M/B Temp:    +34C  (low  =   +15C, high =   +45C)   sensor = thermistor
CPU Temp:    +45C  (low  =   +25C, high =   +55C)   sensor = diode
vid:       +1.60 V


how can I exclude from monitoring the following:
eeprom-i2c-0-51
Adapter: SMBus nForce2 adapter at 1c00
Memory type:            DDR SDRAM DIMM
Memory size (MB):       512

also I would like to have hddtemp? inside sensors? right now I use a
separate tool "hddtemp"
looks like this: /dev/hda: HDT722516DLAT80:  37?C (Hitachi 160GB 7200rpm PATA)



--
Cheers,
Filip
--
Cheers,
Filip
