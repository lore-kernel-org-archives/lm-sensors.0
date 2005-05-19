From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:09 +0000
Subject: i2c-algo-8xx
Message-Id: <20030802170006.GG11038@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030802133344.71d15fac.khali@linux-fr.org>
In-Reply-To: <20030802133344.71d15fac.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Aug 02, 2003 at 01:33:44PM +0200, Jean Delvare wrote:
> 
> Hi Greg,
> 
> Just a quick note about something I noticed this morning.
> 
> In linux-2.6.0-test2, there is the i2c-rpx driver. It needs the
> i2c-algo-8xx module and header file, which are *not* in
> linux-2.6.0-test2, so it won't work, unless I missed something. So I
> guess i2c-algo-8xx should be ported to Linux 2.6 too, or i2c-rpx will
> have to be removed.

As this is a ppc driver, I'd look in the ppc kernel tree to see if they
have included it in their repository and not just synced up with Linus's
tree yet.

As no one seems to be able to compile it right now, and no one has
complained, I'll leave it in for now.

Is that ok?

thanks,

greg k-h
