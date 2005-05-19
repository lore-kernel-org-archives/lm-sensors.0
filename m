From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:20 +0000
Subject: Patches for 2.6.0 (lm83 and misc)
Message-Id: <20031009204658.GA12178@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031004160750.70561b1d.khali@linux-fr.org>
In-Reply-To: <20031004160750.70561b1d.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Oct 04, 2003 at 04:07:50PM +0200, Jean Delvare wrote:
> 
> Hi Greg,
> 
> Please find attached three patches for Linux 2.6.0(-test6).

Thanks, next time could you send me 3 different email messages?  1 mail
per patch is much easier to handle, I had to split this up into 3
different messages to apply them to the bk repository.

> The main patch adds support for the LM83. I followed all your
> recommendations, so I hope it is all correct now, but feel free to buzz
> if something isn't.

Thanks, looks good.  I've applied this, but will have to hold on to it
until 2.6.0 comes out, as no new drivers are going to be able to be
added.  Don't worry, I'll keep track of it and will send it to Linus
when 2.6.0 comes out.

> The second patch corrects some errors in i2c/chips/Kconfig.
> The third patch fixes all chip drivers (but lm83) by moving the
> initialization before any sysfs entry is created, as you once requested.

I've applied these two patches, and will send them to Linus in a bit.

> I don't think it is worth backporting that to CVS. It is very unlikely
> to cause problems, isn't it? I can't even think of a scenario that
> would.

You could open the sysfs device and ask for a sensor setting before the
device was initialized, right?  This patch is a good thing and should
also go into the 2.4 tree.

> Future plans:
> - Update my chip driver porting guide, publish it (lm_sensors CVS,
> should it go into Linux 2.6.0 as well?)

Not really, the cvs tree is good, as it doesn't make much sense when
only looking at the 2.6 tree, right?  :)

> - Port my lm90 driver.
> - Port the adm1025 driver.

Nice.

thanks again for the patches.

greg k-h
