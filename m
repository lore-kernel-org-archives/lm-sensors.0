From: =?ISO-8859-1?Q?Simon_Sandstr=F6m?= <gurka@acc.umu.se>
Date: Thu, 18 Jul 2013 13:00:23 +0000
Subject: Re: [lm-sensors] Module asus_atk0110 - Fan speed often shows zero instead of correct value
Message-Id: <CA+1DPT1thMOwnVCnc90edZ4JdRSK_tSYiHFZoxZn9aL1QQCHdA@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============5041461083108702715=="
List-Id: <lm-sensors.vger.kernel.org>
References: <CA+1DPT0KNOJht7djog8oK61Fs=ConqJpe_O9zJ9csg1jUNA2Sg@mail.gmail.com>
In-Reply-To: <CA+1DPT0KNOJht7djog8oK61Fs=ConqJpe_O9zJ9csg1jUNA2Sg@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--===============5041461083108702715==
Content-Type: multipart/alternative; boundary=001a11c2297a11f66804e1c8cbaa

--001a11c2297a11f66804e1c8cbaa
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello! Thanks for the reply.

2013/7/18 Jean Delvare <khali@linux-fr.org>

> Hi Simon,
>
> On Tue, 16 Jul 2013 19:04:39 +0200, Simon Sandstr=F6m wrote:
> > I'm having trouble with the asus_atk0110 kernel module. The speed for
> fan3
> > (CHASSI2 FAN) often just shows zero, but once in awhile it shows the
> actual
> > speed of the fan. I've checked the fan, and it does spin at all time an=
d
> it
> > also shows the correct speed at all time in BIOS.
>
> Which motherboard is it? On some boards passing module parameter
> new_if=3D1 helps, you may want to give it a try.


> Also, the asus_atk0110 driver heavily relies on the BIOS, so a BIOS
> update may help.
>

Asus P5K Premium. I'm pretty sure it has the latest BIOS version (can't
check now, see below). I tried using the option new_if=3D1 and it just
screwed up all readings. For example it now shows 1.54V for all voltages,
1500~RPM for all fans and 150=B0C for both CPU and MB, which is way off.

>
> Note that the fact that the speed in the BIOS is right doesn't
> necessarily mean that the BIOS is right and the asus_atk0110 Linux
> kernel driver is wrong. If the fan has any form of automatic speed
> control applied, it might simply be that the BIOS keeps your machine
> busy enough for the fan to stay in the measurable speed area. Did you
> enable fan speed control in the BIOS? Does the problem go away if you
> (temporarily) disable it?


> For 3-pin fans, speed measurement is easy and reliable when the fan
> runs at full speed. However as soon as control is applied, measurement
> becomes harder. This is true when PWM control is used, but even more
> when DC control is used: the speed signal weakens as the voltage is
> lowered, and after some point it's difficult for the monitoring chip to
> distinguish between the speed signal and the noise.
>
> So maybe your fan is spinning at the border between readable and
> unreadable.
>

Yes, I have fan control enabled both for CPU and chassi fans. I can not
disable it at the moment as the server is running some services which needs
to be up. CPU is set to automatic and the chassi fans is set to run at 70%
duty. Both chassi fans are the same model, but only one of them is giving
strange readings with lm-sensors. So I don't think there is a problem
because of the speed control.

I will try to disable the fan control and also try to switch the
connectionof the two chassi fans to see if I can come up with anything.


> > There is also a slight delay when reading the input with "cat
> > /sys/class/hwmon/hwmon0/fan3_input". When the speed is zero, it takes
> > approx. 0.3s and when it shows the correct speed (700RPM) it takes 0.1s=
.
> > All other fan inputs respond with no delay (0.001s).
>
> Not necessarily surprising. I don't know how exactly the Asus BIOS code
> works, but I can imagine that they try harder when the fan speed they
> read at first looks suspicious. This would explain the extra delay.
>
> > (...)
> > Does anyone else have this problem, or any similar problem? I could jus=
t
> > connect the fan to fan4 and ignore fan3, but for some reason the minimu=
m
> > speed for fan4 is 800RPM (the others are 600RPM), and I like my fans
> > running at 700RPM..
>
> How do you keep them at exactly 700 RPM?
>

See above.


>
> --
> Jean Delvare
>

Simon

--001a11c2297a11f66804e1c8cbaa
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hello! Thanks for the reply.</div><div><br></div>2013=
/7/18 Jean Delvare <span dir=3D"ltr">&lt;<a href=3D"mailto:khali@linux-fr.o=
rg" target=3D"_blank">khali@linux-fr.org</a>&gt;</span><br><div class=3D"gm=
ail_extra">
<div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204=
);border-left-style:solid;padding-left:1ex">
Hi Simon,<br>
<div><br>
On Tue, 16 Jul 2013 19:04:39 +0200, Simon Sandstr=F6m wrote:<br>
&gt; I&#39;m having trouble with the asus_atk0110 kernel module. The speed =
for fan3<br>
&gt; (CHASSI2 FAN) often just shows zero, but once in awhile it shows the a=
ctual<br>
&gt; speed of the fan. I&#39;ve checked the fan, and it does spin at all ti=
me and it<br>
&gt; also shows the correct speed at all time in BIOS.<br>
<br>
</div>Which motherboard is it? On some boards passing module parameter<br>
new_if=3D1 helps, you may want to give it a try.</blockquote><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px=
;border-left-color:rgb(204,204,204);border-left-style:solid;padding-left:1e=
x">

<br>
Also, the asus_atk0110 driver heavily relies on the BIOS, so a BIOS<br>
update may help.<br></blockquote><div><br></div><div>Asus P5K Premium. I&#3=
9;m pretty sure it has the latest BIOS version (can&#39;t check now, see be=
low). I tried using the option new_if=3D1 and it just screwed up all readin=
gs. For example it now shows 1.54V for all voltages, 1500~RPM for all fans =
and 150=B0C for both CPU and MB, which is way off.<br>
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left-width:1px;border-left-color:rgb(204,204,204);border-left-style:s=
olid;padding-left:1ex">
<br>
Note that the fact that the speed in the BIOS is right doesn&#39;t<br>
necessarily mean that the BIOS is right and the asus_atk0110 Linux<br>
kernel driver is wrong. If the fan has any form of automatic speed<br>
control applied, it might simply be that the BIOS keeps your machine<br>
busy enough for the fan to stay in the measurable speed area. Did you<br>
enable fan speed control in the BIOS? Does the problem go away if you<br>
(temporarily) disable it?</blockquote><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(=
204,204,204);border-left-style:solid;padding-left:1ex">
<br>
For 3-pin fans, speed measurement is easy and reliable when the fan<br>
runs at full speed. However as soon as control is applied, measurement<br>
becomes harder. This is true when PWM control is used, but even more<br>
when DC control is used: the speed signal weakens as the voltage is<br>
lowered, and after some point it&#39;s difficult for the monitoring chip to=
<br>
distinguish between the speed signal and the noise.<br>
<br>
So maybe your fan is spinning at the border between readable and<br>
unreadable.<br></blockquote><div><br></div><div>Yes, I have fan control ena=
bled both for CPU and chassi fans.=A0I can not disable it at the moment as =
the server is running some services which needs to be up.=A0CPU is set to a=
utomatic and the chassi fans is set to run at 70% duty. Both chassi fans ar=
e the same model, but only one of them is giving strange readings with lm-s=
ensors. So I don&#39;t think there is a problem because of the speed contro=
l.</div>
<div><br></div><div>I will try to disable the fan control and also try to s=
witch the connectionof the two chassi fans to see if I can come up with any=
thing.</div><div><br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204=
);border-left-style:solid;padding-left:1ex">

<div><br>
&gt; There is also a slight delay when reading the input with &quot;cat<br>
&gt; /sys/class/hwmon/hwmon0/fan3_input&quot;. When the speed is zero, it t=
akes<br>
&gt; approx. 0.3s and when it shows the correct speed (700RPM) it takes 0.1=
s.<br>
&gt; All other fan inputs respond with no delay (0.001s).<br>
<br>
</div>Not necessarily surprising. I don&#39;t know how exactly the Asus BIO=
S code<br>
works, but I can imagine that they try harder when the fan speed they<br>
read at first looks suspicious. This would explain the extra delay.<br>
<br>
&gt; (...)<br>
<div>&gt; Does anyone else have this problem, or any similar problem? I cou=
ld just<br>
&gt; connect the fan to fan4 and ignore fan3, but for some reason the minim=
um<br>
&gt; speed for fan4 is 800RPM (the others are 600RPM), and I like my fans<b=
r>
&gt; running at 700RPM..<br>
<br>
</div>How do you keep them at exactly 700 RPM?<br></blockquote><div><br></d=
iv><div>See above.</div><div>=A0</div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(=
204,204,204);border-left-style:solid;padding-left:1ex">

<span><font color=3D"#888888"><br>
--<br>
Jean Delvare<br></font></span></blockquote><div><br></div><div>Simon=A0</di=
v></div><br></div></div>

--001a11c2297a11f66804e1c8cbaa--


--===============5041461083108702715==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============5041461083108702715==--
