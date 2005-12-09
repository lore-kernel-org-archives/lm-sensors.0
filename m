From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 09 Dec 2005 19:28:06 +0000
Subject: [lm-sensors] [PATCH] lm_sensors2 w83627thf fix set VCORE max
Message-Id: <20051209202806.66f5aa92.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <FF9D611BFCDB1E42B37FAA148096BECEC2223D@weshml03.winbond.com.tw>
In-Reply-To: <FF9D611BFCDB1E42B37FAA148096BECEC2223D@weshml03.winbond.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Yuan,

> This patch Fix the typo in set VCORE function, in_min should be
> in_max. Please apply.

Wow, good catch once again. Applied, thanks.

Note that the patch was attached with an incorrect mime type
(application/octet-stream), so it didn't make it to the list. Please
make sure you use a text attachement type next time, so that everyone
on the list can read the patch and possibly comment on it. This is the
whole point of our open development model.

Thanks again,
-- 
Jean Delvare

