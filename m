From: greg@kroah.com (Greg KH)
Date: Mon, 06 Jun 2005 09:17:23 +0000
Subject: [lm-sensors] [PATCH 2.6] drivers/i2c/chips/it87.c: use dynamic
Message-Id: <20050606062623.GA6455@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050605115325.27cd4429.khali@linux-fr.org>
In-Reply-To: <20050605115325.27cd4429.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Jun 05, 2005 at 11:53:25AM +0200, Jean Delvare wrote:
> Hi Yani, Greg, all,
> 
> > Here is a patch against it87, since it seems to have many more device
> > attributes than lm90. The size difference:
> > 
> > before:
> > Module                  Size  Used by
> > it87                   28832  0
> > after:
> > Module                  Size  Used by
> > it87                   22432  0
> 
> It seems that this patch never made it to Greg's tree. I have been
> testing it for two weeks now, and no problem arose, so I'd like it to be
> applied. Let's not lose the work that was done. Just like the adm1026
> patch, the original it87 patch had some coding style error, which I
> fixed. New patch attached. Please apply, thanks.

Oops, that one slipped through, good catch.  Applied now.

thanks,

greg k-h
