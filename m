From: greg@kroah.com (Greg KH)
Date: Thu, 02 Jun 2005 08:00:47 +0000
Subject: [lm-sensors] Re: [PATCH 2.6.12-rc5-mm1 0/3] i2c: new sysfs class
Message-Id: <20050602060645.GA8530@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050602032840.GA4906@jupiter.solarsys.private>
In-Reply-To: <20050602032840.GA4906@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Jun 01, 2005 at 11:28:40PM -0400, Mark M. Hoffman wrote:
> Hi Greg:
> 
> Here's the hwmon patchset again; this time I would like you to consider
> applying it.  The device class ID string is now chosen by the (chip) driver.
> That required a small change to the driver/core class code, which is the
> first patch.  The third patch modifies all hwmon-type drivers, instead of
> just a couple.  Also, thanks for your comments re: my previous patchset -
> I've addressed those here.

Nice, I've added them to my tree, and will show up in the next -mm
releases.  If you want to send me updated patches, just let me know.  If
you want to send add-on patches, also, feel free to.  I'll hold off
sending this to Linus till after 2.6.12 is out, and after you feel more
comfortable with the code.

I do have a few issues, and will reply to the patches.

thanks,

greg k-h
