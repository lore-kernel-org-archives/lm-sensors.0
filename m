From: david.w.madsen@intel.com (Madsen, David W)
Date: Thu, 19 May 2005 06:25:26 +0000
Subject: Sensors-detect output from ASUS p5ad2 premium w/ W83627EHF as
Message-Id: <A652FD396F42E94BA29B9EB35404E7A303220927@azsmsx405.amr.corp.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <A652FD396F42E94BA29B9EB35404E7A303220620@azsmsx405.amr.corp.intel.com>
In-Reply-To: <A652FD396F42E94BA29B9EB35404E7A303220620@azsmsx405.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


It looks as if the basic interface is about the same as the THF.

At first glance some of the values look to be off namely:

+/- 12V
Vcore seems high.. Bios is set to 1.385
Range testing doesn't seem to be working correctly as some values within
the range have alarms and others registered outside the specified range
don't.


Fan RPM's look appropriate (CPU fan doesn't have a tachometer)
Temperatures look OK as well except for temp3

From the information I have gathered the new winbond chips implement
VID10.0 so that may explain the VID error.

Is there a way to read the internal thermal diode on the P4 Prescotts?
I know that probably depends on implementation in each motherboard, but
I was thinking that the CPU temp below would be from the thermal diode
on the processor and not a thermistor.  Maybe the sensor identification
isn't correct? 

Below is the sensors output.

If I can be of any further help adding support for this chip let me
know.


w83627thf-isa-0290
Adapter: ISA adapter
VCore:     +1.58 V  (min =  +1.93 V, max =  +1.93 V)       ALARM  
+12V:     +14.04 V  (min = +10.82 V, max = +13.19 V)              
+3.3V:     +3.34 V  (min =  +3.14 V, max =  +3.47 V)       ALARM  
+5V:       +5.55 V  (min =  +4.75 V, max =  +5.25 V)              
-12V:     -14.91 V  (min = -10.80 V, max = -13.18 V)              
V5SB:      +5.59 V  (min =  +4.76 V, max =  +5.24 V)              
VBat:      +0.00 V  (min =  +2.40 V, max =  +3.60 V)              
fan1:     1461 RPM  (min =   -1 RPM, div = 4)                     
CPU Fan:     0 RPM  (min =   -1 RPM, div = 2)                     
fan3:     2136 RPM  (min = 28125 RPM, div = 8)                     
M/B Temp:    +33 C  (high =    +2 C, hyst =    +8 C)   sensor thermistor           
CPU Temp:  +45.5 C  (high =   +80 C, hyst =   +75 C)   sensor thermistor           
temp3:    +122.5 C  (high =   +80 C, hyst =   +75 C)   sensor = 3904
transistor   ALARM   
ERROR: Can't get VID data!
alarms:   
beep_enable:
          Sound alarm enabled
 

--
David Madsen
Xscale Core Integration
480-552-7921
david.w.madsen@intel.com
 
-----Original Message-----
From: Mark Studebaker [mailto:mds4@verizon.net] 
Sent: Tuesday, December 07, 2004 1:51 PM
To: Madsen, David W
Cc: sensors@Stimpy.netroedge.com
Subject: Re: Sensors-detect output from ASUS p5ad2 premium w/ W83627EHF
as requested

ok.
as a quick test, in the w83627hf.c driver, try changing
#define W627THF_DEVID 0x82
to
#define W627THF_DEVID 0x88

then recompile and load the driver (and i2c-isa of course), see if it
loads and if you get decent
results in sensors.

mds




Madsen, David W wrote:
> Feel free to contact me if any more info could be useful!
> 

