From: danny.backx@skynet.be (Danny Backx)
Date: Thu, 19 May 2005 06:24:21 +0000
Subject: my user-space work ? (3d attempt)
Message-Id: <1065888394.1060.6.camel@dell.roesel.skynet.be>
List-Id: <lm-sensors.vger.kernel.org>
References: <200310092001.07946.danny.backx@skynet.be>
In-Reply-To: <200310092001.07946.danny.backx@skynet.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I hacked some more, it's probably cleaner now.

Current output :
dell: {119} prog/sensors/sensors
w83627hf-i2c-0-0290
Adapter: Dummy adapter
Algorithm: Dummy algorithm
VCore 1:   +0.00 V  (min = +26.08 V, max =  +0.00 V)              
VCore 2:   +0.00 V  (min = +26.08 V, max =  +0.00 V)              
+3.3V:     +0.00 V  (min = +26.08 V, max =  +0.00 V)              
+5V:       +0.00 V  (min = +43.81 V, max =  +0.00 V)              
+12V:      +0.00 V  (min = +99.10 V, max =  +0.00 V)              
-12V:     -14.91 V  (min = +119.14 V, max = -14.91 V)       ALARM  
-5V:       -7.71 V  (min = +74.18 V, max =  -7.71 V)              
V5SB:      +0.00 V  (min = +43.81 V, max =  +0.00 V)              
VBat:      +0.00 V  (min = +26.08 V, max =  +0.00 V)              
fan1:        0 RPM  (min = 2608 RPM, div = 2608)                     
fan2:        0 RPM  (min = 2608 RPM, div = 0)                     
fan3:        0 RPM  (min = 2608 RPM, div = 0)              ALARM  
temp1:        +0?C  (limit = +261?C, hysteresis =   +0?C) sensor thermistor   ALARM   
temp2:      +0.0?C  (limit = +89254816?C, hysteresis =   +1?C) sensor thermistor   ALARM   
temp3:      +0.0?C  (limit = +88919504?C, hysteresis =   +1?C) sensor thermistor           
vid:      +808792.881 V
alarms:   
beep_enable:
          Sound alarm enabled


New patch attached (direct output from "cvs -z9 diff").
Obviously there's still something wrong :-)

But I've added code to locate the sysfs mount point, and I believe I'm
reading sufficient info to get rid of hardcoded device numbers in my
earlier hacks.

Am I in the right direction ?

BTW /sys/bus/i2c/devices/0-0290 looks like this :
dell: {2} ls /sys/bus/i2c/devices/0-0290
alarms        fan_min1   in_input7  in_max8  name         temp_input3
beep_enable   fan_min2   in_input8  in_min0  power        temp_max1
beep_mask     fan_min3   in_max0    in_min1  pwm1         temp_max2
detach_state  in_input0  in_max1    in_min2  pwm2         temp_max3
fan_div1      in_input1  in_max2    in_min3  pwm_enable2  temp_min1
fan_div2      in_input2  in_max3    in_min4  sensor1      temp_min2
fan_div3      in_input3  in_max4    in_min5  sensor2      temp_min3
fan_input1    in_input4  in_max5    in_min6  sensor3      vid
fan_input2    in_input5  in_max6    in_min7  temp_input1  vrm
fan_input3    in_input6  in_max7    in_min8  temp_input2

And no, this is no "dell" system, it's an ABIT BE-7 board.

	Danny

On Fri, 2003-10-10 at 20:44, Danny Backx wrote:
> On Thu, 2003-10-09 at 23:11, Greg KH wrote:
> > On Thu, Oct 09, 2003 at 08:01:07PM +0200, Danny Backx wrote:
> > > I think I've submitted some patches twice. I've been
> > > trying to get libsensors and prog/sensors to work
> > > based on linux 2.6-test4 and test6. But I don't
> > > see my submissions in the support db, nor did
> > > I get a reply.
> > > 
> > > Is anyone interested in this?
> > 
> > Yes, have you emailed them to us?
> 
> No, I didn't discover this link until yesterday. It's somewhat hidden.
> I tried copy/pasting this into the support website but apparently
> that failed twice.
> 
> Anyway. Stuff attached. This is no miracle yet, I've hacked both
> libsensors and prog/sensors a bit to get them to talk to sysfs.
> 
> I probably need to look into all the stuff tracking bus numbers
> and such, I've basically added some #if 0 lines here and there
> to get sensors to produce output (even if that output is
> currently nonsense for obvious reasons).
> 
> I've done this on linux-2.6test4. On test6 the output is rather
> empty :
> 	dell: {32} setenv LD_LIBRARY_PATH `pwd`/lib
> 	dell: {33} prog/sensors/sensors
> 	w83627hf
> 	-i2c--2-ffffffff
> 	Adapter: Dummy adapter
> 	Algorithm: Dummy algorithm
> 
> Need to look into the reason, but it's probably one of the
> hacks that fails now.
> 
> I could use help with sorting out the issues with bus numbers
> and such, because I am completely new to the lm_sensors source
> and this looks rather confusing.
> 
> 	Danny
> 
> P.S. If I'm not helping but delaying you with all this, just
>   tell me and I'll wait until you come up with a version that
>   works :-)
> 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: diff-to-cvs.gz
Type: application/x-gzip
Size: 5724 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20031011/2112ae58/diff-to-cvs.gz
