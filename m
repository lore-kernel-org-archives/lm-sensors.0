From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:01 +0000
Subject: [PATCH 2.6] add alternate VCORE calculations for w83627thf and
Message-Id: <20040608212459.GA11813@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040606025430.GC10118@jupiter.solarsys.private>
In-Reply-To: <20040606025430.GC10118@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Jun 05, 2004 at 10:54:30PM -0400, Mark M. Hoffman wrote:
> Hi Greg:
> 
> This can wait until after 2.6.7.  It applies to 2.6.7-rc2.

Are you sure?  I get the following errors when trying to apply it:
	drivers/i2c/chips/w83627hf.c 1.5: 1359 lines
	patching file drivers/i2c/chips/w83627hf.c
	Hunk #4 FAILED at 392.
	Hunk #5 succeeded at 401 with fuzz 2.
	1 out of 6 hunks FAILED -- saving rejects to file drivers/i2c/chips/w83627hf.c.rej


thanks,

greg k-h
