From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:38 +0000
Subject: [PATCH][I2C] Marvell mv64xxx i2c driver
Message-Id: <20050217222540.GE21188@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <42094ADB.9040403@mvista.com> <58cb370e05020816017431b38@mail.gmail.com> <42095A0B.2080400@mvista.com> <58cb370e05020817241aa42631@mail.gmail.com> <420A81C7.1000108@mvista.com>
In-Reply-To: <420A81C7.1000108@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Mark A. Greer" <mgreer@mvista.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, LM Sensors <sensors@stimpy.netroedge.com>, lkml <linux-kernel@vger.kernel.org>

On Wed, Feb 09, 2005 at 02:33:59PM -0700, Mark A. Greer wrote:
> 
> I can't find any definitive policy on this.  I kind of like the explicit 
> return, I don't know why.  I've had others make the same comment, 
> though, so I'll remove them since it obviously bothers people.
> 
> Attached is a replacement patch.
> 
> Thanks again, Bartlomiej.
> 
> Mark
> --
> Marvell makes a line of host bridge for PPC and MIPS systems.  On those 
> bridges is an i2c controller.  This patch adds the driver for that i2c 
> controller.
> 
> Please apply.
> 
> Depends on patch submitted by Jean Delvare: 
> http://archives.andrew.net.au/lm-sensors/msg29405.html
> 
> Signed-off-by: Mark A. Greer <mgreer@mvista.com>

Applied, thanks.

greg k-h
