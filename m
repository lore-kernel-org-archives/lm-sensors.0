From: Andrew Lutomirski <luto@mit.edu>
Date: Sat, 12 Feb 2011 13:53:51 +0000
Subject: Re: [lm-sensors] [PATCH v3 7/7] hwmon: (w83627ehf) Use 16 bit fan
Message-Id: <AANLkTi=rhyUT+i4n3S9SGBZ_zy82aEzJkkVr9qQJr7DS@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1297444832-10874-8-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1297444832-10874-8-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Sat, Feb 12, 2011 at 12:08 AM, Guenter Roeck
<guenter.roeck@ericsson.com> wrote:
>>
>> [13561.120768] w83627ehf: Found NCT6775F chip at 0x290
>> [13561.121084] Reg 0028 =3D 45
>> [13561.121097] Reg 0029 =3D 4c
>> [13561.121108] Reg 002a =3D 00
>> [13561.121119] Reg 003f =3D 00
>> [13561.121147] Reg 0630 =3D 0045
>> [13561.121166] Reg 0631 =3D 4500
>> [13561.121186] Reg 0632 =3D 004c
>> [13561.121205] Reg 0633 =3D 4c00
>> [13561.121225] Reg 0634 =3D 0000
>> [13561.121244] Reg 0635 =3D 0000
>> [13561.121263] Reg 0636 =3D 0000
>> [13561.121283] Reg 0637 =3D 0000
>>
>> >
>> > According to the datasheet, register 0x28 and 0x631 should match, 0x29=
 should
>> > match 0x633, 0x2a should match 0x635, and 0x3f should match 0x637.
>>
>> Doesn't look like it. =A0You might be off by one, or maybe there's an
>> endianness issue.
>>
> No, it is ok, since the registers are detected as 16 bit registers. Readi=
ng from 0x630
> really reads from 0x630 and 0x631, and the result is as expected (ie the =
read from 0x630
> returns the same as the read from 0x28, and both is 0x45).
>
> But then this should translate to a fan1 value of (1350000 / (0x45 * divi=
sor)),
> ie be reported as a value somewhere between 19565 if the divisor is 1 to
> 153 if the divisor is 128. I must be missing something.
>
> Odd is that if I simulate fan speed reading, ie just assign 0x45 to fan[i=
] when
> reading the fan speeds, I do get the expected speeds for the various divi=
sor values.
> So I don't really understand what is going on in your system.
>
> Can you possibly dump the raw values of nr, data->fan[nr], data->fan_div[=
nr], and
> data->fan_from_reg(data->fan[nr], data->fan_div[nr]) in show_fan() ?

With fan2_div =3D 32 (b/c fan2_min =3D 502), I get:

[48429.734521] w83627ehf: Found NCT6775F chip at 0x290
[48429.734818] Reg 0028 =3D 47
[48429.734832] Reg 0029 =3D 00
[48429.734843] Reg 002a =3D 00
[48429.734855] Reg 003f =3D 00
[48429.734884] Reg 0630 =3D 0047
[48429.734905] Reg 0631 =3D 4700
[48429.734925] Reg 0632 =3D 0000
[48429.734945] Reg 0633 =3D 0000
[48429.734965] Reg 0634 =3D 0000
[48429.734986] Reg 0635 =3D 0000
[48429.735006] Reg 0636 =3D 0000
[48429.735026] Reg 0637 =3D 0000
[48437.765900] nr=3D1, fan=3D0, fan_div=3D4, fan_from_reg=3D0  <<< reading =
fan2_input

With fan2_min =3D 100 (i.e. fan2_div =3D 128) I get:

[48525.613069] w83627ehf: Found NCT6775F chip at 0x290
[48525.613686] Reg 0028 =3D 47
[48525.613698] Reg 0029 =3D 4c
[48525.613708] Reg 002a =3D 00
[48525.613719] Reg 003f =3D 00
[48525.613754] Reg 0630 =3D 0047
[48525.613772] Reg 0631 =3D 4700
[48525.613796] Reg 0632 =3D 004c
[48525.613813] Reg 0633 =3D 4c00
[48525.613829] Reg 0634 =3D 0000
[48525.613846] Reg 0635 =3D 0000
[48525.613863] Reg 0636 =3D 0000
[48525.613880] Reg 0637 =3D 0000
[48533.156472] nr=3D1, fanw, fan_div=3D7, fan_from_reg=136

Maybe those 8 high bits just don't work?  Is there some flag to set to
put the chip in 16-bit mode?

--Andy

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
