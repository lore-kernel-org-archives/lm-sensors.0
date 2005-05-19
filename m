From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:23:55 +0000
Subject: it87 driver converted to sysfs
Message-Id: <20030425221304.GA1657@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030424150113.GJ1069@iucha.net> <20030424160431.GC18690@kroah.com> <20030424165132.GK1069@iucha.net> <20030424172758.GA27365@kroah.com> <20030425215335.GN1069@iucha.net>
In-Reply-To: <20030425215335.GN1069@iucha.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

On Fri, Apr 25, 2003 at 04:53:35PM -0500, Florin Iucha wrote:
> On Thu, Apr 24, 2003 at 10:27:58AM -0700, Greg KH wrote:
> > Thanks, I've applied this and will send it on in a bit.
> > 
> > Oops, I've fixed the call to check_region, which should not have been
> > made.  Sorry I missed that last time.
> 
> I have booted 2.5.68-bk6 and upon modprobe it87 I get this:

Let me know if this patch fixes it or not.

thanks,

greg k-h


--- a/drivers/i2c/chips/it87.c	Thu Apr 24 13:35:19 2003
+++ b/drivers/i2c/chips/it87.c	Fri Apr 25 15:06:21 2003
@@ -585,6 +585,7 @@
 		err = -ENOMEM;
 		goto ERROR1;
 	}
+	memset(new_client, 0x00, sizeof(struct i2c_client)+sizeof(struct it87_data));
 
 	data = (struct it87_data *) (new_client + 1);
 	if (is_isa)
