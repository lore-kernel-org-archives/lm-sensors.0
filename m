From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:23:28 +0000
Subject: Complete dead system
Message-Id: <3C475E5E.6AE68438@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3C3FB02B.9400DFE6@paradyne.com>
In-Reply-To: <3C3FB02B.9400DFE6@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Yes you can assume the problem is w83781d.
I assume w83781d is loaded as a module.
You must find the 'modprobe w83781d' commmand so that you can modify it to add init=0.
It is probably in /etc/rc.d somewhere, or wherever
the init scripts are for your system.

Rainer Zocholl wrote:
> 
> mds@paradyne.com(Mark D. Studebaker)  13.01.02 14:32
> 
> Once upon a time Mark D. Studebaker shaped the electrons to say...
> 
> >Rainer Zocholl wrote:
> >>
> >> mds@paradyne.com(Mark D. Studebaker)  13.01.02 11:59
> >>
> >> Once upon a time Mark D. Studebaker shaped the electrons to say...
> >>
> >>>Probably the w83781d is initializing a chip and
> >>>causing problems.
> >>>Does the board documentation say what "Thermal check" means?
> >>
> >> No. There is only another field to say how much the
> >> CPU should be reduced to 50%
> >>
> >> The exact words are:
> >>
> >>  AMIBIOS SETUP
> >>   Power management setup
> >>     "System Thermal" : "ignore" or "Monitor"
> >>     "Throttle slow clock ratio: 87,5%...50% 12,5%
> >>
> >> Throttle Duty Cycle
> >> This option will determine how much power will be used by the CPU ,
> >> if the system goes into suspend mode.
> >>
> >>>- Try loading bus drivers before client drivers,
> >>>  one at a time.
> >>
> >>>- Then load the video drivers, one at a time, to make sure
> >>>  they aren't the problem (they could be scanning the bus)
> >>
> >> Those are loaded as the last. Or what do you mean?
> >>
> >>>- Last, load w83781d
> >>>- If w83781d is the problem, try 'modprobe w83781d init=0'.
> 
> >When a chip driver is loaded, it generally scans every i2c bus
> >which has a driver loaded.
> >When a new bus driver is loaded, ALL chip drivers already loaded
> >will scan the new bus.
> >So it is easier to isolate the problem if you load the
> >bus drivers first, then load the chip drivers one at a time.
> >That will help you find which chip driver is the problem.
> 
> Tried again.
> The good news:
> The hang is reproducible!
> 
> dmesg says:
> ...
> i2c-core.o: i2c core module
> i2c-i801.o version 2.6.2 (20011118)
> i2c-core.o: adapter SMBus I801 adapter at 0540 registered as adapter 0.
> i2c-i801.o: I801 bus detected and initialized
> i2c-algo-bit.o: i2c bit algorithm module
> i2c-i810.o version 2.6.2 (20011118)
> i2c-i810.o: i810/i815 found.
> i2c-core.o: adapter I810/I815 I2C Adapter registered as adapter 1.
> i2c-i810.o: I810/I815 I2C bus initialized
> i2c-core.o: adapter I810/I815 DDC Adapter registered as adapter 2.
> i2c-i810.o: I810/I815 DDC bus initialized
> i2c-isa.o version 2.6.2 (20011118)
> i2c-core.o: adapter ISA main adapter registered as adapter 3.
> i2c-isa.o: ISA bus access for i2c modules initialized.
> i2c-proc.o version 2.6.1 (20010825)
> w83781d.o version 2.6.2 (20011118)
> i2c-core.o: driver W83781D sensor driver registered.
> i2c-core.o: client [W83627HF chip] registered to adapter [ISA main adapter](pos. 0).
> i810tco init: failed to reset NO_REBOOT flag, reboot disabled by hardware
> i810_rng: RNG not detected
> Non-volatile memory driver v1.1
> ...
> 
> If i enable "thermal monitoring" the last line printed on the cosole is:
> i2c-core.o: client [W83627HF chip] registered to adapter [ISA main adapter](pos. 0).
> 
> So i assume the problem is the w83781d.o ?
> 
> I -absolutely- don't know where i should edit the "modprobe w83781d init=0".
> I don't even know who starts the modules and on what is dependend
> I know only a "/etc/(modules.conf", but there is no i2c-core, w83627HF etc.
> 
> The script i though that was run is not running in this
> moment, it runs much later.
> 
> Rainer
