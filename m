From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:28 +0000
Subject: Complete dead system
Message-Id: <3C41BCE2.6D4BA619@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3C3FB02B.9400DFE6@paradyne.com>
In-Reply-To: <3C3FB02B.9400DFE6@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Probably the w83781d is initializing a chip and
causing problems. 
Does the board documentation say what "Thermal check" means?

- Try loading bus drivers before client drivers,
  one at a time.
- Then load the video drivers, one at a time, to make sure
  they aren't the problem (they could be scanning the bus)
- Last, load w83781d
- If w83781d is the problem, try 'modprobe w83781d init=0'.

mds

Rainer Zocholl wrote:
> 
> mds@paradyne.com(Mark D. Studebaker)  11.01.02 22:40
> 
> Once upon a time Mark D. Studebaker shaped the electrons to say...
> 
> >Translation anybody?
> 
> >> linux-i2c@pelican.tk.uni-linz.ac.at steht im
> >> "readme". Hoffentlich ist das keine groessere Mailingliste ;-)
> >>
> >> Problem:
> >>
> >> Hardware: MSI MS-6215 MoBo, 2 DVB-s Cards.
> >>
> >> BIOS (V.1.7 ) Option "Thermal check".
> 
> If the "thermal check" in the BIOS is activated the box
> hangs completly ("is dead") while loading the (ISA?) driver.
> 
> >>   51:58 msi kernel: i2c-core.o: i2c core module
> >>   51:58 msi kernel: i2c-i801.o version 2.6.2 (20011118)
> >>   51:58 msi kernel: i2c-core.o: adapter SMBus I801 adapter at 0540
> >>   registered as adapter 0.
> >> <power off, da nix anderes mehr geht.>
> >>   54:26 msi syslogd 1.3-3#33.1: restart.
> 
> another try:
> 
> >>
> >>   54:37 msi kernel: i2c-core.o: i2c core module
> >>   54:37 msi kernel: i2c-i801.o version 2.6.2 (20011118)
> >>   54:37 msi kernel: i2c-core.o: adapter SMBus I801 adapter at 0540
> >>   registered as adapter 0.
> 
> <turned power off because no other way out.>
> 
> >>   57:06 msi syslogd 1.3-3#33.1: restart.
> >>
> >> Erst das deaktivieren verhinderte den H?nger.
> >>
> 
> >Sounds like his system dies when i2c-i801 is loaded...
> 
> I forget to mention:
> IIRC i could read something with "ISA" on the sreen.
> The problem:
> The "screen" is only a TV set and so it is sometimes very
> hard to read.
> 
> >What were the other sensors modules loaded?
> 
> If the box runs normally it looks like:
> 
> msi:/etc/modutils# cat i2c
> alias char-major-89 i2c-dev
> 
> msi:/etc/init.d# lsmod | grep i2c
> i2c-proc                6176   0  [w83781d]
> i2c-isa                 1220   0  (unused)
> i2c-i810                2536   0  (unused)
> i2c-algo-bit            7148   2  [i2c-i810]
> i2c-i801                4484   0  (unused)
> i2c-core               12352   0  [dvb saa7146_core tuner stv0299 tda8083
> SP8870 L64781 VES1820 VES1893 w83781d i2c-pr
> oc i2c-isa i2c-algo-bit i2c-i801]
> 
> msi:/etc/init.d# lsmod
> Module                  Size  Used by
> dvb                   233312  34
> dvb_frontend            3200   0  [dvb]
> dvb_demux              12768   2  [dvb]
> saa7146_v4l            15812   0  (unused)
> saa7146_core           14496   0  [dvb saa7146_v4l]
> tuner                   4324   2
> stv0299                 2976   2
> tda8083                 2048   0  (unused)
> SP8870                  2592   0  (unused)
> L64781                  3520   0  (unused)
> VES1820                 3360   0  (unused)
> VES1893                 3648   0  (unused)
> dmxdev                  7444   2  [dvb]
> dvb_filter              6976   0  [dvb]
> videodev                4672   2  [dvb]
> dvb_net                 2960   0  [dvb]
> dvbdev                  1856  36  [dvb]
> lirc_serial             6624   1
> nvram                   3880   0  (unused)
> w83781d                17312   0  (unused)
> i2c-proc                6176   0  [w83781d]
> i2c-isa                 1220   0  (unused)
> i2c-i810                2536   0  (unused)
> i2c-algo-bit            7148   2  [i2c-i810]
> i2c-i801                4484   0  (unused)
> i2c-core               12352   0  [dvb saa7146_core tuner stv0299 tda8083
> SP8870 L64781 VES1820 VES1893 w83781d i2c-pr
> oc i2c-isa i2c-algo-bit i2c-i801]
> st                     26420   0  (autoclean) (unused)
> usb-storage           100544   0  (unused)
> usbcore                53056   1  [usb-storage]
> ac97_codec              9632   0  (unused)
> rtc                     5784   0  (autoclean)
> 
> I don't know where to look to see which modules will
> be loaded (debian 2.2 with "woody" EXT3, kernel 2.4.17 )
> 
> Currently the modules are loaded by an own script:
> msi:/etc/init.d# cat modinz
> #! /bin/sh
> modprobe i2c-i801
> modprobe i2c-algo-bit
> modprobe i2c-i810
> #modprobe eeprom
> modprobe i2c-isa
> modprobe w83781d
> modprobe i810-tco
> modprobe i810_rng
> modprobe lp
> modprobe nvram
> modprobe rtc
> lsmod
> 
> HTH.
> 
> Please drop me a CC becaues i'm currently nor subscripted to the list.
> (Is there a way to do?)
> 
> TIA
> Rainer
