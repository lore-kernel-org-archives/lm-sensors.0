From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 25 Jan 2007 12:58:21 +0000
Subject: [lm-sensors] [PATCH] sensors-detect: Cache the I2C/SMBus register
Message-Id: <20070125135821.62dd5417.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

The I2C/SMBus chip detection in sensors-detect is quite dumb, each
possible device is tested individually, resulting in the same registers
being read over and over again. We could rethink the probing logic
completely to workaround that, but that's a huge change and it doesn't
go without risks.

So I propose a different approach: caching the register values. We can
do it almost transparently in i2c_smbus_read_byte_data and
i2c_smbus_read_word_data, clearing the caches when we switch to the
next address. I implemented that, patch is attached.

One thing that needed special care is that some devices do not answer
consistently to some reads, and we use it as a detection method. So I
added a NO_CACHE flag to force actual reads from the chip, for
detecting these devices properly. The LM75, LM77 and MAX6657/8/9 are
affected, and I could test that my LM75 is still detected properly
after the change.

I left the extra instrumentation in this version of the patch if you
want to play with it. To disable caching, just comment out the
intermediate return statements in i2c_smbus_read_byte_data and
i2c_smbus_read_word_data. On my systems, I found that the benefit
differs greatly depending on the address and chip, from almost none to
over 50% of cache hits, effectively dividing the probing time by almost
2.

I kept the byte and word caches separated for now, but we might improve
the speed even more by sharing them. I wonder if there are drawbacks in
doing so. I'll look into that later.

The attached patch applies on top of current SVN. Cumulated with the
other cleanups I made since the beginning of the week, this should give
us a much much faster detection script.

Comments anyone?

-- 
Jean Delvare
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: sensors-detect-register-cache.patch
Url: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20070125/a99c466e/attachment.pl 
