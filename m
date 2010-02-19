From: Jaswinder Singh Rajput <jaswinderlinux@gmail.com>
Date: Fri, 19 Feb 2010 18:06:27 +0000
Subject: Re: [lm-sensors] Status of Andigilog asc7621 driver submitted by
Message-Id: <3f9a31f41002190954u383dec6eleb7963513629e273@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3f9a31f41001230952g6321c47bq9baf5dcfdfaf5b59@mail.gmail.com>
In-Reply-To: <3f9a31f41001230952g6321c47bq9baf5dcfdfaf5b59@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hello George,

On Fri, Feb 19, 2010 at 8:48 PM, George Joseph
<george.joseph@fairview5.com> wrote:
> On 2/19/2010 7:56 AM, Jaswinder Singh Rajput wrote:
>>
>> Hello George,
>>
>> On Sun, Jan 31, 2010 at 3:38 AM, George Joseph
>> <george.joseph@fairview5.com> =A0wrote:
>>
>>>
>>> All items incorporated. =A0Updated patch to follow.
>>>
>>>
>>
>> If you need any kind of help, please let me know. I am ready to test
>> and debug the patch.
>>
>
> I posted the updated patch to the list on 1/30.
> http://lists.lm-sensors.org/pipermail/lm-sensors/2010-January/027739.html
>
> Give it a try and let me know how it works. =A0I've got it running on the
> Intel XBX2, BT2, and DP45SG boards all on one version or another of 2.6.3=
3.
>

I tested this patch on Intel WX58BP with Core i7, so far it seems
good, I am doing further investigations regarding temp1, temp5, temp6,
temp7 and temp8.

Can we make above temp more readable.

[jaswinder@i7 ~]$ sensors
coretemp-isa-0000
Adapter: ISA adapter
Core 0:      +40.0=B0C  (high =3D +80.0=B0C, crit =3D +100.0=B0C)

coretemp-isa-0001
Adapter: ISA adapter
Core 1:      +38.0=B0C  (high =3D +80.0=B0C, crit =3D +100.0=B0C)

coretemp-isa-0002
Adapter: ISA adapter
Core 2:      +43.0=B0C  (high =3D +80.0=B0C, crit =3D +100.0=B0C)

coretemp-isa-0003
Adapter: ISA adapter
Core 3:      +36.0=B0C  (high =3D +80.0=B0C, crit =3D +100.0=B0C)

coretemp-isa-0004
Adapter: ISA adapter
Core 4:      +41.0=B0C  (high =3D +80.0=B0C, crit =3D +100.0=B0C)

coretemp-isa-0005
Adapter: ISA adapter
Core 5:      +38.0=B0C  (high =3D +80.0=B0C, crit =3D +100.0=B0C)

coretemp-isa-0006
Adapter: ISA adapter
Core 6:      +43.0=B0C  (high =3D +80.0=B0C, crit =3D +100.0=B0C)

coretemp-isa-0007
Adapter: ISA adapter
Core 7:      +36.0=B0C  (high =3D +80.0=B0C, crit =3D +100.0=B0C)

asc7621a-i2c-0-2e
Adapter: SMBus I801 adapter at 2000
in0:         +1.08 V  (min =3D  +0.00 V, max =3D  +3.31 V)
in1:         +0.92 V  (min =3D  +0.00 V, max =3D  +2.99 V)
in2:         +3.19 V  (min =3D  +0.00 V, max =3D  +4.36 V)
in3:         +4.99 V  (min =3D  +0.00 V, max =3D  +6.61 V)
in4:        +12.00 V  (min =3D  +0.00 V, max =3D +15.94 V)
fan1:        947 RPM  (min =3D    0 RPM)
fan2:       2425 RPM  (min =3D    0 RPM)
fan3:          0 RPM  (min =3D    0 RPM)
fan4:        625 RPM  (min =3D    0 RPM)
temp1:       -57.8=B0C  (low  =3D -127.0=B0C, high =3D  +0.0=B0C)
                      (crit =3D -17.0=B0C)
temp2:       +35.5=B0C  (low  =3D -127.0=B0C, high =3D +127.0=B0C)
                      (crit =3D +65.0=B0C)
temp3:       +42.0=B0C  (low  =3D -127.0=B0C, high =3D +127.0=B0C)
                      (crit =3D +65.0=B0C)
temp4:       +52.0=B0C  (low  =3D -127.0=B0C, high =3D +127.0=B0C)
                      (crit =3D +103.0=B0C)
temp5:       -58.0=B0C
temp6:       -84.5=B0C
temp7:       +96.2=B0C
temp8:      +118.5=B0C

[jaswinder@i7 ~]$

Thanks,
--
Jaswinder Singh

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
