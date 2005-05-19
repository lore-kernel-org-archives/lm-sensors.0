From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:23:51 +0000
Subject: w83781d i2c driver updated for 2.5.66 (without sysfs support)
Message-Id: <20030326234601.GB27436@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1048582394.4774.7.camel@workshop.saharact.lan> <20030325175603.GG15823@kroah.com> <1048705473.7569.10.camel@nosferatu.lan> <20030326202904.GK24689@kroah.com> <1048721671.7569.46.camel@nosferatu.lan>
In-Reply-To: <1048721671.7569.46.camel@nosferatu.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Martin Schlemmer <azarah@gentoo.org>
Cc: KML <linux-kernel@vger.kernel.org>, Dominik Brodowski <linux@brodo.de>, sensors@Stimpy.netroedge.com

On Thu, Mar 27, 2003 at 01:34:32AM +0200, Martin Schlemmer wrote:
> 
> Quick question .... With sysfs, is it not needed to call
> i2c_detach_client ?   I am asking this as it seems from patches
> that you remove all these calls ...

No, that's still required.  I didn't delete that in my lm75.c patch, did
I?

You just don't have to call i2c_deregister_entry, as we don't call
i2c_register_entry anymore.

thanks,

greg k-h
