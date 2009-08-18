From: "Artem Tashkinov" <t.artem@lycos.com>
Date: Tue, 18 Aug 2009 21:17:22 +0000
Subject: [lm-sensors] Need help in deciphering sensors output (BIOS update
Message-Id: <20090818171722.HM.0000000000008rS@t.artem.mail-wwl10.bo3.lycos.com.lycos.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============3881134192298464093=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============3881134192298464093==
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi!
<br>
<br>With the recent BIOS update, my lm_sensors no longer correctly show m=
any readings (or I don't know how to set up /etc/sensors.conf correctly).
<br>
<br>Hardware info:
<br>
<br>Motherboard: Gigabyte M61P-S3, monitoring chip it87, BIOS revision F7=
f.
<br>
<br>lm_sensors: lm_sensors-3.1.0-1.fc11.i586
<br>Kernel: 2.6.30.1 (vanilla)
<br>
<br># sensors-detect output:
<br>
<br>Driver `it87':
<br>  * ISA bus, address 0x290
<br>    Chip `ITE IT8716F Super IO Sensors' (confidence: 9)
<br>
<br>Driver `adt7473':
<br>  * Bus `NVIDIA i2c adapter '
<br>    Busdriver `nvidia', I2C address 0x2e
<br>    Chip `Analog Devices ADT7473' (confidence: 5)
<br>
<br>Driver `k8temp':
<br>  * Chip `AMD K8 thermal sensors' (confidence: 9)
<br>
<br>$ sensors output:
<br>
<br>sensors
<br>it8716-isa-0290
<br>Adapter: ISA adapter
<br>in0:         +1.10 V  (min =3D  +0.00 V, max =3D  +4.08 V)
<br>in1:         +1.89 V  (min =3D  +0.00 V, max =3D  +4.08 V)
<br>in2:         +3.33 V  (min =3D  +0.00 V, max =3D  +4.08 V)
<br>in3:         +3.34 V  (min =3D  +0.00 V, max =3D  +4.08 V)
<br>in4:         +3.02 V  (min =3D  +0.00 V, max =3D  +4.08 V)
<br>in5:         +3.22 V  (min =3D  +0.00 V, max =3D  +4.08 V)
<br>in6:         +1.15 V  (min =3D  +0.00 V, max =3D  +4.08 V)
<br>in7:         +3.34 V  (min =3D  +0.00 V, max =3D  +4.08 V)
<br>Vbat:        +3.04 V
<br>fan1:       1394 RPM  (min =3D    0 RPM)
<br>fan2:       1344 RPM  (min =3D    0 RPM)
<br>temp1:       +40.0=C2=B0C  (low  =3D +127.0=C2=B0C, high =3D +60.0=C2=
=B0C)  sensor =3D thermistor
<br>temp2:       +40.0=C2=B0C  (low  =3D +127.0=C2=B0C, high =3D +127.0=C2=
=B0C)  sensor =3D thermistor
<br>temp3:       +26.0=C2=B0C  (low  =3D +127.0=C2=B0C, high =3D +60.0=C2=
=B0C)  sensor =3D thermal diode
<br>cpu0_vid:   +0.538 V
<br>
<br>k8temp-pci-00c3
<br>Adapter: PCI adapter
<br>Core0 Temp:  +37.0=C2=B0C
<br>Core1 Temp:  +30.0=C2=B0C
<br>
<br>I wonder where +12V and +5V lines are, which were shown before BIOS u=
pdate. Gigabyte own utility shows that data correctly.
<br>
<br>
<br>Best wishes, Artem


--===============3881134192298464093==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============3881134192298464093==--
