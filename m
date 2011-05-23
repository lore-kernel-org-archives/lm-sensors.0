From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 23 May 2011 13:52:44 +0000
Subject: Re: [lm-sensors] [PATCH] Add support for the Philips SA56004
Message-Id: <20110523135244.GA6897@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1305814253-12528-1-git-send-email-sdevrien@cisco.com>
 <20110523043711.GA4890@ericsson.com>
 <6E4D2678AC543844917CA081C9D6B33F047F51E5@XMB-AMS-103.cisco.com>
In-Reply-To: <6E4D2678AC543844917CA081C9D6B33F047F51E5@XMB-AMS-103.cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Stijn Devriendt (sdevrien)" <sdevrien@cisco.com>
Cc: "khali@linux-fr.org" <khali@linux-fr.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Mon, May 23, 2011 at 03:08:42AM -0400, Stijn Devriendt (sdevrien) wrote:
> > -----Original Message-----
> > From: Guenter Roeck [mailto:guenter.roeck@ericsson.com]
> > 
> > >  	if (!name) { /* identification failed */
> > > @@ -1372,6 +1401,18 @@ static int lm90_probe(struct i2c_client
> > *new_client,
> > >  	/* Set maximum conversion rate */
> > >  	data->max_convrate = lm90_params[data->kind].max_convrate;
> > >
> > > +	if (data->flags & LM90_HAVE_LOCAL_EXT) {
> > > +		if (lm90_params[data->kind].local_ext_offset > 0)
> > > +			data->local_ext_offset > > > +
> lm90_params[data->kind].local_ext_offset;
> > > +		else {
> > > +			dev_err(&new_client->dev,
> > > +			  "Invalid temperature extension register. "
> > > +			  "Accuracy may be limited.\n");
> > > +			data->flags &= (~LM90_HAVE_LOCAL_EXT);
> > > +		}
> > 
> > Either { } in both branches of the if statement, or none.
> > ( ) around ~LM90_HAVE_LOCAL_EXT is unnecessary.
> > 
> > I see it as BUG if LM90_HAVE_LOCAL_EXT is set but local_ext_offset
> isn't.
> > That should be found during coding (or code review), and not be
> exported
> > to the user. So, from my perspective, the check is unnecessary. I'll
> leave
> > that up to Jean to decide, though.
> > 
> Do you think a BUG_ON() would be better suited here?
> 
I would just use

	data->local_ext_offset = lm90_params[data->kind].local_ext_offset;

without any conditionals (the if statements just add code without real value),
followed by

	BUG_ON((data->flags & LM90_HAVE_LOCAL_EXT) && data->local_ext_offset = 0);

if you want to be sure.

> > In addition to the above, your patch generates several checkpatch
> errors
> > (trailing whitespace). Please fix.
> I recall letting checkpatch yell at me... I'll have another round of it
> to
> be sure.
> 
Try to apply your own patch, and you'll see git complain about whitespace errors.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
