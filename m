From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:12 +0000
Subject: [BK PATCH] I2C update for 2.6.8-rc1
Message-Id: <20040825063643.GA8249@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040715000527.GA18923@kroah.com> <1093384722.8445.10.camel@tdi> <20040824220450.GE11165@kroah.com> <Pine.LNX.4.58.0408241721330.17766@ppc970.osdl.org> <1093397881.9555.6.camel@tdi> <Pine.LNX.4.58.0408241847460.17766@ppc970.osdl.org> <20040825061445.GA16938@kroah.com>
In-Reply-To: <20040825061445.GA16938@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@osdl.org>
Cc: Alex Williamson <alex.williamson@hp.com>, akpm@osdl.org, linux-kernel <linux-kernel@vger.kernel.org>, sensors@Stimpy.netroedge.com

On Tue, Aug 24, 2004 at 11:14:45PM -0700, Greg KH wrote:
> On Tue, Aug 24, 2004 at 07:02:47PM -0700, Linus Torvalds wrote:
> > Now, admittedly, that would be a VERY broken BIOS, and likely such a 
> > situation wouldn't have worked _anyway_, but you're the PCI maintainer, so 
> > you get to sit in the hot seat and say aye or nay.
> 
> It looks correct to me, please apply it.  If it breaks people's boxes
> that used to work, I'm sure I'll hear about it :)

It didn't break my finicky little laptop, so it's fine with me.

thanks,

greg k-h
