From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 15 Aug 2008 07:48:07 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] hwmon (hwmon-vid): add 6-bit vid codes
Message-Id: <20080815094807.09c6ed3e@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <48508DAE.8040401@fhmtech.com>
In-Reply-To: <48508DAE.8040401@fhmtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Frank,

On Thu, 14 Aug 2008 19:59:11 -0400, Frank Myhr wrote:
> Hi Jean,
>=20
> Thanks for the heads up. And even more for your patch, which I see has be=
en
> tested and accepted. It looks good to me.
>=20
> I spent a long time looking for K8 specifications (cpuid and vid pins). A=
MD
> doesn't make it easy--a big raspberry to them for not publishing "functio=
nal
> data sheets" for any their sockets since 939. I think it would be helpful=
 to
> include some references to relevant cpu info in hwmon-vid (.c or doc). You
> probably have a good reference to so quickly find the 0x2F (extended) mod=
el
> cutoff for 5-vid-pin K8's.

I received the kind help of Jordan Crouse, who was able to tell me
that the split was happening with revision F CPUs. Thanks Jordan! From
there, I "simply" looked at the following 2 documents:

Revision Guide for AMD NPT Family 0Fh Processors
http://www.amd.com/us-en/assets/content_type/white_papers_and_tech_docs/336=
10.pdf

Revision Guide for AMD Athlon=E2=84=A2 64 and AMD Opteron=E2=84=A2 Processo=
rs
http://www.amd.com/us-en/assets/content_type/white_papers_and_tech_docs/257=
59.pdf

They give the CPUID values and the revision letters for all K8 CPUs. I
came to the conclusion that extended model 0x2 or 0x3 would be the
right cutoff point. Not too sure which one to chose, as there are no
CPU listed with extended model =3D 0x3, as you found out yourself. So
I've chosen 0x2 as the cutoff point... But maybe 0x3 would be a better
choice, if AMD is ever going to produce a last iteration for the old
sockets.

I've mentioned these 2 reference documents in hwmon-vid.c.

> I finally arrived at the same cutoff value using a variety of references =
and
> combining Tables 2 and 3 below to get:
>=20
> Table 1. K8 extended model <-> vid pin count
>=20
> extended model	revision	vid pin count
> --------------	-------------	-------------
>    <=3D 0x2F	<=3D 90nm Rev E	5
> 0x30 - 0x3F	exist?		N/A ?
>    >=3D 0x40	>=3D 90nm Rev F	6
>=20
>=20
> =3D=3D K8 Sockets =3D>=20
> Socket 940 (April 2003):
> http://www.amd.com/us-en/assets/content_type/white_papers_and_tech_docs/3=
1412.pdf
> p. 35
> 5 VID pins
> http://www.cpu-world.com/Sockets/Socket%20940.html
>=20
>=20
> Socket 754 (September 2003):
> http://www.amd.com/us-en/assets/content_type/white_papers_and_tech_docs/3=
1410.pdf
> p. 48
> 5 VID pins
>=20
>=20
> Socket 939 (June 2004):
> http://www.amd.com/us-en/assets/content_type/white_papers_and_tech_docs/3=
1411.pdf
> p. 39
> 5 VID pins


I've read these 3 ones as well, to find out that these sockets didn't
have a 6th VID pin.

> Socket AM2 (May 2006):
> http://en.wikipedia.org/wiki/Socket_AM2
> '"AM2 Processor Functional Data Sheet" (AMD document number 31117) has no=
t been
> made publicly available.'
>=20
> 6 VID pins shown in this unofficial image
> http://www.techimo.com/forum/attachments/processors-memory-overclocking/1=
9001d1201825486-pinout-volt-mod-socket-am2-untitled.gif
> http://www.techimo.com/forum/processors-memory-overclocking/199420-pinout=
-volt-mod-socket-am2.html
>=20
>=20
> Socket S1 (May 2006):
> http://en.wikipedia.org/wiki/Socket_S1
> '"Socket S1g1 Processor Functional Data Sheet" (AMD document number 31731=
) has
> not been made publicly available.'
>=20
>=20
> Socket F (August 2006):
> http://en.wikipedia.org/wiki/Socket_F
> '"Socket F (1207) Processor Functional Data Sheet" (AMD document number 3=
1118)
> has not been made publicly available.'
>=20
>=20
> Socket AM2+ (September 2007):
> http://en.wikipedia.org/wiki/Socket_AM2%2B
> '"AM2r2 Processor Functional Data Sheet" (AMD document number 41607) has =
not
> been made publicly available.'
>=20
>=20
> =3D=3D K8 socket <-> revision map =3D>=20
> http://products.amd.com/en-us/DesktopCPUResult.aspx?f1=3D&f2=3D&f3=3D&f4=
=3D&f5=3D&f6=E6&f7=90nm+SOI&f8=3D&f9=3D&f10=FAlse&
> Desktop:
> E3 stepping -> 754, 939
> E4 -> 939
> E6 -> 754, 939
> no F1 stepping cpus shown
> F2 -> AM2
> F3 -> AM2, F
>=20
> Opteron:
> E6 -> 939, 940
> F2 -> AM2, F
>=20
> Mobile:
> only S1 listed, no steppings listed
>=20
>=20
> http://www.cpu-world.com/Sockets/Socket%20754.html
> fastest cpus for 754:
> AMD Athlon 64 3700+ - ADA3700AEP5AR (ADA3700BOX), 130nm ClawHammer, core =
CG
> AMD Mobile Athlon 64 4000+ - AMN4000BKX5BU, 90nm Newark, core E5
> AMD Turion 64 Mobile technology ML-44 - TMDML44BKX5LD, 90nm E5
> AMD Sempron 64 3400+ - SDA3400AIO3BX (SDA3400BXBOX), 90nm Palermo E6
> AMD Mobile Sempron 3600+ - SMN3600BKX2BX, E6
> "K8 Athlon XP-M" models
>=20
>=20
> So we appear to have:
>=20
> Table 2. K8 revision <-> vid pin count
>=20
> Revision	socket		vid pin count
> --------	-------		-------------
>   <=3D E		940, 754, 939		5
>   >=3D F		AM2, S1, F, AM2+	6
>=20
>=20
> =3D=3D cpuid <-> K8 revision map =3D>=20
> http://www.sandpile.org/ia32/cpuid.htm
>=20
> cpuid_eax(1)
> bits		data			notes
> -----		---------------		------------------------------
> 27:20		extended family
> 19:16		extended model		see Table 3 below
> 13:12		cpu type=09
> 11:8		family			always 0x0F for K8
> 7:4		model		=09
> 3:0		stepping		cpu-specific
>=20
>=20
> Table 3. K8 extended model <-> revision
>=20
> extended
> model		revision
> --------	--------
> 0000		130nm Rev C
> 0001		90nm Rev D
> 0010		90nm Rev E
> 0100		90nm Rev F
> 0101		90nm Rev F
> 0110		65nm Rev G
> 0111		65nm Rev G
>=20
>=20
> excerpt from
> drivers/hwmon/hwmon-vid.c
> vid_which_vrm()
> 	u32 eax =3D cpuid_eax(1);
> 	if (eff_family =3D 0xF) {	/* use extended model & family */
> 		eff_model +=3D ((eax & 0x000F0000)>>16)<<4;
> 	}
>=20
> Thus for K8 where eff_family =3D 0x0F always, the upper 4 bits of eff_mod=
el
> determine the K8 revision as per Table 3.
>=20
>=20
> =3D=3D K8 vid codes =3D>=20
> AMD 26094
> Table 74, p. 283
> http://www.amd.com/us-en/assets/content_type/white_papers_and_tech_docs/2=
6094.PDF
> shows 5-bit vid codes; this seems to apply to sockets <=3D 939, revisions=
 <=3D E

Ah, that's a good one, thanks. I've added a reference to it in
hwmon-vid.c.

>=20
> AMD 32559
> Table 71, p. 309
> http://www.amd.com/us-en/assets/content_type/white_papers_and_tech_docs/3=
2559.pdf
> shows 6-bit vid codes; this seems to apply to sockets >=3D AM2, revisions=
 >=3D F
> 5-bit codes remain the same as in 26094
>=20
>=20
> ---
>=20
> The above can/should probably be edited and split up, but at least some o=
f the
> references might be useful to others.

I'll post an updated patch in a moment, please confirm you're OK with
it.

> Thanks again Jean for fixing the bug so quickly.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
