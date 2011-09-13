From: "R, Durgadoss" <durgadoss.r@intel.com>
Date: Tue, 13 Sep 2011 09:34:40 +0000
Subject: Re: [lm-sensors] [PATCHv4 1/1] Hwmon: Add core/pkg Threshold
Message-Id: <D6D887BA8C9DFF48B5233887EF04654109E8CBB769@bgsmsx502.gar.corp.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1310468836-5517-1-git-send-email-durgadoss.r@intel.com>
In-Reply-To: <1310468836-5517-1-git-send-email-durgadoss.r@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

[snip] 
> I am still suspicious... Does this mean that the thermal interrupt
> mechanism is disabled by default?
[snip]

As you rightly pointed out, the Interrupts for the thresholds are disabled,
by default. We have to enable them if we decide to do so.
If we enable them, we will get interrupts when the input temperature
Crosses temp1_max and temp1_max_hyst in either directions. 

The temp1_max is supposed to be more than temp1_input and
temp1_max_hyst is supposed to be lesser than temp1_input.
By default the temp1_max_hyst is left at 0.

I wanted to use the ABI names temp1_thresh1 and temp1_thresh0.
But Guenter pointed out those are new ABI names, which nobody
is aware of. So, I reused the existing ABI.

The basic idea is this:
Consider, the input temperature is 40. 
We configure the max to 45 and max_hyst to 35.
Case 1:
------
After a while, the temperature reaches 45. We get an interrupt,
and throttle the factors that cause an increase in temperature.
(For example, reduce CPU frequency)
Case 2:
------
After a while, the temperature reaches 35. We get an interrupt,
and release the throttle (if we had any) or increase the
performance.

Our coretemp driver, on getting these interrupts, will
notify the user space (possibly through Uevent or something)
Then the user space will take appropriate actions.

This is what I had in mind, when I submitted this patch.
I am willing to add code to coretemp that will do this.

Kindly let me know your thoughts on this.

Thanks,
Durga

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
