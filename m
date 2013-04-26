From: Joe May <josephdmay@gmail.com>
Date: Fri, 26 Apr 2013 01:16:06 +0000
Subject: [lm-sensors] Kernel problems
Message-Id: <CAJPx3-yTzJCrgHK1BMLz7MvtVKeq4_x5ZFA5_xDGBFeVPTjdrg@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============8804459380294865632=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============8804459380294865632==
Content-Type: multipart/alternative; boundary=089e0149cc548e642304db39475b

--089e0149cc548e642304db39475b
Content-Type: text/plain; charset=ISO-8859-1

Hi,

I recently purchased a phyCORE-MPC5200B development board with on board I2C
components.
After building the kernel (2.6.23.1) I flashed it to the board and it works
great; well everything but the I2C onboard devices.

phytec support told me to include lm_sensors when I compile the kernel.

when I run the mkpatch script, it does not like my kernel tree path.

There is also no linux directory under /usr/src.

I cannot figure out how to generate the patch file with my kernel (which is
a stock 2.6.23 from kernel.org) and I am using lm_sensors-2.8.8 with the
host OS being OpenSuse 11.1.

I have tried from the lm-sensors directory:

mkpatch/mkpatch.pl . /home/joe/linux-2.6.23/ > /tmp/sensors-patch
and it says:
Kernel root '/home/joe/linux-2.6.23/' is not found.

Please advise!

thanks,
Joe

--089e0149cc548e642304db39475b
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div style>Hi,</div><div style><br></div><div style>I =
recently purchased a phyCORE-MPC5200B development board with on board I2C c=
omponents.</div><div style>After building the kernel (2.6.23.1) I flashed i=
t to the board and it works great; well everything but the I2C onboard devi=
ces.</div>
<div style><br></div><div style>phytec support told me to include lm_sensor=
s when I compile the kernel.</div><div style><br></div><div style>when I ru=
n the mkpatch script, it does not like my kernel tree path.</div><div style=
>
<br></div><div style>There is also no linux directory under /usr/src.</div>=
<div style><br></div><div style>I cannot figure out how to generate the pat=
ch file with my kernel (which is a stock 2.6.23 from <a href=3D"http://kern=
el.org">kernel.org</a>) and I am using lm_sensors-2.8.8 with the host OS be=
ing OpenSuse 11.1.</div>
<div style><br></div><div style>I have tried from the lm-sensors directory:=
</div><div style><br></div><div style>mkpatch/<a href=3D"http://mkpatch.pl"=
>mkpatch.pl</a> . /home/joe/linux-2.6.23/ &gt; /tmp/sensors-patch</div><div=
 style>
and it says:</div><div style>Kernel root &#39;/home/joe/linux-2.6.23/&#39; =
is not found.</div><div style><br></div><div style>Please advise!</div><div=
 style><br></div><div style>thanks,</div><div style>Joe</div><div style>
<br></div></div>

--089e0149cc548e642304db39475b--


--===============8804459380294865632==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============8804459380294865632==--
