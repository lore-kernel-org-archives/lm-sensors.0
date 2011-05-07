From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 07 May 2011 15:53:08 +0000
Subject: Re: [lm-sensors] Gigabyte MA785GM-US2H motherboard configuration
Message-Id: <20110507175308.5fec25ef@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <BANLkTimA9Uj9DbC+cG8hrpDXZL+6jTGW9w@mail.gmail.com>
In-Reply-To: <BANLkTimA9Uj9DbC+cG8hrpDXZL+6jTGW9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi David,

On Fri, 6 May 2011 20:32:51 +0200, David Santamar=EDa Rogado wrote:
> Yes that's is the config, but I could, or I think so, confirm that 12V
> has exactly x4 multiplier, despite a very little more voltage than the
> bios is shown.

That would be good news, I could never understand the logic behind the
3.963 or 3.984 scaling factors other Gigabyte boards were using. I have
always attributed them to software bugs. OTOH the offset you mention
below makes no physical sense either, so it would be a software trick
from Gigabyte again. Oh well.

BTW, Did you validate your findings with a digital voltmeter? Even if it's
not accurate, it can be useful to ensure that +12V has the same value
when in the BIOS setup and later on Linux (to make sure you are
comparing scaled and unscaled numbers for the same physical value.)

> Just some comments before, the fan1 speed is setup for my case, with
> the minimum pwm it doesn't go slower. The other fans are like the UD2H
> on internet and should be the same here. Also I made "compute  in4  @
> * 4,            @ / 4", but I one config I can't remember I saw the
> (30/10)+1 as multiplier and then I used the same formula, doesn't know
> if could be issues bi putting only one number. This file should work

Both are OK and strictly equivalent. The (30/10)+1 form is to reflect
the physical reality of scaling (a bridge made of a 30 kOhm resistor
and a 10 kOhm resistor.

> with MA785GMT-UD2H like the other config on internet but I think also
> could work with MA785GPM-UD2H as it has a very very similar PCB. In
> the config file there are more comments, perhaps you could clean up a
> little. Here we go:
>=20
> # lm_sensors 3 configuration file for the Gigabyte MA785GMT-US2H motherbo=
ard
> # 2011-04-17, David Santamar=EDa Rogado <howl.nsp@gmail.com>
> # Written for board revision 1.0, may or may not be suitable for other
> # revisions.
> # Comments welcome!
>=20
> chip "it8718-*"
>=20
> ### Voltages
>=20
>   # in7 is mysterious, it lives in the range 2.19 to 2.94 V, change with
>   # CPU frequency (if you take the highest clock speed of all the cores
>   # you can guess it's value). No idea what it can be.
>=20
>   label  in0  "Vcore"
>   label  in1  "Vram"    # "DDR2" in BIOS

How could the BIOS really say DDR2 when this board uses DDR3 memory
modules? At least this is what
  http://www.gigabyte.com/products/product-page.aspx?pid250#sp
claims.

>   label  in2  "+3.3V"
>   label  in3  "+5V"     # Not in BIOS
>   label  in4  "+12V"
>   ignore in5            # Always fixed at 4.08 V
>   ignore in6            # Always fixed at 4.02 V
>   ignore in7            # Commented above
>   label  in8  "Vbat"    # Not in BIOS
>=20
>   # Vcore, Vram, +3.3V and Vbat are connected directly, so no compute
>   # line is needed for these. For +5V the chip is configured to use
>   # internal scaling. Scaling for +12V is apparently not standard, my
>   # guess is that the BIOS uses 4 as the scaling factor. Not sure

Actually 4 is very standard for +12V scaling.

>   # if it matches the physical reality. BIOS values varies between
>   # 12.048 and 12.112 V, lm-sensors in4 between 3.040 and 3.056 V, is
>   # exactly a x4 scale +0.112 offset.
>=20
>   compute  in3  @ * (6.8/10+1),   @ / (6.8/10+1)
>   compute  in4  @ * ((30/10)+1),  @ / ((30/10)+1)

If there's really a +0.112 V offset (which again makes no physical
sense, but...) and you want the same values as in the BIOS, you can do:

   compute  in4  @ * ((30/10)+1) + 0.112,  (@ - 0.112) / ((30/10)+1)

But again you should verify with a digital voltmeter if you have the
same voltage levels in BIOS and Linux. Also, if you could get a 3rd
value for +12V in the BIOS, it would help validate your formula.

>=20
>   # The BIOS won't set any limit for voltages.
>   # You should set Vcore and Vram to match you setup, mine is:
>   # - CPU: AMD Athlon II X2 250 (VCore 0.85-1.425)
>   # - Mem: KHX8500D2/2G (Vram 1.8-2)
>=20
>   set in0_min  0.85  * 0.95
>   set in0_max  1.425 * 1.05
>   set in1_min  1.8   * 0.95
>   set in1_max  2     * 1.05

These are voltage limits for DDR2... There's something fishy here.

Ah, I think I get it. There are two board series, the MA785GM uses DDR2
and the MA785GMT uses DDR3. So if you have DDR2 your board is really a
GM, not GMT version. You got it wrong in the header.

>   set in2_min  3.3   * 0.95
>   set in2_max  3.3   * 1.05
>   set in3_min  5     * 0.95
>   set in3_max  5     * 1.05
>   set in4_min  12    * 0.95
>   set in4_max  12    * 1.05
>=20
> ### Temperatures
>=20
>   # The BIOS only shows 2 temperature values, corresponding to Sys and CP=
U,
>   # temp3 is usually similar to Sys temp but under heavy load it raises m=
ore.
>=20
>   label  temp1  "Sys Temp"
>   label  temp2  "CPU Temp"
>   label  temp3  "NBr Temp"    # Guessed
>=20
>   set temp1_min  10
>   set temp1_max  50
>   set temp2_min  10
>   set temp2_max  60
>   set temp3_min  10
>   set temp3_max  50
>=20
> ### Fans
>=20
>   # I only have CPU fan, the other ones have to be tested.
>=20
>   label  fan1  "CPU Fan"
>   label  fan2  "Case Fan"
>   ignore fan3
>   label  fan4  "NBr Fan"
>=20
>   # Adjust for your own fans
>   set fan1_min 450
>   #set fan2_min 1000
>   #set fan4_min 1000

All the rest looks good, I'll update the wiki, thanks.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
