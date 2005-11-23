From: sr@denx.de (Stefan Roese)
Date: Wed, 23 Nov 2005 15:54:49 +0000
Subject: [lm-sensors] [PATCH] I2C: Add MAX6900 I2C RTC support
Message-Id: <200511231554.04320.sr@denx.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <200511231317.41695.sr@denx.de>
In-Reply-To: <200511231317.41695.sr@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

On Wednesday 23 November 2005 14:45, Jean Delvare wrote:
> On 2005-11-23, Stefan Roese wrote:
> > This patch adds support for the Maxim/Dallas MAX6900 I2C RTC.
>
> -ENOPATCH
> Try again with the proper attachement type.

Hmmm. All other mailinglists seem to have no problem with ".patch" as file 
extension. Here another try with ".diff".

> Back in March 2004, Anthony Petillo told us he was working on a MAX6900
> driver for Linux 2.4. We never heard back as far as I remember (but I
> have a bad memory). Does your own driver has anything to do with
> Anthony's work?

No. I also found this refenrence, but no driver.

> Can you check whether sensors-detect finds your MAX6900 chip?

Sorry, but I didn't check and I am bit short in time. Is this a requirement?

> What hardware do you have a MAX6900 chip on?

It's used on the Prodrive P3P440, a PPC440GP based PMC module. I commited it's 
platform support yesterday to the ppc community.

Best regards,
Stefan
