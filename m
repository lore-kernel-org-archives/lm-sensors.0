From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:30 +0000
Subject: bus scan removal
Message-Id: <20031222091102.GA29580@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031221100543.28eaf2ff.khali@linux-fr.org>
In-Reply-To: <20031221100543.28eaf2ff.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Dec 21, 2003 at 01:07:32PM +0100, Jean Delvare wrote:
> > > BTW, does i2cdetect work on non-i386 architectures?
> > 
> > Its pretty straight-forward. If it doesn't work, problem is more
> > likely in i2c-dev.
> 
> That's not how I meant it. My point is that I think I remember Greg
> saying someting about i2c-dev not being portable cross platforms. If I'm
> not mistaking, i2cdetect relies on i2c-dev. What I mean is that removing
> in-modules bus scanning might not be accepted if the architectures using
> these modules are not able to use the new and prefered method, i.e.
> i2cdetect.
> 
> I searched my mail archive for Greg's original comment, but couldn't
> find it. Greg, any chance you could refresh my memory?

For systems that have a 64bit kernel, and a 32bit userspace, all ioctls
in the kernel need a "thunking" layer in order to pass the data between
the kernel and userspace properly.  Last I looked that layer did not
contain any i2c ioctls, so i2c-dev will not work on those kinds of
systems (ppc64, sparc64, mips64, amd64, ia64, etc...)

Hope this helps,

greg k-h
