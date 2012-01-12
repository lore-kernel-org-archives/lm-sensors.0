From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 12 Jan 2012 10:22:51 +0000
Subject: Re: [lm-sensors] [PATCH] Drivers: hwmon: adm1031: fixed spacing coding style issues
Message-Id: <20120112102251.GA16184@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1321605413-13614-1-git-send-email-zac.3.14159@gmail.com>
 <20111118103501.3c14d106@endymion.delvare>
 <20120112090149.1acbff01@endymion.delvare>
In-Reply-To: <20120112090149.1acbff01@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: Zac Storer <zac.3.14159@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>

On Thu, Jan 12, 2012 at 03:01:49AM -0500, Jean Delvare wrote:
> On Fri, 18 Nov 2011 10:35:01 +0100, Jean Delvare wrote:
> > On Fri, 18 Nov 2011 01:36:53 -0700, Zac Storer wrote:
> > > Fixed spacing coding style issues.
> > > 
> > > Signed-off-by: Zac Storer <zac.3.14159@gmail.com>
> > > ---
> > >  drivers/hwmon/adm1031.c |    2 +-
> > >  1 files changed, 1 insertions(+), 1 deletions(-)
> > > 
> > > diff --git a/drivers/hwmon/adm1031.c b/drivers/hwmon/adm1031.c
> > > index 0683e6b..694392b 100644
> > > --- a/drivers/hwmon/adm1031.c
> > > +++ b/drivers/hwmon/adm1031.c
> > > @@ -1058,7 +1058,7 @@ static struct adm1031_data *adm1031_update_device(struct device *dev)
> > >  			data->alarm &= 0xc0ff;
> > >  		}
> > >  
> > > -		for (chan=0; chan<(data->chip_type = adm1030 ? 1 : 2); chan++) {
> > > +		for (chan = 0; chan < (data->chip_type = adm1030 ? 1 : 2); chan++) {
> > >  			data->fan_div[chan] > > >  			    adm1031_read_value(client, ADM1031_REG_FAN_DIV(chan));
> > >  			data->fan_min[chan] > > 
> > Err, you apparently did not understand my request. Please send _one_
> > patch fixing all the adm1031 coding style issues at once.
> 
> Zac, do you have an updated patch for me?
> 
Just sent you one, with Zac's patches merged into one and (almost) all other checkpatch issues
fixed as well.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
