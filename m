From: Minkyu Kang <promsoft@gmail.com>
Date: Sun, 28 Jun 2009 23:49:10 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: add GP2A002 proximity/ambient sensor
Message-Id: <1f3430fb0906281649i1e4accdbh26efadc3f565a4e4@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4A448926.1030701@samsung.com>
	 <5d5443650906260322n3c4f5f79r3290ebce2e331234@mail.gmail.com>
In-Reply-To: <5d5443650906260322n3c4f5f79r3290ebce2e331234@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Trilok Soni <soni.trilok@gmail.com>
Cc: Minkyu Kang <mk7.kang@samsung.com>, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, lm-sensors@lm-sensors.org, suchang.woo@samsung.com, kyungmin.park@samsung.com, linux-input@vger.kernel.org, Jean Delvare <khali@linux-fr.org>

Hi Trilok,

2009/6/26 Trilok Soni <soni.trilok@gmail.com>:
> Hi Minkyu,
>
> Adding linux-input ML, as driver is using linux input subsystem.
>
> On Fri, Jun 26, 2009 at 2:09 PM, Minkyu Kang<mk7.kang@samsung.com> wrote:
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

Thanks for review and I'll make new version as you said : )

--=20
from. prom.
www.promsoft.net

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
