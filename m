From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 19 May 2005 06:23:50 +0000
Subject: [PATCH] i2c driver changes for 2.5.64
Message-Id: <20030318085328.A26877@infradead.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <10476033213315@kroah.com>
In-Reply-To: <10476033213315@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Mar 17, 2003 at 08:17:14PM -0500, Mark D. Studebaker  wrote:
> I'd like to keep sensors CVS 2.4-compatible, or at least
> delay a branch as long as possible.

With Greg's driver model changes the code won't compile under 2.4 anymore.
But I think it might be possible to supply stubs for that functionality
so that the drivers can be used on 2.4 aswell.

> Kyosti was working
> on getting to the point that we could submit a patch
> to 2.4 (until we do that, CVS is incompatible with stock 2.4
> kernels because of the i2c_driver struct change).
> Any sensors changes/cleanups that are 2.4 compatible,
> it's preferable to check those changes into CVS
> for testing. Ideally we can submit drivers to 2.5 directly
> out of CVS.

Submitting out of CVS is bad, this leads to the usualy "CVS mentality"
with resyncs instead of properly one thing at a time changes.

What do you think about having them in 2.5 first and then put them into
CVS for the 2.4 backport (which in the best case is not a port at all
but just the addition of a compatiblity header).

I'm happy to help out with feeding the sensors changes to Linus and
review / fix smaller issues.
