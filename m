From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 27 Sep 2005 20:20:24 +0000
Subject: [lm-sensors] [PATCH] website/protocol.html
Message-Id: <20050927201952.016420e8.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200509240453.AA01316@k7.kit.hi-ho.ne.jp>
In-Reply-To: <200509240453.AA01316@k7.kit.hi-ho.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

QUoting myself:
> Patch applied, thanks. I'll cleanup this page later today, BTW, the
> HTML code is really ugly. Such a simple page shouldn't weight 16 kB.

I've rewritten the page in proper HTML, looks much better now.

While we're at it, could someone explain to me what the "i2c-dev.h
macro" and "i2c-core.c i2c_smbus_xxx()" columns of the "w/ PEC" side
are supposed to mean?

There are no particular macros for PEC transactions in i2c-dev.h, and
no particular functions for PEC transactions in i2c-core.c either. Even
the "i2c-dev.c ioctl" column doesn't make much sense to me, as there is
no per-transaction PEC-specific code in i2c-dev.c. I'd as well drop
these meaningless columns, which would have the nice benefit that the
table would fit in my screen again. Opinions?

Thanks,
-- 
Jean Delvare
