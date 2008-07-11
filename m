From: Wolfgang Grandegger <wg@grandegger.com>
Date: Fri, 11 Jul 2008 12:40:58 +0000
Subject: Re: [lm-sensors] [PATCH] Support for DS75 thermal sensor
Message-Id: <487754DA.1060207@grandegger.com>
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

I have some general question on I2C device probing. Our board does have=20
two I2C buses. On the first on, there is an RTC at addr 0x32 and a DS75=20
at 0x4c. Both are defined in the Flattened Device Tree and therefore=20
i2c_register_board_info() will be called for them. On the second bus,=20
there are other I2C devices. Nevertheless, probing for RTC and DS75 at=20
addr 0x32 and 0x4c will be performed also on that bus. Is this the=20
normal/intended behavior? Can such probing be suppressed?

Thanks.

Wolfgang.



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
