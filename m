From: mds@mds.gotdns.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:25:52 +0000
Subject: Winbond W83792D driver
Message-Id: <42641192.804@mds.gotdns.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <42461044.3080406@mds.gotdns.com>
In-Reply-To: <42461044.3080406@mds.gotdns.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

checked in.
thanks for the contribution.
mds


Huang0@Winbond.com.tw wrote:
> Dear MDS
>=20
> Quoting MDS
>=20
>>4) a documentation file for doc/chips would be greatly appreciated :)
>=20
>=20
> I finished the doc/chips/w83792d yesterday, please check the attachment,
> If you have time, you may help me to review this document and add some
> supplement into it, Then please help to commit it into CVS.
> I will continue to update this document if need.
>=20
>=20
> Thanks
> Best Regards
>=20
> Chunhao
>=20
>=20
>=20
>=20
>>-----Original Message-----
>>From: Mark Studebaker [mailto:mds@mds.gotdns.com]
>>Sent: 2005=C4=EA4=D4=C216=C8=D5 0:20
>>To: LM Sensors
>>Cc: PI14 HUANG0
>>Subject: Re: Winbond W83792D driver
>>
>>I made the same mistake at first,
>>Khali caught it and on rereading the datasheet I agree.
>>It's the same behavior as the w83781d, other than the power-on default.
>>All 3 bits can be modified.
>>mds
>>
>>
>>Rudolf Marek wrote:
>>
>>>Hi all.
>>>
>>>We just tried and all three bits can be used despite the fact datasheet
>>
>>proposes
>>
>>>on page 37 that bit2 should be 0 and bit6 1
>>>
>>>We tried to write 0x76 and subclients moved to 0x4e and 0x4f.
>>>
>>>Maybe the datasheet should be clearified that values on bit2 and bit6
>>>are power on defaults but all three bits can be altered.
>>>
>>>Regards
>>>
