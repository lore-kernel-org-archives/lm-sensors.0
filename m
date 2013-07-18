From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 18 Jul 2013 20:43:23 +0000
Subject: Re: [lm-sensors] [patch] hwmon: using wrong ARRAY_SIZE() limit
Message-Id: <20130718204323.GA4110@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20130717084317.GA4851@elgon.mountain>
In-Reply-To: <20130717084317.GA4851@elgon.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kernel-janitors@vger.kernel.org

On Thu, Jul 18, 2013 at 05:41:08PM +0200, walter harms wrote:
> 
> 
> Am 18.07.2013 01:36, schrieb Guenter Roeck:
> > On Wed, Jul 17, 2013 at 03:26:14PM +0300, Dan Carpenter wrote:
> >> We cleaned up this code to use ARRAY_SIZE() instead of just the number
> >> 4.  The problem is that data->reg_temp[] has 5 elements and we actually
> >> wanted ARRAY_SIZE(data->temp) which has 4 elements.
> >>
> >> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> >>
> > Hi Dan,
> > 
> > good catch, except that the array size of data->temp[] should be 5, not 4.
> > So the real culprit is commit 7cbbd6a (Add support for critical low/high
> > temperature limits on NCT6106) which increased the size of reg_temp but not the
> > size of temp.
> > 
> > Do you want to send me a patch fixing that, or should I take care of it ?
> > 
> > Thanks,
> > Guenter
> 
> hi Guenther,
> is an array the way to go here ? To avoid that kind of problems they sould be
> connected some how. Is it possible to replace the array with a malloc() ?
> 
To clean it up I should probably add a define for the array sizes. A malloc
would be overkill.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
