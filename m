From: Gabriel C <nix.or.die@googlemail.com>
Date: Mon, 04 Jan 2010 14:43:55 +0000
Subject: Re: [lm-sensors] Status/support for Linux HECI from Intel? (for
Message-Id: <1820d69d1001040643h5e2f383bo7e077cbc2d2af554@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <alpine.DEB.1.10.0812300700410.11356@p34.internal.lan>
	 <4964DB3E.6080908@intel.com>
	 <alpine.DEB.1.10.0901071142200.29147@p34.internal.lan>
	 <1231356111.6648.2.camel@maxim-laptop> <49937CDF.10307@frugalware.org>
	 <alpine.DEB.1.10.0902121236120.19381@p34.internal.lan>
	 <1820d69d1001040551k26cfd925q4ada6b226740ac30@mail.gmail.com>
	 <alpine.DEB.2.00.1001040851490.29475@p34.internal.lan>
	 <1820d69d1001040609j6c0b169w38694c33af3fa686@mail.gmail.com>
	 <alpine.DEB.2.00.1001040921000.29475@p34.internal.lan>
In-Reply-To: <alpine.DEB.2.00.1001040921000.29475@p34.internal.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Cc: Gabriel C <crazy@frugalware.org>, Maxim Levitsky <maximlevitsky@gmail.com>, Dan Williams <dan.j.williams@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, Andriy Gapon <avg@icyb.net.ua>

2010/1/4 Justin Piszcz <jpiszcz@lucidpixels.com>:
>
>
> On Mon, 4 Jan 2010, Gabriel C wrote:
>
>>>>
>>>> Today I'm out from hospital so I've decided to quick hack this tool
>>>> and make it work on Linux.
>>>>
>>>> Here the output from my DQ45CB mobo:
>>>>
>>>> crazy@thor:~/INTEL/QST/Li$ sudo ./heci-qst
>>>> CPU =A0Temp: =A0 =A0 =A056.00 =A0 =B0C
>>>> MB =A0 Temp: =A0 =A0 =A031.14 =A0 =B0C
>>>> ICH =A0Temp: =A0 =A0 =A067.37 =A0 =B0C
>>>> MCH =A0Temp: =A0 =A0 =A066.00 =A0 =B0C
>>>> CPU =A0Fan: =A0 =A0 =A0 1080 =A0 =A0RPM
>>>> INL =A0Fan: =A0 =A0 =A0 1202 =A0 =A0RPM
>>>> OUTL Fan: =A0 =A0 =A0 288 =A0 =A0 RPM
>>>> +12 =A0Volts: =A0 =A0 11.965 =A0V
>>>> +5 =A0 Volts: =A0 =A0 5.021 =A0 V
>>>> +3.3 Volts: =A0 =A0 3.316 =A0 V
>>>> MCH =A0Vccp: =A0 =A0 =A01.122 =A0 V
>>>> CPU1 Vccp: =A0 =A0 =A01.125 =A0 V
>>>>
>>>> Justin I know is not based on released SDK of Intel but maybe you
>>>> still want to do some tests ?:)
>
> DMI Info:
>
> Handle 0x0004, DMI type 0, 24 bytes
> BIOS Information
> =A0 =A0 =A0 =A0Vendor: Intel Corp.
> =A0 =A0 =A0 =A0Version: MQ96510J.86A.1754.2008.1117.0002
>
> Handle 0x0006, DMI type 2, 20 bytes
> Base Board Information
> =A0 =A0 =A0 =A0Manufacturer: Intel Corporation
> =A0 =A0 =A0 =A0Product Name: DG965WH
> =A0 =A0 =A0 =A0Version: AAD41692-304
>
> Cool, first time I have ever seen this =3D)
>
> # ./heci-qst-linux CPU =A0Temp: =A0 =A0 =A036.55 =A0 =B0C
> MB =A0 Temp: =A0 =A0 =A038.75 =A0 =B0C
> MCH =A0Temp: =A0 =A0 =A033.89 =A0 =B0C
> 04: =A0 =A0 64.90 =A0 =B0C
> 05: =A0 =A0 46.25 =A0 =B0C
> CPU =A0Fan: =A0 =A0 =A0 836 =A0 =A0 RPM
> INL =A0Fan: =A0 =A0 =A0 1362 =A0 =A0RPM
> OUTL Fan: =A0 =A0 =A0 836 =A0 =A0 RPM
> AUX =A0Fan: =A0 =A0 =A0 2600 =A0 =A0RPM
> +12 =A0Volts: =A0 =A0 12.029 =A0V
> +5 =A0 Volts: =A0 =A0 4.949 =A0 V
> +3.3 Volts: =A0 =A0 3.247 =A0 V
> MCH =A0Vccp: =A0 =A0 =A01.260 =A0 V
> CPU1 Vccp: =A0 =A0 =A01.180 =A0 V
>
> It appears to work.
>
> Thanks,

NP :)

Anyway It seems like ICH8* has some different output .. can't tell yet
without docs =3D)

Please open heci-qst-linux.c and find :


const char * const temp_names[THERM_SENSOR_COUNT] =3D {
...

Change to look like this :


const char * const temp_names[THERM_SENSOR_COUNT] =3D {
=A0 =A0 =A0 =A0"CPU =A0Temp",
=A0 =A0 =A0 =A0"MB1 =A0Temp",
=A0 =A0 =A0 =A0 NULL,
=A0 =A0 =A0 =A0"MB2 =A0Temp",
=A0 =A0 =A0 =A0"ICH =A0Temp",
=A0 =A0 =A0 =A0"MCH =A0Temp",
=A0 =A0 =A0 =A0NULL,
=A0 =A0 =A0 =A0NULL,
=A0 =A0 =A0 =A0NULL,
=A0 =A0 =A0 =A0NULL,
=A0 =A0 =A0 =A0NULL,
=A0 =A0 =A0 =A0NULL,
};


Also can you post a lspci -nn please :)

>
> Justin.
>


Gabriel

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
