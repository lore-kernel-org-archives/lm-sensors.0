From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:21 +0000
Subject: [kronos@kronoz.cjb.net: Re: [patch] sensors/w83781d.c creates
Message-Id: <20031013161015.GA10552@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031011193739.GA2999@frodo.local>
In-Reply-To: <20031011193739.GA2999@frodo.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Oct 11, 2003 at 09:37:39PM +0200, Frodo Looijaard wrote:
> ----- Forwarded message from Kronos <kronos@kronoz.cjb.net> -----
> 
> From: Kronos <kronos@kronoz.cjb.net>
> To: linux-kernel@vger.kernel.org
> Cc: frodol@dds.nl, Jindrich Makovicka <makovick@kmlinux.fjfi.cvut.cz>
> Subject: Re: [patch] sensors/w83781d.c creates useless sysfs entries
> Reply-To: kronos@kronoz.cjb.net
> X-Spam-Status: No, hits=-7.4 required=5.0 tests=IN_REP_TO,UNIFIED_PATCH,RCVD_IN_OSIRUSOFT_COM version=2.20
> X-Spam-Level: 
> 
> Jindrich Makovicka <makovick@kmlinux.fjfi.cvut.cz> ha scritto:
> > Hello,
> > 
> > here is a trivial fix for Winbond sensor driver, which currently creates 
> > useless entries in sys/bus/i2c due to missing braces after if statements 
> > - author probably forgot about the macro expansion.
> 
> IMHO it's better to fix the macro:

I'll take this fix, thanks.

Oh, and do you want to be removed from the MAINTAINERS list in the
2.6 kernel, so as to not receive these kinds of messages?

thanks,

greg k-h
