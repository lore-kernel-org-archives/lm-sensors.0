From: "Mark E. Hansen" <meh@Winfirst.Com>
Date: Tue, 14 Jul 2009 15:15:51 +0000
Subject: Re: [lm-sensors] Can someone give me some help? thanks
Message-Id: <4A5CA127.7030805@Winfirst.Com>
List-Id: <lm-sensors.vger.kernel.org>
References: <c98b13f80907101313g76b337batfe028da5046fcd00@mail.gmail.com>
In-Reply-To: <c98b13f80907101313g76b337batfe028da5046fcd00@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On 07/14/09 08:02, he liang wrote:
> ok,I know.
> This time  I send my question to  the  lm-sensors mailing address
>  thanks for your advice.
>=20
> my result is as follow,so why it has so many ALARM?
> need I to modify or check something?
>=20
> Processor 4x Intel(R) Core(TM)2 Quad CPU @ 2.40GHz
> Operating System Ubuntu 8.04.3 LTS
> Kernel Linux 2.6.24-24-generic (i686)
> mainboard: asus p5b plus
>=20
> Adapter: ISA adapter
> VCore:       +1.12 V  (min =3D  +0.00 V, max =3D  +1.74 V)
> in1:        +12.20 V  (min =3D  +9.03 V, max =3D  +5.17 V)   ALARM

Let's look at in1. You have min for in1 set to +9.03 and max set
to +5.17 (these are set in your configuration file). However, the
value read from the sensor chip is +12.20. This is outside your
configured range, so you get an alarm.

Also, your range is backwards. How can you have a configured Min
value that is larger than your configured Max value?

As I said in my previous response (perhaps you missed that?), you
need to correct your configuration file. I'm not an expert at this,
so I'll leave it for others to answer.

Best Regards,

> AVCC:        +3.17 V  (min =3D  +3.14 V, max =3D  +2.98 V)   ALARM
> 3VCC:        +3.17 V  (min =3D  +2.66 V, max =3D  +2.82 V)   ALARM
> in4:         +0.00 V  (min =3D  +0.13 V, max =3D  +1.39 V)   ALARM
> in5:         +1.58 V  (min =3D  +1.18 V, max =3D  +0.22 V)   ALARM
> in6:         +0.13 V  (min =3D  +4.35 V, max =3D  +6.35 V)   ALARM
> VSB:         +3.17 V  (min =3D  +1.14 V, max =3D  +2.61 V)   ALARM
> VBAT:        +3.17 V  (min =3D  +2.40 V, max =3D  +2.53 V)   ALARM
> Case Fan:      0 RPM  (min =3D 21093 RPM, div =3D 64)  ALARM
> CPU Fan:    1394 RPM  (min =3D 2678 RPM, div =3D 8)  ALARM
> Aux Fan:       0 RPM  (min =3D 21093 RPM, div =3D 64)  ALARM
> fan4:          0 RPM  (min =3D 42187 RPM, div =3D 32)  ALARM
> fan5:          0 RPM  (min =3D 10546 RPM, div =3D 128)  ALARM
> Sys Temp:    +37.0=B0C  (high =3D +15.0=B0C, hyst =3D +68.0=B0C)  sensor =
=3D thermistor
> CPU Temp:    +14.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sensor =
=3D diode
> AUX Temp:   +111.5=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  ALARM  =
sensor > thermistor
> cpu0_vid:   +1.550 V
> coretemp-isa-0000
> Adapter: ISA adapter
> Core 0:      +36.0=B0C  (crit =3D +100.0=B0C)
> coretemp-isa-0001
> Adapter: ISA adapter
> Core 1:      +36.0=B0C  (crit =3D +100.0=B0C)
> coretemp-isa-0002
> Adapter: ISA adapter
> Core 2:      +34.0=B0C  (crit =3D +100.0=B0C)
> coretemp-isa-0003
> Adapter: ISA adapter
> Core 3:      +34.0=B0C  (crit =3D +100.0=B0C)
>=20
> 2009/7/14 Mark E. Hansen <meh@winfirst.com>
>=20
>> On 07/13/09 20:53, he liang wrote:
>> > it can works
>> > THanks very much!
>> > the result as follows
>> > I want to ask why so many ALARM?
>> > need i to check something?
>>
>> First, you should make sure you always include the lm-sensors mailing
>> list on all messages, so the entire list can participate.
>>
>> You're getting the alarms because your configuration, for in1 for
>> example, shows a min voltage of +9.03 and a max voltage of +5.17,
>> while the sensed voltage is +12.20 - well above the defined max:
>>
>> > in1:        +12.20 V  (min =3D  +9.03 V, max =3D  +5.17 V)   ALARM
>>
>>
>> Note that although the sensors-detect script can detect which sensor
>> chips are used by your motherboard and install the proper drivers,
>> it can't really set up the configuration file, as each motherboard
>> manufacturer "wires-up" the chips differently.
>>
>> I'm not an expert at setting up a configuration file, so I'll let
>> someone else answer here.
>>
>> Best Regards,
>>
>>
>> >
>> ------------------------------------------------------------------------=
-------------------
>> > Adapter: ISA adapter
>> > VCore:       +1.12 V  (min =3D  +0.00 V, max =3D  +1.74 V)
>> > in1:        +12.20 V  (min =3D  +9.03 V, max =3D  +5.17 V)   ALARM
>> > AVCC:        +3.17 V  (min =3D  +3.14 V, max =3D  +2.98 V)   ALARM
>> > 3VCC:        +3.17 V  (min =3D  +2.66 V, max =3D  +2.82 V)   ALARM
>> > in4:         +0.00 V  (min =3D  +0.13 V, max =3D  +1.39 V)   ALARM
>> > in5:         +1.58 V  (min =3D  +1.18 V, max =3D  +0.22 V)   ALARM
>> > in6:         +0.13 V  (min =3D  +4.35 V, max =3D  +6.35 V)   ALARM
>> > VSB:         +3.17 V  (min =3D  +1.14 V, max =3D  +2.61 V)   ALARM
>> > VBAT:        +3.17 V  (min =3D  +2.40 V, max =3D  +2.53 V)   ALARM
>> > Case Fan:      0 RPM  (min =3D 21093 RPM, div =3D 64)  ALARM
>> > CPU Fan:    1394 RPM  (min =3D 2678 RPM, div =3D 8)  ALARM
>> > Aux Fan:       0 RPM  (min =3D 21093 RPM, div =3D 64)  ALARM
>> > fan4:          0 RPM  (min =3D 42187 RPM, div =3D 32)  ALARM
>> > fan5:          0 RPM  (min =3D 10546 RPM, div =3D 128)  ALARM
>> > Sys Temp:    +37.0=B0C  (high =3D +15.0=B0C, hyst =3D +68.0=B0C)  sens=
or >> thermistor
>> > CPU Temp:    +14.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sens=
or =3D diode
>> > AUX Temp:   +111.5=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  ALAR=
M  sensor >> > thermistor
>> > cpu0_vid:   +1.550 V
>> > coretemp-isa-0000
>> > Adapter: ISA adapter
>> > Core 0:      +36.0=B0C  (crit =3D +100.0=B0C)
>> > coretemp-isa-0001
>> > Adapter: ISA adapter
>> > Core 1:      +36.0=B0C  (crit =3D +100.0=B0C)
>> > coretemp-isa-0002
>> > Adapter: ISA adapter
>> > Core 2:      +34.0=B0C  (crit =3D +100.0=B0C)
>> > coretemp-isa-0003
>> > Adapter: ISA adapter
>> > Core 3:      +34.0=B0C  (crit =3D +100.0=B0C)
>> > 2009/7/13 Mark E. Hansen <meh@winfirst.com>
>> >
>> >> On 07/13/09 03:52, Martyn Welch wrote:
>> >> > he liang wrote:
>> >> >>
>> >> >> Just press ENTER to continue:
>> >> >>
>> >> >> I will now generate the commands needed to load the required modul=
es.
>> >> >>
>> >> >> To load everything that is needed, add this to /etc/modules:
>> >> >>
>> >> >> #----cut here----
>> >> >> # Chip drivers
>> >> >> w83627ehf
>> >> >> coretemp
>> >> >> #----cut here----
>> >> >>
>> >> >> Do you want to add these lines automatically? (yes/NO)yes
>> >> >> psy@psy-desktop:~$ <mailto:psy@psy-desktop:%7E$> sudo sensors
>> >> >> No sensors found!
>> >> >> Make sure you loaded all the kernel drivers you need.
>> >> >> Try sensors-detect to find out which these are.
>> >> >>
>> >> > Have you tried rebooting? Adding those lines to "/etc/modules" shou=
ld
>> >> > take effect after a reboot.
>> >> >
>> >> > Try rebooting or issuing the following commands to load the modules:
>> >> >
>> >> >   sudo modprobe w83627ehf
>> >> >   sudo modprobe coretemp
>> >> >
>> >> > Hope that helps,
>> >> >
>> >> > Martyn
>> >> >
>> >>
>> >> Also, the OP should try 'sensors -s' as root (in /etc/rc.local) to
>> >> upload the sensors configuration to the sensors chips.
>> >>
>> >>
>> >> _______________________________________________
>> >> lm-sensors mailing list
>> >> lm-sensors@lm-sensors.org
>> >> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>> >>
>> >
>>
>>
>=20


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
