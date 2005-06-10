From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 10 Jun 2005 09:22:29 +0000
Subject: [lm-sensors] How can I skip i2c detection?
Message-Id: <FG6JXvyv.1118387551.7052870.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <F06EB2894F3F0D45AD9BEA7246DE9C90854F15@WCSEXCMBS1.ad.wabtec.com>
In-Reply-To: <F06EB2894F3F0D45AD9BEA7246DE9C90854F15@WCSEXCMBS1.ad.wabtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Ben,

> Good point about the 127.
> Perhaps there isn't a reliable way to distinguish the two chips. =(

Does sensors-detect find an LM82, or an LM83? Or both? Or none?

Could you please provide a dump of your LM82 chip (use i2cdump)? I could
compare with my LM83.

If there really is no way to differenciate between both chips, well,
we'll simply document that fact, and invite LM82 owners to ignore the
two irrelevant temperature channels.

Thanks,
--
Jean Delvare
