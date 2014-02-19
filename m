From: ianp <braveheart_leo@yahoo.com>
Date: Wed, 19 Feb 2014 17:51:14 +0000
Subject: Re: [lm-sensors] Sensors configuration for ASRock G41C-GS
Message-Id: <1392832274.15316.YahooMailNeo@web160506.mail.bf1.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1392823661.17478.YahooMailNeo@web160502.mail.bf1.yahoo.com>
In-Reply-To: <1392823661.17478.YahooMailNeo@web160502.mail.bf1.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

> On Thursday, February 20, 2014 1:01 AM, Jean Delvare <jdelvare@suse.de> w=
rote:

>
>>  =A0=A0 ### Set in0 according to CPU nominal voltage.
>>  =A0=A0 ### Set min and max values according to preference.
>>=20
>>  =A0=A0 set in0_min 1.2 * 0.95
>>  =A0=A0 set in0_max 1.2 * 1.05
>=20
> What (family of) CPU is it? Typically modern CPUs have a range of
> supported voltages and the voltage changes dynamically depending on
> load. So you should use the lowest value to set in0_min and the highest
> value to set in0_max.
>=20

It's an Intel Core 2 Duo E8400 (family 6, model 23; CPUID 0x10676). You are=
 correct about the CPU min and max voltages, which I have overlooked. Intel=
's Ark provides just that: http://ark.intel.com/products/33910/Intel-Core2-=
Duo-Processor-E8400-6M-Cache-3_00-GHz-1333-MHz-FSB?q=3De8400

set in0_min 0.850
set in0_max 1.362

>>  =A0=A0 set in5_min=A0=A0 5 * 0.95
>>  =A0=A0 set in5_max=A0=A0 5 * 1.05
>>  =A0=A0 set in6_min=A0 12 * 0.95
>>  =A0=A0 set in6_max=A0 12 * 1.05
>>=20
>>  ### Temperatures
>>=20
>>  =A0=A0 ### Ignore temp3 until properly identified.
>>=20
>>  =A0=A0 label=A0 temp1=A0 "N/B Temp"
>>  =A0=A0 label=A0 temp2=A0 "CPU Temp"
>>  =A0=A0 ignore temp3
>=20
> I do not recommend ignoring unidentified temperatures, they are still
> useful as long as they are real (which seems to be the case here.)
>=20

hwmonitor labels it as AUXTIN. It's value resides between 45 C - 46 C, even=
 from a cold boot. I guess that value seems rational so I will leave it 'as=
 is' per your recommendation.

>=20
> Initial version of the file is in the wiki now:
> http://www.lm-sensors.org/wiki/Configurations/ASRock/G41C-GS
>=20
> Thanks for your contribution.
>=20

You're welcome. Glad I could contribute something back.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
