From: mathog@mendel.bio.caltech.edu (David Mathog)
Date: Thu, 19 May 2005 06:25:16 +0000
Subject: ticket 1775
Message-Id: <E1C9Rnj-0007OT-00@mendel.bio.caltech.edu>
List-Id: <lm-sensors.vger.kernel.org>
References: <E1C9PtS-000754-00@mendel.bio.caltech.edu>
In-Reply-To: <E1C9PtS-000754-00@mendel.bio.caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Your suggestions were a big help.

I added this to /etc/modprobe.conf:

options w83781d force_w83782d=0,0x2d force_subclients=0,0x2d,0x48,0x49
force_w83627hf=0,0x2c force_subclients=0,0x2c,0x4a,0x4b init=0

(which used to be in /etc/modules.conf on the old system)

then
 
% /etc/rc.d/init.d/lm_sensors start
% sensors

showed reasonable values (see below)

However...

In /var/log/messages there was:

Sep 20 10:07:11 safserver kernel: w83781d 0-002d: Duplicate addresses
0x4f for subclients.
Sep 20 10:07:13 safserver sensord: sensord started

and when I tried to load these manually (from /etc/sysconfig/lm_sensors)

MODULE_0=i2c-amd756
MODULE_1=i2c-isa
MODULE_2=w83781d
MODULE_3=w83627hf

the last one said:

FATAL: Module w83627hf not found.  In comparison, for RH 7.3 (2.4
kernel) the modules were:

MODULE_0=i2c-proc
MODULE_1=i2c-dev
MODULE_2=i2c-amd756
MODULE_3=w83781d

so I'm guessing that w83627hf doesn't belong on the current list.
Removed it, and sensors still works.  The duplicate address warning
remains though.  Here's the current output of sensors (without
eeprom):

w83627hf-i2c-0-2c
Adapter: SMBus AMD756 adapter at 80e0
VCore 1:   +1.73 V  (min =  +1.74 V, max =  +1.94 V)       ALARM  
VCore 2:   +1.73 V  (min =  +1.74 V, max =  +1.94 V)       ALARM  
AGP Volt:  +3.30 V  (min =  +0.00 V, max =  +0.00 V)              
chs2 Fan:    0 RPM  (min = 3534 RPM, div = 2)                     
chs5 Fan:    0 RPM  (min =    0 RPM, div = 2)                     
chs6 Fan:    0 RPM  (min = 2824 RPM, div = 2)                     
VRM1 Temp:   +62?C  (high =   -67?C, hyst =  -101?C)   sensor = 3904
transistor           
AGP Temp:  +53.0?C  (high =   +70?C, hyst =   +80?C)   sensor = 3904
transistor           
DDR Temp:  +51.5?C  (high =   +70?C, hyst =   +80?C)   sensor = 3904
transistor           
vid:      +1.750 V
alarms:   
beep_enable:
          Sound alarm disabled

w83782d-i2c-0-28
Adapter: SMBus AMD756 adapter at 80e0
DDR V:     +1.23 V  (min =  +1.65 V, max =  +2.05 V)              
+3.3V:     +3.38 V  (min =  +3.14 V, max =  +3.46 V)              
 +5 V:     +5.00 V  (min =  +4.73 V, max =  +5.24 V)              
+12 V:    +11.98 V  (min =  +0.00 V, max =  +0.00 V)              
-12 V:    -12.36 V  (min = -14.91 V, max = -14.83 V)              
Bat V:     +0.00 V  (min =  +2.64 V, max =  +3.95 V)              
CPU1 Fan: 8437 RPM  (min = 5273 RPM, div = 2)                     
CPU2 Fan: 8881 RPM  (min = 84375 RPM, div = 2)                     
chs1 Fan:    0 RPM  (min =   -1 RPM, div = 2)                     
CPU1 Temp:   +55?C  (high =   +40?C, hyst =   +60?C)   sensor = 3904
transistor   ALARM   
CPU2 Temp: +56.5?C  (high =   +70?C, hyst =   +80?C)   sensor = 3904
transistor           
VRM2 Temp: +57.5?C  (high =   +70?C, hyst =   +80?C)   sensor = 3904
transistor           
alarms:   
beep_enable:
          Sound alarm disabled


Thanks,


David Mathog
mathog@caltech.edu
Manager, Sequence Analysis Facility, Biology Division, Caltech


> On Mon, 20 Sep 2004 08:15:54 -0700, David Mathog wrote
> > (Sorry, couldn't figure out how to amend a ticket through
> > the web interface.)
> 
> Maybe that's because there is no way? Our ticket system sucks.
> 
> > In reply to ticket 1775 the response was:
> > 
> > > try changing sensor type to 3435 in sensors.conf
> > 
> > The sensors.conf from Tyan (and every other one I've
> > found on the web for this mobo) says to do this:
> > 
> >  # thermal sensor types (do not adjust)
> >    set sensor1 2
> >    set sensor2 2
> >    set sensor3 2
> > 
> > Moreover, those settings worked on the same machine when
> > it ran RH 7.3 and an older version of lm_sensors.  However,
> > now they do not work (kernel 2.8.6.1 and sensors 2.8.7).
> > Since the hardware type of the sensor on the mobo clearly has
> > not changed (only the OS) why would the sensor type change now
> > from 2 to 3435 with a different version of the kernel or
> > lm_sensors???
> 
> Completely agreed.
> 
> One interesting thing I found in Tyan's proposed configuration file is
that
> there should be two monitoring chips, not just one. What's more,
addresses for
> these chips should be 0x2c and 0x2d, while yours shows at 0x28.
> 
> Another thing worth noting IMHO is that Tyan's config file, and your
old RH
> 7.3, date from before the ISA-only w83627hf chip driver was written.
Thus I
> would suggest that you do *not* load the i2c-isa nor w83627hf drivers,
so as
> to be as near as possible from your original setup. We may try using the
> (possibly better) w83627hf driver at a later time. One thing at a time.
> 
> Tyan suggests to use the following line in /etc/modules.conf:
> options w83781d force_w83782d=0,0x2d force_subclients=0,0x2d,0x48,0x49
> force_w83627hf=0,0x2c force_subclients=0,0x2c,0x4a,0x4b init=0
> Did you try doing this? Note that for Linux 2.6, the correct file is
> /etc/modprobe.conf, not modules.conf.
> 
> If it doesn't help, you may provide a scan of your I2C bus (i2cdetect
0) for a
> starter.
> 
> -- 
> Jean Delvare
> http://khali.linux-fr.org/
> 
> 
> 
