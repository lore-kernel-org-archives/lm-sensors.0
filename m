From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 04 Oct 2010 06:59:54 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: LTC4261 Hardware monitoring driver
Message-Id: <20101004085954.40867c90@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1284784361-18893-1-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1284784361-18893-1-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 3 Oct 2010 18:18:07 -0700, Guenter Roeck wrote:
> Hi Ira,
> 
> On Sun, Oct 03, 2010 at 05:17:42PM -0400, Ira W. Snyder wrote:
> > > +MODULE_DEVICE_TABLE(i2c, ltc4261_id);
> > > +
> > > +/* This is the driver that will be inserted */
> > > +static struct i2c_driver ltc4261_driver = {
> > > +   .driver = {
> > > +              .name = "ltc4261",
> > > +              },
> > > +   .probe = ltc4261_probe,
> > > +   .remove = ltc4261_remove,
> > > +   .id_table = ltc4261_id,
> > > +};
> > > +
> > 
> > I'd align the equal signs, like the ltc4245 driver does. No strong
> > preference, though. Like this:
> > 
> > static struct i2c_driver ltc4261_driver = {
> >         .driver = {
> >                 .name   = "ltc4261",
> >         },
> >         .probe          = ltc4261_probe,
> >         .remove         = ltc4261_remove,
> >         .id_table       = ltc4261_id,
> > };
> > 
> The formatting is the result of Lindent, which doesn't seem to like
> the extra blanks. In questions like this - where much of it is
> personal preference - I prefer to go with the Lindent results.

FWIW, I've never used Lindent. I only consider it as a tool for
converting really ugly-formatted code to acceptably-formatted code, not
as the perfect formatting script.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
