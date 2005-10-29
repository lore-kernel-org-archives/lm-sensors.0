From: j.w.r.degoede@hhs.nl (Hans de Goede)
Date: Sat, 29 Oct 2005 12:04:12 +0000
Subject: [lm-sensors] New Abit uGuru driver + libsensors patch, review
Message-Id: <43634A60.6090405@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <4358B291.6070702@hhs.nl>
In-Reply-To: <4358B291.6070702@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org



Rudolf Marek wrote:
> Hello Hans,
>=20
>=20
>>>But certainly, having a kernel driver output 0-255 for a voltage input is
>>>a huge and unacceptable step backwards.  Please fix that first and then
>>>we can talk about the rest.
>=20
> I agree completely.
>=20
> But I have a proposal to solution.
>=20
> All we just need to know is the how many volts are used for one bit.
> http://www.winbond.com/e-winbondhtm/partner/PDFresult.asp?Pname=926
>=20
> Some suggestions are here around page 64.
>=20
> And some information are here:
>=20
> + label in0 "CPUcore"
> +   compute in0 @*0.0137 , @/0.0137
> +   label in1 "DDRVdd"
> +   compute in1 @*0.0137 , @/0.0137
> +   label in7 "Vdd5V"
> +   compute in7 @*0.0245 , @/0.0245
>=20
> VCore is often unscaled so this *0.0137 gives for 8bit =3D>  3.4935Vref s=
o 3.5V
>=20
> Rest is simple: just compute the correct divisors for each in0
> 0.0245/0.0137 is round 2 so 5V might be scaled by 2. I dont know how thos=
e values were obtained so I cant do more speculations.
>=20
> Best would be if could measure actual voltage on pin P3REF so pin50 of th=
e chip. Also there is another Vref at pin 72 the datasheet
> is unclear what pin is used when. If you are measuring please measure act=
ual chip VCC too. (This should be 5V)
>=20
> How to measure:
>=20
> Multimeter 0-5V DC
> one wire to selected pin, second wire try the black wire of 4 hole power =
connector. Try not to shortcut the pins around.
> You can take a needle and glue it with the tape to multimeter probe.
>=20

For the record, I'm a teacher in electrical engineering and computer=20
science at a Dutch university.

At first I had the same tought process as you and I too thought that the=20
uGuru is most likely hooked up to a 3.5v voltage reference. But there=20
are a number of reasons why I'm not so sure:

The W83L950D has only 8 analog inputs, but the uGuru has 16. So somehow=20
Abit is doing some trickery to get more analog inputs, they could be=20
using the 8 comparator inputs, with one of the DA outputs hooked up to=20
the comparator reference pin, and using SAR to build another 8 AD inputs
out of this.

BTW pin P3REF is the comparator reference not the AD/DA reference. the=20
VREF pin (72) is the AD/DA reference. Also P3REF is pin 58, not 50.

They could however also be using one or more external sensor IC's hooked=20
up to one of the 2 i2c/smbus controllers which are onboard the W83L950D.=20
In this case the reference voltage hooked up to the W83L950D is=20
irrelevant (or atleast irrelevant for some of the inputs).

Also if I we're to design the sensor part of a mainboard I would want to=20
have a cheap reference voltage with a low temperature drift, thus I=20
would use an of the shelf component. These however do not come in a 3.5=20
volt variant, atleast not from the worldst 2 biggest reference voltage=20
IC suppliers, see:
http://para.maxim-ic.com/compare.asp?Fam=3DVolt_Ref&Tree=3DReferences&HP=3D=
References.cfm&lnhttp://www.analog.com/en/subCat/0,2879,769%255F838%255F0%2=
55F%255F0%255F,00.html

So a reference voltage of 3.5 volt is not likely, assuming that Abit=20
doesn't want to build a descrete reference voltage source themselves, or=20
use an expensive programmable one. Also note that a simple zenerdiode=20
setup will not suffice since its temperature drift is to high, (at least=20
higher then what I've seen with my mb sofar).

Also you assume that the other mutipliers used are based on round=20
dividers of the input voltage, but if that where the case then the=20
0-6.25 volt would be 0-7 volt which is a rather big error.

Last, the uGuru is a microcontroller and could do some scaling itself. I=20
know this is the case for temperature sensors, since the register value=20
equals the temperature in degrees celcius here, so most likely the uGuru=20
has already done conversion here.

So in short, we don't even now which inputs if any are used, and we=20
don't know what kindoff conversions if any are already done by the=20
uGuru. And since I'm not planning on reverse engineering the layout of a=20
6 layer print we will probably never know.

The current uGuru driver is based on software reverse-engineering, not=20
hardware reverse-engineering. One of the reasons for this is that the=20
hardware used is programmable, so we will probably never know what is=20
going on inside. Another reason is that its a lot easier and safer.

I can however modify the driver to always scale all analog inputs to=20
0-3.5 volts and modify sensors.conf accordingly if that makes you happier.

Regards,

Hans
