From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:35 +0000
Subject: [PATCH] i2c driver fixes for 2.6.0
Message-Id: <20040114190334.GB6107@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <10728219692713@kroah.com>
In-Reply-To: <10728219692713@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Jan 11, 2004 at 09:50:54PM +0100, Jean Delvare wrote:
> > > They should be converted.  From module.h:
> > > 	/* DEPRECATED: Do not use. */
> > > 	#define MODULE_PARM(var,type) 	\
> > > 	...
> > 
> > Note that realistically, it's not going away in 2.6, so mass migration
> > doesn't really win anything.  However, I never implemented mixing old
> > and new style in the same module, so if you're adding a parameter, it
> > makes sense to convert them all.
> 
> OK, I don't have much time for a mass conversion anyway. Greg, could you
> please apply the following patch to the "porting-clients" document so
> that at least the new drivers don't need to be converted afterwards?

Applied, thanks.

greg k-h
