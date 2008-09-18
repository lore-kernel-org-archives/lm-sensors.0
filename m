From: Marc Hulsman <m.hulsman@tudelft.nl>
Date: Thu, 18 Sep 2008 09:24:25 +0000
Subject: Re: [lm-sensors] New Asus board and multiple sensors chips
Message-Id: <200809181124.25831.m.hulsman@tudelft.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <48CA5C05.8040307@absence.it>
In-Reply-To: <48CA5C05.8040307@absence.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Jean,

From the earlier communication on list I got the impression you were plann=
ing=20
to include the w83791d patches I send last month (which were acked by Hans)=
=20
in your tree for submission.=20
Are you still planning to do this (as you later made it clear you dont want=
 to=20
be _the_ maintainer)? No pressure, I can also send them directly to Andrew =
if=20
you like. I just want to try to get them in for 2.6.28.

Regards,
Marc

On Wednesday 17 September 2008 00:35:41 Jean Delvare wrote:
> Hi Rudolf, Marco,
>
> Le mardi 16 septembre 2008, Rudolf Marek a =E9crit=A0:
> > Hello,
> >
> > Here is mine research:
> >
> > DHG chip is wired as follows:
> >
> > in0 is Vcore
> > in1 is 12V
> > in2 not used
> > in3 is 3.3V
> > in4 is 5V
> >
> > temp1 is MB temp
> > fans are
> > fan2 is cpu,
> > fan5 is not, fan4 is not
> >
> > There is some unknown i2c chip at 0x38 which measures voltages, and fans
> >
> > It measures:
> > Cpu voltage, DDR voltage, SB 1.1V voltage SB 1.5V, CPU PLL voltage, NB
> > 1.1V Dram VTT volrage, VTT CPU voltage,
> >
> > And also fans:
> > Chasis fan1
> > Chasis fan2
> > Power Fan
> > And some Opt fans, I know what registers are there (mostly up 0xa0 for
> > fans)
> >
> > So we need to find out what chip it is, because it measures a lot too.
> >
> > The NB temperature etc etc is measured by some chip at 0x40 it seems it
> > also controls some fan temperature???
> >
> > Definitely what is the output of
> >
> > i2cdetect 0
> > i2cdump 0 0x40
> > i2cdump 0 0x38
>
> Excellent work, thanks Rudolf. We don't currently know of any
> hardware monitoring chip at either 0x40 or 0x38, which is why
> sensors-detect didn't reveal anything. The output of i2cdetect would
> definitely be a good thing to have, sorry for not thinking of this
> earlier.



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
