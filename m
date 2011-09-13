From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 13 Sep 2011 12:55:38 +0000
Subject: Re: [lm-sensors] [PATCHv4 1/1] Hwmon: Add core/pkg Threshold
Message-Id: <20110913125538.GA26372@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1310468836-5517-1-git-send-email-durgadoss.r@intel.com>
In-Reply-To: <1310468836-5517-1-git-send-email-durgadoss.r@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Sep 13, 2011 at 05:22:40AM -0400, R, Durgadoss wrote:
> Hi Jean,
> 
> [snip] 
> > I am still suspicious... Does this mean that the thermal interrupt
> > mechanism is disabled by default?
> [snip]
> 
> As you rightly pointed out, the Interrupts for the thresholds are disabled,
> by default. We have to enable them if we decide to do so.
> If we enable them, we will get interrupts when the input temperature
> Crosses temp1_max and temp1_max_hyst in either directions. 
> 
> The temp1_max is supposed to be more than temp1_input and
> temp1_max_hyst is supposed to be lesser than temp1_input.
> By default the temp1_max_hyst is left at 0.
> 
Should be set to something useful. Also, it does not have to be less
than temp1_input, as long as it is less than temp1_max (which was my
understanding). Worst case you would get another interrupt (when the
temperature crosses temp1_max_hyst from below) which you would ignore.

Interrupts should be enabled, and you can send uevents and sysfs notifications
whenever a threshold is crossed. All you would have to do is to keep the old alarm
state and send events whenever it changes.

Example:
	temp@, max_thresholdP, max`

1st interrupt when temp reaches 50 -> ignore
2nd interrupt when temp reaches 60 -> set alarm, send uevent and sysfs notifications
3rd interrupt when temp reaches 60 (from above) -> ignore
4th interrupt when temp reaches 50 (from above) -> reset alarm, send uevent and sysfs notifications 

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
