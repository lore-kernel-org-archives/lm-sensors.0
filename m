From: David Hubbard <david.c.hubbard+coreboot@gmail.com>
Date: Tue, 13 Aug 2013 23:05:46 +0000
Subject: Re: [lm-sensors] About the Asus F2A temperature sensor (it8603e)
Message-Id: <CAC-0EqgNNTEvavmVpnTn_RLf0uhgMrkn9VdTrezxp2kmpqrQLg@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============4553454184418901655=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============4553454184418901655==
Content-Type: multipart/alternative; boundary=089e0149ca3af062a204e3dc47f1

--089e0149ca3af062a204e3dc47f1
Content-Type: text/plain; charset=ISO-8859-1

Hi Jukka,


On Tue, Aug 13, 2013 at 1:10 AM, Jukka Nikulainen <
jukka.nikulainen@helsinki.fi> wrote:

> There are really only two questions I have.
>
> Firstly: Did I understand correctly that only using the slightly modified
> it87-driver 'sensors' was able to report the temperature readings correctly?
>

It needs more testing, but the short answer is: yes.


> After reading the thread I was under the impression that changes in the
> hwmon-vid.c file were only needed to get sane readings about voltages. Is
> this correct? I have built the case for my computer and I am only
> interested in monitoring the temperatures.
>

The changes to hwmon-vid.c were to correctly interpret the VID bits -- bits
that store a coded value representing the CPU voltage. You can get more
information about that from Jean Delvare via lm-sensors@lm-sensors.org. He,
not I, wrote the changes for hwmon-vid.c as a matter of fact.

Secondly: I assume that the correct work-flow is to make your changes in
> the it87 source code, compile the file, replace the driver and modprobe it.
> I have compiled programs before but not very frequently and nothing
> kernel-related. I'm sure that the procedure is dead-simple, but I still
> have a few questions that even extensive googling didn't answer. For
> example, are the relevant kernel header files the only dependency?
>

Building a module out-of-tree is possible (using just the kernel header
files). I am aware that this may result in the cleanest results for a
debian system, since you can use a stock debian kernel and load your
out-of-tree module.

However, I suggest taking a different approach. This module in particular
is highly experimental, as in: I think I'm the only other person who has
actually tried it. I believe that is a good reason not to use a stock
kernel. If you use a stock kernel, your results are not representative of
the simplest "base case" for debugging, and this particular chip would
benefit from more testing of the base case. It would also be possible to
use a stock debian kernel + out-of-tree module, and then carefully attempt
to replicate your problem on a kernel compiled from source any time you
want to discuss it on the lm-sensors list... but that's a whole lot of
extra work for you :)


> Do you know of any (possibly generic) makefile for the drivers? I was also
> unable to find any version of it87.c that would readily incorporate your
> changes; has it been published anywhere?
>

You can get the source I used for it87.c from the latest kernel sources and
then apply the patch. If the patch does not apply well to the latest
it87.c, I'm interested in updating the patch so it does apply cleanly to
the latest kernel. (I view the patch as a relatively simple change, which
should be highly portable.)

Good luck and happy hacking,
David

P.S. I have reason to believe that the it87 device we are talking about is
actually an emulation running on an 8051 co-processor, specifically the EC
(Embedded Controller) in the AMD A85 Hudson chipset. The it87 emulation is
poorly written in the 8051 code and can result in unexpected effects --
bugs. I have specifically seen the sensor stop updating (as if it just
stopped sampling values).

Therefore, the patch may be somewhat useful for getting sensor data in
linux, but it is not going to be the final solution for getting good sensor
data from the F2A85-M motherboard. Or in other words, I don't plan to take
the patch all the way to inclusion in the Linux kernel.

--089e0149ca3af062a204e3dc47f1
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Jukka,<br><div class=3D"gmail_extra"><br><br><div class=
=3D"gmail_quote">On Tue, Aug 13, 2013 at 1:10 AM, Jukka Nikulainen <span di=
r=3D"ltr">&lt;<a href=3D"mailto:jukka.nikulainen@helsinki.fi" target=3D"_bl=
ank">jukka.nikulainen@helsinki.fi</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">There are really only two=
 questions I have.<br>
<br>
Firstly: Did I understand correctly that only using the slightly modified i=
t87-driver &#39;sensors&#39; was able to report the temperature readings co=
rrectly?<br></blockquote><div><br></div><div>It needs more testing, but the=
 short answer is: yes.<br>
</div><div>=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
 After reading the thread I was under the impression that changes in the hw=
mon-vid.c file were only needed to get sane readings about voltages. Is thi=
s correct? I have built the case for my computer and I am only interested i=
n monitoring the temperatures.<br>
</blockquote><div><br></div><div>The changes to hwmon-vid.c were to correct=
ly interpret the VID bits -- bits that store a coded value representing the=
 CPU voltage. You can get more information about that from Jean Delvare via=
 <a href=3D"mailto:lm-sensors@lm-sensors.org">lm-sensors@lm-sensors.org</a>=
. He, not I, wrote the changes for hwmon-vid.c as a matter of fact.<br>
<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
Secondly: I assume that the correct work-flow is to make your changes in th=
e it87 source code, compile the file, replace the driver and modprobe it. I=
 have compiled programs before but not very frequently and nothing kernel-r=
elated. I&#39;m sure that the procedure is dead-simple, but I still have a =
few questions that even extensive googling didn&#39;t answer. For example, =
are the relevant kernel header files the only dependency?<br>
</blockquote><div><br></div><div>Building a module out-of-tree is possible =
(using just the kernel header files). I am aware that this may result in th=
e cleanest results for a debian system, since you can use a stock debian ke=
rnel and load your out-of-tree module.<br>
<br>However, I suggest taking a different approach. This module in particul=
ar is highly experimental, as in: I think I&#39;m the only other person who=
 has actually tried it. I believe that is a good reason not to use a stock =
kernel. If you use a stock kernel, your results are not representative of t=
he simplest &quot;base case&quot; for debugging, and this particular chip w=
ould benefit from more testing of the base case. It would also be possible =
to use a stock debian kernel + out-of-tree module, and then carefully attem=
pt to replicate your problem on a kernel compiled from source any time you =
want to discuss it on the lm-sensors list... but that&#39;s a whole lot of =
extra work for you :)<br>
=A0<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
Do you know of any (possibly generic) makefile for the drivers? I was also =
unable to find any version of it87.c that would readily incorporate your ch=
anges; has it been published anywhere?<br></blockquote><div><br></div>
<div>You can get the source I used for it87.c from the latest kernel source=
s and then apply the patch. If the patch does not apply well to the latest =
it87.c, I&#39;m interested in updating the patch so it does apply cleanly t=
o the latest kernel. (I view the patch as a relatively simple change, which=
 should be highly portable.)<br>
<br></div><div>Good luck and happy hacking,<br>David<br><br>P.S. I have rea=
son to believe that the it87 device we are talking about is actually an emu=
lation running on an 8051 co-processor, specifically the EC (Embedded Contr=
oller) in the AMD A85 Hudson chipset. The it87 emulation is poorly written =
in the 8051 code and can result in unexpected effects -- bugs. I have speci=
fically seen the sensor stop updating (as if it just stopped sampling value=
s).<br>
<br></div><div>Therefore, the patch may be somewhat useful for getting sens=
or data in linux, but it is not going to be the final solution for getting =
good sensor data from the F2A85-M motherboard. Or in other words, I don&#39=
;t plan to take the patch all the way to inclusion in the Linux kernel.<br>
</div></div></div></div>

--089e0149ca3af062a204e3dc47f1--


--===============4553454184418901655==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============4553454184418901655==--
