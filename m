From: james.kirkpatrick@imperial.ac.uk (James Kirkpatrick)
Date: Mon, 24 Jul 2006 11:46:26 +0000
Subject: [lm-sensors] voltage reading too low: what next?
Message-Id: <44C4B312.1010205@imperial.ac.uk>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

    Hi,

I have just finished building a computer at uni. It has two dual core 
Opterons 275 on an MSI K8N-DL. It is very hot in my town at the moment 
and I would like to monitor temperature etc.

I *think* that sensors-detect is running all fine, the output I get from 
`sensors` is:

<quote>
w83627thf-isa-0290
Adapter: ISA adapter
VCore:     +1.02 V  (min =  +0.94 V, max =  +0.96 V)
+12V:      +4.13 V  (min = +10.82 V, max = +13.19 V)
+3.3V:     +1.92 V  (min =  +3.14 V, max =  +3.47 V)
+5V:       +5.04 V  (min =  +4.75 V, max =  +5.25 V)
-12V:     -14.91 V  (min = -10.80 V, max = -13.18 V)
V5SB:      +5.08 V  (min =  +4.76 V, max =  +5.24 V)
VBat:      +2.93 V  (min =  +2.40 V, max =  +3.60 V)
fan1:     5578 RPM  (min = 9375 RPM, div = 2)
CPU Fan:  5769 RPM  (min =   -1 RPM, div = 2)
fan3:        0 RPM  (min = 112500 RPM, div = 2)
M/B Temp:    +47 C  (high =    +5 C, hyst =    +0 C)   sensor = thermistor
CPU Temp:  +42.0 C  (high =   +80 C, hyst =   +75 C)   sensor = thermistor
temp3:     +39.0 C  (high =   +80 C, hyst =   +75 C)   sensor = thermistor
vid:      +0.275 V  (VRM Version 9.0)
alarms:
beep_enable:
          Sound alarm disabled

eeprom-i2c-0-53
Adapter: SMBus nForce2 adapter at f800
Memory type:            DDR SDRAM DIMM
Memory size (MB):       1024

eeprom-i2c-0-52
Adapter: SMBus nForce2 adapter at f800
Memory type:            DDR SDRAM DIMM
Memory size (MB):       1024

eeprom-i2c-0-51
Adapter: SMBus nForce2 adapter at f800
Memory type:            DDR SDRAM DIMM
Memory size (MB):       1024

eeprom-i2c-0-50
Adapter: SMBus nForce2 adapter at f800
Memory type:            DDR SDRAM DIMM
Memory size (MB):       1024

<\quote>


This suggest that the rail which ought to have 3.3V, provides only 1.9! 
Does anyone have any information about whether this is a real 
problem/artifact? What's my next step?

Thanks for any advice and for bearing with my ignorance!
James

