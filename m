From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:04 +0000
Subject: Pre-release tests
Message-Id: <20030711232855.GK23240@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030707213700.3eef7104.khali@linux-fr.org>
In-Reply-To: <20030707213700.3eef7104.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Jul 11, 2003 at 05:50:13PM +0200, Jean Delvare wrote:
> 
> Do you prefer a single patch or individual diffs? Do you want me to
> generate the core patch against 2.4.21, 2.4.21-bk7 or 2.4.22-pre4? (or
> you can do it yourself)

Individual diffs are good.  In an incremental fashion is even better
(this one fixes up the core files to match cvs, this one adds one
driver, etc...)

Always against the latest kernel is the best, 2.4.22-preX or 2.4.21-bkX
is fine, I should be able to handle either of them.

I can imagine that we aren't going to just be able to drop in the cvs
version into the kernel, due to some cleanups that we might want to do
(along the lines of what's happened in 2.5 before I did the sysfs
changes.)  So this will be an iterative process.

Sound ok?

thanks,

greg k-h
