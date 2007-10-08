From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Mon, 08 Oct 2007 17:21:46 +0000
Subject: Re: [lm-sensors] Unknown chip on Dell Latitude D630
Message-Id: <470A672A.40808@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <200710071631.00273.arnestaecker@web.de>
In-Reply-To: <200710071631.00273.arnestaecker@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Juerg Haefliger wrote:
> Hi Arne,
>=20
>=20
> On 10/7/07, Arne St=E4cker <arnestaecker@web.de> wrote:
>> Hi,
>> when I run sensors-detect, I get:
>>
>> ...
>> Some Super I/O chips may also contain sensors. We have to write to
>> standard I/O ports to probe them. This is usually safe.
>> Do you want to scan for Super I/O sensors? (YES/no):
>> Probing for Super-I/O at 0x2e/0x2f
>> Trying family `National Semiconductor'...                   No
>> Trying family `SMSC'...                                     Yes
>> Found unknown chip with ID 0x3201
>> Probing for Super-I/O at 0x4e/0x4f
>> Trying family `National Semiconductor'...                   No
>> Trying family `SMSC'...                                     Yes
>> Found unknown non-standard chip with ID 0x13
>> ...
>=20
> This is an unknown chip. You could try the superiotool
> (http://linuxbios.org/Superiotool) to check if it can find something.
> Other than that, you would have to open your machine and look for a
> chip with the SMSC logo an tell us the chip name. Maybe we can do
> something with that information...
>=20
> ...juerg
>=20

Jumping a bit late into the game (waking up). Dell now a days is a Linux=20
friendly company. We could try asking Matt Domsch from Dell if he can help =

identifyong the part.

I'll send him a mail about this and include Juerg and Arne in the CC. I'll =

leave this off the list to not send Matt's mail address to the list.

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
