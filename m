From: Stefan Catruna <stefancatruna@gmail.com>
Date: Sat, 12 Sep 2009 09:36:41 +0000
Subject: Re: [lm-sensors] Intel DQ45CB motherboard - zero stats
Message-Id: <5a2e2c6e0909120236yd49cc4u39aaa6a5d5968039@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <5a2e2c6e0909112349n7ec3a8f5m4c22af9dff02cd33@mail.gmail.com>
In-Reply-To: <5a2e2c6e0909112349n7ec3a8f5m4c22af9dff02cd33@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Sat, Sep 12, 2009 at 12:25 PM, Jean Delvare <khali@linux-fr.org> wrote:
> On Sat, 12 Sep 2009 12:15:33 +0300, Stefan Catruna wrote:
>> Here are 2 consecutise "sensors" run:
>>
>> # sensors
>> coretemp-isa-0000
>> Adapter: ISA adapter
>> Core 0: =A0 =A0 =A0+73.0=B0C =A0(high =3D +74.0=B0C, crit =3D +100.0=B0C=
) =A0ALARM
>>
>> coretemp-isa-0001
>> Adapter: ISA adapter
>> Core 1: =A0 =A0 =A0+68.0=B0C =A0(high =3D +74.0=B0C, crit =3D +100.0=B0C)
>>
>> coretemp-isa-0002
>> Adapter: ISA adapter
>> Core 2: =A0 =A0 =A0+69.0=B0C =A0(high =3D +74.0=B0C, crit =3D +100.0=B0C=
) =A0ALARM
>>
>> coretemp-isa-0003
>> Adapter: ISA adapter
>> Core 3: =A0 =A0 =A0+71.0=B0C =A0(high =3D +74.0=B0C, crit =3D +100.0=B0C=
) =A0ALARM
>>
>> # sensors
>> coretemp-isa-0000
>> Adapter: ISA adapter
>> Core 0: =A0 =A0 =A0+72.0=B0C =A0(high =3D +74.0=B0C, crit =3D +100.0=B0C=
) =A0ALARM
>>
>> coretemp-isa-0001
>> Adapter: ISA adapter
>> Core 1: =A0 =A0 =A0+67.0=B0C =A0(high =3D +74.0=B0C, crit =3D +100.0=B0C)
>>
>> coretemp-isa-0002
>> Adapter: ISA adapter
>> Core 2: =A0 =A0 =A0+67.0=B0C =A0(high =3D +74.0=B0C, crit =3D +100.0=B0C=
) =A0ALARM
>>
>> coretemp-isa-0003
>> Adapter: ISA adapter
>> Core 3: =A0 =A0 =A0+70.0=B0C =A0(high =3D +74.0=B0C, crit =3D +100.0=B0C=
) =A0ALARM
>
> This is odd. Rudolf, do you know why alarm flags are set while
> temperatures are below the high limits?
>
>> PS: lm-sensors was installed from repository
>> # sensors -v
>> sensors version 3.0.2 with libsensors version 3.0.2
>
> Kernel version is useful as well.

# uname -a
Linux 2.6.28-11-server #42-Ubuntu SMP Fri Apr 17 02:45:36 UTC 2009
x86_64 GNU/Linux

>> PPS: I'm having some problems with the temperature, it reached even 100
>
> Not good. Maybe your fans aren't spinning fast enough? If you are doing
> fan speed control, try without it for a moment.

I'm not using fan speed control, set them to Aggressive in BIOS and
the temp is still high ...

> --
> Jean Delvare
> http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
