From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 10 Aug 2011 17:41:06 +0000
Subject: Re: [lm-sensors] [PATCH 2/3] hwmon: Fix applesmc temperature
Message-Id: <1312998066.2214.28.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1312906483-3046-2-git-send-email-mjg@redhat.com>
In-Reply-To: <1312906483-3046-2-git-send-email-mjg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 2011-08-10 at 13:17 -0400, Matthew Garrett wrote:
> On Wed, Aug 10, 2011 at 10:05:05AM -0700, Guenter Roeck wrote:
> > >  	if (entry->len = 2) {
> > > +		if (buffer[0] >= 0x80) {
> > > +			/* The two byte format is signed - ignore negative */
> > > +			return -EINVAL;
> > > +		}
> > 
> > Kind of unusual. Do you have evidence that such an error is in fact
> > seen ? If there is no such evidence, I'd rather keep the original code.
> > We don't usually return errors for negative temperature readings just
> > because we assume that the readings might be erroneous.
> 
> Yeah, my MBA returns these from TCZ3 and TH0F. Typical read value is 
> 0xf978. There may be some other underlying issue that's triggering this, 
> but returning data that's known to be bogus seems unhelpful.
> 
Sounds like that is a persistent condition, though, not a temporary one.
Negative values returned from temperature sensors often indicate either
a non-existing thermistor or a sensor fault.

Personally, I think it would be better to just ignore the returned
value. Ultimately, you'll have to add an entry into sensors.conf anyway,
and returning an error just because the returned value _might_ be wrong
does not seem to be a good idea to me.

Either case, -EINVAL seems wrong. Maybe -EIO.

Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
