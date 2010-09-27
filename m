From: roothorick <roothorick@gmail.com>
Date: Mon, 27 Sep 2010 00:55:58 +0000
Subject: [lm-sensors] Compatibility report: MSI 770-G45
Message-Id: <AANLkTi=Y_U7XVDKwt=o4z9_ADbNAsR0e7TpWLqtUYG8-@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="000325557956040a9e0491333113"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--000325557956040a9e0491333113
Content-Type: multipart/alternative; boundary=000325557956040a8f0491333111

--000325557956040a8f0491333111
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

My primary desktop is built around an MSI 770-G45 motherboard. The BIOS
shows three fanspeeds (CPU FAN, SYS FAN 1, SYS FAN 2), two temperatures (CP=
U
and "System"), and four voltages (CPU Vcore, 3.3V, 5V, and 12V). My CPU is =
a
Phenom II; k10temp detects it uneventfully and the values given are within
2-3 degrees of what the BIOS says. The board has a Fintek F71889FG (or
derivative; the driver detects it and returns valid values) but it's sittin=
g
in an ACPI zone...

I'm using acpi_enforce_resources=3Dlax, and getting this in dmesg every tim=
e
f71882 is loaded:
[27466.942766] f71882fg: Found f71889fg chip at 0x600, revision 21
[27466.942826] ACPI: resource f71882fg [io  0x0600-0x0607] conflicts with
ACPI region HMOR [mem 0x00000605-0x00000606 64bit pref window]
[27466.942833] ACPI: This conflict may cause random problems and system
instability
[27466.942838] ACPI: If an ACPI driver is available for this device, you
should use it instead of the native driver

I'm not seeing any stability problems. What voltages I can translate are
well within correct ranges.

I've made an incomplete .conf for this board (with guessed voltage, and wit=
h
it, sensors gives me this:
f71889fg-isa-0600
Adapter: ISA adapter
3.3V:          +3.36 V
Vcore:         +0.98 V  (max =3D  +2.04 V)
in2:           +1.08 V
in3:           +0.90 V
in4:           +0.58 V
in5:           +0.38 V
in6:           +0.29 V
3.3V (again?): +3.36 V
Vbat:          +3.28 V
CPU:          1347 RPM
System1:         0 RPM  ALARM
System2:         0 RPM  ALARM
CPU:           +30.0=B0C  (high =3D +255.0=B0C, hyst =3D +251.0=B0C)
                        (crit =3D +255.0=B0C, hyst =3D +251.0=B0C)  sensor =
=3D Intel
PECI
System:        +33.0=B0C  (high =3D +255.0=B0C, hyst =3D +253.0=B0C)
                        (crit =3D +255.0=B0C, hyst =3D +253.0=B0C)  sensor =
=3D
transistor

Note: Vcore (in1) jumps up to 1.4V (what my CPU is supposed to run at) when
the processor is under load; I'm guessing this is some kind of thermal
control feature. There are three fan headers on the board (one 4-pin two
3-pin); I just don't have anything connected to two of them.

I attached my .conf.

Any guesses what in2-in6 may be, and the correct multipliers for them?

--000325557956040a8f0491333111
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

My primary desktop is built around an MSI 770-G45 motherboard. The BIOS sho=
ws three fanspeeds (CPU FAN, SYS FAN 1, SYS FAN 2), two temperatures (CPU a=
nd &quot;System&quot;), and four voltages (CPU Vcore, 3.3V, 5V, and 12V). M=
y CPU is a Phenom II; k10temp detects it uneventfully and the values given =
are within 2-3 degrees of what the BIOS says. The board has a Fintek F71889=
FG (or derivative; the driver detects it and returns valid values) but it&#=
39;s sitting in an ACPI zone...<br>
<br>I&#39;m using acpi_enforce_resources=3Dlax, and getting this in dmesg e=
very time f71882 is loaded:<br>[27466.942766] f71882fg: Found f71889fg chip=
 at 0x600, revision 21<br>[27466.942826] ACPI: resource f71882fg [io=A0 0x0=
600-0x0607] conflicts with ACPI region HMOR [mem 0x00000605-0x00000606 64bi=
t pref window]<br>
[27466.942833] ACPI: This conflict may cause random problems and system ins=
tability<br>[27466.942838] ACPI: If an ACPI driver is available for this de=
vice, you should use it instead of the native driver<br><br>I&#39;m not see=
ing any stability problems. What voltages I can translate are well within c=
orrect ranges.<br>
<br>I&#39;ve made an incomplete .conf for this board (with guessed voltage,=
 and with it, sensors gives me this:<br>f71889fg-isa-0600<br>Adapter: ISA a=
dapter<br>3.3V:=A0=A0=A0=A0=A0=A0=A0=A0=A0 +3.36 V<br>Vcore:=A0=A0=A0=A0=A0=
=A0=A0=A0 +0.98 V=A0 (max =3D=A0 +2.04 V)=A0=A0 <br>
in2:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +1.08 V<br>in3:=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 +0.90 V<br>in4:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.58 V<br>in5:=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 +0.38 V<br>in6:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +0.2=
9 V<br>3.3V (again?): +3.36 V<br>Vbat:=A0=A0=A0=A0=A0=A0=A0=A0=A0 +3.28 V<b=
r>CPU:=A0=A0=A0=A0=A0=A0=A0=A0=A0 1347 RPM<br>System1:=A0=A0=A0=A0=A0=A0=A0=
=A0 0 RPM=A0 ALARM<br>
System2:=A0=A0=A0=A0=A0=A0=A0=A0 0 RPM=A0 ALARM<br>CPU:=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 +30.0=B0C=A0 (high =3D +255.0=B0C, hyst =3D +251.0=B0C)=A0 <br=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 (cri=
t =3D +255.0=B0C, hyst =3D +251.0=B0C)=A0 sensor =3D Intel PECI<br>System:=
=A0=A0=A0=A0=A0=A0=A0 +33.0=B0C=A0 (high =3D +255.0=B0C, hyst =3D +253.0=B0=
C)=A0 <br>
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 (crit=
 =3D +255.0=B0C, hyst =3D +253.0=B0C)=A0 sensor =3D transistor<br><br>Note:=
 Vcore (in1) jumps up to 1.4V (what my CPU is supposed to run at) when the =
processor is under load; I&#39;m guessing this is some kind of thermal cont=
rol feature. There are three fan headers on the board (one 4-pin two 3-pin)=
; I just don&#39;t have anything connected to two of them.<br>
<br>I attached my .conf.<br><br>Any guesses what in2-in6 may be, and the co=
rrect multipliers for them?<br>

--000325557956040a8f0491333111--

--000325557956040a9e0491333113
Content-Type: text/plain; charset=US-ASCII; name="770-G45.conf"
Content-Disposition: attachment; filename="770-G45.conf"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gekm7ooi0

IyBUaGlzIGlzIG9idmlvdXNseSB2ZXJ5IGluY29tcGxldGUuIFdlIGhhdmUgbm8gaWRlYSB3aGF0
IGluMiB0aHJvdWdoIGluNgojIGFyZS4KY2hpcCAiZjcxODg5ZmctKiIKICAgICAgICBsYWJlbCB0
ZW1wMSAiQ1BVIgogICAgICAgIGlnbm9yZSB0ZW1wMiAjIE5vdCBwcmVzZW50IGluIEJJT1MKICAg
ICAgICBsYWJlbCB0ZW1wMyAiU3lzdGVtIgoKICAgICAgICBsYWJlbCBmYW4xICJDUFUiCiAgICAg
ICAgbGFiZWwgZmFuMiAiU3lzdGVtMSIgIyBVc2luZyBCSU9TIGxhYmVscyBoZXJlCiAgICAgICAg
bGFiZWwgZmFuMyAiU3lzdGVtMiIKCgkjIFZyYW0gaXNuJ3QgcHJlc2VudC4gWW91IGNhbiBwbGF5
IHdpdGggdGhlIERSQU0gdm9sdGFnZSBpbiB0aGUgQklPUwoJIyBhbGwgeW91IHdhbnQgYW5kIG5v
bmUgb2YgdGhlIHZhbHVlcyB3aWxsIGNoYW5nZS4KCSMgVGhlIEJJT1MgZ2l2ZXMgdm9sdGFnZSB2
YWx1ZXMgZm9yIDVWIGFuZCAxMlYgc28gdGhleSBoYXZlIHRvIGJlIGluCgkjIGhlcmUuLi4uICpz
b21ld2hlcmUqLiBZb3VyIGd1ZXNzIGlzIGFzIGdvb2QgYXMgbWluZS4KICAgICAgICBsYWJlbCBp
bjAgIjMuM1YiCiAgICAgICAgbGFiZWwgaW4xICJWY29yZSIKICAgICAgICBsYWJlbCBpbjcgIjMu
M1YgKGFnYWluPykiCiAgICAgICAgbGFiZWwgaW44ICJWYmF0IgoKIyBpbjAsIGluNywgYW5kIGlu
OCBhcHBlYXIgdG8gYmUgaGFyZHdpcmVkIHRoZSBzYW1lIHdheSB0aGV5IGFyZSBvbgojIHRoZSA3
MTg4MjsgYXQgbGVhc3QgdGhlIG51bWJlcnMgbWFrZSBzZW5zZSB0aGF0IHdheS4KICAgICAgICBj
b21wdXRlIGluMCAoQCAqIDIpLCAoQCAvIDIpCiAgICAgICAgIyBpbjEgaXMgYWxyZWFkeSBjb3Jy
ZWN0CiAgICAgICAgY29tcHV0ZSBpbjcgKEAgKiAyKSwgKEAgLyAyKQogICAgICAgIGNvbXB1dGUg
aW44IChAICogMiksIChAIC8gMikKCg==
--000325557956040a9e0491333113
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--000325557956040a9e0491333113--
