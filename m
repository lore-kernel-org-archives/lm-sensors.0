From: George Joseph <george.joseph@fairview5.com>
Date: Fri, 19 Feb 2010 21:28:00 +0000
Subject: Re: [lm-sensors] Status of Andigilog asc7621 driver submitted by
Message-Id: <4B7F0260.9060807@fairview5.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3f9a31f41001230952g6321c47bq9baf5dcfdfaf5b59@mail.gmail.com>
In-Reply-To: <3f9a31f41001230952g6321c47bq9baf5dcfdfaf5b59@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On 2/19/2010 11:50 AM, Jaswinder Singh Rajput wrote:
> Hello George,
>
> On Fri, Feb 19, 2010 at 11:24 PM, Jaswinder Singh Rajput
> <jaswinderlinux@gmail.com>  wrote:
>   =20
>> asc7621a-i2c-0-2e
>> Adapter: SMBus I801 adapter at 2000
>> in0:         +1.08 V  (min =3D  +0.00 V, max =3D  +3.31 V)
>> in1:         +0.92 V  (min =3D  +0.00 V, max =3D  +2.99 V)
>> in2:         +3.19 V  (min =3D  +0.00 V, max =3D  +4.36 V)
>> in3:         +4.99 V  (min =3D  +0.00 V, max =3D  +6.61 V)
>> in4:        +12.00 V  (min =3D  +0.00 V, max =3D +15.94 V)
>> fan1:        947 RPM  (min =3D    0 RPM)
>> fan2:       2425 RPM  (min =3D    0 RPM)
>> fan3:          0 RPM  (min =3D    0 RPM)
>> fan4:        625 RPM  (min =3D    0 RPM)
>> temp1:       -57.8=B0C  (low  =3D -127.0=B0C, high =3D  +0.0=B0C)
>>                       (crit =3D -17.0=B0C)
>> temp2:       +35.5=B0C  (low  =3D -127.0=B0C, high =3D +127.0=B0C)
>>                       (crit =3D +65.0=B0C)
>> temp3:       +42.0=B0C  (low  =3D -127.0=B0C, high =3D +127.0=B0C)
>>                       (crit =3D +65.0=B0C)
>> temp4:       +52.0=B0C  (low  =3D -127.0=B0C, high =3D +127.0=B0C)
>>                       (crit =3D +103.0=B0C)
>> temp5:       -58.0=B0C
>> temp6:       -84.5=B0C
>> temp7:       +96.2=B0C
>> temp8:      +118.5=B0C
>>
>>     =20
> I did further investigations and noticed that in my case : temp1 > temp5 =
and temp6, temp7 and temp8 are false readings which never
> changes :
>
> temp1:       -33.0=B0C  (low  =3D -127.0=B0C, high =3D  +0.0=B0C)
>                        (crit =3D -17.0=B0C)
> temp2:       +38.2=B0C  (low  =3D -127.0=B0C, high =3D +127.0=B0C)
>                        (crit =3D +65.0=B0C)
> temp3:       +51.8=B0C  (low  =3D -127.0=B0C, high =3D +127.0=B0C)
>                        (crit =3D +65.0=B0C)
> temp4:       +55.5=B0C  (low  =3D -127.0=B0C, high =3D +127.0=B0C)
>                        (crit =3D +103.0=B0C)
> temp5:       -33.0=B0C
> temp6:       -84.5=B0C
> temp7:       +96.2=B0C
> temp8:      +118.5=B0C
>
> Can you give me some hint why temp6, temp7 and temp8 are showing wrong
> value for Intel WX58BP with Core i7.
>   =20

The mapping of the temps is controlled by the motherboard design and the=20
BIOS.  On most Intel motherboards...

temp1 =3D PECI CPU temp.  I.E.  Degrees below thermal throttling.  Similar =

to what coretemp reports.
temp2 =3D aSC7621 chip itself.  I.E.  Motherboard temp.
temp3 =3D Sensor between the DIMM sockets.
temp4 =3D CPU diode temp.
temp5 =3D temp1
temp6, 7, 8 =3D Documented by Andigilog as additional PECI temps but not=20
documented by Intel.

That's all the info I have.
> Can you share your temp6, temp7 and temp8 readings.
>   =20
Pretty much same as yours.
> Thanks,
> --
> Jaswinder Singh.
>   =20


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
