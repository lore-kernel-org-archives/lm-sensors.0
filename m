From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 21 Oct 2008 12:27:52 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Add LTC4245 driver
Message-Id: <20081021142752.35869755@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081020160308.GA22915@ovro.caltech.edu>
In-Reply-To: <20081020160308.GA22915@ovro.caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 20 Oct 2008 19:29:50 +0200, Hans de Goede wrote:
> 
> 
> Ira Snyder wrote:
> > Add Linux support for the Linear Technology LTC4245 Multiple Supply Hot
> > Swap controller I2C monitoring interface.
> > 
> > Signed-off-by: Ira W. Snyder <iws@ovro.caltech.edu>
> > ---
> > 
> > I'm pretty sure this should be the final revision of the driver. Please
> > go ahead and forward it upstream. :)
> > 
> 
> Looks good now :)
> 
> Jean, can you put this patch in your for Linus for 2.6.28 queue please?
> 
> This is:
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> or
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> 
> Whatever you deem more appropriate.

Actually that would be:

Acked-by: Hans de Goede <hdegoede@redhat.com>

Signed-off-by would technically require that you resend the patch to me.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
