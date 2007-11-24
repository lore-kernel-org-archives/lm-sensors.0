From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Date: Sat, 24 Nov 2007 20:22:32 +0000
Subject: [lm-sensors] (solved) Re: Linux 2.6.24-rc* regression: sensors says
Message-Id: <47488808.2000104@s5r6.in-berlin.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <4748606D.6050501@s5r6.in-berlin.de> <474861FB.1080104@s5r6.in-berlin.de>
In-Reply-To: <474861FB.1080104@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@lm-sensors.org
Cc: linux-kernel@vger.kernel.org

> Stefan Richter wrote:
>> I just booted 2.6.24-rc3 on two different PCs, one with i945 based MSI
>> motherboard and i386 kernel and one with i945 based Apple motherboard
>> and x86-64 kernel.  Before that I ran linux 2.6.23.
>>
>> On both PCs, "sensors" exits with
>>> No sensors found!
>=20
> now logged at http://bugzilla.kernel.org/show_bug.cgi?id=9451

Updating sysfsutils from version 1.3.0 to 2.1.0 cured this on both PCs.
Thanks to Jean for pointing me to sysfsutils.
--=20
Stefan Richter
-=3D=3D=3D-=3D-=3D=3D =3D-=3D =3D---
http://arcgraph.de/sr/

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
