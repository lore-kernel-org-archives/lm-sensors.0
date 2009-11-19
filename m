From: Nemykal <nemykal@gmail.com>
Date: Thu, 19 Nov 2009 04:07:32 +0000
Subject: [lm-sensors] lm-sensors w83795 chip, I want to help.
Message-Id: <d08fef840911182007y4793ac72w7c186e774546595b@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============5496062381992165140=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============5496062381992165140==
Content-Type: multipart/alternative; boundary=00151759031ea3f54e0478b17f21

--00151759031ea3f54e0478b17f21
Content-Type: text/plain; charset=UTF-8

Hello
I have an asus z8pe-d18 motherboard and according to the asus support site,
it has this (w83795) hardware monitoring chip in it.
By googling, I found this thread:
http://lists.lm-sensors.org/pipermail/lm-sensors/2009-March/025551.html
I am currently on 2.6.32-rc7 sources.
I'm on Gentoo x86_64
[I] sys-apps/lm_sensors 3.1.1 is installed [+sensord]

In that thread you asked for an i2c dump. I'm not sure how to do that.

First of all though, sensors-detect found these:

Driver `w83627ehf':
  * ISA bus, address 0x290
    Chip `Winbond W83667HG Super IO Sensors' (confidence: 9)

Driver `coretemp':
  * Chip `Intel Core family thermal sensor' (confidence: 9)

Driver `ipmisensors':
  * ISA bus
    Chip `IPMI BMC KCS' (confidence: 8)

...and also

Using driver `i2c-i801' for device 0000:00:1f.3: Intel ICH10


Anyway... I'm trying to figure out i2cdetect right now. I dont know what bus
number to use.

This is the output of my .config | grep I2C:

CONFIG_I2C=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
CONFIG_I2C_CHARDEV=y
CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_I801=y
CONFIG_I2C_ISCH=y
CONFIG_I2C_PIIX4=y
CONFIG_I2C_SCMI=y
CONFIG_I2C_OCORES=m
CONFIG_I2C_PARPORT=y
CONFIG_I2C_DEBUG_CORE=y
CONFIG_I2C_DEBUG_ALGO=y
CONFIG_I2C_DEBUG_BUS=y
CONFIG_I2C_DEBUG_CHIP=y
CONFIG_MFD_WM8350_I2C=y


I do not have a /dev/i2c/ folder...

I want to help get this chip supported, it seems the guy who wrote the
original driver disappeared.

--00151759031ea3f54e0478b17f21
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello<div>I have an asus z8pe-d18 motherboard and according to the asus sup=
port site, it has this (w83795) hardware monitoring chip in it.</div><div>B=
y googling, I found this thread:=C2=A0<a href=3D"http://lists.lm-sensors.or=
g/pipermail/lm-sensors/2009-March/025551.html">http://lists.lm-sensors.org/=
pipermail/lm-sensors/2009-March/025551.html</a></div>
<div>I am currently on 2.6.32-rc7 sources.</div><div>I&#39;m on Gentoo x86_=
64</div><div>[I] sys-apps/lm_sensors 3.1.1 is installed [+sensord]</div><di=
v><br></div><div>In that thread you asked for an i2c dump. I&#39;m not sure=
 how to do that.</div>
<div><br></div><div>First of all though, sensors-detect found these:</div><=
div><br></div><div><div>Driver `w83627ehf&#39;:</div><div>=C2=A0=C2=A0* ISA=
 bus, address 0x290</div><div>=C2=A0=C2=A0 =C2=A0Chip `Winbond W83667HG Sup=
er IO Sensors&#39; (confidence: 9)</div>
<div><br></div><div>Driver `coretemp&#39;:</div><div>=C2=A0=C2=A0* Chip `In=
tel Core family thermal sensor&#39; (confidence: 9)</div><div><br></div><di=
v>Driver `ipmisensors&#39;:</div><div>=C2=A0=C2=A0* ISA bus</div><div>=C2=
=A0=C2=A0 =C2=A0Chip `IPMI BMC KCS&#39; (confidence: 8)</div>
<div><br></div><div>...and also=C2=A0</div><div><br></div><div><div>Using d=
river `i2c-i801&#39; for device 0000:00:1f.3: Intel ICH10</div><div><br></d=
iv><div><br></div><div>Anyway... I&#39;m trying to figure out i2cdetect rig=
ht now. I dont know what bus number to use.=C2=A0</div>
<div><br></div><div>This is the output of my .config | grep I2C:</div><div>=
<br></div><div><div>CONFIG_I2C=3Dy</div><div>CONFIG_I2C_BOARDINFO=3Dy</div>=
<div>CONFIG_I2C_COMPAT=3Dy</div><div>CONFIG_I2C_CHARDEV=3Dy</div><div>CONFI=
G_I2C_HELPER_AUTO=3Dy</div>
<div>CONFIG_I2C_ALGOBIT=3Dy</div><div>CONFIG_I2C_I801=3Dy</div><div>CONFIG_=
I2C_ISCH=3Dy</div><div>CONFIG_I2C_PIIX4=3Dy</div><div>CONFIG_I2C_SCMI=3Dy</=
div><div>CONFIG_I2C_OCORES=3Dm</div><div>CONFIG_I2C_PARPORT=3Dy</div><div>C=
ONFIG_I2C_DEBUG_CORE=3Dy</div>
<div>CONFIG_I2C_DEBUG_ALGO=3Dy</div><div>CONFIG_I2C_DEBUG_BUS=3Dy</div><div=
>CONFIG_I2C_DEBUG_CHIP=3Dy</div><div>CONFIG_MFD_WM8350_I2C=3Dy</div><div><b=
r></div><div><br></div><div>I do not have a /dev/i2c/ folder...</div><div><=
br></div>
<div>I want to help get this chip supported, it seems the guy who wrote the=
 original driver disappeared.=C2=A0</div></div></div></div>

--00151759031ea3f54e0478b17f21--


--===============5496062381992165140==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============5496062381992165140==--
