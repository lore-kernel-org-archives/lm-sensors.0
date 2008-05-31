From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Date: Sat, 31 May 2008 20:30:24 +0000
Subject: Re: [lm-sensors] [Bug?] W83697: Broken readings for fan speed 10%
Message-Id: <20080531223024.5973d503@neptune.home>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080531220339.05dc83fd@neptune.home>
In-Reply-To: <20080531220339.05dc83fd@neptune.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Sun, 01 June 2008 Grant Coady <grant_lkml@dodo.com.au> wrote:
> On Sat, 31 May 2008 22:03:39 +0200, Bruno Pr=C3=A9mont
> <bonbons@linux-vserver.org> wrote:
>=20
> >On a Commell LE-365 I get readings for fan speed that are broken
> >about 10% of the time.
> >The board has a Winbond W83697 chip (I can't check the exact chip
> >name on the board as it's hidden by a heatsink, the photo from
> >Commell, as as well as the manual indicate a HG, the kenrel reports:
> >  [    3.572831] w83627hf: Found W83697HF chip at 0x290
> >  [    3.572831] WDT driver for the Winbond(TM) W83627HF/THF/HG
> > Super I/O chip initialising. [    3.572831] w83627hf/thf/hg WDT:
> > Watchdog already running. Resetting timeout to 60 sec
> > [    3.572831] w83627hf/thf/hg WDT: initialized. timeout` sec
> > (nowayout=3D0)
> >)
> >
> >Below a sample (reformatted) output of
> >  while sleep 1; do
> >    date;
> >    cat /sys/class/hwmon/hwmon0/device/fan1_input;
> >  done
>=20
> Try slowing down your polling, change to sleep 5.  See if the problem
> goes away.
>=20
> Grant.
>=20
Unfortunately polling less often does not help.
The monitoring software which made me see this issue is polling once
every 10 seconds, I don't see the -1s there, but the too large values
do show up.

Bruno

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
