From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sun, 18 Mar 2012 12:14:07 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon/sch56xx: Add support for the integrated watchdog
Message-Id: <20120318121407.GA26167@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1331977229-1370-1-git-send-email-hdegoede@redhat.com>
 <1331977229-1370-2-git-send-email-hdegoede@redhat.com>
 <20120317185850.GA23351@ericsson.com>
 <4F65CF2C.4000205@redhat.com>
In-Reply-To: <4F65CF2C.4000205@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Hans de Goede <hdegoede@redhat.com>
Cc: LM Sensors <lm-sensors@lm-sensors.org>, Thilo Cestonaro <thilo.cestonaro@ts.fujitsu.com>, "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>

Hi Hans,

On Sun, Mar 18, 2012 at 08:03:56AM -0400, Hans de Goede wrote:
[ ... ]
> >> +
> >> +       data = kzalloc(sizeof(struct sch56xx_watchdog_data), GFP_KERNEL);
> >> +       if (!data)
> >> +               return NULL;
> >> +

One more:

You don't include slab.h, which in some configurations results in:

/tmp/linux.15278/drivers/hwmon/sch56xx-common.c: In function 'sch56xx_watchdog_release_resources':
/tmp/linux.15278/drivers/hwmon/sch56xx-common.c:278: error: implicit declaration of function 'kfree'
/tmp/linux.15278/drivers/hwmon/sch56xx-common.c: In function 'sch56xx_watchdog_register':
/tmp/linux.15278/drivers/hwmon/sch56xx-common.c:644: error: implicit declaration of function 'kzalloc'
/tmp/linux.15278/drivers/hwmon/sch56xx-common.c:644: warning: assignment makes pointer from integer without a cast
make[3]: *** [drivers/hwmon/sch56xx-common.o] Error 1
make[3]: *** Waiting for unfinished jobs....

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
