From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 24 Sep 2005 18:22:11 +0000
Subject: [lm-sensors] [PATCH] increase size of buffer in
Message-Id: <20050924182310.2b2ca722.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200509221745.AA01313@k7.kit.hi-ho.ne.jp>
In-Reply-To: <200509221745.AA01313@k7.kit.hi-ho.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Konbanwa Hideki,

> One more byte is needed for PEC.

This is correct, I will commit your fix to i2c CVS and will prepare a
similar fix for Linux 2.6.

Arigato!
-- 
Jean Delvare
