From: Howard Chu <hyc@symas.com>
Date: Tue, 23 Sep 2008 20:41:27 +0000
Subject: Re: [lm-sensors] AMD Family 11h thermal sensor
Message-Id: <48D95477.4020609@symas.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <48D95408.2010804@symas.com>
In-Reply-To: <48D95408.2010804@symas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Howard Chu wrote:
> The newer AMD X2 Turion (and other) processors appear to have the same th=
ermal
> monitoring capability as K10, but the PCI device IDs for the Northbridge =
have
> changed. (1022:1303)
>
> I added the new ID to the K10 code posted here
> http://lists.lm-sensors.org/pipermail/lm-sensors/2008-April/022909.html
> and it seems to be working.

By the way, here's the output from my HP dv5z running linux-2.6.27-rc7

root@violino:/usr/src/obj2.6.27/drivers/hwmon# sensors
acpitz-virtual-0
Adapter: Virtual device
temp1:       +59.0=B0C  (crit =3D +105.0=B0C)

k10temp-pci-00c3
Adapter: PCI adapter
temp1:       +59.4=B0C

--=20
   -- Howard Chu
   CTO, Symas Corp.           http://www.symas.com
   Director, Highland Sun     http://highlandsun.com/hyc/
   Chief Architect, OpenLDAP  http://www.openldap.org/project/

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
