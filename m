From: Wolfgang Grandegger <wg@grandegger.com>
Date: Tue, 08 Jul 2008 13:38:14 +0000
Subject: Re: [lm-sensors] [PATCH] Support for DS75 thermal sensor
Message-Id: <48736DC6.1050000@grandegger.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <487331DC.2020601@grandegger.com>
In-Reply-To: <487331DC.2020601@grandegger.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> On Tue, 08 Jul 2008 15:09:32 +0200, Wolfgang Grandegger wrote:
>> Jean Delvare wrote:
>>> On Tue, 08 Jul 2008 11:22:36 +0200, Wolfgang Grandegger wrote:
>>>> The existing driver for the LM75 is unable to identify a compatible DS=
75=20
>>>> device properly. This patch from
>>>>
>>>> http://lists.lm-sensors.org/pipermail/lm-sensors/2007-February/018838.=
html=20
>>>>
>>>> does fix the problem and I wonder why it did not make it into the kern=
el yet.
>>> Because meanwhile the lm75 driver was converted to a new-style
>>> i2c driver, with support for the DS75:
>>>
>>> http://lm-sensors.org/kernel?p=3Dkernel/mhoffman/hwmon-2.6.git;a=3Dcomm=
it;h=EA6db11742de63324f29d1383122657cabe90940
>>>
>>> This will presumably go in kernel 2.6.27-rc1.
>> Ah, thanks for the info. Unfortunately, this new driver does not work=20
>> with the DS75 on our custom board. THe identification fails, because=20
>> it's as in the old lm75.c driver (and not like Alan suggested).
>=20
> There's no "detection" involved for the new-style i2c devices.
> Presumably you are still using the old binding model, not taking
> benefit of the patch at all. Use i2c_register_board_info() to
> instantiate your "ds75" i2c device from you board's platform code, and
> it should work.


OK, I see. For my board I need to add a FDT node to the DTS file and add=20
some binding code like for the RTC. For the lm75, it still works without=20
that.

Wolfgang.



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
