From: amarsh@freeshell.org (Aaron Marsh)
Date: Thu, 19 May 2005 06:25:13 +0000
Subject: Driver for vt8231
Message-Id: <20040908144801.GA12507@SDF.LONESTAR.ORG>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Starting with a couple of leads posted on this list, I've put together a
working driver for the vt8231.  I've only been able to test it against my
EPIA800 board, with the following output from 'sensors' under 2.8.7:

vt8231-isa-6000
Adapter: ISA adapter
VCore1:    +3.47 V  (min =  -0.05 V, max =  +4.42 V)   
+5V:       +3.26 V  (min =  -0.08 V, max =  +6.31 V)   
+12V:     +12.56 V  (min =  -0.18 V, max = +15.00 V)   
fan1:     3971 RPM  (min =    0 RPM, div = 2)          
fan2:     6425 RPM  (min =    0 RPM, div = 2)          
ERROR: Can't get TEMP2 data!
Proc Temp: +16.3 C  (high =  +276 C, hyst =    -1 C)   
vid:       +2.05 V


I know this isn't quite right, but it matches the output from lm_sensors-2.8.7
under 2.4.27 (specifically the VCore as 3.3v not 5.v and the TEMP2 error).  

I'm not entirely confident in the ability to _input_ to the driver, that's
next on my tasklist.  



In any case, the patch against kernel 2.6.8.1 is at:

http://www.stanford.edu/~amarsh/vt8231/linux-2.6.8.1-vt8231.patch

A patch against lm_sensors-2.8.7 is at:

http://www.stanford.edu/~amarsh/vt8231/lm_sensors-2.8.7-vt8231.patch

And a copy of my sensors.conf is at:

http://www.stanford.edu/~amarsh/vt8231/sensors.conf


One additional side note.  I originally wrote the driver to use the VID sys
file 'cpu0_vid' then rolled it back to use the current 'in0_ref.'  I'd happily
change back to cpu0_vid if that's the way the wind's blowing.


I'm afraid I'm new to contributing to projects of this size.  Please let me
know what else I can do to get this driver in the mainstream. 

Thank you,

Aaron Marsh

-- 
amarsh@sdf.lonestar.org
SDF Public Access UNIX System - http://sdf.lonestar.org
