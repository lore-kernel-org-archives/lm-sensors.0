From: "Juerg Haefliger" <juergh@gmail.com>
Date: Sat, 02 Jun 2007 21:46:28 +0000
Subject: Re: [lm-sensors] Jetway J7F2 with f71805: PWM not working
Message-Id: <191fb4ca0706021446o62cf6e7ch58f2e8d2d8ffb4f4@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1180813726137@dmwebmail.belize.chezphil.org>
In-Reply-To: <1180813726137@dmwebmail.belize.chezphil.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Phil,

On 6/2/07, Phil Endecott <spam_from_lm_sensors@chezphil.org> wrote:
> Dear All,
>
> I have a Jetway J7F2 motherboard; it's a mini-ITX board with a VIA C7
> processor and the Fintec f71805f sensor chip.
>
> Temperature and fan speed measurements work correctly, and most of the
> voltages look right to me.  I have no idea whether the values for
> Vtt1.2V, Vram, Vchip and Vcc1.5V are right:
>
> # sensors
> f71805f-isa-0290
> Adapter: ISA adapter
> +3.3V:     +3.42 V  (min =3D  +3.01 V, max =3D  +3.58 V)
> Vtt1.2V:   +0.86 V  (min =3D  +0.00 V, max =3D  +2.02 V)
> Vram:      +1.46 V  (min =3D  +0.00 V, max =3D  +4.03 V)
> Vchip:     +3.58 V  (min =3D  +0.00 V, max =3D  +6.31 V)
> +5V:       +5.13 V  (min =3D  +0.00 V, max =3D +10.59 V)
> +12V:     +12.32 V  (min =3D  +0.00 V, max =3D +22.18 V)
> Vcc1.5V:   +1.11 V  (min =3D  +0.00 V, max =3D  +2.02 V)
> Vcore:     +1.09 V  (min =3D  +0.00 V, max =3D  +2.02 V)
> 5VSB:      +5.13 V  (min =3D  +0.00 V, max =3D +10.59 V)
> CPU Fan:     0 RPM  (min =3D    0 RPM)
> Sys Fan:     0 RPM  (min =3D    0 RPM)
> Aux Fan:  4559 RPM  (min =3D    0 RPM)
> CPU Temp:    +22=B0C  (high =3D   +70=B0C, hyst =3D   +69=B0C)         [d=
iode]
> Sys Temp:    +31=B0C  (high =3D  +255=B0C, hyst =3D    +0=B0C)         [d=
iode]
> Aux Temp:   +115=B0C  (high =3D  +255=B0C, hyst =3D    +0=B0C)         [t=
hermistor]
>
> (err, well some of those numbers look a bit odd but that's just because
> I have been messing around.)
>
> Unfortunately, PWM fan speed control doesn't seem to work.  I can write
> things to the pwm /sys devices, but nothing happens.  For example, I
> have asked for them all to be off:
>
> localhost:/sys/devices/platform/f71805f.656# for i in pwm*; do echo -n
> $i ': '; cat $i; done
> pwm1 : 0
> pwm1_enable : 1
> pwm1_freq : 187500
> pwm1_mode : 1
> pwm2 : 0
> pwm2_enable : 1
> pwm2_freq : 187500
> pwm2_mode : 1
> pwm3 : 0
> pwm3_enable : 1
> pwm3_freq : 187500
> pwm3_mode : 1
>
> (I hope I have understood this correctly; 'enable=3D1' means manual
> control, and 'pwm=3D0' means off, right?)
>
> But I still see 12V on all of the fan connectors and they run at full spe=
ed.
>
> So the possibilities are:
> - I'm doing something wrong (very likely, I'm new to this).
> - The lm-sensors code is doing something wrong.
> - My board doesn't actually have PWM control on these outputs and
> they're hard-wired to 12V.
>
> Right now I think that the last of those is quite likely; I can't
> exactly trace the 12V from the power input all the way to the fan
> connectors, but I can see where it goes for much of the distance and I
> don't see any power transistors.

If you have an Ohmmeter, you can measure the resistance between the
fan connector pins and 12V & ground. If both readings are 0 you're out
of luck, i.e., the fan is hardwired to 12V/ground.


> So, has anyone else had any experience with this board?  Has PWM been
> known to work with other boards with this chip?  Is it common for fan
> connectors to not have PWM control?

I can't speak for your board but the same applies to my EPIA M10000.
No PWM control, stupid design.


> Finally, somewhat O.T., if it seems that I can't control the fan speed
> on this board, can anyone suggest a "hardware hack"?  In the past I
> have built fan speed controllers with thermisters and op-amps, but
> something with software control would be better.

That's fairly simple, typically a transistor between the fan and
ground, controlled by the PWM controller. The hard part is to get to
the components, especially on a Mini ITX board. You might have to
solder wires to pins and lift pins and fun stuff like that.
Alternatively, you could use a i2c PWM controller (that is of course
supported by lm-sensors) and hook it up to the boards I2C bus, Mini
ITX typically have it exposed on a header.
Google it.

...juerg


>
> Many thanks in advance for any suggestions.
>
>
> Phil.
>
>
>
>
>
>
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
