From: Guillaume <bou.gui@laposte.net>
Date: Fri, 30 Jan 2009 12:29:27 +0000
Subject: [lm-sensors] lm-sensors and Intel P4
Message-Id: <200901301329.27821.bou.gui@laposte.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi everyone.

On my (old) laptop, i have an Intel P4=20

LSHW says :
*-cpu:0                                                                    =
                                                  =20
          description: CPU                                                 =
                                                       =20
          product: Intel(R) Pentium(R) 4 CPU 2.40GHz                       =
                                                       =20
          vendor: Intel Corp.                                              =
                                                       =20
          physical id: 4                                                   =
                                                       =20
          bus info: cpu@0                                                  =
                                                       =20
          version: 15.2.7                                                  =
                                                       =20
          slot: uPGA2                                                      =
                                                       =20
          size: 2400MHz                                                    =
                                                       =20
          capacity: 2400MHz                                                =
                                                       =20
          width: 32 bits                                                   =
                                                       =20
          clock: 2400MHz                                                   =
                                                       =20
          capabilities: fpu fpu_exception wp vme de pse tsc msr pae mce cx8=
=20
sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm=
 pbe=20
up pebs bts cid                                                            =
                              =20
          configuration: id=3D0

In DMESG, i have the following information :
[    0.085147] CPU0: Intel P4/Xeon Extended MCE MSRs (12) available        =
                                                       =20
[    0.085196] CPU0: Thermal monitoring enabled

I try the lm-sensors script sensors-detect, but no results.

Can someone help me ? I work with a debian distro.

Thank's for answer.

Guillaume

--=20
Garanti 0% Micro$oft
Envoy=E9 sous Debian
---
Pourquoi payer des logiciels inutiles =E0 l'achat d'un ordinateur neuf ?
http://www.racketiciel.info

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
