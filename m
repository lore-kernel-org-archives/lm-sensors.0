From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 17 Dec 2010 22:26:36 +0000
Subject: Re: [lm-sensors] [Patch]Adding_threshold_support_to_coretemp
Message-Id: <20101217222636.GB13207@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <D6D887BA8C9DFF48B5233887EF04654105C117387C@bgsmsx502.gar.corp.intel.com>
In-Reply-To: <D6D887BA8C9DFF48B5233887EF04654105C117387C@bgsmsx502.gar.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Dec 17, 2010 at 02:59:34PM -0500, Guenter Roeck wrote:
> On Fri, Dec 17, 2010 at 01:17:09PM -0500, Fenghua Yu wrote:
> [ ... ]
> > > >  temp1_max   - All cooling devices should be turned on (on Core2).
> > > > +              If the IA32_TEMPERATURE_TARGET is not supported, this
> > > > +              value indicates the higher core threshold. When the CPU
> > > > +              temperature crosses this temperature, an interrupt is
> > > > +              generated.
> > The temp1_max explanation is confusing. This is not what your code is doing.
> > If both IA32_TEMPERATURE_TARGET and threshold are supported (most likely in
> > new processors), this explanation goes nowhere.
> > 
> Then find a better text.
> 
... such as:

temp1_max	Temperature at which all cooling devices should be turned on.
		Initialized with IA32_TEMPERATURE_TARGET if supported, otherwise
		initialized with (tjmax - <pick something>).
		When the CPU temperature reaches this temperature, an interrupt is
		generated and temp1_max_alarm is set.

temp1_max_hyst	If the CPU temperature falls below than this temperature, an interrupt
		is generated and temp1_max_alarm is reset.

temp1_max_alarm	Set if the temperature reaches or exceeds temp1_max. Reset if the temperature 
		drops to or below temp1_max_hyst.

This would extend the semantics of temp1_max, but not redefine it. Also, temp1_max_alarm
could conveniently be implemented such that it supports polling, and be used by an application 
with poll() or select().

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
