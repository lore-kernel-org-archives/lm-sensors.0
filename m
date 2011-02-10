From: "Ian Dobson" <i.dobson@planet-ian.com>
Date: Thu, 10 Feb 2011 19:34:32 +0000
Subject: Re: [lm-sensors] [PATCH v2 5/5] hwmon: (w83627ehf) Add support for
Message-Id: <BEE238AC2FE441DC9DA03B430EBDD03E@portable2>
List-Id: <lm-sensors.vger.kernel.org>
References: <1297352949-25602-6-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1297352949-25602-6-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



--------------------------------------------------
From: "Guenter Roeck" <guenter.roeck@ericsson.com>
Sent: Thursday, February 10, 2011 7:59 PM
To: "Ian Dobson" <i.dobson@planet-ian.com>
Cc: "Jean Delvare" <khali@linux-fr.org>; "Andy Lutomirski" <luto@mit.edu>; 
<lm-sensors@lm-sensors.org>
Subject: Re: [PATCH v2 5/5] hwmon: (w83627ehf) Add support for Nuvoton 
NCT6775F and NCT6776F

> On Thu, 2011-02-10 at 13:37 -0500, Ian Dobson wrote:
> [ ... ]
>
>> Hi Guenter,
>>
>> Are you sure the smartfan readout of pwm_* parameters actually works
>> correctly on nct6776f chips?
>>
> Not really.
>
>> root@alpha2:/sys/devices/platform/w83627ehf.656# cat pwm1_enable
>> 5
>> root@alpha2:/sys/devices/platform/w83627ehf.656# cat pwm1
>> 193
>> root@alpha2:/sys/devices/platform/w83627ehf.656# cat pwm1_mode
>> 1
>> root@alpha2:/sys/devices/platform/w83627ehf.656# cat pwm1_target
>> 0
>> root@alpha2:/sys/devices/platform/w83627ehf.656# cat pwm1_tolerance
>> 0
>> root@alpha2:/sys/devices/platform/w83627ehf.656# cat pwm1_start_output
>> 1
>> root@alpha2:/sys/devices/platform/w83627ehf.656# cat pwm1_step_output
>> 255
>> root@alpha2:/sys/devices/platform/w83627ehf.656# cat  pwm1_stop_output
>> 1
>>
>> It looks as if pwm1 is in smartfan mode but the remaining parameters look
>> totally wrong. Maybe there's parameters are only valid in thermal cruise
>> mode. I'll study the code at the weekend and maybe playing with my test 
>> box.
>>
> Keep in mind that SmartFan IV isn't fully supported, ie it is not
> possible to set any SmartFan IV specific registers. So question is what
> we would want to do if the system is configured for SmartFan IV mode.
> Right now the code just reports that SmartFan IV is configured; the
> other registers don't really mean anything in that mode. An option might
> be to make the other attributes read-only if SmartFan IV is configured.
> And maybe I should add some text to the documentation explaining this in
> more detail.
>
> We could of course add full SmartFan IV support, but that goes a bit
> beyond the time I have available, and I would not want to hold nct677X
> chip support hostage for it.
>
> Input is welcome ...
>
> Thanks,
> Guenter
>
>

Hi Guenter,

Maybe if the parameters (_target, _tolerance etc) are invalid in smartfan 
mode, we should return invalid-ENOVAL? It would be interesting to be able to 
actually control the setpoints, for example on my box running the fans is 
silent mode the CPU temperature is abit high for my liking and and standard 
mode the fans are too loud. Something in between  would be good.

I have no problems with getting a driver out that monitors correctly, even 
if control doesn't work. Most people would be happy with that, and when you 
think that the new motherboards (1155) only came out 1 month ago, and the 
lm-sensors project already has support for the superIO chips used on most 
boards.

I'll start looking into the code at the weekend, and if I'm lucky I'll find 
whats wrong with the smartfan stuff.

Regards and thanks again for the great work.
Ian Dobson

 


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
