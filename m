From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 08 Oct 2005 11:11:19 +0000
Subject: [lm-sensors] [PATCH] protocol.html
Message-Id: <20051008111100.71e4d84d.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200510080359.AA01326@k7.kit.hi-ho.ne.jp>
In-Reply-To: <200510080359.AA01326@k7.kit.hi-ho.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Ohaio Hideki,

> - This page has not described the status of vanilla kernel.
> - The user space i2c-dev.h is provided by the lm_sensors package.

This is true, I've applied your patch.

That being said, I plan to update this page after my PEC rewrite is
merged into the Linux 2.6 kernel and possibly backported to i2c CVS.
The table could be made much more simple and readable. Also,
mentionning the Linux 2.6 (and maybe 2.4) kernel status would probably
be helpful, as this now represents a large share of our users.

Arigato,
-- 
Jean Delvare
