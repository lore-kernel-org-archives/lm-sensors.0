From: =?ISO-8859-1?Q?Holger_B=FCrger?= <buerger@teamnet.de>
Date: Thu, 08 Aug 2013 14:59:50 +0000
Subject: [lm-sensors] SOLVED: Re:  Motherboard Fujitsu D-3076-S
Message-Id: <5203B266.5090201@teamnet.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi,

problem solved.
Thank you very much.
I will also report this procedure to FUJITSU support, so they can update
the HOWTOs provided under the following link.

ftp://ftp.ts.fujitsu.com/pub/Mainboard-OEM-Sales/Products/Mainboards/Indust=
rial&ExtendedLifetime/D3071-S_D3076-S/IndustrialTools_D307x-S/Linux_SystemM=
onitoring&Watchdog-Driver/


Regards

Holger B.


Am 08.08.2013 14:32, schrieb Hans de Goede:
> Hi,
>=20
> On 08/08/2013 01:24 PM, Holger B=FCrger wrote:
>> Hi,
>>
>>
>>> Yes you can simply remove the line in question, and the 2 lines remove
>>> it, so remove the following lines:
>>
>> But I have more errors then.
>=20
> Yes, it now passes building sch56xx-common.c, and moves on to another
> file which has other issues.
>=20
>>
>> make -C /lib/modules/2.6.18-348.el5/build M=3D/root/test modules
>>
>>
>> make[1]: Entering directory `/usr/src/kernels/2.6.18-348.12.1.el5-i686'
>>
>>
>>    CC [M]  /root/test/sch56xx-common.o
>>    CC [M]  /root/test/sch5636.o
>> /root/test/sch5636.c: In function =BBshow_in_value=AB:
>> /root/test/sch5636.c:189: Fehler: Implizite Deklaration der Funktion
>> =BBDIV_ROUND_CLOSEST=AB
>=20
> To fix this replace (at line 189):
>=20
>         val =3D DIV_ROUND_CLOSEST(
>                 data->in[attr->index] *
> SCH5636_REG_IN_FACTORS[attr->index],
>                 255);
>=20
> With:
>=20
>     val =3D data->in[attr->index] * SCH5636_REG_IN_FACTORS[attr->index] /
> 255;
>=20
>=20
>> /root/test/sch5636.c: In function =BBsch5636_remove=AB:
>> /root/test/sch5636.c:392: Warnung: =DCbergabe des Arguments 1 von
>> =BBhwmon_device_unregister=AB von inkompatiblem Zeigertyp
>> /root/test/sch5636.c: In function =BBsch5636_probe=AB:
>> /root/test/sch5636.c:505: Warnung: Zuweisung von inkompatiblem Zeigertyp
>=20
> These 2 warnings can be ignored.
>=20
> You likely need to make the same change in sch5627.c
>=20
> Regards,
>=20
> Hans


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
