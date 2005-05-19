From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:37 +0000
Subject: [PATCH 2.6] Bring lm75 and lm78 in compliance with sysfs naming
Message-Id: <20040127224738.GA28305@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040127200058.1100b1fa.khali@linux-fr.org>
In-Reply-To: <20040127200058.1100b1fa.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Jan 27, 2004 at 08:00:58PM +0100, Jean Delvare wrote:
> Hi Greg,
> 
> Here is a patch that brings the lm75 and lm78 drivers in compliance with
> sysfs naming conventions. The drivers as found in existing 2.6 kernels
> do not have a digit appended to the temperature-related files names as
> the sysfs naming conversion recommends (obviously because they each have
> a single temperature channel). As a result, libsensors won't find the
> files.
> 
> It was discussed on the list wether a '1' should be appended in this
> case, and our conclusion was that it would be better to do so because it
> helps automatic processing of the sysfs exported files. Please apply if
> you agree with this.

I agree, and have applied it.

thanks,

greg k-h
