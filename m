From: James Cloos <cloos@jhcloos.com>
Date: Wed, 05 Nov 2014 21:15:54 +0000
Subject: [lm-sensors] Kaveri temps
Message-Id: <m31tph9wmt.fsf@carbon.jhcloos.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

I'm getting odd temp readings on an A8-7600 with 3.3.4 and Linus'
current kernel.

Eg, the gpu temp shows up when (mostly) idle as:

 radeon-pci-0008
 Adapter: PCI adapter
 temp1:         -1.0=B0C  (crit =3D +120.0=B0C, hyst =3D +90.0=B0C)

aka:

 radeon-pci-0008
 Adapter: PCI adapter
 temp1:        +32.0=B0F  (crit =3D +248.0=B0F, hyst =3D +194.0=B0F)


And the cpu temp is similar:

 k10temp-pci-00c3
 Adapter: PCI adapter
 temp1:         +0.0=B0C  (high =3D +70.0=B0C)
                        (crit =3D +80.0=B0C, hyst =3D +79.0=B0C)
aka:

 k10temp-pci-00c3
 Adapter: PCI adapter
 temp1:        +32.0=B0F  (high =3D +158.0=B0F)
                        (crit =3D +176.0=B0F, hyst =3D +174.2=B0F)

Is this a known issue?

-JimC
--=20
James Cloos <cloos@jhcloos.com>         OpenPGP: 0x997A9F17ED7DAEA6

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
