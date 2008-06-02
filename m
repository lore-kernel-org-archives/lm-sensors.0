From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Date: Mon, 02 Jun 2008 19:09:41 +0000
Subject: Re: [lm-sensors] [Bug?] W83697: Broken readings for fan speed 10%
Message-Id: <20080602210941.050e0d3c@neptune.home>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080531220339.05dc83fd@neptune.home>
In-Reply-To: <20080531220339.05dc83fd@neptune.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Jean,

On Mon, 02 June 2008 Jean Delvare <khali@linux-fr.org> wrote:
> Hi Bruno,
>=20
> On Sat, 31 May 2008 22:03:39 +0200, Bruno Pr=C3=A9mont wrote:
> > On a Commell LE-365 I get readings for fan speed that are broken
> > about 10% of the time.
> > The board has a Winbond W83697 chip (I can't check the exact chip
> > name on the board as it's hidden by a heatsink, the photo from
> > Commell, as as well as the manual indicate a HG, the kenrel reports:
> >   [    3.572831] w83627hf: Found W83697HF chip at 0x290
> >   [    3.572831] WDT driver for the Winbond(TM) W83627HF/THF/HG
> > Super I/O chip initialising. [    3.572831] w83627hf/thf/hg WDT:
> > Watchdog already running. Resetting timeout to 60 sec
> > [    3.572831] w83627hf/thf/hg WDT: initialized. timeout` sec
> > (nowayout=3D0) )
> >=20
> > Below a sample (reformatted) output of
> >   while sleep 1; do
> >     date;
> >     cat /sys/class/hwmon/hwmon0/device/fan1_input;
> >   done
> > :
> > Sat May 31 21:11:23 CEST 2008    2070
> > <snip>
> > Sat May 31 21:11:34 CEST 2008      -1
> > <snip>
> > Sat May 31 21:12:14 CEST 2008  337500
> > <snip>
> >=20
> > The 337k RPM and -1 RPM do not make any sense.
> > I can't tell if this is a regression as I just started monitoring
> > a few sensor values (with older kernels I just did a few manual
> > checks but never noticed broken fan speeds)
>=20
> I do not think this is a regression, most likely a hardware issue.
>=20
> Is the fan's speed controlled in any way, either by the W83697HG chip,
> or maybe it is a self-regulated fan? Just check if the fan's speed
> increases with the temperature (i.e. with CPU load).

Yes, the fan has a built-in thermal sensor and regulates it's speed
based on temperature.
It's running either at its lowest speed or the speed just above.

> If this is the case, then please read this recent discussion the
> lm-sensors list:
>   http://marc.info/?l=3Dlm-sensors&m=121196069612940&w=3D2
> I suspect that your problem is similar.

That looks quite similar to what I'm seeing

> If the fan is not controlled and is running at full speed, then all I
> can think of is defective hardware (either the fan or the monitoring
> chip.)
>=20
> > In case there is more data I can provide, please ask.
> > As the board is not in production use I can easily try out patches.
>=20
> One patch you may want to apply it this one:
>   http://lists.lm-sensors.org/pipermail/lm-sensors/2008-May/023189.html
> It will let you switch the W83697HG chip from automatic fan speed
> control to manual control and back - might be useful to investigate
> the issue you have.

I will try this one, maybe the board is capable of doing speed control
but its not implemented in vanilla driver.
Until now setting pwm_enable to any values and changing PWM value did
not influence fan speed

The BIOS does not offer any speed control settings nor does it
configure the chip to do automatic speed control. (at least nothing
recognizable even with automatic-controlled fan)

> You can also give a try to the following patch, which is the
> equivalent of the one I just posted for the it87 driver, but for the
> w83627hf driver:
>=20
> Subject: hwmon: (w83627hf) Filter out unlikely fan speed values
>=20
> Filter out very large fan speed values. These can be reported by the
> chip when a fan is being controlled at low speed. The tachometer
> signal gets too weak and the chip fails to monitor the speed properly,
> but unfortunately it reports unreasonably high values instead of 0
> RPM, which is quite confusing.

I would prefer it to return the last valid speed if that speed is not
older than a few seconds though 0 is still better than "out of range".

I didn't look at the controlling circuit on the FAN to see how the
speed regulation may/may not influence the speed signal.

I will have a look at the tachometer with my oscilloscope (in the hope
the analog oscilloscope can display anything usable) to see how the
signal looks, comparing fixed-speed fan and the varying-speed fan at
different speeds.

I will also check fan behavior on IT8712F which is capable of doing PWM
control on 3 pin fans (maybe also automatic control, to be checked)


I will report back in the next days when I got around testing,
thanks for the pointers,
Bruno

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
