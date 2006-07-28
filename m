From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 28 Jul 2006 13:43:01 +0000
Subject: [lm-sensors] Differences between w83781d.c in 2.4 and 2.6
Message-Id: <20060728154301.1d7a0fda.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <onr3c2pk3p96kqejtnousjsml75rh16srf@4ax.com>
In-Reply-To: <onr3c2pk3p96kqejtnousjsml75rh16srf@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi "com.ea" (what a strange name is that),

> Im continuing with my job about adding PWM clock support for
> the winbond family. I noticed that the w83781d.c driver for 2.4
> kernels has support for w83791d while the same driver
> for 2.6 kernels doesnt (last release 2.6.17). Is anybody porting
> it to 2.6? Where can i get the code if its already done?

It was moved to a separate driver (unsurprisingly named w83791d) by
Charles Spirakis. The reason is that the W83791D is quite different
from the other chips already supported by the w83781d driver and having
a separate driver was cleaner.

You can find the new driver in linux 2.6.18-rc1 and later, it was just
merged.

-- 
Jean Delvare

