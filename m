From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:58 +0000
Subject: No readings on SuSE 9.1
Message-Id: <20040519194229.3e89a11e.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200405191735.i4JHZI4F004970@ms-smtp-05.tampabay.rr.com>
In-Reply-To: <200405191735.i4JHZI4F004970@ms-smtp-05.tampabay.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> kernel 	2.6.4-52
> i2c	modules from kernel
> lm_sensors 2.8.3 (modules from kernel)  user space tools from 2.8.5

No way. lm_sensors modules have no version in linux 2.6.

> Sensors-detect works and identifies my asb100.  modules load without
> complaint. sensors -s gives no error message.
> 
> When I do sensors or sensors -f, I get the message:
> 
> asb100-i2c-2-2d
> Adapter: SMBus Via Pro adapter at e800
> Algorithm: Unavailable from sysfs
> ERROR: Can't get IN data! (0x0001)
(...)

Suse is lying about the kernel version. Your 2.6.4 kernel is actually a
2.6.5-rcX kernel, so you need lm_sensors 2.8.6 user-space tools (or CVS,
at your option).

-- 
Jean Delvare
http://khali.linux-fr.org/
