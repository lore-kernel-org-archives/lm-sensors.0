From: Angelo Compagnucci <angelo.compagnucci@gmail.com>
Date: Mon, 29 Jul 2013 10:47:35 +0000
Subject: [lm-sensors] Design decisions implementing an I2C LDD
Message-Id: <CA+TH9VktNEiLHmU1WJAUG0QWPsCCXrG5O=KjynBasR5h8LhpPw@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============1309004846675333062=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============1309004846675333062==
Content-Type: multipart/alternative; boundary=bcaec53f3591d27d7304e2a43a8c

--bcaec53f3591d27d7304e2a43a8c
Content-Type: text/plain; charset=ISO-8859-1

Hello list,

I'm implementing an LDD for the MCP3422 ADC from microchip. I'm heading at
kernel inclusion, so I'm asking here before doing it too much wrong.

I'm reading Documentation/hwmon/sysfs-interface, and I find that the chip
adhere poorly to that specification:

0) The chip has an 18bits ADC, but the unit of in0_input should be in mV, I
don't want to waste the 18bits precision. Right now I have the unit in nV
and it works quite well, but If I understand correctly, it's not right for
hwmon specs.
1) The chip provides up to 4 differential input channels, but only one at a
time could be read after setting the corresponding channel in a registry.
How should I manage 4 different inputs that maps the same device registry
to be compliant?
2) Cause the device has 4 differential inputs, it could output negative
values. Are they permitted?
3) The device has various configuration parameters (like varialbe
12/14/16/18bits precision, variable gain), could them be added as external
attributes?
4) The update_interval depends on the precion (device is faster with less
precision), could it be updated at runtime if user changes precision?

Thank you four support!

Angelo

-- 
Profile: http://it.linkedin.com/in/compagnucciangelo

--bcaec53f3591d27d7304e2a43a8c
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello list,<div><br></div><div>I&#39;m implementing an LDD=
 for the MCP3422 ADC from microchip. I&#39;m heading at kernel inclusion, s=
o I&#39;m asking here before doing it too much wrong.</div><div><br></div>

<div>I&#39;m reading Documentation/hwmon/sysfs-interface, and I find that t=
he chip adhere poorly to that specification:</div><div><br></div><div>0) Th=
e chip has an 18bits ADC, but the unit of in0_input should be in mV, I don&=
#39;t want to waste the 18bits precision. Right now I have the unit in nV a=
nd it works quite well, but If I understand correctly, it&#39;s not right f=
or hwmon specs.</div>

<div>1) The chip provides up to 4 differential input channels, but only one=
 at a time could be read after setting the corresponding channel in a regis=
try. How should I manage 4 different inputs that maps the same device regis=
try to be compliant?</div>

<div>2) Cause the device has 4 differential inputs, it could output negativ=
e values. Are they permitted?</div><div>3) The device has various configura=
tion parameters (like varialbe 12/14/16/18bits precision, variable gain), c=
ould them be added as external attributes?</div>

<div>4) The update_interval depends on the precion (device is faster with l=
ess precision), could it be updated at runtime if user changes precision?</=
div><div><br></div><div>Thank you four support!</div><div><br></div><div>

Angelo</div><div><div><br></div>-- <br>Profile: <a href=3D"http://it.linked=
in.com/in/compagnucciangelo" target=3D"_blank">http://it.linkedin.com/in/co=
mpagnucciangelo</a>
</div></div>

--bcaec53f3591d27d7304e2a43a8c--


--===============1309004846675333062==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============1309004846675333062==--
