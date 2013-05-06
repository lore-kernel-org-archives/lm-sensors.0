From: Jingoo Han <jg1.han@samsung.com>
Date: Mon, 06 May 2013 04:41:58 +0000
Subject: Re: [lm-sensors] [PATCH 1/5] hwmon: (abituguru3) remove unnecessary platform_set_drvdata()
Message-Id: <004a01ce4a14$0b1eeae0$215cc0a0$@samsung.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <002901ce4a0d$b899cac0$29cd6040$@samsung.com>
In-Reply-To: <002901ce4a0d$b899cac0$29cd6040$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Monday, May 06, 2013 1:29 PM, Guenter Roeck wrote:
> On Mon, May 06, 2013 at 12:56:43PM +0900, Jingoo Han wrote:
> > The driver core clears the driver data to NULL after device_release
> > or on probe failure, since commit 0998d0631001288a5974afc0b2a5f568bcdecb4d
> > (device-core: Ensure drvdata = NULL when no driver is bound).
> > Thus, it is not needed to manually clear the device driver data to NULL.
> >
> > Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> 
> Hi,
> 
> the entire series was already submitted by Sachin Kamat last Friday,
> and is already enqueued in my -next tree. It will be visible in the -next
> tree after the commit window closes.

Hi Guenter Roeck,
OK, I see. :)
Thank you.

> 
> Thanks,
> Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
