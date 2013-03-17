From: Ross Moore <ross@rossmoore.net>
Date: Sun, 17 Mar 2013 06:05:05 +0000
Subject: Re: [lm-sensors] IT8771E
Message-Id: <CAJDbZnSsVybunZUy-AsjnMNXxPBsmgRYFhyiMZvGPpyKnd20XA@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============6295566729429326971=="
List-Id: <lm-sensors.vger.kernel.org>
References: <CAJDbZnQ-rGoUL+5F=e8cWD9Q8JQd+RXZ9ec=J8PC+8SE9P+=Cg@mail.gmail.com>
In-Reply-To: <CAJDbZnQ-rGoUL+5F=e8cWD9Q8JQd+RXZ9ec=J8PC+8SE9P+=Cg@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--===============6295566729429326971==
Content-Type: multipart/alternative; boundary=e89a8ff1c7e660ce3e04d818a77d

--e89a8ff1c7e660ce3e04d818a77d
Content-Type: text/plain; charset=ISO-8859-1

Here is the output of pwmconfig - I was noting the pwm and fan are on the
same chip; perhaps they always are. But note the correlation plots in here.
It seems pwm is controlling the fans in any kind of consistent manner
(although clearly there is a link):

# pwmconfig revision 5857 (2010-08-22)
This program will search your sensors for pulse width modulation (pwm)
controls, and test each one to see if it controls a fan on
your motherboard. Note that many motherboards do not have pwm
circuitry installed, even if your sensor chip supports pwm.

We will attempt to briefly stop each fan using the pwm controls.
The program will attempt to restore each fan to full speed
after testing. However, it is ** very important ** that you
physically verify that the fans have been to full speed
after the program has completed.

Found the following devices:
   hwmon0 is acpitz
   hwmon1/device is coretemp
   hwmon2/device is it8771
   hwmon3 is asus

Found the following PWM controls:
   hwmon2/device/pwm1
   hwmon2/device/pwm2
   hwmon2/device/pwm3

Giving the fans some time to reach full speed...
Found the following fan sensors:
   hwmon2/device/fan1_input     current speed: 2227 RPM
   hwmon2/device/fan2_input     current speed: 1211 RPM

Warning!!! This program will stop your fans, one at a time,
for approximately 5 seconds each!!!
This may cause your processor temperature to rise!!!
If you do not want to do this hit control-C now!!!
Hit return to continue:

Testing pwm control hwmon2/device/pwm1 ...
  hwmon2/device/fan1_input ... speed was 2227 now 1115
    It appears that fan hwmon2/device/fan1_input
    is controlled by pwm hwmon2/device/pwm1
Would you like to generate a detailed correlation (y)? y
Note: If you had gnuplot installed, I could generate a graphical plot.
    PWM 255 FAN 1256
    PWM 240 FAN 1149
    PWM 225 FAN 1256
    PWM 210 FAN 1388
    PWM 195 FAN 1599
    PWM 180 FAN 1795
    PWM 165 FAN 1739
    PWM 150 FAN 1683
    PWM 135 FAN 1562
    PWM 120 FAN 1490
    PWM 105 FAN 1400
    PWM 90 FAN 1313
    PWM 75 FAN 1250
    PWM 60 FAN 1194
    PWM 45 FAN 1121
    PWM 30 FAN 1112
    PWM 28 FAN 1113
    PWM 26 FAN 1112
    PWM 24 FAN 1112
    PWM 22 FAN 1113
    PWM 20 FAN 1112
    PWM 18 FAN 1112
    PWM 16 FAN 1113
    PWM 14 FAN 1112
    PWM 12 FAN 1113
    PWM 10 FAN 1112
    PWM 8 FAN 1113
    PWM 6 FAN 1112
    PWM 4 FAN 1112
    PWM 2 FAN 1112
    PWM 0 FAN 1112

  hwmon2/device/fan2_input ... speed was 1211 now 1207
    no correlation

Testing pwm control hwmon2/device/pwm2 ...
  hwmon2/device/fan1_input ... speed was 2227 now 2419
    no correlation
  hwmon2/device/fan2_input ... speed was 1211 now 0
    It appears that fan hwmon2/device/fan2_input
    is controlled by pwm hwmon2/device/pwm2
Would you like to generate a detailed correlation (y)? y
Note: If you had gnuplot installed, I could generate a graphical plot.
    PWM 255 FAN 548
    PWM 240 FAN 258
    PWM 225 FAN 360 (probably incorrect)
    PWM 210 FAN 547 (probably incorrect)
    PWM 195 FAN 734 (probably incorrect)
    PWM 180 FAN 891 (probably incorrect)
    PWM 165 FAN 903 (probably incorrect)
    PWM 150 FAN 853 (probably incorrect)
    PWM 135 FAN 791 (probably incorrect)
    PWM 120 FAN 724 (probably incorrect)
    PWM 105 FAN 651 (probably incorrect)
    PWM 90 FAN 573 (probably incorrect)
    PWM 75 FAN 485 (probably incorrect)
    PWM 60 FAN 382 (probably incorrect)
    PWM 45 FAN 188
    PWM 30 FAN 0
    Fan Stopped at PWM = 30


Testing pwm control hwmon2/device/pwm3 ...
  hwmon2/device/fan1_input ... speed was 2227 now 2280
    no correlation
  hwmon2/device/fan2_input ... speed was 1211 now 1214
    no correlation

No correlations were detected.
There is either no fan connected to the output of hwmon2/device/pwm3,
or the connected fan has no rpm-signal connected to one of
the tested fan sensors. (Note: not all motherboards have
the pwm outputs connected to the fan connectors,
check out the hardware database on http://www.almico.com/forumindex.php)

Did you see/hear a fan stopping during the above test (n)? n

Testing is complete.
Please verify that all fans have returned to their normal speed.

The fancontrol script can automatically respond to temperature changes
of your system by changing fanspeeds.
Do you want to set up its configuration file now (y)? n



On 17 March 2013 13:53, Guenter Roeck <linux@roeck-us.net> wrote:

> On Sun, Mar 17, 2013 at 01:43:59PM +0800, Ross Moore wrote:
> > Hi,
> >
> > I see the IT87 driver has been updated to handle the IT8771E found on
> some
> > ASUS boards. I downloaded the latest it87.c, compiled it and loaded the
> > module.
> >
> > My fans are now detected, and seem to report correctly - hurrah! However,
> > the pwm controls for those fans seem way out of wack, and appear to be on
> > the same chip.
> >
> Can you be a bit more specific ? "appear to be on the same chip" - sure,
> where
> else ?
>
> Thanks,
> Guenter
>

--e89a8ff1c7e660ce3e04d818a77d
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Here is the output of pwmconfig - I was noting the pwm and=
 fan are on the same chip; perhaps they always are. But note the correlatio=
n plots in here. It seems pwm is controlling the fans in any kind of consis=
tent manner (although clearly there is a link):<br>
<br># pwmconfig revision 5857 (2010-08-22)<br>This program will search your=
 sensors for pulse width modulation (pwm)<br>controls, and test each one to=
 see if it controls a fan on<br>your motherboard. Note that many motherboar=
ds do not have pwm<br>
circuitry installed, even if your sensor chip supports pwm.<br><br>We will =
attempt to briefly stop each fan using the pwm controls.<br>The program wil=
l attempt to restore each fan to full speed<br>after testing. However, it i=
s ** very important ** that you<br>
physically verify that the fans have been to full speed<br>after the progra=
m has completed.<br><br>Found the following devices:<br>=A0=A0 hwmon0 is ac=
pitz<br>=A0=A0 hwmon1/device is coretemp<br>=A0=A0 hwmon2/device is it8771<=
br>=A0=A0 hwmon3 is asus<br>
<br>Found the following PWM controls:<br>=A0=A0 hwmon2/device/pwm1<br>=A0=
=A0 hwmon2/device/pwm2<br>=A0=A0 hwmon2/device/pwm3<br><br>Giving the fans =
some time to reach full speed...<br>Found the following fan sensors:<br>=A0=
=A0 hwmon2/device/fan1_input=A0=A0=A0=A0 current speed: 2227 RPM<br>
=A0=A0 hwmon2/device/fan2_input=A0=A0=A0=A0 current speed: 1211 RPM<br><br>=
Warning!!! This program will stop your fans, one at a time,<br>for approxim=
ately 5 seconds each!!!<br>This may cause your processor temperature to ris=
e!!!<br>
If you do not want to do this hit control-C now!!!<br>Hit return to continu=
e: <br><br>Testing pwm control hwmon2/device/pwm1 ...<br>=A0 hwmon2/device/=
fan1_input ... speed was 2227 now 1115<br>=A0=A0=A0 It appears that fan hwm=
on2/device/fan1_input<br>
=A0=A0=A0 is controlled by pwm hwmon2/device/pwm1<br>Would you like to gene=
rate a detailed correlation (y)? y<br>Note: If you had gnuplot installed, I=
 could generate a graphical plot.<br>=A0=A0=A0 PWM 255 FAN 1256<br>=A0=A0=
=A0 PWM 240 FAN 1149<br>
=A0=A0=A0 PWM 225 FAN 1256<br>=A0=A0=A0 PWM 210 FAN 1388<br>=A0=A0=A0 PWM 1=
95 FAN 1599<br>=A0=A0=A0 PWM 180 FAN 1795<br>=A0=A0=A0 PWM 165 FAN 1739<br>=
=A0=A0=A0 PWM 150 FAN 1683<br>=A0=A0=A0 PWM 135 FAN 1562<br>=A0=A0=A0 PWM 1=
20 FAN 1490<br>=A0=A0=A0 PWM 105 FAN 1400<br>=A0=A0=A0 PWM 90 FAN 1313<br>
=A0=A0=A0 PWM 75 FAN 1250<br>=A0=A0=A0 PWM 60 FAN 1194<br>=A0=A0=A0 PWM 45 =
FAN 1121<br>=A0=A0=A0 PWM 30 FAN 1112<br>=A0=A0=A0 PWM 28 FAN 1113<br>=A0=
=A0=A0 PWM 26 FAN 1112<br>=A0=A0=A0 PWM 24 FAN 1112<br>=A0=A0=A0 PWM 22 FAN=
 1113<br>=A0=A0=A0 PWM 20 FAN 1112<br>=A0=A0=A0 PWM 18 FAN 1112<br>
=A0=A0=A0 PWM 16 FAN 1113<br>=A0=A0=A0 PWM 14 FAN 1112<br>=A0=A0=A0 PWM 12 =
FAN 1113<br>=A0=A0=A0 PWM 10 FAN 1112<br>=A0=A0=A0 PWM 8 FAN 1113<br>=A0=A0=
=A0 PWM 6 FAN 1112<br>=A0=A0=A0 PWM 4 FAN 1112<br>=A0=A0=A0 PWM 2 FAN 1112<=
br>=A0=A0=A0 PWM 0 FAN 1112<br><br>=A0 hwmon2/device/fan2_input ... speed w=
as 1211 now 1207<br>
=A0=A0=A0 no correlation<br><br>Testing pwm control hwmon2/device/pwm2 ...<=
br>=A0 hwmon2/device/fan1_input ... speed was 2227 now 2419<br>=A0=A0=A0 no=
 correlation<br>=A0 hwmon2/device/fan2_input ... speed was 1211 now 0<br>=
=A0=A0=A0 It appears that fan hwmon2/device/fan2_input<br>
=A0=A0=A0 is controlled by pwm hwmon2/device/pwm2<br>Would you like to gene=
rate a detailed correlation (y)? y<br>Note: If you had gnuplot installed, I=
 could generate a graphical plot.<br>=A0=A0=A0 PWM 255 FAN 548<br>=A0=A0=A0=
 PWM 240 FAN 258<br>
=A0=A0=A0 PWM 225 FAN 360 (probably incorrect)<br>=A0=A0=A0 PWM 210 FAN 547=
 (probably incorrect)<br>=A0=A0=A0 PWM 195 FAN 734 (probably incorrect)<br>=
=A0=A0=A0 PWM 180 FAN 891 (probably incorrect)<br>=A0=A0=A0 PWM 165 FAN 903=
 (probably incorrect)<br>=A0=A0=A0 PWM 150 FAN 853 (probably incorrect)<br>
=A0=A0=A0 PWM 135 FAN 791 (probably incorrect)<br>=A0=A0=A0 PWM 120 FAN 724=
 (probably incorrect)<br>=A0=A0=A0 PWM 105 FAN 651 (probably incorrect)<br>=
=A0=A0=A0 PWM 90 FAN 573 (probably incorrect)<br>=A0=A0=A0 PWM 75 FAN 485 (=
probably incorrect)<br>=A0=A0=A0 PWM 60 FAN 382 (probably incorrect)<br>
=A0=A0=A0 PWM 45 FAN 188<br>=A0=A0=A0 PWM 30 FAN 0<br>=A0=A0=A0 Fan Stopped=
 at PWM =3D 30<br><br><br>Testing pwm control hwmon2/device/pwm3 ...<br>=A0=
 hwmon2/device/fan1_input ... speed was 2227 now 2280<br>=A0=A0=A0 no corre=
lation<br>=A0 hwmon2/device/fan2_input ... speed was 1211 now 1214<br>
=A0=A0=A0 no correlation<br><br>No correlations were detected.<br>There is =
either no fan connected to the output of hwmon2/device/pwm3,<br>or the conn=
ected fan has no rpm-signal connected to one of<br>the tested fan sensors. =
(Note: not all motherboards have<br>
the pwm outputs connected to the fan connectors,<br>check out the hardware =
database on <a href=3D"http://www.almico.com/forumindex.php">http://www.alm=
ico.com/forumindex.php</a>)<br><br>Did you see/hear a fan stopping during t=
he above test (n)? n<br>
<br>Testing is complete.<br>Please verify that all fans have returned to th=
eir normal speed.<br><br>The fancontrol script can automatically respond to=
 temperature changes<br>of your system by changing fanspeeds.<br>Do you wan=
t to set up its configuration file now (y)? n<br>
<br></div><div class=3D"gmail_extra"><br><br><div class=3D"gmail_quote">On =
17 March 2013 13:53, Guenter Roeck <span dir=3D"ltr">&lt;<a href=3D"mailto:=
linux@roeck-us.net" target=3D"_blank">linux@roeck-us.net</a>&gt;</span> wro=
te:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"im">On Sun, Mar 17, 2013 at 01=
:43:59PM +0800, Ross Moore wrote:<br>
&gt; Hi,<br>
&gt;<br>
&gt; I see the IT87 driver has been updated to handle the IT8771E found on =
some<br>
&gt; ASUS boards. I downloaded the latest it87.c, compiled it and loaded th=
e<br>
&gt; module.<br>
&gt;<br>
&gt; My fans are now detected, and seem to report correctly - hurrah! Howev=
er,<br>
&gt; the pwm controls for those fans seem way out of wack, and appear to be=
 on<br>
&gt; the same chip.<br>
&gt;<br>
</div>Can you be a bit more specific ? &quot;appear to be on the same chip&=
quot; - sure, where<br>
else ?<br>
<br>
Thanks,<br>
Guenter<br>
</blockquote></div><br></div>

--e89a8ff1c7e660ce3e04d818a77d--


--===============6295566729429326971==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============6295566729429326971==--
