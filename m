From: Raymond Kao <raymkao@gmail.com>
Date: Thu, 18 Oct 2012 10:18:55 +0000
Subject: [lm-sensors] quesion about i2cdetect and i2cget
Message-Id: <CADt+=H2ycekqH+QzydqTx17H-wnYp-aTkRbU3D9uCPCAj_iH3A@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============3671660471157488582=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============3671660471157488582==
Content-Type: multipart/alternative; boundary=e89a8f838d9ff7011a04cc52b63b

--e89a8f838d9ff7011a04cc52b63b
Content-Type: text/plain; charset=ISO-8859-1

Hi,

I built i2c tools from the source i2c-tools -3.1.0 and try to use it to
access my home brew DM3730 board. When I use i2cdetect to check I2c bus,
the error "controller timed out" happens, but if I run i2cget to retrieve
data from the device, it can get the right result. I checked the code to
look for the difference, and found that in i2cget.c, the code

res = i2c_smbus_write_byte(file, daddress);

has been called before read data from device, which seems to set register
address for reading.  In i2cdetect.c, there is no instructions like this. I
am not sure if this causes the time out error, since i2cdetect app can scan
other devices on the bus correctly.

Can anybody can help me to understand why this happens? Thank you very much.

-Ray

--e89a8f838d9ff7011a04cc52b63b
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>Hi,</div><div>=A0</div><div>I built i2c tools from the source i2c-tool=
s -3.1.0 and try to use it to access my home brew DM3730 board. When I use =
i2cdetect to check I2c bus, the error &quot;controller timed out&quot; happ=
ens, but if I run i2cget to retrieve data from the device, it can get the r=
ight result. I checked the code to look for the difference, and found that =
in i2cget.c, the code </div>
<div>=A0</div><div>res =3D i2c_smbus_write_byte(file, daddress);</div><div>=
=A0</div><div>has been called before read data from device, which=A0seems t=
o set register address for reading.=A0=A0In i2cdetect.c, there is no instru=
ctions like this. I am not sure if this causes the time out error, since i2=
cdetect app can scan other devices on the bus correctly. </div>
<div>=A0</div><div>Can anybody can help me to understand why this happens? =
Thank you very much.</div><div>=A0</div><div>-Ray</div>

--e89a8f838d9ff7011a04cc52b63b--


--===============3671660471157488582==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============3671660471157488582==--
