From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:31 +0000
Subject: [BK PATCH] I2C fixes for 2.6.11-rc1
Message-Id: <20050117221214.GA29158@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050117214543.GB28400@kroah.com>
In-Reply-To: <20050117214543.GB28400@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com

On Mon, Jan 17, 2005 at 01:45:43PM -0800, Greg KH wrote:
> Hi,
> 
> Here are some i2c driver fixes and updates for 2.6.11-rc1.  There is a
> new chip and a new bus driver, as well as a bunch of minor fixes.  All
> of these patches have been in the past few -mm releases.

Oops, no new chip and bus drivers here, just some bigger updates to a
chip and a bus driver.  Sorry for misreading the diffstat.

But the patches are all still good :)

thanks,

greg k-h
