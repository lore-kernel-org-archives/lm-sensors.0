From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:30 +0000
Subject: i2c-piix4 fix undo
Message-Id: <20031219193852.GR3017@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031206221027.45ecfdea.khali@linux-fr.org>
In-Reply-To: <20031206221027.45ecfdea.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Dec 19, 2003 at 09:41:39AM -0700, Tom Rini wrote:
> On Thu, Dec 18, 2003 at 10:26:40AM -0800, Greg KH wrote:
> > On Thu, Dec 18, 2003 at 11:16:12AM -0700, Tom Rini wrote:
> > > On Wed, Dec 17, 2003 at 03:52:50PM -0800, Greg KH wrote:
> > > > On Sat, Dec 06, 2003 at 10:10:27PM +0100, Jean Delvare wrote:
> > > > > Hi Greg,
> > > > > 
> > > > > A few months ago, we added a workaround to i2c-piix4 to help it to work
> > > > > on a few boards. The fix was ported to 2.6, the patch is here:
> > > > > http://linuxusb.bkbits.net:8080/i2c-2.6/patch@1.1123.21.1
> > > > > 
> > > > > It since turned out that it also breaks the module for other boards, and
> > > > > it even breaks more than it fixes (4 reports since lm_sensors-2.8.1 was
> > > > > released). The problem is under investigation by Tom Rini, the author of
> > > > > the original fix.
> > > > > 
> > > > > I suggest that you reverse the fix in Linux 2.6 before 2.6.0 is
> > > > > released. Once we have enough information to submit a better one (could
> > > > > take some time), I'll send a new patch to you.
> > > > 
> > > > Thanks, I've backed this patch out and will send it off to Linus.
> > > 
> > > If it's not too late, how about doing the current work-around (module
> > > param to enable the fix) instead?
> > 
> > Sure, got patch?  :)
> 
> Here you go:

Thanks, I've applied this version instead.

greg k-h
