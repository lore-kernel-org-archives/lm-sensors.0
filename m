From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:57 +0000
Subject: userspace  dev-interface linux-2.6.7
Message-Id: <20050508144430.34ec4e0e.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <42775670.5070709@inf.ed.ac.uk>
In-Reply-To: <42775670.5070709@inf.ed.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Nils,

> i am happy to submit an update patch for the dev-interface document,
> but  at the moment i still have too many errors - i assume not many
> people  use /dev from user-space in 2.6.x anymore ?

Well, i2cdetect, i2cdump and i2cset can be compiled when running a 2.6
kernel - so lots of people actually do.

> (i) use lm_sensors i2c-dev.h instead of kernel header file
> #include <linux/i2c.h>
> #include "i2c-dev.h" /* lm_sensors header file */
> 
> causes compile errors due to <linux/i2c.h>

Do not include linux/i2c.h in a user-space program. This is a
kernel-space header file. If should work just fine without it, the only
header file you really need is i2c-dev.h.

-- 
Jean Delvare
