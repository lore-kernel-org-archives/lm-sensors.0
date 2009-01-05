From: Mark Nienberg <gmane@tippingmar.com>
Date: Mon, 05 Jan 2009 19:02:30 +0000
Subject: [lm-sensors] Asus KFN4-DRE board
Message-Id: <gjtlg7$htb$1@ger.gmane.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Forgive me if this is double posted.  I'm using gmane and I forgot to enabl=
e the=20
address the first time.

CentOS 5.2 x86_64
lm_sensors 2.10.6 installed from atrpms
ASUS KFN4-DRE server motherboard

sensors-detect suggested the w83627hf module, but that gave nonsense result=
s.  The=20
w83792d module is the correct one for this board, as documented in the moth=
erboard=20
user guide.  I switched to that one and it mostly works.

Here is typical output:

[root@gecko sysconfig]# service lm_sensors status
w83792d-i2c-0-2f
Adapter: SMBus nForce2 adapter at 4c00
VCoreA:    +1.10 V  (min =3D  +0.80 V, max =3D  +1.60 V)
5VCC:      +4.91 V  (min =3D  +0.00 V, max =3D  +6.12 V)
5VSB:      +4.81 V  (min =3D  +0.00 V, max =3D  +6.12 V)
VBAT:      +3.01 V  (min =3D  +0.00 V, max =3D  +4.08 V)
HD Fan:   2033 RPM  (min =3D    0 RPM, div =3D 4)
CPU Fan:  5037 RPM  (min =3D    0 RPM, div =3D 4)
P/S Fan:   715 RPM  (min =3D    0 RPM, div =3D 16)
Temp1:     +29.0=B0C  (high =3D +127.0=B0C, hyst =3D +0.0=B0C)
Temp2:     +28.5=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)
Temp3:     +25.5=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)

I can't make sense of the temperatures because they are almost all the same.
The BIOS reports these temps at approx the same time as the ones above:

CPU1 34 deg C
CPU2 N/A  (I only have one CPU on the board, but it holds 2)
MB   29 deg C

Can anyone suggest corrections and proper labels for the temps?

Also, the board has 10 fan connectors (really!) and I carefully mapped them=
 to the=20
monitored fans.  I would be happy to provide this info for a page in the Tr=
ac wiki.=20
Or is it possible for me to edit the wiki?

Thanks,

Mark Nienberg



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
