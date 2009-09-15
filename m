From: =?UTF-8?B?TWFydGluIE1PS1JFSsWg?= <mmokrejs@ribosome.natur.cuni.cz>
Date: Tue, 15 Sep 2009 16:41:41 +0000
Subject: Re: [lm-sensors] unhide_ICH_SMBus: line 33:
Message-Id: <4AAFC3C5.8020709@ribosome.natur.cuni.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <4A9122E1.7010006@ribosome.natur.cuni.cz>
In-Reply-To: <4A9122E1.7010006@ribosome.natur.cuni.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> On Tue, 15 Sep 2009 17:43:19 +0200, Martin MOKREJ=C5=A0 wrote:
>> $ gzip -dc /proc/config.gz | grep THERMAL
>> CONFIG_ACPI_THERMAL=3Dy
>> CONFIG_THERMAL=3Dy
>> CONFIG_THERMAL_HWMON=3Dy
>> $ gzip -dc /proc/config.gz | grep ATK
>> CONFIG_KEYBOARD_ATKBD=3Dy
>> CONFIG_SENSORS_ATK0110=3Dy
>> $
>>
>> These I have already in the kernel, so I can drop the whole SMbus thing?
>=20
> Yes.

Ooops, are we talking about I2C_I801=3DN, I2C=3DN or SENSORS_DS1621=3DN? ;-)
Actually I had SENSORS_LM90=3DY as it was also proposed by sensors-detect.
That one was also mis-detected?
M.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
