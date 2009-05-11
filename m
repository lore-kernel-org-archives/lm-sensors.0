From: Hubert Kario <hka@qbs.com.pl>
Date: Mon, 11 May 2009 12:57:57 +0000
Subject: Re: [lm-sensors] Specific configurations - Gigabyte mainboard
Message-Id: <200905111457.57742.hka@qbs.com.pl>
List-Id: <lm-sensors.vger.kernel.org>
References: <200905091227.09847.hka@qbs.com.pl>
In-Reply-To: <200905091227.09847.hka@qbs.com.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Monday 11 May 2009 13:17:22 you wrote:
> Hi Hubert,
>
> On Sat, 9 May 2009 12:27:09 +0200, Hubert Kario wrote:
> > Hello everybody!
> > I've created a mainboard specific configuration for Gigabyte EP45-DS3P:
> >
> > =3D=3D snip =3D> > chip "it87-*" "it8712-*" "it8716-*" "it8718-*" "it87=
20-*"
>
> Which actual IT87xxF chip does the EP45-DS3P have?
IT8720, I'll check when I'll be able to how it's visible by lspci/sensors, =
I=20
don't know when it will be though, maybe today evening, maybe in a week's t=
ime
>
> >         label in0 "Vcore"
> >         label in1 "Vram"
> >         label in2 "+3.3V"
> >
> >         label in3 "+5V"
> > 	# Standard resistor
> >         compute in3 @ * ( 6.8/10+1), @ / (6.8/10+1)
> >
> >         ignore in4
> >
> >         label in5 "+12V"
> > 	# that's a bit weird, as the value (29.6) is close to typical resistor,
> > 	# but it does give proper results (in line with what a multimeter
> > 	# and BIOS show)
>
> Could be that the 10 isn't correct. Not that it really matters
> though... what matters is that the scaling factor is correct.
>
> >         compute in5 @ * (29.6/10+1), @ / (29.6/10+1)
> >
> >         ignore in6
> >
> > 	# not sure about this one
> >         label in7 "5VSB"
> >         compute in7 @ * (6.8/10+1), @ / (6.8/10+1)
> >
> >         label in8 "Vbat"
> >
> > 	# labels are after the ones printed on the mainboard
> >         label fan1 "CPU_FAN"
> >         label fan2 "SYS_FAN2"
> >         label fan3 "PWR_FAN"
> >         label fan4 "SYS_FAN1"
>
> These labels are ugly. What about:
yes, I know, but these are the exact ones that are printed on the mainboard=
...
and besides CPU_FAN, they can be connected to any fan one wishes (northbrid=
ge=20
is passively cooled in this mainboard)
>
>         label fan1 "CPU Fan"
>         label fan2 "Sys Fan 2"
>         label fan3 "Power Fan"
>         label fan4 "Sys Fan 2"
>
> >         label temp1 "Sys Temp"
> >         label temp2 "Tcase Temp"
>
> Why "Tcase" and not just "Case"?
because it's the Tcase temp of a CPU (temperature of an IHS)

I bet "Case Temp" would be read as ambient temperature by most people=20
(temperature inside the computer case), making it Tcase should clear the=20
confusion, especially when after putting "tcase temp" to google one does=20
recive "C2Q/C2D Temp Guide" as first result and "Tcase/Tjunction/Temp=20
question" as second
>
> >         ignore temp3
> > =3D=3D snip =3D>
> Yes it does, thanks for your contribution!
np

BTW, I couldn't use "compute" with "Core 0" and "Core 1" labels (I wanted t=
o=20
calibrate my core temperatures)
line:

 compute "Core 0" @ +3, @ -3

was completely ignored...
--=20
Hubert Kario
QBS - Quality Business Software
ul. Ksawer=F3w 30/85
02-656 Warszawa
POLAND
tel. +48 (22) 646-61-51, 646-74-24
fax +48 (22) 646-61-50



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
