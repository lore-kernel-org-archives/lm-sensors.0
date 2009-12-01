From: Ralf Baechle <ralf@linux-mips.org>
Date: Tue, 01 Dec 2009 14:27:10 +0000
Subject: Re: [lm-sensors] [PATCH v6 5/8] Loongson: YeeLoong: add hwmon driver
Message-Id: <20091201142710.GE14064@linux-mips.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <cover.1259664573.git.wuzhangjin@gmail.com>
 <3973cc1fdb6ff2b2e540ed93ae92dac8d7b2a38f.1259664573.git.wuzhangjin@gmail.com>
In-Reply-To: <3973cc1fdb6ff2b2e540ed93ae92dac8d7b2a38f.1259664573.git.wuzhangjin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wu Zhangin <wuzhangjin@gmail.com>
Cc: linux-mips@linux-mips.org, zhangfx@lemote.com, lm-sensors@lm-sensors.org

On Tue, Dec 01, 2009 at 07:09:59PM +0800, Wu Zhangin wrote:

> From: Wu Zhangjin <wuzhangjin@gmail.com>
> 
> This patch adds hwmon driver for managing the temperature of battery,
> cpu and controlling the fan.

And this one should now go to drivers/hwmon and become a platform driver
as well.

  Ralf

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
