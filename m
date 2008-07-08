From: Wolfgang Grandegger <wg@grandegger.com>
Date: Tue, 08 Jul 2008 13:09:32 +0000
Subject: Re: [lm-sensors] [PATCH] Support for DS75 thermal sensor
Message-Id: <4873670C.6080204@grandegger.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <487331DC.2020601@grandegger.com>
In-Reply-To: <487331DC.2020601@grandegger.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> On Tue, 08 Jul 2008 11:22:36 +0200, Wolfgang Grandegger wrote:
>> The existing driver for the LM75 is unable to identify a compatible DS75=
=20
>> device properly. This patch from
>>
>> http://lists.lm-sensors.org/pipermail/lm-sensors/2007-February/018838.ht=
ml=20
>>
>> does fix the problem and I wonder why it did not make it into the kernel=
 yet.
>=20
> Because meanwhile the lm75 driver was converted to a new-style
> i2c driver, with support for the DS75:
>=20
> http://lm-sensors.org/kernel?p=3Dkernel/mhoffman/hwmon-2.6.git;a=3Dcommit=
;h=EA6db11742de63324f29d1383122657cabe90940
>=20
> This will presumably go in kernel 2.6.27-rc1.

Ah, thanks for the info. Unfortunately, this new driver does not work=20
with the DS75 on our custom board. THe identification fails, because=20
it's as in the old lm75.c driver (and not like Alan suggested).

Wolfgang.



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
