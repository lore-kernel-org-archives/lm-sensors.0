From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:01 +0000
Subject: adm1031 patch for 2.6.6-bk5
Message-Id: <20040613190924.5aea31b0.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1086336106.40c02c6a1e312@imp6-q.free.fr>
In-Reply-To: <1086336106.40c02c6a1e312@imp6-q.free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Alexandre,

> Here is the latest patch for adm1031 support on 2.6 kernel.

I've tried your even latest patch as downloaded from your website. Works
great except one problem:

Lowering fan div doesn't correctly preserve fan min (most likely an
8-bit reg overflow). For exemple:
# echo 2 > fan1_div
# echo 2000 > fan1_min
# echo 1 > fan1_div
fan1_div will now read 8437 (instead of 2678, the lowest value for div 1)

I guess you forgot to port the change from the 2.4 driver.

I've also noticed something strange. That's not a bug, but I'd like to
know if you noticed the same.

It looks like temperature comparisons are done on the integer part only.
For example, if the high limit set to 45 degrees, and measured
temperature is 45.5 degrees, no alarm will raise. I'll trigger at 46.0
degrees. I think this isn't what most chips do. I'll check with the
ADM1032, but I'm almost sure...

Maybe we could slightly shift the hardware limit and the user-space
visible limit so as to correct that difference?


-- 
Jean Delvare
http://khali.linux-fr.org/
