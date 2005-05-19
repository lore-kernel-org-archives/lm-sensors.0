From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:06 +0000
Subject: [PATCH] I2C update for 2.6.8-rc1
Message-Id: <20040715141036.GA5451@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <10898500251206@kroah.com>
In-Reply-To: <10898500251206@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Jul 15, 2004 at 09:33:17AM +0200, Jean Delvare wrote:
> 
> >> Is this right that we don't want to explicitly initialize the adm1031_id
> >> counter?
> >>
> >> Why is that?
> >
> >Because the compiler/linker does it already for you :)
> >
> >See the kernel janitor's list for more information about why this is a
> >good thing to change.
> 
> Hm, then I want to update my i2c client porting guide to mention that?

It's probably not worth it, unless you want to mention to check the
kernel janitor's list to make sure you aren't doing any of the things
mentioned there.

thanks,

greg k-h
