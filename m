From: Peter Mahlknecht <mali100@gmx.net>
Date: Fri, 31 Oct 2008 22:20:58 +0000
Subject: Re: [lm-sensors] [Em28xx] ACPI reads wrong temperature after
Message-Id: <490B84CA.1080208@gmx.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <d9def9db0810311515n166f7ff2t6362d690a883de70@mail.gmail.com>
In-Reply-To: <d9def9db0810311515n166f7ff2t6362d690a883de70@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org



Markus Rechberger schrieb:
> Hi Peter,
>
> On Fri, Oct 31, 2008 at 11:08 PM, Peter Mahlknecht <mali100@gmx.net> wrot=
e:
>  =20
>> Hi,
>> I have here a strange problem:
>> after loading the em28xx_cx25843 module in
>> /proc/acpi/thermal_zone/THRM/temperature a wrong temperature (65535 C) w=
hich
>> forces a shutdown on my notebook ("Critical temperature reached (65535 C=
).
>> Shutting down."). Same thing happens if I load the lm90 module (hwmon dr=
iver
>> for the temperaturesensor used by lm-sensors). Both modules depend on
>> i2c_core, so maybe its an I=B2C bug. Any suggestions?
>>
>>    =20
>
> I think the lmsensors mailinglist might be better for this! Jean
> Delvare might now more about it.
> added the lm-sensors ML.
>
> also provide which kernel version you use.
>
> Markus
>
>  =20
Thanks for the fast reply,
I am using Debian Lenny (2.6.26-1-686) on my notebook (Samsung P40 with=20
the latest Bios 09HK), but had the same problem also with the=20
2.6.18-6-686 (Lenny) and with Ubuntu Hardy Heron (think the kernel was=20
2.6.24).

Peter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
