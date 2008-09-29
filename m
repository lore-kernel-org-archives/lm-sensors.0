From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Mon, 29 Sep 2008 20:38:08 +0000
Subject: Re: [lm-sensors] Add a driver for the ADT7475 thermal
Message-Id: <48E13CB0.4070704@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jordan Crouse wrote:
> On 27/09/08 16:04 +0200, Hans de Goede wrote:
>> Hi Jordan,
>>
>> This time I've done a more thorough review, here is a quite long list of 
>> remarks I would like you to take care of in one last revision, then this can go 
>> upstream (through Jean or Andrew, Jean ?).
> 
> Thanks for your time.
> 

Your welcome, thanks for being persistent we (the lm_sensors community) really 
need to do a better job of timely reviewing driver submissions.

>> 11) set_pwm_ctrl set_pwm_chan need better error checking. They should check the
>>      value they get passed is not negative, and set_pwm_chan should check for
>>      unsupported combos. I guess the best would be to do no checking and just
>>      pass the old chan and the new ctrl or vica versa to hw_set_pwm()
>>      and then return -EINVAL from hw_set_pwm on not valid combo's (and do
>>      storing of the values in the data struct also in hw_set_pwm when
>>      things are ok).
> 
> I did the bounds checking in the individual functions - it just makes
> things easier then trying to make hw_set_pwm do bounds checking as well
> as calculating the value.

But bounds only checking is not enough, as not all combo's of make these temp 
channels influence this pwm are supported, and since not all combo's are 
supported, you will need a switch case to check which are valid, and that 
switch case is already present in hw_set_pwm, really moving the error checking 
to hw_set_pwm is easy, just mke it return a status code and add default cases 
to catch invalid values.

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
