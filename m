From: <Wsong@nuvoton.com>
Date: Fri, 13 Mar 2009 01:25:03 +0000
Subject: Re: [lm-sensors] NEW Nuvoton w83795 hw chip driver
Message-Id: <29CFBC9A3FDC81418F5FACEEC8970E0033F309@ntshml01.nuvoton.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <29CFBC9A3FDC81418F5FACEEC8970E003069F4@ntshml01.nuvoton.com>
In-Reply-To: <29CFBC9A3FDC81418F5FACEEC8970E003069F4@ntshml01.nuvoton.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Jean,

Thank you for your response.

I named main driver file as "wb83795.c" just for fit the Makefile. Please c=
hange its name to fit other drivers in kernel.

The attach file is the i2cdump result.

In fact I have made some subversions for kernel 2.6.5 (Suse 9), kernel 2.6.=
9 (RHEL 4), kernel 2.6.21 and kernel 2.6.27. You can contact with me if you=
 need them.


Best Regards,
wsong

-----Original Message-----
From: Jean Delvare [mailto:khali@linux-fr.org]=20
Sent: 2009=C4=EA3=D4=C212=C8=D5 21:06
To: PS23 WSONG
Cc: lm-sensors@lm-sensors.org; PS23 WMWU; PS00 LCChen; PS23 JGONG
Subject: Re: [lm-sensors] NEW Nuvoton w83795 hw chip driver

Hi Wei,

On Tue, 3 Mar 2009 16:20:15 +0800, Wsong@nuvoton.com wrote:
> Dear lm-sensor group,
>=20
> I am glad to submit to you the driver for Nuvoton W83795G/ADG hw monitor =
chip.=20
>=20
> The W83795G/ADG chip information are show at here:
> http://www.nuvoton.com/hq/enu/ProductAndSales/ProductLines/ComputerIC/Har=
dwareMonitor/HWMonitorforDesktopAndServer/

I have added an entry for that chip to our wiki Devices page. Thanks a
lot for contributing code for your hardware, this is very appreciated.

> Driver files list:
> The attach file "wb83795.c" is the main driver file. This driver passed t=
est on kernel 2.6.28.7.

Shouldn't this rather be w83795.c? This would be consistent with the
other driver names and with your sensors-detect patch.

> The attach file "Makefile" is used for compile the driver.
>=20
> Patch files for lm-sensors 3.0.3:
>=20
> The attach file "795_sensor3.conf" is the 795 related lines for sensor3.c=
onf. But the exact names and settings may be changed for the motherboards.
>=20
> The attach file "DESC" is the list of sys files which 795 driver would cr=
eate.
>=20
> The attach file "sensors-detect.3.0.3.patch" add detect 795 chip for "sen=
sor-detect" tool in lm-sensors 3.0.3 package.

I have adjusted this patch so that it applies on top of 3.1.0 (there
have been a lot of changes in sensors-detect between 3.0.3 and 3.1.0.)
Can you please send me a dump of your W83795 chip so that I can test
the code before I commit it? You can obtain such a dump using the
i2c-dev kernel driver and "i2cdump" from the i2c-tools package:

# modprobe i2c-dev
# i2cdump 0 0x2d b

Replace 0 with the actual I2C bus number your chip sits on and 0x2d
with the actual I2C address of the chip. Remember to first unload the
w83795 driver if it is loaded.

> Until now, it seems there is not a motherboard based on W83795G/ADG in th=
e market, and I am sure not the 795 SPEC could be share to you or not.
>=20
> Please contact me if you need any help, want to know any information or h=
ave some other questions.

Unfortunately I will not have the time to do more. Maybe later when
there are actual motherboards with this chip and users start asking for
support...

--=20
Jean Delvare


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3DThe privileged =
confidential information contained in this email is intended for use only b=
y the addressees as indicated by the original sender of this email. If you =
are not the addressee indicated in this email or are not responsible for de=
livery of the email to such  a person, please kindly reply to the sender in=
dicating this fact and delete all copies of it from your computer and netwo=
rk server immediately. Your cooperation is highly appreciated. It is advise=
d that any unauthorized use of confidential information of Nuvoton is stric=
tly prohibited; and any information in this email irrelevant to the officia=
l business of Nuvoton shall be deemed as neither given nor endorsed by Nuvo=
ton.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
