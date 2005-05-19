From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:23:55 +0000
Subject: [CVS PATCH] Sync cvs tree with latest 2.5 bk tree
Message-Id: <20030428165944.GC24193@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030425183641.GB2257@kroah.com>
In-Reply-To: <20030425183641.GB2257@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Apr 26, 2003 at 10:47:06PM -0700, Philip Pokorny wrote:
> I'd personally like to see my lm85 patch make it into 2.7.x...

Have a reference to it?  If it works with 2.5 right now, I'd be glad to
add it.

> Also, I've recently compiled i2c on a 64-bit Opteron and there are several 
> type conversion issues that are not 64-bit clean.  I looked into it a 
> little bit and the conversions seemed wrong even in a 32-bit environment 
> (ints to void *)

Hm, not good.  I'll gladly take patches to fix this problem.  I think I
even have access to a amd64 box around here somewhere that I could test
them out on.

> If you haven't already encountered these problems, then I'll work up a 
> patch and post it.

Patches are always welcome :)

thanks,

greg k-h
