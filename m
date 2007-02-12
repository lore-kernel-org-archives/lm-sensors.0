From: riwright@vt.edu (Rick Wright)
Date: Mon, 12 Feb 2007 17:32:34 +0000
Subject: [lm-sensors] Abit AT8 (non-32X) / Winbond 83627EHF
Message-Id: <45D0A4B2.6030002@vt.edu>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hello list,

I have the Abit AT8 mobo described in the subject line and I'm trying to 
get lm_sensors working properly for this board.  I see there is still 
very recent activity concerning getting this Winbond chip fully 
supported.  In the latest 2.10.2 release I see Dave Platt added these 
changes relavent to my board:

Program sensord:
                        Add w83627ehf voltage support (Dave Platt)
                        Add k8temp support (Dave Platt)

These additions appear to be working properly OOTB as the "sensors" 
command produces the following output:

[riwright at box ~]$ sensors
k8temp-pci-00c3
Adapter: PCI adapter
Core0 Temp:
             +45 ?C
Core1 Temp:
             +46 ?C

w83627ehf-isa-0290
Adapter: ISA adapter
VCore:     +2.04 V  (min =  +0.00 V, max =  +1.74 V) ALARM
in1:      +13.46 V  (min = +13.46 V, max = +12.36 V) ALARM
AVCC:      +3.22 V  (min =  +3.02 V, max =  +4.08 V)
3VCC:      +3.22 V  (min =  +3.92 V, max =  +3.82 V) ALARM
in4:       +1.66 V  (min =  +2.01 V, max =  +1.01 V) ALARM
in5:       +1.66 V  (min =  +1.16 V, max =  +0.95 V) ALARM
in6:       +5.32 V  (min =  +6.53 V, max =  +6.32 V) ALARM
VSB:       +3.07 V  (min =  +4.08 V, max =  +3.06 V) ALARM
VBAT:      +2.16 V  (min =  +2.02 V, max =  +2.38 V)
in9:       +1.56 V  (min =  +1.98 V, max =  +1.75 V) ALARM
Case Fan:    0 RPM  (min = 1318 RPM, div = 128) ALARM
CPU Fan:     0 RPM  (min = 1757 RPM, div = 128) ALARM
Aux Fan:     0 RPM  (min = 10546 RPM, div = 128) ALARM
fan4:        0 RPM  (min = 10546 RPM, div = 128) ALARM
fan5:        0 RPM  (min = 168750 RPM, div = 8) ALARM
Sys Temp:    -48 ?C  (high =   +45 ?C, hyst =   +40 ?C)
CPU Temp:  -48.0 ?C  (high = +45.0 ?C, hyst = +40.0 ?C)
AUX Temp:  -48.0 ?C  (high = +80.0 ?C, hyst = +75.0 ?C)


So, as advertized, the Voltage support seems to be working.  However, 
the fan speeds and temperatures do not.  Are these items currently 
supported yet?  Or do I have a configuration problem?  If not yet 
supported, is this planned for the future?

Any input/hints/pointers greatly appreciated.

Thanks,
Rick

