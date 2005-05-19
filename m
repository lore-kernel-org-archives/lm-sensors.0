From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:56 +0000
Subject: [PATCH][2.6]
Message-Id: <20040505175323.GA13088@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <409923F7.7050101@convergence.de>
In-Reply-To: <409923F7.7050101@convergence.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michael Hunold <hunold@convergence.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Jean Delvare <khali@linux-fr.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>, sensors@stimpy.netroedge.com

On Wed, May 05, 2004 at 07:27:19PM +0200, Michael Hunold wrote:
> 
> I think these things are unquestionable and don't make any functional 
> changes to the code, so this should be applied to 2.6 now.

"now" as in 2.6.6-rc3?  No.

Now as in I'll add it to my i2c tree, which will get picked up by -mm
and let it bake a bit and then pushed to Linus, yes.

I'll look this over and add it to my tree, thanks,

greg k-h
