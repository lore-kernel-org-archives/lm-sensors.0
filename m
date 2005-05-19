From: kmalkki@cc.hut.fi (=?ISO-8859-1?Q?Ky=F6sti_M=E4lkki?=)
Date: Thu, 19 May 2005 06:23:42 +0000
Subject: i2c-algo-bit timing
Message-Id: <Pine.OSF.4.50.0212012145500.11264-101000@kosh.hut.fi>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.OSF.4.50.0211241027550.15523-100000@kosh.hut.fi>
In-Reply-To: <Pine.OSF.4.50.0211241027550.15523-100000@kosh.hut.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


First, included gzipped patch against latest CVS, it's my current local
work I told I would not commit before release and round for comments.

On Sun, 1 Dec 2002, Mark D. Studebaker wrote:

> // The following call to sclhi() contains a call to delay(adap->udelay)
> // which ensures the clock high time
> 		if (sclhi(adap)<0) { /* timed out */
> 			sdahi(adap); /* we don't want to block the net */
> 			DEB2(printk(KERN_DEBUG " i2c_outb: 0x%02x, timeout at bi
> 			return -ETIMEDOUT;
> 		};

Unfortunately sclhi() does not ensure clock high time the right way.
The delay should be after we read clock as high.

Usually this means we get no acknowledge from the client, since it has
missed this one clock cycle. If we miss a bit during the address bits,
we may access incorrect chips or more than one chip at a time.

-- 
  Ky?sti M?lkki
  kmalkki@cc.hut.fi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: i2c-patches.gz
Type: application/octet-stream
Size: 7495 bytes
Desc: 
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20021201/33b58d9c/i2c-patches.obj
