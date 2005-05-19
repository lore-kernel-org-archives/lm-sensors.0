From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:20 +0000
Subject: [2.6 patch] i2c it87.c: remove an unused function
Message-Id: <5qqD8rRk.1099035252.6524190.khali@gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <20041029001745.GI29142@stusta.de>
References: <20041028222039.GO3207@stusta.de>
In-Reply-To: <20041028222039.GO3207@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: bunk@stusta.de, chrisg@0-in.com, greg@kroah.com
Cc: sensors@Stimpy.netroedge.com, linux-kernel@vger.kernel.org


Hi Adrian & all,

> The patch below removes an unused function from drivers/i2c/chips/it87.c
> (...)
> -static inline void
> -superio_outb(int reg, int val)

For information, this function was most likely there for the case we
would implement the force_addr module parameter for this driver (see the
w83627hf driver in the same directory for an example of that).

That said, I have no objection to the removal of this function. We can
still add it back later if we ever need it.

Thanks,
Jean
