From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:37 +0000
Subject: [PATCH] i2c driver fixes for 2.6.1
Message-Id: <20040131152320.GA2730@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <10745567662012@kroah.com> <10745567661358@kroah.com> <20040121225012.1addb5c7.khali@linux-fr.org> <20040121235655.GF1958@kroah.com> <20040131095642.09c29ac3.khali@linux-fr.org>
In-Reply-To: <20040131095642.09c29ac3.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sensors@stimpy.netroedge.com, linux-kernel@vger.kernel.org

On Sat, Jan 31, 2004 at 09:56:42AM +0100, Jean Delvare wrote:
> > > That said, I still think it was a good idea. Not that it matters
> > > much to me since I don't use that driver, but anyway... Who should I
> > > contact to get it included?
> > 
> > The ieee1394 maintainer?
> 
> OK, done that. It is supposed to have been applied, although it's not in
> 2.6.2-rc3.

Give them time, iee1394 doesn't sync up with Linus as often as USB and
I2C does :)

greg k-h
