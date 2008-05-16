From: Alistair John Strachan <alistair@devzero.co.uk>
Date: Fri, 16 May 2008 22:07:28 +0000
Subject: [lm-sensors] abituguru probe failure
Message-Id: <200805162307.28224.alistair@devzero.co.uk>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi,

I have an IP35 Pro mainboard with the uGuru feature. Until recently I was
using the abituguru hwmon driver without issue. Recently (possibly since
upgrading the BIOS to 16) the driver no longer loads, citing:

abituguru3: no Abit uGuru3 found, data =3D 0x00, cmd =3D 0x55

After looking at the code in the driver, I found the force module parameter
and tried it. Sure enough, the module loaded fine:

abituguru3-isa-00e0
Adapter: ISA adapter
CPU Core:          +1.28 V  (min =3D  +0.00 V, max =3D  +1.70 V)
DDR2:              +2.10 V  (min =3D  +1.70 V, max =3D  +2.54 V)
DDR2 VTT:          +1.04 V  (min =3D  +0.85 V, max =3D  +1.27 V)
CPU VTT 1.2V:      +1.25 V  (min =3D  +1.05 V, max =3D  +1.55 V)
MCH 1.25V:         +1.25 V  (min =3D  +1.00 V, max =3D  +1.50 V)
ICHIO 1.5V:        +1.53 V  (min =3D  +1.20 V, max =3D  +1.80 V)
ICH 1.05V:         +1.07 V  (min =3D  +0.85 V, max =3D  +1.25 V)
ATX +12V (24-Pin):+12.36 V  (min =3D  +9.60 V, max =3D +14.40 V)
ATX +12V (8-pin): +12.36 V  (min =3D  +9.60 V, max =3D +14.40 V)
ATX +5V:           +5.04 V  (min =3D  +3.99 V, max =3D  +6.00 V)
+3.3V:             +3.32 V  (min =3D  +2.64 V, max =3D  +3.94 V)
5VSB:              +5.19 V  (min =3D  +3.99 V, max =3D  +6.00 V)
CPU Fan:             0 RPM  (min =3D  300 RPM)
SYS Fan:             0 RPM  (min =3D  300 RPM)
AUX1 Fan:         1380 RPM  (min =3D  300 RPM)
AUX2 Fan:         1620 RPM  (min =3D  300 RPM)
AUX3 Fan:            0 RPM  (min =3D  300 RPM)
AUX4 Fan:            0 RPM  (min =3D  300 RPM)
CPU:               +34.0=B0C  (high =3D +75.0=B0C, crit =3D +85.0=B0C)
System :           +28.0=B0C  (high =3D +55.0=B0C, crit =3D +65.0=B0C)
PWM :              +40.0=B0C  (high =3D +80.0=B0C, crit =3D +90.0=B0C)
PWM Phase2:         +0.0=B0C  (high =3D  +0.0=B0C, crit =3D +255.0=B0C)
PWM Phase3:         +0.0=B0C  (high =3D  +0.0=B0C, crit =3D +255.0=B0C)
PWM Phase4:         +0.0=B0C  (high =3D  +0.0=B0C, crit =3D +255.0=B0C)
PWM Phase5:         +0.0=B0C  (high =3D  +0.0=B0C, crit =3D +255.0=B0C)

A fix that works here is to add 0x55 as an additional cmd_val check in
abituguru3_detect(), but I think we all know this function is starting to
look a bit suspicious. I've attached a patch which does this (tested as
working), but I won't be surprised if you guys don't want to apply it.

Signed-off-by: Alistair John Strachan <alistair@devzero.co.uk>
---

diff --git a/drivers/hwmon/abituguru3.c b/drivers/hwmon/abituguru3.c
index ed33fdd..74b283d 100644
--- a/drivers/hwmon/abituguru3.c
+++ b/drivers/hwmon/abituguru3.c
@@ -1115,7 +1115,7 @@ static int __init abituguru3_detect(void)
 	u8 data_val =3D inb_p(ABIT_UGURU3_BASE + ABIT_UGURU3_DATA);
 	u8 cmd_val =3D inb_p(ABIT_UGURU3_BASE + ABIT_UGURU3_CMD);
 	if (((data_val =3D 0x00) || (data_val =3D 0x08)) &&
-			((cmd_val =3D 0xAC) || (cmd_val =3D 0x05)))
+		((cmd_val =3D 0xAC) || (cmd_val =3D 0x05) || (cmd_val =3D 0x55)))
 		return ABIT_UGURU3_BASE;
=20
 	ABIT_UGURU3_DEBUG("no Abit uGuru3 found, data =3D 0x%02X, cmd =3D "

--=20
Cheers,
Alistair.

137/1 Warrender Park Road, Edinburgh, UK.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
