From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 19 Sep 2012 12:29:58 +0000
Subject: Re: [lm-sensors] Configuration for Foxconn A7GM-S 2.0
Message-Id: <20120919142958.7fe363af@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20556.55176.173597.530756@freddi.uddeborg>
In-Reply-To: <20556.55176.173597.530756@freddi.uddeborg>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi G=F6ran,

On Sun, 9 Sep 2012 19:53:12 +0200, G=F6ran Uddeborg wrote:
> I've tried to configure lm-sensors correctly for my TV-box following
> the instructions on
> http://www.lm-sensors.org/wiki/VoltageLabelsAndScaling Having done it,
> I thought I could contribute my result if you want to incorporate it
> in the wiki.  Maybe I could register and do it myself, I haven't
> tried.  But I thought it could be a good idea if someone more
> experienced did a review first anyway.

You actually can't, as the wiki access is restricted.

> My motherboard is a Foxconn A7GM-S 2.0 with "BIOS ID" 872F1P04 and
> "BIOS Version" 08.00.14.  According to sensors, the exact chip is an
> IT8716.  The BIOS reports CPU, DRAM, 3.3V, 12V and 1.1V readings.  All
> but the 12V could be found directly available without scaling.  For
> 12V I used the instructions on the VoltageLabelsAndScaling page and
> think I've figured out that it goes in steps of 64mV.  I.e. the
> scaling factor is 4.

I'm happy to see that my article in the wiki starts being helpful :)

> So my configuration for this motherboard ended up like this:
>=20
> chip "it8716-*"
>      label  in0 "CPU core"
>      label  in1 "DRAM voltage"
>      label  in2 "+3.3V"
>      ignore in3
>      label  in4 "+12.0V"
>      label  in5 "+1.1V"
>      ignore in6
>      ignore in7
>      ignore in8

What were the values of in3, in6 and in7? One of these could be +5V,
it's usually monitored (even though the lack of mention in your BIOS
suggests that might not be the case here.) One could be 5VSB. Both
would need scaling so are more likely to appear in the 2.5 - 3.3 V
range unscaled.

in8 is normally Vbat on the IT8716F, it shouldn't need scaling. Didn't
it report a correct value for you?

For reference, please let us know which kernel you're running.

>=20
>      compute in4  @ * (64/16), @ / (64/16)

You can just make this:

     compute in4  @ * 4, @ / 4

This is more efficient.

>=20
>      label  fan1 "CPU fan"
>      # One of these is the "System fan", but I don't have anything connec=
ted
>      # to that socket, so I don't know which one.
>      ignore fan2
>      ignore fan3

Then for the wiki version of your configuration file, we won't ignore
any input. Better print 0 RPM than omit a running fan. If you have the
possibility to test with a spare fan to see which is which, we'll
update the configuration file.

>=20
>      label  temp1 "CPU temp"
>      label  temp2 "System temp"
>      ignore temp3
>=20
>      # Min and max for Athlon II X2 245e
>      set in0_min  0.875
>      set in0_max  1.4

Did you check if the BIOS had set proper limits on its own?

>      # JEDEC standard for DDR2
>      set in1_min  1.7
>      set in1_max  1.9
>      # 5 % tolerance on the remaining measurements
>      set in2_min  3.3   * 0.95
>      set in2_max  3.3   * 1.05
>      set in4_min 12.0   * 0.95
>      set in4_max 12.0   * 1.05
>      set in5_min  1.1   * 0.95
>      set in5_max  1.1   * 1.05

This all looks very good, I've added your configuration file to the
wiki:
http://www.lm-sensors.org/wiki/Configurations/Foxconn/A7GM-S%202.0

We can update it with your later findings as needed.

--=20
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
