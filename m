From: sr@denx.de (Stefan Roese)
Date: Fri, 30 Jun 2006 07:18:07 +0000
Subject: [lm-sensors] [PATCH] I2C: Add MAX6900 I2C RTC support (4th try!)
Message-Id: <200606300918.07474.sr@denx.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <200511231317.41695.sr@denx.de>
In-Reply-To: <200511231317.41695.sr@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

On Sunday 25 June 2006 22:28, Jean Delvare wrote:
> > This patch adds support for the Maxim/Dallas MAX6900 I2C RTC.
> >
> > Signed-off-by: Stefan Roese <sr at denx.de>
>
> Sorry, I didn't have the time to review your driver back then. Now
> there is a new RTC subsystem where your driver would fit better, so if
> you are still interested in having your driver merged, please submit it
> again for inclusion into this subsystem (drivers/rtc).

Yes, I will try to find some time in the next weeks to do this.

> The RTC 
> subsystem is maintained by Alessandro Zummo.

Is the lm-sensors mailinglist the correct list also for this new rtc 
subsystem?

Best regards,
Stefan

