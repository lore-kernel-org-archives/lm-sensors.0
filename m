From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 17 Oct 2005 21:47:57 +0000
Subject: [lm-sensors] [PATCH] hwmon - lm78, lm85  sparse fixes
Message-Id: <20051017214756.36feb206.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051013102407.GA31018@home.fluff.org>
In-Reply-To: <20051013102407.GA31018@home.fluff.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi again Ben,

> > lm78.c and lm85.c have a number of items declared static
> > then implemented without the static on them. The following
> > patch fixes the sparse errors below
> (...)
> Correct, applied, thanks.

BTW, there seems to be many more missing statics in hwmon and i2c
drivers. I wonder why you did only report these for the eeprom, lm78 and
lm85 drivers. Care to provide patches for the other drivers as well?

Thanks,
-- 
Jean Delvare
