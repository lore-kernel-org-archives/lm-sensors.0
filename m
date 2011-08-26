From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 26 Aug 2011 15:50:09 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] hwmon: (pmbus/adm1275) Add support for
Message-Id: <1314373809.2796.76.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1314324755-18514-3-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1314324755-18514-3-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 2011-08-26 at 11:16 -0400, Jean Delvare wrote:
> On Fri, 26 Aug 2011 06:52:38 -0700, Guenter Roeck wrote:
> > On Fri, Aug 26, 2011 at 08:29:53AM -0400, Jean Delvare wrote:
> > > On Thu, 25 Aug 2011 19:12:35 -0700, Guenter Roeck wrote:
> > > > @@ -78,11 +83,24 @@ static int adm1275_read_word_data(struct i2c_client *client, int page, int reg)
> > > >  	case PMBUS_VIRT_READ_VIN_MAX:
> > > >  		ret = pmbus_read_word_data(client, 0, ADM1275_PEAK_VIN);
> > > >  		break;
> > > > +	case PMBUS_VIRT_READ_PIN_MAX:
> > > > +		if (data->id != adm1276) {
> > > > +			ret = -EINVAL;
> > > > +			break;
> > > > +		}
> > > > +		ret = pmbus_read_word_data(client, 0, ADM1276_PEAK_PIN);
> > > > +		break;
> > > >  	case PMBUS_VIRT_RESET_IOUT_HISTORY:
> > > >  	case PMBUS_VIRT_RESET_VOUT_HISTORY:
> > > >  	case PMBUS_VIRT_RESET_VIN_HISTORY:
> > > >  		ret = 0;
> > > >  		break;
> > > > +	case PMBUS_VIRT_RESET_PIN_HISTORY:
> > > > +		if (data->id != adm1276)
> > > > +			ret = -EINVAL;
> > > > +		else
> > > > +			ret = 0;
> > > > +		break;
> > > 
> > > As with the previous patch, I am confused by the mix of -EINVAL and
> > > -ENODATA for unsupported features.
> >
> > Same as before - the calling code reacts differently.
> 
> But then this means that your patch changes the behavior for the
> ADM1275, while it is supposed to only add support for the ADM1276. This
> can't be right, can it?
> 
The AD1275 does not have support for maximum power and thus also not for
resetting its history. So far the chip driver returned -ENODATA in this
case, which for virtual commands causes the calling code to abort (it
checks for virtual commands and does not try to send those to the chip).
So the only difference is that the calling code now aborts immediately
since it gets -EINVAL from the chip driver, while earlier it had to
perform an additional check if the command is virtual, which also caused
it to abort.

I'll really have to spend some time documenting all this.

Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
