From: gregkh@suse.de (Greg KH)
Date: Fri, 12 May 2006 20:10:29 +0000
Subject: [lm-sensors] [GIT PATCH] I2C bugfixes for 2.6.17-rc4 - resend
Message-Id: <20060512201029.GA12248@suse.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060512190332.GA22627@kroah.com> <Pine.LNX.4.64.0605121216540.3866@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0605121216540.3866@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

On Fri, May 12, 2006 at 12:18:53PM -0700, Linus Torvalds wrote:
> 
> 
> On Fri, 12 May 2006, Greg KH wrote:
> However, please fix your scripts:
> 
> > Please pull from:
> > 	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/gregkh/i2c-2.6.git/
> 
> Nobody should use "rsync:", it's just more pain for everybody these days. 
> If you use rsync, and miss an object, because the mirroring was 
> incomplete, you'll never know, you'll just have a strange corrupted 
> archive.
> 
> Use rsync if you mirror things, but not for git.
> 
> So please make that read "git://git.kernel.org/.." instead. 

Oops, sorry, that's a leftover from a long time ago when I first wrote
the "create a pull email" script.  Sorry, I'll go fix that.

thanks,

greg k-h

