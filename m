From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:21 +0000
Subject: [PATCH] 2.6 lm85.c driver update
Message-Id: <20041109004918.GA25651@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041004200943.GE22290@penguincomputing.com> <20041019222920.GJ9521@kroah.com> <20041025203610.GA19053@penguincomputing.com> <20041025225959.6026626f.khali@linux-fr.org> <20041025220526.GC19053@penguincomputing.com> <20041105214841.GI1750@kroah.com> <20041105222546.GA31538@penguincomputing.com>
In-Reply-To: <20041105222546.GA31538@penguincomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Justin Thiessen <jthiessen@penguincomputing.com>
Cc: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com, phil@netroedge.com

On Fri, Nov 05, 2004 at 02:25:46PM -0800, Justin Thiessen wrote:
> On Fri, Nov 05, 2004 at 01:48:41PM -0800, Greg KH wrote:
> > On Mon, Oct 25, 2004 at 03:05:26PM -0700, Justin Thiessen wrote:
> > > On Mon, Oct 25, 2004 at 10:59:59PM +0200, Jean Delvare wrote:
> > > > > > Hm, there are a number of rejects in this patch.  Care to resync up
> > > > > > with the next kernel release and resend this?
> > > > > 
> > > > > Ok, try this:
> > > > > 
> > > > > signed off by:  Justin Thiessen  <jthiessen@penguincomputing.com>
> > > > > 
> > > > > patch for kernel 2.6.X lm85 driver follows:
> 
> <snip>
> 
> > Applied, thanks.
> > 
> > But now I get the following build warnings:
> > 
> > drivers/i2c/chips/lm85.c:220: warning: 'SMOOTH_TO_REG' defined but not used
> > drivers/i2c/chips/lm85.c:236: warning: 'SPINUP_TO_REG' defined but not used
> > 
> > Care to send me a patch to fix them up?
> 
> Ok.
> 
> Justin Thiessen
> 
> Signed off by Justin Thiessen <jthiessen@penguincomputing.com>

Applied, thanks.

greg k-h
