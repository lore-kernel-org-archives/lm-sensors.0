From: "Andrew Voznytsa" <andrew.voznytsa@gmail.com>
Date: Sat, 19 Jan 2008 15:12:57 +0000
Subject: Re: [lm-sensors] SMSC Super I/O: unknown chip with ID 0x8902
Message-Id: <003b01c85aad$c70d9fa0$0204a8c0@IT>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="----=_NextPart_000_003C_01C85ABE.8A966FA0"
List-Id: <lm-sensors.vger.kernel.org>
References: <004e01c856bc$6f975c10$0204a8c0@IT>
In-Reply-To: <004e01c856bc$6f975c10$0204a8c0@IT>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_003C_01C85ABE.8A966FA0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Jean, Juerg,

> On Fri, 18 Jan 2008 16:08:00 +0100, Juerg Haefliger wrote:
> > Again, I'll take a look at the datasheets and if the chips are indeed
> > compatible, I'll fix the dme1737 driver to support the sch5027. I
> > don't have access to a test machine until next week, so it has to wait
> > until then.
> 
> You may be interested in the following recipe then:
> 
> * Have Andrew send you a dump of his chip:
>   i2cdump 0 0x2e b > sch5027.dump

Dump attached.

Best regards,
Andrew Voznytsa

------=_NextPart_000_003C_01C85ABE.8A966FA0
Content-Type: application/octet-stream;
	name="sch5027.dump"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="sch5027.dump"

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef=0A=
00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................=0A=
10: 00 00 00 00 00 00 00 00 00 00 00 00 02 00 00 00    ............?...=0A=
20: b0 61 c3 3a cd c5 24 1e 7c 18 ff ff ff ff ff ff    ?a?:??$?|?......=0A=
30: b2 ae 3f 30 00 00 00 10 00 00 00 00 00 00 5c 69    ???0...?......\i=0A=
40: 25 80 38 00 00 ff 00 ff 00 ff 00 ff 00 ff 81 7f    %?8...........??=0A=
50: 81 7f 81 7f 4c 1d 4c 1d 4c 1d 4c 1d 42 22 02 7a    ????L?L?L?L?B"?z=0A=
60: 7a 7a e8 88 b2 a5 3f e4 23 3c 00 3c 50 44 40 00    zz??????#<.<PD@.=0A=
70: b2 ae 3f 00 00 00 00 00 00 00 00 00 00 00 ec 1c    ???...........??=0A=
80: 7e a4 0e 80 00 40 e6 aa e4 00 33 33 24 24 19 19    ~???.@???.33$$??=0A=
90: 04 04 04 04 0c 0c 0c 5a f1 bf b5 00 ff 00 ff 00    ???????Z???.....=0A=
a0: 00 00 0c 00 00 ff ff 0b 0b 1d 00 00 00 0c 00 0c    ..?....???...?.?=0A=
b0: 00 00 00 00 00 00 08 08 0e 0e 0f 0f 00 00 00 00    ......??????....=0A=
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................=0A=
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................=0A=
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................=0A=
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................=0A=

------=_NextPart_000_003C_01C85ABE.8A966FA0
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
------=_NextPart_000_003C_01C85ABE.8A966FA0--

