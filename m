From: greg@kroah.com (Greg KH)
Date: Thu, 09 Jun 2005 09:28:20 +0000
Subject: [lm-sensors] [PATCH 2.6.12-rc5-mm2] w1 search cleanup
Message-Id: <20050609070907.GC22729@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <F06EB2894F3F0D45AD9BEA7246DE9C9076C1EA@WCSEXCMBS1.ad.wabtec.com>
In-Reply-To: <F06EB2894F3F0D45AD9BEA7246DE9C9076C1EA@WCSEXCMBS1.ad.wabtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Jun 04, 2005 at 01:33:03AM +0400, Evgeniy Polyakov wrote:
> Greg, did you applied my previous 4 cleanups for w1?

Yes I have, they are in the -mm tree as well.

> Current patches are made against pure rc5-mm2 patches
> and thus can fuzz and even fail with your tree with previous w1 cleanups.

Well, as -mm has your patches, these should apply.  I'll see how well
they go and let you know.

thanks,

greg k-h
