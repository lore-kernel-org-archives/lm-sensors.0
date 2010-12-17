From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 17 Dec 2010 19:59:34 +0000
Subject: Re: [lm-sensors] [Patch]Adding_threshold_support_to_coretemp
Message-Id: <20101217195934.GA12933@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <D6D887BA8C9DFF48B5233887EF04654105C117387C@bgsmsx502.gar.corp.intel.com>
In-Reply-To: <D6D887BA8C9DFF48B5233887EF04654105C117387C@bgsmsx502.gar.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Dec 17, 2010 at 01:17:09PM -0500, Fenghua Yu wrote:
[ ... ]
> > >  temp1_max   - All cooling devices should be turned on (on Core2).
> > > +              If the IA32_TEMPERATURE_TARGET is not supported, this
> > > +              value indicates the higher core threshold. When the CPU
> > > +              temperature crosses this temperature, an interrupt is
> > > +              generated.
> The temp1_max explanation is confusing. This is not what your code is doing.
> If both IA32_TEMPERATURE_TARGET and threshold are supported (most likely in
> new processors), this explanation goes nowhere.
> 
Then find a better text.

> > > +temp1_min   - Indicates the lower threshold of the core. An interrupt is
> > > +              generated when CPU temperature crosses this threshold.
> 
> Guenter and Durgadoss, I don't want to discuss this back and forth. But can we
> use temp1_max_alarm and temp1_min_alarm as the threshold interfaces? Seems they
> are existing interfaces and won't chang legacy temp1_max meaning in coretemp?
> 
Those are _alarms_, ie flags, not values.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
