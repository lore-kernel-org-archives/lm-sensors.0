From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 09 Jun 2005 22:27:24 +0000
Subject: [lm-sensors] How can I skip i2c detection?
Message-Id: <20050609222651.7ab741fb.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <F06EB2894F3F0D45AD9BEA7246DE9C90854F15@WCSEXCMBS1.ad.wabtec.com>
In-Reply-To: <F06EB2894F3F0D45AD9BEA7246DE9C90854F15@WCSEXCMBS1.ad.wabtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Ben,

> Detailed modprobe times for i2c modules: 
> lm83=0.38s ds2482=0.57s max6875=0.55s pca9539=0.62s
> 
> Is that closer to what is expected?

Yes, sounds more reasonable.

> Oh, I'm using the lm83 driver with a lm82 chip - and it works great.

The lm83 driver could easily be extended to natively support the LM82.
It wasn't done so far because no LM82 chip was ever seen, but now you
seem to have one. If you want support, just ask and I'll add it.

-- 
Jean Delvare
