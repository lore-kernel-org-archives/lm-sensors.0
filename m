From: mgreer@mvista.com (Mark A. Greer)
Date: Tue, 07 Mar 2006 17:01:07 +0000
Subject: [lm-sensors] [PATCH 1/1] i2c: m41txx driver for ST i2c RTC chips
Message-Id: <20060307170107.GA5250@mag.az.mvista.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060217011359.GA16247@mag.az.mvista.com>
In-Reply-To: <20060217011359.GA16247@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean.

On Mon, Mar 06, 2006 at 12:45:14PM +0100, Jean Delvare wrote:
> 
> Hi Mark, Rudolf,
> 
> First of all, Mark, I'm very sorry I did not reply earlier, as you're
> always doing such a good job. I'm just too busy with many other stuff
> :( and I need to take some time for myself from times to times too.

No problem.

> I see that Rudolf has been reviewing your code, thanks Rudolf.
> 
> > > Thanks for taking the time to look at it.
> >
> > Lets wait when Jean will have some little time to look into it.
> 
> I won't have the time to review it completely, but I'd just have one
> question/suggestion: Mark, why did you rename the driver from m41t00 to
> m41txx? I understand that the driver now supports more than one device,
> but almost all our i2c and hwmon drivers so, and we still usually stick
> to the name of the first supported device. This works just fine.
> 
> The problem I see with the renaming is that it makes reviewing the
> changes much more difficult. As a matter of fact, I did not review your
> patch, in part for that reason :( Then it can confuse some source
> control systems (such as quilt, which I use) or at least make them less
> convenient to use.
> 
> It'll also make things harder for the users (they may need to update
> some configuration files, which won't be compatible between old and new
> kernels.) Last, I doubt that your driver actually covers all 100 devices
> from m41t00 to m41t99 ;) and if any of these chips isn't compatible
> enough to be supported by your driver, you'll be in trouble to find a
> name for the new driver...
> 
> So I'd suggest that you do not rename the driver, it it's not too late.

Okay, that makes sense.  I'll change the name back to m41t00 and submit that
patch in the next day or so.

Mark

