From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 20 Jun 2009 08:21:01 +0000
Subject: Re: [lm-sensors] [PATCH 1/1] HWMON: max6650, fix lock imbalance
Message-Id: <20090620102101.35e92c01@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1245446795-1901-1-git-send-email-jirislaby@gmail.com>
	<20090619230252.GB3862@local>
In-Reply-To: <20090619230252.GB3862@local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Hans J. Koch" <hjk@linutronix.de>, Jiri Slaby <jirislaby@gmail.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

On Sat, 20 Jun 2009 01:02:52 +0200, Hans J. Koch wrote:
> On Fri, Jun 19, 2009 at 11:26:35PM +0200, Jiri Slaby wrote:
> > Add omitted update_lock to one switch/case in set_div.
> 
> Ahem, yes, thanks!
> 
> > 
> > Signed-off-by: Jiri Slaby <jirislaby@gmail.com>
> 
> Signed-off-by: Hans J. Koch <hjk@linutronix.de>
> 
> > ---
> >  drivers/hwmon/max6650.c |    1 +
> >  1 files changed, 1 insertions(+), 0 deletions(-)
> > 
> > diff --git a/drivers/hwmon/max6650.c b/drivers/hwmon/max6650.c
> > index 86142a8..58f66be 100644
> > --- a/drivers/hwmon/max6650.c
> > +++ b/drivers/hwmon/max6650.c
> > @@ -418,6 +418,7 @@ static ssize_t set_div(struct device *dev, struct device_attribute *devattr,
> >  		data->count = 3;
> >  		break;
> >  	default:
> > +		mutex_unlock(&data->update_lock);
> >  		dev_err(&client->dev,
> >  			"illegal value for fan divider (%d)\n", div);
> >  		return -EINVAL;

Applied, thanks.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
