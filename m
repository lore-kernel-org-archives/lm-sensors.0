From: "Michael S. Zick" <lkml@morethan.org>
Date: Fri, 12 Jun 2009 17:38:19 +0000
Subject: Re: [lm-sensors]
Message-Id: <200906121238.21568.lkml@morethan.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090612_152510_043383.tomaz.mertelj@guest.arnes.si> <200906121031.05738.lkml@morethan.org> <200906121104.26174.lkml@morethan.org>
In-Reply-To: <200906121104.26174.lkml@morethan.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: tomaz.mertelj@guest.arnes.si
Cc: Harald Welte <HaraldWelte@viatech.com>, Jean Delvare <khali@linux-fr.org>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

On Fri June 12 2009, Michael S. Zick wrote:
>
> The tool does not report read failures.
> **BUT** if you remember to "modprobe msr" or have it built in...
> Translation: Cockpit error.  ;)
>=20
> root@cb01:~# for r in 0x1160 0x1161 0x1162 0x1163 0x1164 0x1165 0x1166 0x=
1167 0x1168 0x1169 0x116a 0x116b 0x116c 0x1152 0x1153 ; do ./rdmsrll  $r ; =
done
> MSR register 0x1160 =3D> 00:00:00:00:00:00:05:dc
> MSR register 0x1161 =3D> 00:00:00:00:00:00:03:e8
> MSR register 0x1162 =3D> 00:00:00:00:00:00:00:00
> MSR register 0x1163 =3D> 00:00:00:00:00:00:00:00
> MSR register 0x1164 =3D> 00:00:00:00:00:00:00:5f
> MSR register 0x1165 =3D> 00:00:00:00:00:00:00:64
> MSR register 0x1166 =3D> 00:00:00:00:00:00:00:7d
> MSR register 0x1167 =3D> 00:00:00:00:00:00:00:00
> MSR register 0x1168 =3D> 00:00:00:00:00:00:01:8d
> MSR register 0x1169 =3D> 00:00:00:00:00:00:00:32
> MSR register 0x116a =3D> 00:00:00:00:00:00:00:03
> MSR register 0x116b =3D> 00:00:00:00:00:00:01:a6
> MSR register 0x116c =3D> 00:00:00:00:00:00:03:34
> MSR register 0x1152 =3D> e7:2c:b3:9f:fb:ff:ff:ff
> MSR register 0x1153 =3D> 04:06:0c:09:fe:ff:ff:ff
>=20
> Which is the same data as reported by msr-tools.
>

And the output of sensors with H.W. driver built-in:

root@cb01:~# sensors
acpitz-virtual-0
Adapter: Virtual device
temp1:       +48.8=B0C  (crit =3D +94.8=B0C)

via-cputemp-isa-0000
Adapter: ISA adapter
Core 0:      +50.0=B0C

Which looks reasonable to me, on this machine.

Mike=20
> Mike=20


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
