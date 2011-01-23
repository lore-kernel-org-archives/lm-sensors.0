From: Audio Phile <da_audiophile@yahoo.com>
Date: Sun, 23 Jan 2011 22:27:26 +0000
Subject: [lm-sensors] insane readings on Asus A7M266 motherboard
Message-Id: <761574.42437.qm@web36601.mail.mud.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

I had to reinstall Linux after a HDD crash.  Before the crash, sensors woul=
d work just fine with this board.  I am now unable to get it to work to cor=
rectly read the temp sensors.  If I look at them in the BIOS, the CPU is ab=
out 50C and the MB is about 35C.  When I view them in sensors, I get:

# sensors
via686a-isa-f000
Adapter: ISA adapter
Vcore:       +3.10 V  (min =3D  +3.10 V, max =3D  +3.10 V)  =20
in1:         +3.10 V  (min =3D  +3.10 V, max =3D  +3.10 V)  =20
+3.3V:       +3.12 V  (min =3D  +2.98 V, max =3D  +3.63 V)  =20
+5V:         +6.44 V  (min =3D  +4.51 V, max =3D  +5.50 V)  =20
+12V:       +15.60 V  (min =3D +10.81 V, max =3D +13.20 V)  =20
fan1:       3026 RPM  (min =3D 2689 RPM, div =3D 2)
fan2:          0 RPM  (min =3D    0 RPM, div =3D 2)
temp1:      +146.2=B0C  (high =3D +146.2=B0C, hyst =3D +54.4=B0C) =20
temp2:      +146.2=B0C  (high =3D +146.2=B0C, hyst =3D +54.4=B0C) =20
temp3:      +135.2=B0C  (high =3D +146.2=B0C, hyst =3D +146.2=B0C) =20

Hardware: Asus A7M266 (old, I know)
Sensors: sensors version 3.2.0 with libsensors version 3.2.0
Kernel: 2.6.32 or 2.6.37

Note that sensors-detect finds the "via686a" module but loading it does not=
hing without forcing an address as per the dmesg:
via686a 0000:00:04.4: Sensors disabled, enable with force_addr=3D0xe300

So I do it via: modprobe via686a force_addr=3D0xe300

Again, the temps are reasonable in the BIOS so I believe that the sensors a=
re fine.  Suggestions are welcomed.


     =20

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
