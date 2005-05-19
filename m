From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:46 +0000
Subject: I2C driver for embedded Motorola PPC products
Message-Id: <20040311015008.GA13614@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <0AB9C6CD-72E3-11D8-B2B5-000393DBC2E8@motorola.com>
In-Reply-To: <0AB9C6CD-72E3-11D8-B2B5-000393DBC2E8@motorola.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Mar 10, 2004 at 08:30:36PM -0500, Mark Studebaker wrote:
> 
> So we're happy to review your driver and help you out if you need it.
> But if you're looking to get the driver where people will use it,
> and ultimately into the mainstream kernel, you should target
> a PPC 2.6 tree.

The mainline kernel works just fine on a ppc64 box, so the mainline
kernel is the "ppc 2.6" tree these days :)

Now yes, there is a separate ppc kernel tree, but the delta between it
and mainline is getting much smaller, thankfully...

thanks,

greg k-h
