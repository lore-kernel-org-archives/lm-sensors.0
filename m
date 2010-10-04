From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 04 Oct 2010 13:29:23 +0000
Subject: Re: [lm-sensors] [RFC PATCH 8/9] hwmon: lis3: use block read to
Message-Id: <20101004132923.GA3269@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1285933616-16044-1-git-send-email-samu.p.onkalo@nokia.com>
 <1285933616-16044-9-git-send-email-samu.p.onkalo@nokia.com>
 <4CA9BD6E.6040002@cam.ac.uk>
In-Reply-To: <4CA9BD6E.6040002-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
Cc: Samu Onkalo <samu.p.onkalo-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, "eric.piel-VkQ1JFuSMpfAbQlEx87xDw@public.gmane.org" <eric.piel-VkQ1JFuSMpfAbQlEx87xDw@public.gmane.org>, "khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org" <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org" <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>

On Mon, Oct 04, 2010 at 07:41:34AM -0400, Jonathan Cameron wrote:
> On 10/01/10 12:46, Samu Onkalo wrote:
> > Add optional blockread function to interface driver. If available
> > the chip driver uses it for data register access. For 12 bit device
> > it reads 6 bytes to get 3*16bit data. For 8 bit device it reads out
> > 5 bytes since every second byte is dummy.
> > This optimizes bus usage and reduces number of operations and
> > interrupts needed for one data update.
> 
> Do we need to query if the i2c bus supports block reading or are they
> all guaranteed to do so?
> 
Not really. It may be true that block reads happen to be supported on 
all i2c controllers used on all boards using this chip, but that
is pretty much a coincidence.

> I'm guessing not seeing as i2c.h has a functionality bit for it...
> I2C_FUNC_SMBUS_READ_BLOCK_DATA
> 
> Otherwise looks good.  Either justify that all i2c buses will work
> or add the functionality check and you can add.
> 
Should really have the check. And, for completeness, the driver should
check if BYTE_DATA is supported as well. Besides, adding the check
seems to be much less effort than trying to explain why it isn't needed.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
