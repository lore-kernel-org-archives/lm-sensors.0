From: greg@kroah.com (Greg KH)
Date: Wed, 26 Oct 2005 22:40:51 +0000
Subject: [lm-sensors]
Message-Id: <20051026203940.GA7468@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <87ekb9s3tn.wl%info@wore.ma.cx>
In-Reply-To: <87ekb9s3tn.wl%info@wore.ma.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Oct 26, 2005 at 06:15:44PM -0200, Mauro Carvalho Chehab wrote:
> Greg,
> 
> 	Please don't send this patch to Andrew or mainstream. I'll apply it on
> my tree and I will send it at the end my patchset series, for not
> breaking these.
> 
> 	I have several patches that are including newer IDs on
> linux/media/i2c-id.h and I'm just preparing a patch, on V4L tree, to
> remove this file from kernel.

But we are removing this file, as it's just not needed.  Why would you
add more ids to it?

thanks,

greg k-h
