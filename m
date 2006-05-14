From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 14 May 2006 08:12:17 +0000
Subject: [lm-sensors] Support for Fintek F71872F
Message-Id: <20060514101217.7a31d211.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <4464D0B8.8070203@drzukov.is-a-geek.org>
In-Reply-To: <4464D0B8.8070203@drzukov.is-a-geek.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Thomas,

> > However I am unable to successfully insert the f71805f module for the 
> > 2.6.16 kernel. How much work still has to be done to support the F71872F 
> > chip? I'd be willing to program the support myself, but I would need a 
> > few pointers and the necessary documentation.
> 
> Having started playing with i2c a couple of weeks ago, I'd say just give
> it a try yourself: Rebuild your kernel with i2c debugging enabled, and
> then just have a look at dmesg output to see what happens. What I do is
> put a bunch of printk messages in the driver, and just watch to see what
> happens. It isn't hard to figure it out.

That wouldn't work, the f71805f driver is a platform driver, not an i2c
driver.

It's not a bug anyway. As I said in another post, the f71805f driver
simply lacks support for the F71872F chip at the moment, so some
additional code will be needed. Should be easy to do though.

-- 
Jean Delvare

