From: "R, Durgadoss" <durgadoss.r@intel.com>
Date: Sat, 17 Sep 2011 17:10:40 +0000
Subject: Re: [lm-sensors] [PATCHv4 1/1] Hwmon: Add core/pkg Threshold
Message-Id: <D6D887BA8C9DFF48B5233887EF04654109E8D6D1FB@bgsmsx502.gar.corp.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1310468836-5517-1-git-send-email-durgadoss.r@intel.com>
In-Reply-To: <1310468836-5517-1-git-send-email-durgadoss.r@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter/Jean,

[snip..] 
> > But anyway, the current state of the coretemp driver is simply not
> > good, so we have to do something. Short of a better proposal, I'd say
> > yes, let's go with tempX_threshold[0-7] and their associated alarms.
> >
> Alarms is tricky. Keep in mind that those thresholds are non-directional and
> trigger each time the temperature is reached, from above or from below.
> Unless relationship between the threshold is well defined, such as with
> <hyst, max> as we tried before, an "alarm" attribute on a single threshold
> does not have a well defined meaning. An attribute named "triggered"
> or similar might make more sense - something that causes a notification
> if triggered and auto-resets after being read.
> 
> Still, with Durgadoss' other email, I am not sure I like where this is going.
> I thought the idea was to trigger interrupts which would result in a
> notification
> on the alarm attribute. As it is, it looks like the idea is to have the
> interrupts handled by arch/x86/kernel/cpu/mcheck/therm_throt.c. If so,
> I think it might be better to handle thresholds completely in the thermal
> throttling code.
> 

It was just a suggestion from me that we can handle the interrupts from
within therm_throt since there was code in there, doing this already.
I did not know (in fact do not know..) how to catch these interrupts
inside coretemp. That's why I thought of adding code in therm_throt.

If it's not the right way to go, I am open to other ideas.

On the other hand, I am fine with the idea of having tempX_threshold[0-7]
and their alarms. We can use the 'status' bits in the THERM_STATUS 
register to represent the alarm. The logic can be something like this:

//Log bits indicate the input temperature reached the configured threshold;
//but we do not know from which direction.
if (msr_val & THERM_LOG_THRESHOLD0) {
	//if the status bit is one, the input temperature is higher than the
	//configured threshold. If it is zero, the input temperature is lower
	//than the configured threshold.
	bool alarm = msr_val & THERM_STATUS_THRESHOLD0;
		print: alarm
	//Let the user space take care of 0/1 from the *_alarm interfaces.
}

Does this look Ok ? 
Or, kindly suggest alternatives.

Thanks,
Durga

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
