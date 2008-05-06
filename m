From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 06 May 2008 14:11:02 +0000
Subject: Re: [lm-sensors] sensors-detect killed my CPU
Message-Id: <20080506161102.0e7d955c@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <481B851A.10800@ag-web.biz>
In-Reply-To: <481B851A.10800@ag-web.biz>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Achim,

On Mon, 05 May 2008 21:44:35 +0200, Achim Gottinger wrote:
> Jean Delvare schrieb:
> > Hi Achim,
> >
> > On Mon, 05 May 2008 14:15:34 +0200, achim wrote:
> >  =20
> >> He He, the BKDG is tough to read. I tried to figure out the SMbus
> >> adresses.
> >>
> >> http://www.abload.de/image.php?img=BAredit-sidebandeis.jpg
> >>
> >> This is the register where the adress should be in bits 4:6 whom are a=
ll
> >> zero. However bit 3 is set and that should mean that the sideband
> >> interface is used.
> >>
> >> http://www.abload.de/image.php?img=3Dsidebandumy.jpg
> >>    =20
> >
> > This isn't how I read the specification. Bit 3 set means that the SBI
> > is _disabled_. But it your case, bit 3 is _not_ set, is it?
> >
> > I wonder where the 4 higher SMBus address bits are set.
> >
> >  =20
> Yepp it's unset means SBI is enabled. Can be a bios issue that the=20
> correct address does not shop up here.

What makes you think it doesn't? If I read it correctly, the BKDG says:
if the address is unset/unused then these bits are 0; it doesn't say:
if these bits are 0 it means that the address is unset/unused. It is
perfectly valid for the 3 low bits of an I2C address to be 0. Ideally
you would find in the datasheet what the other address bits are (I
guess they are hard-coded.) Note that we've seen a chip at 0x70 on your
SMBus and we don't know what it is. That could be it, as its 3 low
address bits at 0.

> > So there must be yet another chip which doesn't like being probed. This
> > confirms my impression that the safest fix is to blacklist the
> > motherboard and disable the SMBus entirely. Although I understand that
> > you don't want to do this now, as you are still investigating
>
> It's i2cdetect 0 itself. I need to reboot after i ran this to dump the=20
> special chips. Otherwise I only get XX's. This issue only occures with=20
> the phenom and not with the X2 cpu.
> All chips beside those at 0x2e,0x47 and 0x6e can be fully dumped without =

> causing the XX-issue.

Given that we see a chip at 0x70, the bus has to be alive until then, so
the i2cdetect probe breaking the bus must be with address >=3D 0x70. Some
chips don't like the quick command we use by default for probing. You
might try "i2cdetect -r" and see if it helps. You can also try the
extra range parameters to probe the addresses one by one, that way you
can find out which one exactly breaks the bus when probed.

> Today I wrote a long problem report for the sapphire support and asked=20
> them what chip they use at 0x2e. Hope they will shed some light on this=20
> issue.
> I'll post their response here.

Thank you.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
