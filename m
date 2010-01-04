From: Gabriel C <nix.or.die@googlemail.com>
Date: Mon, 04 Jan 2010 15:07:08 +0000
Subject: Re: [lm-sensors] Status/support for Linux HECI from Intel? (for
Message-Id: <1820d69d1001040707w69dc5351k3daa035d32dd108a@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <alpine.DEB.1.10.0812300700410.11356@p34.internal.lan>
	 <1231356111.6648.2.camel@maxim-laptop> <49937CDF.10307@frugalware.org>
	 <alpine.DEB.1.10.0902121236120.19381@p34.internal.lan>
	 <1820d69d1001040551k26cfd925q4ada6b226740ac30@mail.gmail.com>
	 <alpine.DEB.2.00.1001040851490.29475@p34.internal.lan>
	 <1820d69d1001040609j6c0b169w38694c33af3fa686@mail.gmail.com>
	 <alpine.DEB.2.00.1001040921000.29475@p34.internal.lan>
	 <1820d69d1001040643h5e2f383bo7e077cbc2d2af554@mail.gmail.com>
	 <alpine.DEB.2.00.1001040954150.29475@p34.internal.lan>
In-Reply-To: <alpine.DEB.2.00.1001040954150.29475@p34.internal.lan>
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
>> 2010/1/4 Justin Piszcz <jpiszcz@lucidpixels.com>:
>>
>> Anyway It seems like ICH8* has some different output .. can't tell yet
>> without docs =3D)
>>
>> Please open heci-qst-linux.c and find :
>>
>>
>> const char * const temp_names[THERM_SENSOR_COUNT] =3D {
>> ...
>>
>> Change to look like this :
>>
>>
>> const char * const temp_names[THERM_SENSOR_COUNT] =3D {
>> =A0 =A0 =A0 =A0"CPU =A0Temp",
>> =A0 =A0 =A0 =A0"MB1 =A0Temp",
>> =A0 =A0 =A0 =A0 NULL,
>> =A0 =A0 =A0 =A0"MB2 =A0Temp",
>> =A0 =A0 =A0 =A0"ICH =A0Temp",
>> =A0 =A0 =A0 =A0"MCH =A0Temp",
>> =A0 =A0 =A0 =A0NULL,
>> =A0 =A0 =A0 =A0NULL,
>> =A0 =A0 =A0 =A0NULL,
>> =A0 =A0 =A0 =A0NULL,
>> =A0 =A0 =A0 =A0NULL,
>> =A0 =A0 =A0 =A0NULL,
>> };
>
> Done:
>
> # ./heci-qst-linux CPU Temp: =A0 =A0 =A0 34.37 =A0 =B0C
> MB1 Temp: =A0 =A0 =A0 37.75 =A0 =B0C
> MB2 Temp: =A0 =A0 =A0 34.89 =A0 =B0C
> ICH Temp: =A0 =A0 =A0 65.59 =A0 =B0C
> MCH Temp: =A0 =A0 =A0 46.25 =A0 =B0C
> CPU =A0Fan: =A0 =A0 =A0 840 =A0 =A0 RPM
> INL =A0Fan: =A0 =A0 =A0 1398 =A0 =A0RPM
> OUTL Fan: =A0 =A0 =A0 839 =A0 =A0 RPM
> AUX =A0Fan: =A0 =A0 =A0 2607 =A0 =A0RPM
> +12 =A0Volts: =A0 =A0 12.040 =A0V
> +5 =A0 Volts: =A0 =A0 4.954 =A0 V
> +3.3 Volts: =A0 =A0 3.247 =A0 V
> MCH =A0Vccp: =A0 =A0 =A01.258 =A0 V
> CPU1 Vccp: =A0 =A0 =A01.165 =A0 V
>


Ok that looks now right for your HW.

>> Also can you post a lspci -nn please :)
>
> # lspci -nn
> 00:00.0 Host bridge [0600]: Intel Corporation 82P965/G965 Memory Controll=
er
> Hub [8086:29a0] (rev 02)
> 00:01.0 PCI bridge [0604]: Intel Corporation 82P965/G965 PCI Express Root
> Port [8086:29a1] (rev 02)
> 00:02.0 VGA compatible controller [0300]: Intel Corporation 82G965
> Integrated Graphics Controller [8086:29a2] (rev 02)
> 00:03.0 Communication controller [0780]: Intel Corporation 82P965/G965 HE=
CI
> Controller [8086:29a4] (rev 02)
> 00:19.0 Ethernet controller [0200]: Intel Corporation 82566DC Gigabit
> Network Connection [8086:104b] (rev 02)
> 00:1a.0 USB Controller [0c03]: Intel Corporation 82801H (ICH8 Family) USB
> UHCI Controller #4 [8086:2834] (rev 02)
> 00:1a.1 USB Controller [0c03]: Intel Corporation 82801H (ICH8 Family) USB
> UHCI Controller #5 [8086:2835] (rev 02)
> 00:1a.7 USB Controller [0c03]: Intel Corporation 82801H (ICH8 Family) USB2
> EHCI Controller #2 [8086:283a] (rev 02)
> 00:1b.0 Audio device [0403]: Intel Corporation 82801H (ICH8 Family) HD Au=
dio
> Controller [8086:284b] (rev 02)
> 00:1c.0 PCI bridge [0604]: Intel Corporation 82801H (ICH8 Family) PCI
> Express Port 1 [8086:283f] (rev 02)
> 00:1c.1 PCI bridge [0604]: Intel Corporation 82801H (ICH8 Family) PCI
> Express Port 2 [8086:2841] (rev 02)
> 00:1c.2 PCI bridge [0604]: Intel Corporation 82801H (ICH8 Family) PCI
> Express Port 3 [8086:2843] (rev 02)
> 00:1c.3 PCI bridge [0604]: Intel Corporation 82801H (ICH8 Family) PCI
> Express Port 4 [8086:2845] (rev 02)
> 00:1c.4 PCI bridge [0604]: Intel Corporation 82801H (ICH8 Family) PCI
> Express Port 5 [8086:2847] (rev 02)
> 00:1d.0 USB Controller [0c03]: Intel Corporation 82801H (ICH8 Family) USB
> UHCI Controller #1 [8086:2830] (rev 02)
> 00:1d.1 USB Controller [0c03]: Intel Corporation 82801H (ICH8 Family) USB
> UHCI Controller #2 [8086:2831] (rev 02)
> 00:1d.2 USB Controller [0c03]: Intel Corporation 82801H (ICH8 Family) USB
> UHCI Controller #3 [8086:2832] (rev 02)
> 00:1d.7 USB Controller [0c03]: Intel Corporation 82801H (ICH8 Family) USB2
> EHCI Controller #1 [8086:2836] (rev 02)
> 00:1e.0 PCI bridge [0604]: Intel Corporation 82801 PCI Bridge [8086:244e]
> (rev f2)
> 00:1f.0 ISA bridge [0601]: Intel Corporation 82801HH (ICH8DH) LPC Interfa=
ce
> Controller [8086:2812] (rev 02)
> 00:1f.2 SATA controller [0106]: Intel Corporation 82801HR/HO/HH
> (ICH8R/DO/DH) 6 port SATA AHCI Controller [8086:2821] (rev 02)
> 00:1f.3 SMBus [0c05]: Intel Corporation 82801H (ICH8 Family) SMBus
> Controller [8086:283e] (rev 02)
> 01:00.0 SCSI storage controller [0100]: Marvell Technology Group Ltd.
> 88SX7042 PCI-e 4-port SATA-II [11ab:7042] (rev 02)
> 03:00.0 IDE interface [0101]: Marvell Technology Group Ltd. 88SE6101
> single-port PATA133 interface [11ab:6101] (rev b1)
> 04:00.0 RAID bus controller [0104]: Silicon Image, Inc. SiI 3132 Serial A=
TA
> Raid II Controller [1095:3132] (rev 01)
> 05:00.0 RAID bus controller [0104]: Silicon Image, Inc. SiI 3132 Serial A=
TA
> Raid II Controller [1095:3132] (rev 01)
> 06:00.0 RAID bus controller [0104]: Silicon Image, Inc. SiI 3132 Serial A=
TA
> Raid II Controller [1095:3132] (rev 01)
> 07:00.0 Ethernet controller [0200]: Intel Corporation 82540EM Gigabit
> Ethernet Controller [8086:100e] (rev 02)
> 07:01.0 Ethernet controller [0200]: Intel Corporation 82541GI Gigabit
> Ethernet Controller [8086:1076]
> 07:02.0 Mass storage controller [0180]: Promise Technology, Inc. PDC40718
> (SATA 300 TX4) [105a:3d17] (rev 02)
> 07:03.0 FireWire (IEEE 1394) [0c00]: Texas Instruments TSB43AB22/A
> IEEE-1394a-2000 Controller (PHY/Link) [104c:8023]
>

Thx :)

> Justin.
>

Gabriel

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
