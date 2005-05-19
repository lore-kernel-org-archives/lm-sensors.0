From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:24 +0000
Subject: adm1026 driver port for kernel 2.6.10-rc2 (patch includes driver,
Message-Id: <20041124223500.GA3787@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041102221745.GB18020@penguincomputing.com> <NN38qQl1.1099468908.1237810.khali@gcu.info> <20041103164354.GB20465@penguincomputing.com> <20041118185612.GA20728@penguincomputing.com> <20041123165236.GA4936@penguincomputing.com> <20041124213600.GA3165@kroah.com> <20041124231017.GA10171@penguincomputing.com>
In-Reply-To: <20041124231017.GA10171@penguincomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Justin Thiessen <jthiessen@penguincomputing.com>
Cc: phil@netroedge.com, khali@linux-fr.org, sensors@Stimpy.netroedge.com, linux-kernel@vger.kernel.org

On Wed, Nov 24, 2004 at 03:10:17PM -0800, Justin Thiessen wrote:
> On Wed, Nov 24, 2004 at 01:36:00PM -0800, Greg KH wrote:
> > Hm, this looks like a bug:
> 
> <snip egregious stupidity>
> 
> > Care to fix this up and resend the whole patch?
> 
> Affirmative.
> 
> > Oh, and it should be "Signed-off-by:" not "Signed off by:" like you had
> > used :)
> 
> See below:

Applied, thanks.

Oh, I did make one change:

> +/* Adjust fan_min to account for new fan divisor */
> +void fixup_fan_min(struct device *dev, int fan, int old_div)

This should be static.

thanks,

greg k-h
