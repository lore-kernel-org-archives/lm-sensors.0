From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 07 Jul 2011 18:06:51 +0000
Subject: Re: [lm-sensors] [PATCHv3 1/1] Hwmon: Add core_pkg Threshold
Message-Id: <1310062011.2387.11.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1309885334-16106-1-git-send-email-durgadoss.r@intel.com>
In-Reply-To: <1309885334-16106-1-git-send-email-durgadoss.r@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 2011-07-07 at 07:08 -0400, R, Durgadoss wrote:
> Hi Guenter/Jean,
> 
> > > I don't think we want to deal with this interrupt in coretemp at all.
> > > This is all therm_throt's job.
> > >
> > Agreed.
> 
> From the earlier mails, what I clearly get is that we don't want 'coretemp'
> to deal with the Threshold Violation Interrupts.
> In this case, I would submit the next version of the patch doing:
> 1) Update the max_alarm by reading 0x19C and checking the status bits
> 2) Since I see different opinions on max and max_hyst comparisons,
>    Should I do a check inside the store methods ?
> 
No agreement -> do nothing, ie no check.

Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
