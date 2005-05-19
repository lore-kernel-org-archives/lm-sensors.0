From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:12 +0000
Subject: [PATCH] Fix for i2c-piix4 with on some boards
Message-Id: <20030811203718.GC18317@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030811181001.GE807@ip68-0-152-218.tc.ph.cox.net>
In-Reply-To: <20030811181001.GE807@ip68-0-152-218.tc.ph.cox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Aug 11, 2003 at 11:10:01AM -0700, Tom Rini wrote:
> +		printk("Fixed I2C problem on Force CPCI735\n");

Shame on adding a printk() without a proper level value.  I'll convert
this to a dev_info() message and apply it (the 2.6 patch, not the cvs
patch.)

thanks,

greg k-h
