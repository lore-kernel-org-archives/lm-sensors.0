From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 12 Nov 2012 09:28:16 +0000
Subject: Re: [lm-sensors] Configuration File for ASRock B75 Pro3
Message-Id: <20121112102816.58b32e82@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <509C1EBF.3000309@ing-poetter.de>
In-Reply-To: <509C1EBF.3000309@ing-poetter.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Lars,

On Sat, 10 Nov 2012 14:57:50 +0100, Lars P=F6tter wrote:
> > Run sensors -u, and you'll see the underlying attribute names. SYSTIN is
> > probably temp1, CPUTIN is temp2, and AUXTIN is temp3. They are not spec=
ial,
> > but the driver provides a symbolic name, which is displayed by the sens=
ors
> > command. You have to use the raw name, not the symbolic name, in sensor=
s.conf.
> >=20
> > Hope this helps,
>=20
> Yes that helped. Thank you very much. It now works !
>=20
> So here is the working configuration file for the ASRock B75 Pro 3 Main
> Board:

I was about to add this to the wiki but there are a few things which worry =
me:

> chip "nct6776-isa-0290"
>     label in1 "+1.9V"
>     ignore in4
>     label in5 "+1.66V"

+1.9V and +1.66V make little sense to me. These voltage values aren't
part of the ATX specification. They most certainly correspond to +12V
and +5V (the ASROck BIOS displays these) and need proper scaling
factors. Please read:
  http://www.lm-sensors.org/wiki/VoltageLabelsAndScaling
then you should be able to figure out who is who and which scaling
factors should be applied.

>     ignore fan1
>     label fan2 "CPU Fan"
>     ignore fan3
>     ignore fan4
>     ignore fan5

You have only one fan in your machine but the board had 5 headers. The
BIOS can display 5 fan speed values, so we don't want these ignore
statements in the configuration file that will go to the wiki. Best
would be to provide the right label for each fan, with some luck they
are in the same order as in the BIOS, but you if you have a spare fan
to confirm that, it would be great.

>     set in1_min  1.9 * 0.90
>     set in1_max  1.9 * 1.10
>     set in5_min  1.66 * 0.90
>     set in5_max  1.66 * 1.10

These will need to be adjusted once proper scaling factors are in place.

>     set fan2_min  900 * 0.90

That's rather uncommon. We use this for voltage limits because there is
a nominal target and a standard maximum deviance (which is +/- 5% for
core ATX voltages BTW, not 10%.) For fans there is no nominal speed,
just a minimum speed so you can express it directly.

>     set temp1_max  50
>     set temp1_max_hyst 30
>=20
> So this could be added to the Wiki (I do not have write rights) perhaps

I will do once we have come up with a really good configuration file.

> it would be good to add the information to use sensors -s and sensors -u
> when creating new configuration files to the Wiki here:
> http://lm-sensors.org/wiki/Configurations

"sensors -s" is documented in sensors.conf(5) already. I think "sensors
-u" should be documented there as well.

> Also the sensors -h warning on -u " Raw output (debugging only)" made me
> not trying it. Perhaps "all underlying attribute names" would be a
> better description.

I agree "debugging only" is wrong, I'll simply drop it.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
