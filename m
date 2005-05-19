From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:37 +0000
Subject: Typo (Re: [PATCH] i2c driver fixes for 2.6.2-rc2)
Message-Id: <20040128232320.GA10657@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <10752464532256@kroah.com> <200401281408.34364.ender@debian.org>
In-Reply-To: <200401281408.34364.ender@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David =?iso-8859-1?Q?Mart=EDnez?= Moreno <ender@debian.org>
Cc: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

On Wed, Jan 28, 2004 at 02:08:34PM +0100, David Mart?nez Moreno wrote:
> El Mi?rcoles, 28 de Enero de 2004 00:34, Greg KH escribi?:
> > +			dev_err(&adapter->dev, "Unrecgonized version/stepping 0x%02x"
> > +				" Defaulting to LM85.\n", verstep);
> 
> 	Hello, Greg.
> 
> 	Just noticed, please s,recgonized,recognized,g all over the file.

Care to send me a spelling fix patch?

thanks,

greg k-h
