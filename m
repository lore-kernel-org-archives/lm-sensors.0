From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 26 Oct 2009 09:16:53 +0000
Subject: Re: [lm-sensors] 2.6.32-rc5-git3 -- WARNING: drivers/hwmon/lm90:
Message-Id: <20091026101653.069fc078@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <a44ae5cd0910251632i71ebdebcpeb00e7d4c8f1ae3d@mail.gmail.com>
In-Reply-To: <a44ae5cd0910251632i71ebdebcpeb00e7d4c8f1ae3d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Miles Lane <miles.lane@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, lm-sensors@lm-sensors.org

Hi Miles,

On Sun, 25 Oct 2009 19:32:44 -0400, Miles Lane wrote:
> WARNING: drivers/hwmon/lm90: 'pv_lock_ops' exported twice. Previous
> export was in vmlinux
> drivers/hwmon/lm93.o: Invalid argument
> make[1]: *** [__modpost] Error 1

Your config builds just fine here with gcc 4.3.2 and binutils 2.19. The
above warning doesn't make any sense to me, the lm90 driver is
definitely not exporting pv_lock_ops. I suspect either source tree
corruption or build chain problems. Either way, this isn't something I
can help you with, sorry.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
