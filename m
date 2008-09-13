From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Sat, 13 Sep 2008 21:30:11 +0000
Subject: Re: [lm-sensors] hwmon: Add a driver for the ADT7475 thermal sensor
Message-Id: <48CC30E3.5050400@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080908174853.GG24308@cosmic.amd.com>
In-Reply-To: <20080908174853.GG24308@cosmic.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jordan Crouse wrote:
> On 06/09/08 12:00 +0200, Hans de Goede wrote:
>> Jordan Crouse wrote:
>>> Resend of the ADT7475 driver.  Jean said he would like to
>>> see a review on this version, even though it had been discussed before.
>>> Therefore I'm CCing Hans for his opinion.. :) I would really like to
>>> see this go into 2.6.28 and get out of my patch stack.
>>>
>> Jordan,
>>
>> I did do a review although very late (but didn't get very far, as there
>> are some sysfs API issues that need addressing first).
>>
>> See:
>> http://lists.lm-sensors.org/pipermail/lm-sensors/2008-August/023948.html
> 
> Okay - I have generated a new patch.  I implemented all of your suggestions -
> the only one I had any concerns about was the hystersis (hystersis makes
> more sense to me as an offset rather then an absolute), but consistancy
> among hwmon drivers is rather more important.
> 
> There is one possible issue in the patch - I pulled the decimal point
> from the pwmX_freq numbers since I wasn't sure if we wanted to express
> the number in milihertz.  If we do, then it is an easy fix.
> 
> Compile tested and run on an ADT7475 platform.
> 

Hi Jordan et all,

I've given this a quick review (not as thorough as I would have liked to do but 
I simply don't have enough time for a really thorough review) and I've found no 
issues. So this patch is now:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans

p.s.

Yes the email I'm signing-off with changed as my employer has changed

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
