From: zdavatz@ywesee.com (Zeno R.R. Davatz)
Date: Thu, 19 May 2005 06:24:04 +0000
Subject: Ticket 1319 - lm_sensors-2.8.0-cvs linux-2.4.20-smp-i386
Message-Id: <20030710101804.7f036694.zdavatz@ywesee.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030710085158.42e68c95.zdavatz@ywesee.com>
In-Reply-To: <20030710085158.42e68c95.zdavatz@ywesee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 10 Jul 2003 10:10:47 +0200
Jean Delvare <khali@linux-fr.org> wrote:

> Let's see. Please locate *all* "i2c.h" files that are present on your
> system. Either do:
>   dbupdate
>   locate i2c.h
> or:
>   find / -name "i2c.h"

gives me:
/usr/src/l/linux/linux-2.4.20/arch/cris/drivers/i2c.h
/usr/src/l/linux/linux-2.4.20/include/linux/i2c.h
/usr/src/l/linux/linux-2.4.20/include/config/i2c.h
/usr/src/modules/i2c/kernel/i2c.h
/usr/include/linux/i2c.h

Thanks for your Feedback.

Zeno
