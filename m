From: Minkyu Kang <promsoft@gmail.com>
Date: Mon, 29 Jun 2009 10:47:26 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: add GP2A002 proximity/ambient sensor
Message-Id: <1f3430fb0906290347r92201acpb35087c55049d8c5@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4A448926.1030701@samsung.com>
	 <20090626113059.4c0c2fb3@hyperion.delvare>
In-Reply-To: <20090626113059.4c0c2fb3@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Jean Delvare <khali@linux-fr.org>
Cc: Minkyu Kang <mk7.kang@samsung.com>, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, lm-sensors@lm-sensors.org, suchang.woo@samsung.com, kyungmin.park@samsung.com

Hi Jean,

2009/6/26 Jean Delvare <khali@linux-fr.org>:
> On Fri, 26 Jun 2009 17:39:02 +0900, Minkyu Kang wrote:
>> The GP2A002 is a I2C interfaced Sensor for Proximity/Ambient
>> This patch adds support the GP2A002 sensor
>>
>> Signed-off-by: Minkyu Kang <mk7.kang@samsung.com>
>> Signed-off-by: Suchang Woo <suchang.woo@samsung.com>
>> ---
>> =A0drivers/hwmon/Kconfig =A0 =A0| =A0 =A07 +
>> =A0drivers/hwmon/Makefile =A0 | =A0 =A01 +
>> =A0drivers/hwmon/gp2ap002.c | =A0471 +++++++++++++++++++++++++++++++++++=
+++++++++++
>> =A0include/linux/gp2ap002.h | =A0 21 ++
>> =A04 files changed, 500 insertions(+), 0 deletions(-)
>> =A0create mode 100644 drivers/hwmon/gp2ap002.c
>> =A0create mode 100644 include/linux/gp2ap002.h
>>
>> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
>> index 2d50166..cc4e200 100644
>> --- a/drivers/hwmon/Kconfig
>> +++ b/drivers/hwmon/Kconfig
>> @@ -1017,6 +1017,13 @@ config SENSORS_APPLESMC
>> =A0 =A0 =A0 =A0 Say Y here if you have an applicable laptop and want to =
experience
>> =A0 =A0 =A0 =A0 the awesome power of applesmc.
>>
>> +config SENSORS_GP2AP002
>> + =A0 =A0 tristate "GP2AP002 series Proximity/Ambient Sensor"
>> + =A0 =A0 depends on HWMON && I2C
>> + =A0 =A0 help
>> + =A0 =A0 =A0 This driver provides support for Proximity/Ambient Sensor.
>> +
>
> This doesn't have anything to do with hardware monitoring, so this
> doesn't belong to drivers/hwmon.
>

Can you please explain about belong to hardware monitoring?
did i missing something?

many thanks :)

--=20
from. prom.
www.promsoft.net

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
