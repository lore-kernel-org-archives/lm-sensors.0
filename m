From: "Gaston, Jason D" <jason.d.gaston@intel.com>
Date: Fri, 31 Aug 2007 19:26:36 +0000
Subject: Re: [lm-sensors] [PATCH lm_sensors-2.10.4][RESEND] sensors-detect:
Message-Id: <39B20DF628532344BC7A2692CB6AEE0701B5BEEA@orsmsx420.amr.corp.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070831171637.2c343762@hyperion.delvare>
In-Reply-To: <20070831171637.2c343762@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

>-----Original Message-----
>From: Jean Delvare [mailto:khali@linux-fr.org]
>Sent: Friday, August 31, 2007 8:17 AM
>To: Gaston, Jason D
>Cc: LM Sensors
>Subject: Re: [PATCH lm_sensors-2.10.4][RESEND] sensors-detect: patch for
>Intel Tolapai
>
>Hi Jason,
>
>For next time: patches to lm-sensors should be sent to the lm-sensors
>list, not the i2c list.
>
>On Thu, 30 Aug 2007 17:47:51 -0700, Jason Gaston wrote:
>> Resend without wordwrap.
>>
>> This patch adds the Intel Tolapai SMBus Controller DID to the sensors-
>detect
>> script.
>>
>> Signed-off-by: =A0Jason Gaston <jason.d.gaston@intel.com>
>>
>> --- lm_sensors-2.10.4/prog/detect/sensors-detect.orig	2007-08-30
>15:51:39.000000000 -0700
>> +++ lm_sensors-2.10.4/prog/detect/sensors-detect	2007-08-30
>15:53:06.000000000 -0700
>> @@ -166,7 +166,14 @@
>>         procid =3D> "Intel ICH9",
>>         driver =3D> "i2c-i801",
>>         match =3D> qr/^SMBus I801 adapter at [0-9a-f]{4}/,
>> -     },
>> +     },
>> +     {
>> +       vendid =3D> 0x8086,
>> +       devid  =3D> 0x5032,
>> +       procid =3D> "Intel Tolapai",
>> +       driver =3D> "i2c-i801",
>> +       match =3D> qr/^SMBus I801 adapter at [0-9a-f]{4}/,
>> +     },
>>       {
>>         vendid =3D> 0x1106,
>>         devid  =3D> 0x3040,
>
>Applied, thanks.
>
>--
>Jean Delvare


Should we update the MAINTAINERS file in the base kernel to reflect this?

I2C SUBSYSTEM
P:	Jean Delvare
M:	khali@linux-fr.org
L:	i2c@lm-sensors.org
T:	quilt http://khali.linux-fr.org/devel/linux-2.6/jdelvare-i2c/
S:	Maintained

Thanks,

Jason

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
