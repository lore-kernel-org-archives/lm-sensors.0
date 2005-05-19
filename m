From: kmalkki@cc.hut.fi (=?ISO-8859-1?Q?Ky=F6sti_M=E4lkki?=)
Date: Thu, 19 May 2005 06:23:45 +0000
Subject: i2c/kernel i2c.h i2c-velleman.c i2c-rpx.c i2c-proc.c i2c-pport.c
Message-Id: <Pine.OSF.4.50.0301141302360.11865-100000@kosh.hut.fi>
List-Id: <lm-sensors.vger.kernel.org>
References: <3E23647B.2070805@paradyne.com>
In-Reply-To: <3E23647B.2070805@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 13 Jan 2003, Mark Studebaker wrote:

> uncommenting 8xx and rpx in kernel/Module.mk causes compile errors for me
> (non-8xx kernel)

Same here. I was hoping one who fixes mkpatch to run cleanly over 2.5
would know how to fix this too. Also pcf-epp and elektro will not
compile for me.

> Also, for my info, why is 2.4.9 and not 2.4.0 the minimum kernel now?

Removed llseek for /dev.

-- 
  Ky?sti M?lkki
  kmalkki@cc.hut.fi
