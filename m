From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:46 +0000
Subject: 2.6.4-rc2-mm1: IPMI_SMB doesnt compile
Message-Id: <20040310190648.GB18892@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040307223221.0f2db02e.akpm@osdl.org> <20040309013917.GH14833@fs.tum.de> <404F3BC3.2090906@acm.org> <20040310185105.GS14833@fs.tum.de>
In-Reply-To: <20040310185105.GS14833@fs.tum.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Corey Minyard <minyard@acm.org>, Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, "Davis, Todd C" <todd.c.davis@intel.com>, sensors@stimpy.netroedge.com, "Simon G. Vogl" <simon@tk.uni-linz.ac.at>

On Wed, Mar 10, 2004 at 07:51:05PM +0100, Adrian Bunk wrote:
> On Wed, Mar 10, 2004 at 10:01:07AM -0600, Corey Minyard wrote:
> >...
> > I have included a patch from Todd Davis at Intel that adds this function 
> > to the I2C driver.  I believe Todd has been working on getting this in 
> > through the I2C driver writers, although the patch is fairly non-intrusive.
> > 
> > However, I have no real way to test this patch.
> >...
> 
> I can only confirm that it fixes the compilation...
> 
> 
> The patch to i2c-core.c is strange:

And dumb, and incorrect :(

thanks,

greg k-h
