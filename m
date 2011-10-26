From: lllars with only one lll <lllars@gmail.com>
Date: Wed, 26 Oct 2011 19:03:41 +0000
Subject: Re: [lm-sensors] support for ite it8518
Message-Id: <CAFCitknR5jnKOiqD9AB46g4qoF0q6sQLkMFaQRexxc3KsiA1xg@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAFCitk=iAdJX_vkWPazqrZ76mH1tfJtSUz0c6C-5fRGRjNAsTQ@mail.gmail.com>
In-Reply-To: <CAFCitk=iAdJX_vkWPazqrZ76mH1tfJtSUz0c6C-5fRGRjNAsTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

ok, i'm a newbie at this, so maybe it would help if i explain my
current understanding and ask some more pointed questions.


here's my understanding which is based solely on studying the
sensors-detect script and the it87 driver.  i have not been able to
find a datasheet for this chip.  i do have a simplified schematic of
my motherboard which suggests the chip is responsible for controlling
the fan.

the it8518 chip is detected on my computer at ports 0x2e & 0x2f.  to
select which register of the chip i'm looking at, i write a byte to
0x2e.  to read or write the value of that register, i use port 0x2f.
by writing a value to register 0x07, i select a logical device.
selecting a different device will change the of some of the registers.
 other registers are always the same: 0x20 =3D 85, 0x21 =3D 18, 0x22 =3D 02,
0x23 =3D 01, and 0x2c =3D 01.  most registers always have zero value
regardless of logical device.  the interesting ones are: 0x30, 0x60,
0x61, 0x62, 0x63, 0x70, 0x71, 0x74, and 0x75.  those registers contain
different values depending on which device is selected.  i can detect
no change in any of the registers for any logical device by putting
the machine under load (which causes an audible increase in fan
noise).


now here are some questions:

1.  would there be any potential harm in writing values to registers
other than 0x07?

2.  is there something else i should be trying that i've missed?

3.  is it likely that my chip has not been programmed to make hardware
monitoring data available?

4.  could there be connections missing on the motherboard that will
make it impossible for me to monitor/control the fan?

5.  can you point me to any resources that would help me learn more
about this problem?


cheers,
lars


On Fri, Oct 21, 2011 at 10:22 PM, lllars with only one lll
<lllars@gmail.com> wrote:
> hello,
>
> i have a fairly new laptop that uses the ITE it8518e chip to control
> the cpu fan. =A0can anyone provide some advice on how to interface with
> this chip?
>
> i've tried probing all of its registers to see if any changes are
> apparent with changes in fan speed, but to no avail. =A0i've also tried
> to manually load the it87 module with the force_id parameter, but am
> not sure what id to use.
>
> kernel: 3.0
> processor: i7 2630QM
> laptop: sager np5160 / clevo w150hnq
>
>
> relevant sensors-detect output:
>
> Do you want to scan for Super I/O sensors? (YES/no):
> Probing for Super-I/O at 0x2e/0x2f
> Trying family `National Semiconductor/ITE'... =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 Yes
> Found unknown chip with ID 0x8518
> Probing for Super-I/O at 0x4e/0x4f
> Trying family `National Semiconductor/ITE'... =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 No
> Trying family `SMSC'... =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0No
> Trying family `VIA/Winbond/Nuvoton/Fintek'... =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 No
> Trying family `ITE'... =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 No
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
