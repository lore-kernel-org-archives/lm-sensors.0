From: Frank Myhr <fmyhr@fhmtech.com>
Date: Thu, 14 Aug 2008 23:59:11 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] hwmon (hwmon-vid): add 6-bit vid codes
Message-Id: <48A4C6CF.7040109@fhmtech.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <48508DAE.8040401@fhmtech.com>
In-Reply-To: <48508DAE.8040401@fhmtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Jean,

Thanks for the heads up. And even more for your patch, which I see has been
tested and accepted. It looks good to me.

I spent a long time looking for K8 specifications (cpuid and vid pins). AMD
doesn't make it easy--a big raspberry to them for not publishing "functional
data sheets" for any their sockets since 939. I think it would be helpful to
include some references to relevant cpu info in hwmon-vid (.c or doc). You
probably have a good reference to so quickly find the 0x2F (extended) model
cutoff for 5-vid-pin K8's.

I finally arrived at the same cutoff value using a variety of references and
combining Tables 2 and 3 below to get:

Table 1. K8 extended model <-> vid pin count

extended model	revision	vid pin count
--------------	-------------	-------------
   <=3D 0x2F	<=3D 90nm Rev E	5
0x30 - 0x3F	exist?		N/A ?
   >=3D 0x40	>=3D 90nm Rev F	6


=3D=3D K8 Sockets =3D
Socket 940 (April 2003):
http://www.amd.com/us-en/assets/content_type/white_papers_and_tech_docs/314=
12.pdf
p. 35
5 VID pins
http://www.cpu-world.com/Sockets/Socket%20940.html


Socket 754 (September 2003):
http://www.amd.com/us-en/assets/content_type/white_papers_and_tech_docs/314=
10.pdf
p. 48
5 VID pins


Socket 939 (June 2004):
http://www.amd.com/us-en/assets/content_type/white_papers_and_tech_docs/314=
11.pdf
p. 39
5 VID pins


Socket AM2 (May 2006):
http://en.wikipedia.org/wiki/Socket_AM2
'"AM2 Processor Functional Data Sheet" (AMD document number 31117) has not =
been
made publicly available.'

6 VID pins shown in this unofficial image
http://www.techimo.com/forum/attachments/processors-memory-overclocking/190=
01d1201825486-pinout-volt-mod-socket-am2-untitled.gif
http://www.techimo.com/forum/processors-memory-overclocking/199420-pinout-v=
olt-mod-socket-am2.html


Socket S1 (May 2006):
http://en.wikipedia.org/wiki/Socket_S1
'"Socket S1g1 Processor Functional Data Sheet" (AMD document number 31731) =
has
not been made publicly available.'


Socket F (August 2006):
http://en.wikipedia.org/wiki/Socket_F
'"Socket F (1207) Processor Functional Data Sheet" (AMD document number 311=
18)
has not been made publicly available.'


Socket AM2+ (September 2007):
http://en.wikipedia.org/wiki/Socket_AM2%2B
'"AM2r2 Processor Functional Data Sheet" (AMD document number 41607) has not
been made publicly available.'


=3D=3D K8 socket <-> revision map =3D
http://products.amd.com/en-us/DesktopCPUResult.aspx?f1=3D&f2=3D&f3=3D&f4=3D=
&f5=3D&f6=E6&f7=90nm+SOI&f8=3D&f9=3D&f10=FAlse&
Desktop:
E3 stepping -> 754, 939
E4 -> 939
E6 -> 754, 939
no F1 stepping cpus shown
F2 -> AM2
F3 -> AM2, F

Opteron:
E6 -> 939, 940
F2 -> AM2, F

Mobile:
only S1 listed, no steppings listed


http://www.cpu-world.com/Sockets/Socket%20754.html
fastest cpus for 754:
AMD Athlon 64 3700+ - ADA3700AEP5AR (ADA3700BOX), 130nm ClawHammer, core CG
AMD Mobile Athlon 64 4000+ - AMN4000BKX5BU, 90nm Newark, core E5
AMD Turion 64 Mobile technology ML-44 - TMDML44BKX5LD, 90nm E5
AMD Sempron 64 3400+ - SDA3400AIO3BX (SDA3400BXBOX), 90nm Palermo E6
AMD Mobile Sempron 3600+ - SMN3600BKX2BX, E6
"K8 Athlon XP-M" models


So we appear to have:

Table 2. K8 revision <-> vid pin count

Revision	socket		vid pin count
--------	-------		-------------
  <=3D E		940, 754, 939		5
  >=3D F		AM2, S1, F, AM2+	6


=3D=3D cpuid <-> K8 revision map =3D
http://www.sandpile.org/ia32/cpuid.htm

cpuid_eax(1)
bits		data			notes
-----		---------------		------------------------------
27:20		extended family
19:16		extended model		see Table 3 below
13:12		cpu type=09
11:8		family			always 0x0F for K8
7:4		model		=09
3:0		stepping		cpu-specific


Table 3. K8 extended model <-> revision

extended
model		revision
--------	--------
0000		130nm Rev C
0001		90nm Rev D
0010		90nm Rev E
0100		90nm Rev F
0101		90nm Rev F
0110		65nm Rev G
0111		65nm Rev G


excerpt from
drivers/hwmon/hwmon-vid.c
vid_which_vrm()
	u32 eax =3D cpuid_eax(1);
	if (eff_family =3D 0xF) {	/* use extended model & family */
		eff_model +=3D ((eax & 0x000F0000)>>16)<<4;
	}

Thus for K8 where eff_family =3D 0x0F always, the upper 4 bits of eff_model
determine the K8 revision as per Table 3.


=3D=3D K8 vid codes =3D
AMD 26094
Table 74, p. 283
http://www.amd.com/us-en/assets/content_type/white_papers_and_tech_docs/260=
94.PDF
shows 5-bit vid codes; this seems to apply to sockets <=3D 939, revisions <=
=3D E

AMD 32559
Table 71, p. 309
http://www.amd.com/us-en/assets/content_type/white_papers_and_tech_docs/325=
59.pdf
shows 6-bit vid codes; this seems to apply to sockets >=3D AM2, revisions >=
=3D F
5-bit codes remain the same as in 26094


---

The above can/should probably be edited and split up, but at least some of =
the
references might be useful to others.


Thanks again Jean for fixing the bug so quickly.

-Frank

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
