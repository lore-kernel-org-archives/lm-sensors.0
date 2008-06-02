From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 02 Jun 2008 09:18:14 +0000
Subject: Re: [lm-sensors] LM93,
Message-Id: <20080602111814.7f893296@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Santi,

On Wed, 28 May 2008 10:52:35 +0200, Santi Saez wrote:
> I want to monitor some temperatures in a server with a Supermicro =20
> X6DH8-XG2 motherboard with 2 Xeon processors, running Linux 2.6.25.4 =20
> and lm-sensors v3.0.2, in a Debian Etch box.
>=20
> LM93 and PC87427 Super I/O sensor chips are detected, according to =20
> the wiki only LM93 is fully supported by lm-sensors, in PC87427 fan =20
> monitoring only is available, this is an example of the command output:

Did you load the pc87427 driver nevertheless? If you did, what did it
say? I have patches improving this driver and I am looking for testers.

> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=20
> # sensors
> lm93-i2c-0-2e
> Adapter: SMBus I801 adapter at 1100
> in1:         +0.94 V  (min =3D  +0.83 V, max =3D  +1.02 V)
> in2:         +0.94 V  (min =3D  +0.83 V, max =3D  +1.02 V)
> in3:         +0.94 V  (min =3D  +0.83 V, max =3D  +1.02 V)
> in4:         +1.21 V  (min =3D  +1.08 V, max =3D  +1.32 V)
> in5:         +1.49 V  (min =3D  +1.35 V, max =3D  +1.66 V)
> in6:         +1.50 V  (min =3D  +1.35 V, max =3D  +1.66 V)
> in7:         +1.35 V  (min =3D  +1.02 V, max =3D  +1.54 V)
> in8:         +1.36 V  (min =3D  +1.02 V, max =3D  +1.54 V)
> in9:         +3.35 V  (min =3D  +2.97 V, max =3D  +3.64 V)
> in10:        +5.02 V  (min =3D  +4.47 V, max =3D  +5.49 V)
> in11:        +0.00 V  (min =3D  +2.25 V, max =3D  +2.76 V)
> in12:        +1.79 V  (min =3D  +1.77 V, max =3D  +2.17 V)
> in13:        +1.19 V  (min =3D  +0.89 V, max =3D  +1.09 V)
> in14:        +0.97 V  (min =3D  +0.89 V, max =3D  +1.09 V)
> in15:        +0.30 V  (min =3D  +0.07 V, max =3D  +0.54 V)
> in16:        +3.41 V  (min =3D  +2.97 V, max =3D  +3.63 V)
> fan1:          0 RPM  (min =3D    0 RPM)
> fan2:          0 RPM  (min =3D    0 RPM)
> fan3:          0 RPM  (min =3D    0 RPM)
> fan4:          0 RPM  (min =3D    0 RPM)
> temp1:       +32.0=B0C  (low  =3D -128.0=B0C, high =3D -128.0=B0C)
> temp2:       +32.0=B0C  (low  =3D -128.0=B0C, high =3D -128.0=B0C)
> temp3:       +27.0=B0C  (low  =3D -128.0=B0C, high =3D +50.0=B0C)
> cpu0_vid:   +1.088 V
> cpu1_vid:   +1.088 V
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=20
>=20
> What's the meaning of temp1, temp2 and temp3 params? maybe physical =20
> processors (temp1, temp2) and mother board (temp3)? There's no info =20
> about lm93 chip in "/etc/sensors3.conf" file..

Even if there was, it wouldn't necessarily be very helpful, as every
motherboard manufacturer is free to connect the hardware monitoring
chip inputs the way they want.

One very nice thing with SuperMicro is that they provide a hardware
monitoring tool with a human-readable configuration file for all of
their boards, so it's usually not too difficult to figure out the chip
wiring. I'm looking at the configuration for your board at the moment
and it says the following things:

* 8 fans are monitored by the PC87427. fan7 is the CPU1 fan speed, fan8
  is the CPU2 fan speed.
* Voltages are monitored by the LM93. in1 is +12V, in7 is CPU1
  Vcore, in8 is CPU2 Vcore, in9 is +3.3V, in10 is +5V, in15 is -12V.
  +12V and -12V obviously need some scaling, but fortunately it seems
  that SuperMicro followed the recommendations in the LM93 datasheet.
* Temperatures are monitored by the LM93. temp1 is CPU1 temperature,
  temp2 is CPU2 temperature, temp3 is system temperature.

So a preliminary configuration file for the X6DH8-XG2 would look like:

chip "pc87427-*"

   label  fan7  "CPU1 Fan"
   label  fan8  "CPU2 Fan"

chip "lm93-*"

   ignore fan1
   ignore fan2
   ignore fan3
   ignore fan4

   label  in1  "+12V"
   label  in7  "VCore1"
   label  in8  "VCore2"
   label  in9  "+3.3V"
   label  in10 "+5V"
   ignore in11
   label  in15 "-12V"

   compute in1  @ * ((13.7/1.15)+1), @ / ((13.7/1.15)+1)
   compute in15 @ * 5.1138 - 13.5771, (@ + 13.5771) / 5.1138

   label  temp1  "CPU1 Temp"
   label  temp2  "CPU2 Temp"
   label  temp3  "Sys Temp"

The other voltage inputs are apparently wired but I don't know what
they are monitoring. in2 and in3 are suspiciously similar to in1, I
wonder if +12V is monitored 3 times?

Please test the configuration file above. If the output of "sensors"
makes sense, I'll copy it to the wiki.

> Is there anyway to get processor temperatures in this motherboard =20
> using ACPI? There's no data inside "/proc/acpi/thermal_zone/".. =20
> running "acpi" I get this error:
>=20
> # modprobe thermal
> # acpi --thermal
> No support for device type: thermal

So the answer to this question is obviously "no". Which is a good thing
in fact, as it suggests that ACPI won't conflict with the native
hardware monitoring drivers on this system.

--=20
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
