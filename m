From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:47 +0000
Subject: [PATCH 2.6] Don't handle kind errors that cannot happen
Message-Id: <20040315211330.GE32636@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040313185302.6955c4a9.khali@linux-fr.org>
In-Reply-To: <20040313185302.6955c4a9.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Mar 13, 2004 at 06:53:02PM +0100, Jean Delvare wrote:
> 
> Note: What kind of error should the detection function return when the
> user forces the driver, but the driver doesn't agree to load? Some of
> our drivers return -EINVAL (e.g. w83781d), some -ENODEV (e.g. asb100,
> lm78), some return without an error (e.g. it87). I think we should decide
> of a policy and stick to it.

Why would the driver not agree to load?  It should always load, but just
not bind to a device, right?

Anyway, -ENODEV is a good error, as the device isn't there, or can't be
found.

thanks,

greg k-h
