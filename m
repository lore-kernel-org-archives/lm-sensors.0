From: kiran@serc.iisc.ernet.in
Date: Sat, 26 Jan 2008 14:32:38 +0000
Subject: [lm-sensors] CPU temperature
Message-Id: <1896.10.16.10.158.1201357238.squirrel@mail.serc.iisc.ernet.in>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi,

  We have IBM Intellistation, I am using lm_sensors-2.10.1-1.fc6. It is
working fine. But when i run sensors it shows three temperatures as
temp1 temp2 and temp3. Kindly indicate in this three which is CPU
temperature.

temp1:       +58=B0C  (high =3D   +71=B0C, hyst =3D   +66=B0C)
temp2:    +127.0=B0C  (high =3D  -128=B0C, hyst =3D  +126=B0C)   ALARM
temp3:     +35.5=B0C  (high =3D   +41=B0C, hyst =3D   +39=B0C)


I am using following modules as detected by sensors-detec. My Os fedora
core 6

modprobe i2c-i801
modprobe i2c-isa
modprobe w83781d
modprobe eeprom
modprobe smbus-arp
modprobe smsc47m1


Thanking you,
regards,
kiran


--=20
This message has been scanned for viruses and
dangerous content by MailScanner, and is
believed to be clean.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
