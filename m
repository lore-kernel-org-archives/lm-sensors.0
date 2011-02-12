From: Andrew Lutomirski <luto@mit.edu>
Date: Sat, 12 Feb 2011 04:08:54 +0000
Subject: Re: [lm-sensors] [PATCH v3 7/7] hwmon: (w83627ehf) Use 16 bit fan
Message-Id: <AANLkTime3ccuejPiQu_v8o4inHs-Zt2CDycBvgS4_3=H@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1297444832-10874-8-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1297444832-10874-8-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Fri, Feb 11, 2011 at 10:45 PM, Guenter Roeck
<guenter.roeck@ericsson.com> wrote:
> On Fri, Feb 11, 2011 at 10:09:23PM -0500, Andrew Lutomirski wrote:
>> On Fri, Feb 11, 2011 at 12:20 PM, Guenter Roeck
>> <guenter.roeck@ericsson.com> wrote:
>> > Some of the chips supported by this driver have 13 bit or 16 bit fan c=
ount
>> > registers. This patch improves support for those registers, specifical=
ly for
>> > NCT6775F. With the changes in this patch, fan speed is reported correc=
tly even
>> > if the fan divider is set to a low value, which results in a fan speed=
 reading
>> > above 0xff.
>>
>> I'm not convinced this works. =A0I have an NCT6775F (or at least the
>> driver says I do) and, with fan2_min =3D 0 or 100, I get fan2_div =3D 12=
8.
>> =A0If I set fan2_min=1000, I get fan2_div =3D 8 but fan2_input reads 0.
>> Presumably a low divider should have worked if I really had 16 bits to
>> play with.
>>
> Yes, you are right. Can you dump the raw contents of the registers at 0x2=
8..0x2a
> as well as 0x630..0x637 ?

[13561.120768] w83627ehf: Found NCT6775F chip at 0x290
[13561.121084] Reg 0028 =3D 45
[13561.121097] Reg 0029 =3D 4c
[13561.121108] Reg 002a =3D 00
[13561.121119] Reg 003f =3D 00
[13561.121147] Reg 0630 =3D 0045
[13561.121166] Reg 0631 =3D 4500
[13561.121186] Reg 0632 =3D 004c
[13561.121205] Reg 0633 =3D 4c00
[13561.121225] Reg 0634 =3D 0000
[13561.121244] Reg 0635 =3D 0000
[13561.121263] Reg 0636 =3D 0000
[13561.121283] Reg 0637 =3D 0000

>
> According to the datasheet, register 0x28 and 0x631 should match, 0x29 sh=
ould
> match 0x633, 0x2a should match 0x635, and 0x3f should match 0x637.

Doesn't look like it.  You might be off by one, or maybe there's an
endianness issue.

FWIW, here's the code I used:

	int regs_to_dump[] =3D {0x28, 0x29, 0x2a, 0x3f, 0x630, 0x631,
			      0x632, 0x633, 0x634, 0x635, 0x636, 0x637};
	for (i =3D 0; i < sizeof(regs_to_dump) / sizeof(regs_to_dump[0]); i++)
	{
		unsigned int val;
		val =3D w83627ehf_read_value(data, regs_to_dump[i]);
		if (is_word_sized(regs_to_dump[i])) {
			printk(KERN_ERR "Reg %04x =3D %04x\n",
			       regs_to_dump[i], val);
		} else {
			printk(KERN_ERR "Reg %04x =3D %02x\n",
			       regs_to_dump[i], val);
		}
	}

--Andy

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
