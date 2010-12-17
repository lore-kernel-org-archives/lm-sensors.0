From: "Jeff Rickman" <jrickman@myamigos.us>
Date: Fri, 17 Dec 2010 19:04:53 +0000
Subject: Re: [lm-sensors] Testing LM-Sensor Support of SCH5127 in Acer
Message-Id: <2090.75.142.173.238.1292612693.squirrel@webmail.myamigos.us>
List-Id: <lm-sensors.vger.kernel.org>
References: <57920.75.142.173.238.1291011644.squirrel@webmail.myamigos.us>
In-Reply-To: <57920.75.142.173.238.1291011644.squirrel@webmail.myamigos.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Jean,

> On Wed, 15 Dec 2010 11:04:15 +0100, Juerg Haefliger wrote:
>> > On Fri, 10 Dec 2010 10:43:57 +0100, Juerg Haefliger wrote:
>> >> --- dme1737.c 2010-08-02 00:11:14.000000000 +0200
>> >> +++ /home/khali/dme1737.c =A0 =A0 2010-12-10 14:39:04.000000000 +0100
>> >> @@ -75,16 +75,20 @@
>> >> =A0 * in4 =A0 +12V
>> >> =A0 * in5 =A0 VTR =A0 (+3.3V stby)
>> >> =A0 * in6 =A0 Vbat
>> >> + * in7 =A0 Vtrip (sch5127 only)
>> >> =A0 *
>> >> =A0 *
>> ---------------------------------------------------------------------
>> */
>> >>
>> >> -/* Voltages (in) numbered 0-6 (ix) */
>> >> -#define =A0 =A0 =A0DME1737_REG_IN(ix) =A0 =A0 =A0 =A0 =A0 =A0 =A0((i=
x) < 5 ? 0x20 + (ix)
>> \
>> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 : 0x94 + (ix))
>> >> -#define =A0 =A0 =A0DME1737_REG_IN_MIN(ix) =A0 =A0 =A0 =A0 =A0((ix) <=
 5 ? 0x44 + (ix)
>> * 2 \
>> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 : 0x91 + (ix) * 2)
>> >> -#define =A0 =A0 =A0DME1737_REG_IN_MAX(ix) =A0 =A0 =A0 =A0 =A0((ix) <=
 5 ? 0x45 + (ix)
>> * 2 \
>> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 : 0x92 + (ix) * 2)
>> >> +/* Voltages (in) numbered 0-7 (ix) */
>> >> +#define =A0 =A0 =A0DME1737_REG_IN(ix) =A0 =A0 =A0 =A0 =A0 =A0 =A0((i=
x) < 5 ? 0x20 + (ix)
>> : \
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0(ix) < 7 ? 0x94 + (ix) : \
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x1f)
>> >> +#define =A0 =A0 =A0DME1737_REG_IN_MIN(ix) =A0 =A0 =A0 =A0 =A0((ix) <=
 5 ? 0x44 + (ix)
>> * 2 : \
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0(ix) < 7 ? 0x91 + (ix) * 2 : \
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x9f)
>> >> +#define =A0 =A0 =A0DME1737_REG_IN_MAX(ix) =A0 =A0 =A0 =A0 =A0((ix) <=
 5 ? 0x45 + (ix)
>> * 2 : \
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0(ix) < 7 ? 0x92 + (ix) * 2 : \
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0xa0)
>> >
>> > Maybe it is time to give up macros and go with const arrays? The
>> macros
>> > are never called with a constant parameters so the compiler can't
>> > optimize the calls.
>>
>> I thought about that too. I keep it for now for the REG_IN for
>> consistency reasons (since MIN and MAX don't need any modification as
>> you pointed out in a subsequent email. duh!).
>
> Agreed.
>
>> > (...)
>> > Shouldn't this be [0-7]?
>>
>> Yes. And increasing the actual in[] array in the 'data' structure
>> might be a good thing too to prevent array overruns :-) Duh! No wonder
>> Jeff's min/max values behave weird.
>
> D'oh, how did I manage to miss that in my review :(
>
> Jeff, please search for "struct dme1737_data" in the source code, and
> change:
>
> 	u16 in[7];
> 	u8  in_min[7];
> 	u8  in_max[7];
>
> to
>
> 	u16 in[8];
> 	u8  in_min[8];
> 	u8  in_max[8];
>
> then rebuild the driver and try again!
>

Changes made. Recompile successful. Old module removed. Module installs
without error. Output as follows:

[root@anas-01 sensors]# sensors
sch5127-isa-0870
Adapter: ISA adapter
in0:         +1.78 V  (min =3D  +0.00 V, max =3D  +3.32 V)
Vccp:        +1.19 V  (min =3D  +1.08 V, max =3D  +1.32 V)
VCC:         +3.31 V  (min =3D  +2.97 V, max =3D  +3.63 V)
in3:         +1.13 V  (min =3D  +0.00 V, max =3D  +1.49 V)
in4:         +1.48 V  (min =3D  +0.00 V, max =3D  +1.49 V)
VTR:         +3.33 V  (min =3D  +2.97 V, max =3D  +3.63 V)
VBAT:        +3.25 V  (min =3D  +2.70 V, max =3D  +3.30 V)
in7:         +1.43 V  (min =3D  +1.35 V, max =3D  +1.65 V)
Side Fan:   1905 RPM  (min =3D  700 RPM)
MCH Fan:    5032 RPM  (min =3D 4500 RPM)
CPU Temp:    +41.8=B0C  (low  =3D +20.0=B0C, high =3D +60.0=B0C)
SYS Temp:    +32.9=B0C  (low  =3D +20.0=B0C, high =3D +60.0=B0C)

1.43 volts isn't 1.5 volts, but within +- 10 percent.

>> > (...)
>> > checkpatch.pl will complain. It wants:
>> >
>> > =A0 =A0 =A0 =A0if (data->has_features & HAS_IN7) {
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D sysfs_create_group(&dev->kobj,
>> &dme1737_in7_group);
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (err)
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto exit_remove;
>> > =A0 =A0 =A0 =A0}
>>
>> OK. Assignments in if statements are being used all over the place in
>> this driver. I guess I should clean those up, shouldn't I?
>
> If you have time, yes. OTOH there are some cases where it actually
> makes the code a lot more complex so I am not always following
> checkpatch.pl on this myself. So you might as well keep your code as is
> if it is consistent throughout the driver.
>
> --
> Jean Delvare
>


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
