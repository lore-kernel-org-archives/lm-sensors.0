From: Justin Piszcz <jpiszcz@lucidpixels.com>
Date: Mon, 04 Jan 2010 14:22:56 +0000
Subject: Re: [lm-sensors] Status/support for Linux HECI from Intel? (for
Message-Id: <alpine.DEB.2.00.1001040921000.29475@p34.internal.lan>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="-1463747160-1264034288-1262614976=:29475"
List-Id: <lm-sensors.vger.kernel.org>
References: <alpine.DEB.1.10.0812300700410.11356@p34.internal.lan>  <4964DB3E.6080908@intel.com>  <alpine.DEB.1.10.0901071142200.29147@p34.internal.lan>  <1231356111.6648.2.camel@maxim-laptop> <49937CDF.10307@frugalware.org>  <alpine.DEB.1.10.0902121236120.19381@p34.internal.lan>
  <1820d69d1001040551k26cfd925q4ada6b226740ac30@mail.gmail.com>  <alpine.DEB.2.00.1001040851490.29475@p34.internal.lan> <1820d69d1001040609j6c0b169w38694c33af3fa686@mail.gmail.com>
In-Reply-To: <1820d69d1001040609j6c0b169w38694c33af3fa686@mail.gmail.com>
To: Gabriel C <nix.or.die@googlemail.com>
Cc: Gabriel C <crazy@frugalware.org>, Maxim Levitsky <maximlevitsky@gmail.com>, Dan Williams <dan.j.williams@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, Andriy Gapon <avg@icyb.net.ua>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463747160-1264034288-1262614976=:29475
Content-Type: TEXT/PLAIN; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE



On Mon, 4 Jan 2010, Gabriel C wrote:

>>>
>>> Today I'm out from hospital so I've decided to quick hack this tool
>>> and make it work on Linux.
>>>
>>> Here the output from my DQ45CB mobo:
>>>
>>> crazy@thor:~/INTEL/QST/Li$ sudo ./heci-qst
>>> CPU =A0Temp: =A0 =A0 =A056.00 =A0 =B0C
>>> MB =A0 Temp: =A0 =A0 =A031.14 =A0 =B0C
>>> ICH =A0Temp: =A0 =A0 =A067.37 =A0 =B0C
>>> MCH =A0Temp: =A0 =A0 =A066.00 =A0 =B0C
>>> CPU =A0Fan: =A0 =A0 =A0 1080 =A0 =A0RPM
>>> INL =A0Fan: =A0 =A0 =A0 1202 =A0 =A0RPM
>>> OUTL Fan: =A0 =A0 =A0 288 =A0 =A0 RPM
>>> +12 =A0Volts: =A0 =A0 11.965 =A0V
>>> +5 =A0 Volts: =A0 =A0 5.021 =A0 V
>>> +3.3 Volts: =A0 =A0 3.316 =A0 V
>>> MCH =A0Vccp: =A0 =A0 =A01.122 =A0 V
>>> CPU1 Vccp: =A0 =A0 =A01.125 =A0 V
>>>
>>> Justin I know is not based on released SDK of Intel but maybe you
>>> still want to do some tests ?:)

DMI Info:

Handle 0x0004, DMI type 0, 24 bytes
BIOS Information
         Vendor: Intel Corp.
         Version: MQ96510J.86A.1754.2008.1117.0002

Handle 0x0006, DMI type 2, 20 bytes
Base Board Information
         Manufacturer: Intel Corporation
         Product Name: DG965WH
         Version: AAD41692-304

Cool, first time I have ever seen this =3D)

# ./heci-qst-linux=20
CPU  Temp:      36.55   =B0C
MB   Temp:      38.75   =B0C
MCH  Temp:      33.89   =B0C
04:     64.90   =B0C
05:     46.25   =B0C
CPU  Fan:       836     RPM
INL  Fan:       1362    RPM
OUTL Fan:       836     RPM
AUX  Fan:       2600    RPM
+12  Volts:     12.029  V
+5   Volts:     4.949   V
+3.3 Volts:     3.247   V
MCH  Vccp:      1.260   V
CPU1 Vccp:      1.180   V

It appears to work.

Thanks,

Justin.

---1463747160-1264034288-1262614976=:29475
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
---1463747160-1264034288-1262614976=:29475--
