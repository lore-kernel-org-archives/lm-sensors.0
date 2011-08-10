From: Matthew Garrett <mjg@redhat.com>
Date: Wed, 10 Aug 2011 17:17:53 +0000
Subject: Re: [lm-sensors] [PATCH 2/3] hwmon: Fix applesmc temperature
Message-Id: <20110810171753.GB7012@srcf.ucam.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1312906483-3046-2-git-send-email-mjg@redhat.com>
In-Reply-To: <1312906483-3046-2-git-send-email-mjg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Aug 10, 2011 at 10:05:05AM -0700, Guenter Roeck wrote:
> >  	if (entry->len = 2) {
> > +		if (buffer[0] >= 0x80) {
> > +			/* The two byte format is signed - ignore negative */
> > +			return -EINVAL;
> > +		}
> 
> Kind of unusual. Do you have evidence that such an error is in fact
> seen ? If there is no such evidence, I'd rather keep the original code.
> We don't usually return errors for negative temperature readings just
> because we assume that the readings might be erroneous.

Yeah, my MBA returns these from TCZ3 and TH0F. Typical read value is 
0xf978. There may be some other underlying issue that's triggering this, 
but returning data that's known to be bogus seems unhelpful.

-- 
Matthew Garrett | mjg59@srcf.ucam.org

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
