From: =?ISO-8859-1?Q?Holger_B=FCrger?= <buerger@teamnet.de>
Date: Thu, 08 Aug 2013 11:24:43 +0000
Subject: Re: [lm-sensors] Motherboard Fujitsu D-3076-S
Message-Id: <52037FFB.2070709@teamnet.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <52035CE7.3060103@teamnet.de>
In-Reply-To: <52035CE7.3060103@teamnet.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi,


> Yes you can simply remove the line in question, and the 2 lines remove
> it, so remove the following lines:

But I have more errors then.

make -C /lib/modules/2.6.18-348.el5/build M=3D/root/test modules


make[1]: Entering directory `/usr/src/kernels/2.6.18-348.12.1.el5-i686'


  CC [M]  /root/test/sch56xx-common.o
  CC [M]  /root/test/sch5636.o
/root/test/sch5636.c: In function =BBshow_in_value=AB:
/root/test/sch5636.c:189: Fehler: Implizite Deklaration der Funktion
=BBDIV_ROUND_CLOSEST=AB
/root/test/sch5636.c: In function =BBsch5636_remove=AB:
/root/test/sch5636.c:392: Warnung: =DCbergabe des Arguments 1 von
=BBhwmon_device_unregister=AB von inkompatiblem Zeigertyp
/root/test/sch5636.c: In function =BBsch5636_probe=AB:
/root/test/sch5636.c:505: Warnung: Zuweisung von inkompatiblem Zeigertyp
make[2]: *** [/root/test/sch5636.o] Fehler 1
make[1]: *** [_module_/root/test] Fehler 2
make[1]: Leaving directory `/usr/src/kernels/2.6.18-348.12.1.el5-i686'
make: *** [all] Fehler 2


Regards

Holger B=FCrger

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
