From: Soeren Sonnenburg <kernel@nn7.de>
Date: Thu, 21 Jun 2007 21:55:16 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon/coretemp: Fix a broken error path -
Message-Id: <1182462916.5118.3.camel@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <1182026585.4230.8.camel@localhost>
	 <20070616231745.1b0f7bd9@hyperion.delvare>
	 <1182071803.4815.5.camel@localhost>  <467575BF.1090207@assembler.cz>
	 <1182335403.21563.99.camel@localhost>  <467AE640.9090409@assembler.cz>
In-Reply-To: <467AE640.9090409@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Rudolf Marek <r.marek@assembler.cz>
Cc: lkml <linux-kernel@vger.kernel.org>, LM Sensors <lm-sensors@lm-sensors.org>

On Thu, 2007-06-21 at 22:57 +0200, Rudolf Marek wrote:
> Hello Soeren,
>=20
> Sorry for the delay.
>=20
> I'm ccing all lists maybe some other people are interested. There is know=
n=20
> errata AE18 which prevents coretemp from working correctly on some mobile=
 Core=20
> processors (family 6 model e). My driver refuses to load and now thanks t=
o=20
> soeren will not crash ;) However what to do when no microcode update (no =
new=20
> BIOS) is available?
>=20
> Soeren pointed at some T60, T60p BIOS update and luckily, there is a easy=
 way=20
> how to extract the microcode update and even convert it into the .txt for=
mat as=20
> microcode update utility (http://www.urbanmyth.org/microcode/) expects.
> Attached scripts generates the mcode.txt file which may be used by the up=
date=20
> utility. Please can you give a try?

great! it works:

sensors excerpt :

coretemp-isa-0000
Adapter: ISA adapter
temp1:       +62=B0C  (high =3D  +100=B0C)                    =20

coretemp-isa-0001
Adapter: ISA adapter
temp1:       +64=B0C  (high =3D  +100=B0C)

> It seems that there is microcode update for CPUID 06E8 version 0x39 just =
as my=20
> driver is checking. So if your CPUID is 06e8 too you should get the coret=
emp=20
> driver working.

how do I find that out ? I mean sensors seem to work but how do I know
which CPUID+version I have ?

> If so I will post a patch and document the script in documentation direct=
ory (or=20
> at least some general instructions how to do that)
>=20
> Please tell me your stepping:
> cat /proc/cpuinfo  | grep stepping

$ cat /proc/cpuinfo  | grep stepping
stepping        : 8
stepping        : 8

Thank you *very* much!
Soeren
--=20
Sometimes, there's a moment as you're waking, when you become aware of
the real world around you, but you're still dreaming.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
