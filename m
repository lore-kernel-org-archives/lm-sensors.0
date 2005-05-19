From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:38 +0000
Subject: [PATCH][I2C] ST M41T00 I2C RTC chip driver
Message-Id: <20050217222601.GG21188@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <41FE7368.1000307@mvista.com> <20050131210319.44a69d49.khali@linux-fr.org> <41FFE9EE.3000504@mvista.com> <420401EB.5080700@mvista.com> <20050204232525.GA28571@kroah.com> <42040D79.8040502@mvista.com>
In-Reply-To: <42040D79.8040502@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Mark A. Greer" <mgreer@mvista.com>
Cc: LM Sensors <sensors@Stimpy.netroedge.com>, LKML <linux-kernel@vger.kernel.org>

On Fri, Feb 04, 2005 at 05:04:09PM -0700, Mark A. Greer wrote:
> Greg KH wrote:
> 
> >Can you resend it with a proper Changelog description in the top of the
> >email and the signed-off-by line?  thanks,
> >
> >greg k-h
> >
> > 
> >
> Certainly.
> --
> 
> This patch adds support for the ST M41T00 I2C RTC chip.
> 
> This rtc chip has no mechanism to freeze it's registers while being 
> read; however, it will delay updating the external values of the 
> registers for 250ms after a register is read.  To ensure that a sane 
> time value is read, the driver verifies that the same registers values 
> were read twice before returning.
> 
> Also, when setting the rtc from an interrupt handler, a tasklet is used 
> to provide the context required by the i2c core code.
> 
> Please apply.

Applied, thanks.

greg k-h
