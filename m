From: "Juerg Haefliger" <juergh@gmail.com>
Date: Tue, 24 Jul 2007 21:44:22 +0000
Subject: Re: [lm-sensors] VT1211: wrong vid, vcore
Message-Id: <191fb4ca0707241444h22c5bf7rfa9f31d4d460e4c5@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <08D6463A-3693-42BE-B8E5-6D32758A3C03@cilly.mine.nu>
In-Reply-To: <08D6463A-3693-42BE-B8E5-6D32758A3C03@cilly.mine.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi cilly,

Please also reply to the list. Other people might be interested as well.


> Hi Juerg,
>
> thanks for helping me, here is output of sensors:
>
> vt1211-isa-6000
> Adapter: ISA adapter
> +3.3V:     +3.30 V  (min =3D  +3.14 V, max =3D  +3.47 V)
> +2.5V:     +2.38 V  (min =3D  +2.38 V, max =3D  +2.63 V)   ALARM
> VCore:     +1.22 V  (min =3D  +1.36 V, max =3D  +1.44 V)   ALARM
> +5V:       +4.66 V  (min =3D  +4.51 V, max =3D  +5.49 V)
> +12V:     +11.49 V  (min =3D +10.77 V, max =3D +13.21 V)
> +3.3V:     +3.28 V  (min =3D  +3.13 V, max =3D  +3.46 V)
> Case Fan:    0 RPM  (min =3D 3006 RPM, div =3D 2)
> CPU Fan:     0 RPM  (min =3D 3006 RPM, div =3D 2)
> CPU Temp:  +45.4=B0C  (high =3D   +85=B0C, hyst =3D   +79=B0C)
> Int Temp:  +61.0=B0C  (high =3D   +65=B0C, hyst =3D   +60=B0C)
> vid:      +1.250 V  (VRM Version 8.5)

Yeah, 1.250V for VRM8.5 means that all the VID inputs read 0. I don't
think they are connected. On the other hand now the vid and VCore kind
of match :-) But VCore should really be 1.4V for a Nehemiah in an EBGA
package. The only way to confirm this is to hook up a voltmeter to the
Vcore voltage.


> and vt1211-section of sensors.conf:
>
> chip "vt1211-*"
>
> #                                                       1 for temp, 0 for=
 volt.
> #       Sensor          Voltage Mode    Temp Mode       config bit
> #       --------        ------------    ---------       --------------
> #       Reading 1                       temp1
> #       Reading 3                       temp2
> #       UCH1/Reading2   in0             temp3           0x04 (4)
> #       UCH2            in1             temp4           0x08 (8)
> #       UCH3            in2             temp5           0x10 (16)
> #       UCH4            in3             temp6           0x20 (32)
> #       UCH5            in4             temp7           0x40 (64)
> #       3.3V            in5
>
> # Set uch1-2 to temp mode, uch3-5 to voltage mode. This works only
> # for the 2.4 driver. For the 2.6 driver use the uch_config module
> parameter.
> # If the value doesn't match the hardware wiring, you'll get weird
> readings!
> #    set config 12
>
> # The 2.6 driver will automatically ignore the inputs which are not
> # configured, but the 2.4 driver will not so you'll need to add ignore
> # statements depending on the config value above.
> #   ignore in0
> #   ignore in1
> #       ignore in2
> #   ignore temp3
> #   ignore temp4
>      ignore temp5
>      ignore temp6
>      ignore temp7
>
>      label in0 "+3.3V"
>      label in1 "+2.5V"
>      label in2 "VCore"
>      label in3 "+5V"
>      label in4 "+12V"
>      label in5 "+3.3V"
>
>      label temp1 "CPU Temp"
>      label temp2 "Int Temp"
>
>      label fan1 "Case Fan"
>      label fan2 "CPU Fan"
>
> # All voltage calculations have the form
> #    compute inX  @ * (1 + R1 / R2), @ / (1 + R1 / R2)
> #
> # The following are the resistor values as recommended by VIA
> #       Voltage         R1      R2
> #       -------         ----    ----
> #       VCore           -       -       (no scaling)
> #        3.3            6.8k    10k
> #        2.5            2k      10k
> #        5.0            14k     10k
> #       12.0            47k     10k
> #
> # The VT1211 internal 3.3V (in5) is scaled by the driver and doesn't
> # need to be adjusted here. VCore doesn't need scaling at all.
>
>      compute in0  @ * (1 + 6.8 / 10),  @ / (1 + 6.8 / 10)
>      compute in1  @ * (1 +   2 / 10),  @ / (1 +   2 / 10)
>      compute in3  @ * (1 +  14 / 10),  @ / (1 +  14 / 10)
>      compute in4  @ * (1 +  47 / 10),  @ / (1 +  47 / 10)

Interesting, you don't have a 'compute in2' line (which is correct)
but the in2 voltage doesn't return 1.4V. So that leaves only two
conclusions:
1) The reported Vcore of 1.22V is the correct value. If you do have a
voltmeter, please check.
2) There are scaling resistors on the Vcore input pin of the vt1211.
Assuming Vcore should be 1.4V, you can add the following compute line:

compute in2  @ * (1 +  1.47 / 10),  @ / (1 +  1.47 / 10)

...juerg



> # Adjust this if your vid is wrong (for 2.4 only); see doc/vid
>     set vrm 8.5
>
>     set in0_min 3.3 * 0.95
>     set in0_max 3.3 * 1.05
>     set in1_min 2.5 * 0.95
>     set in1_max 2.5 * 1.05
> # If your vid is wrong, hardcode the CPU voltage (e.g. 1.4)
>     set in2_min 1.4 * 0.97
>     set in2_max 1.4 * 1.03
>     set in3_min 5.0 * 0.90
>     set in3_max 5.0 * 1.10
>     set in4_min 12.0 * 0.90
>     set in4_max 12.0 * 1.10
>      set in5_min 3.3 * 0.95
>      set in5_max 3.3 * 1.05
>
> # The temperature calculations are of the form
> #    compute tempX  (@ - Offset) / Gain, (@ * Gain) + Offset
> #
> # The following are the gain and offset values as recommended by VIA
> #       Diode Type      Gain    Offset
> #       ----------      ----    ------
> #       Intel CPU       0.9528  88.638
> #                       0.9686  65.000  *)
> #       VIA C3 Ezra     0.9528  83.869
> #       VIA C3 Ezra-T   0.9528  73.869
> #
> # *) These are the values from the previous sensors.conf. I don't know
> # where they came from or how they got derived.
> #
> # The VT1211 internal temperature (temp2) is scaled by the driver
> # and doesn't need to be adjusted here.
>
>      compute temp1 (@ - 65) / 0.9686, (@ * 0.9686) + 65
>      #compute temp1  (@ - 83.869) / 0.9528,  (@ * 0.9528) + 83.869
>      #compute temp1  (@ - 73.869) / 0.9528,  (@ * 0.9528) + 73.869
>         ## i use a linear approximation of the via hw tool value->temp
> mapping table:
>         ## temp =3D (71.0/73.0)*x-72.41
>         #compute temp1 (@*71)/73-72.41, (@+72.41)*73/71
>
> # The thermistor calculations are of the form
> #    compute tempX  1 / (1 / 298.15 - (` Vmax / @ - 1)) / B) - 273.15, \
> #                   Vmax / (1 + (^ (B / 298.15 - B / (273.15 + @))))
> #
> # B is the thermistor beta value, Vmax is the reference voltage, '^'
> is the
> # exp() operator and '`' is the ln() operator.
> # Given B =3D 3435 and Vmax =3D 2.2V and assuming that the thermistor
> forms a
> # resistor divider with a resistor equal to the thermistor's nominal
> value at
> # 25 degrees C, the following compute lines can be used:
>
>      compute temp3  1 / (1 / 298.15 - (` (2.2 / @ - 1)) / 3435) -
> 273.15, \
>                     2.2 / (1 + (^ (3435 / 298.15 - 3435 / (273.15 +
> @))))
>      compute temp4  1 / (1 / 298.15 - (` (2.2 / @ - 1)) / 3435) -
> 273.15, \
>                     2.2 / (1 + (^ (3435 / 298.15 - 3435 / (273.15 +
> @))))
>      compute temp5  1 / (1 / 298.15 - (` (2.2 / @ - 1)) / 3435) -
> 273.15, \
>                     2.2 / (1 + (^ (3435 / 298.15 - 3435 / (273.15 +
> @))))
>      compute temp6  1 / (1 / 298.15 - (` (2.2 / @ - 1)) / 3435) -
> 273.15, \
>                     2.2 / (1 + (^ (3435 / 298.15 - 3435 / (273.15 +
> @))))
>      compute temp7  1 / (1 / 298.15 - (` (2.2 / @ - 1)) / 3435) -
> 273.15, \
>                     2.2 / (1 + (^ (3435 / 298.15 - 3435 / (273.15 +
> @))))
>
>      set temp1_hyst 80
>      set temp1_over 85
>      set temp2_hyst 60
>      set temp2_over 65
> #    set temp3_hyst 60
> #    set temp3_over 65
> #    set temp4_hyst 40
> #    set temp4_over 45
>
>      set fan1_min 3000
>      set fan2_min 3000
>
>
>
>
>
>
> On Jul 24, 2007, at 10:53 PM, Juerg Haefliger wrote:
>
> > Hi c.,
> >
> > The Nehemiah CPU follows the VRM 8.5 spec. But even if you set the VRM
> > to 8.5 it will not show the right value. I don't think VIA cared to
> > connected the VID inputs of the vt1211 on the EPIA boards. On my
> > M10000 they seem to be grounded.
> >
> > Could you please post the vt1211 section of your /etc/sensors.conf
> > file and full output when running sensors? My guess is you need to
> > adjust the compute line to show the correct core voltage.
> >
> > ...juerg
> >
> >
> >
> > On 7/24/07, cilly <cilly@cilly.mine.nu> wrote:
> >> Hi all,
> >>
> >> I have a problem with vt1211-isa-6000 and VIA EPIA PE 10000 (1GHz),
> >> the vid is reported as: vid: +1.850 V  (VRM Version 9.1) and VCore:
> >> +1.22 V. Those values aren't correct, VCore is 1.4 V. I tried to set
> >> the vid manually, which does not work. Any hints? Thx.
> >>
> >> Regards,
> >>
> >> c.
> >>
> >> PS: sorry, forgot to add the subject
> >>
> >> _______________________________________________
> >> lm-sensors mailing list
> >> lm-sensors@lm-sensors.org
> >> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
> >>
>
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
