From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Sun, 14 Oct 2007 11:57:01 +0000
Subject: Re: [lm-sensors] lm-sens 2.10.5 fschmd support
Message-Id: <4712040D.9070601@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <470F3474.5040809@hhs.nl>
In-Reply-To: <470F3474.5040809@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Hi Hans,
> 
> On Fri, 12 Oct 2007 10:46:44 +0200, Hans de Goede wrote:
>> I've just committed support for the new fschmd to trunk, so that it will be 
>> available in 2.10.5
>>
>> It would be much appreciated if people who have an fsc chip could test the 
>> current trunk with it. I've been very carefull to make sure there will be no 
>> regressions.
>>
>> Also a quick review would be nice.
> 
> I've taken a look. Except for a few cosmetic fixes I already committed,
> here are my concerns:
> 
> * In changeset 4938, you modified the fsc* support code in "sensors" to
>   properly use the fault bit instead of the alarm bit to report faults.
>   However this means that the alarms are no longer reported. This is a kind
>   of regression. Could you please add alarm reporting?
> 

Fixed.

> * In changeset 4939:
> 
>> #define SENSORS_FSCHMD_FAN_FEATURES(nr) \ 
>>         { { SENSORS_FSCHMD_FAN(nr), "fan" #nr, \ 
>>                 NOMAP, NOMAP, R }, \ 
>>                 NOSYSCTL, VALUE(2), 0 }, \ 
>>         { { SENSORS_FSCHMD_FAN_DIV(nr), "fan" #nr "_div", \ 
>>                 SENSORS_FSCHMD_FAN(nr), NOMAP, R }, \ 
>>                 NOSYSCTL, VALUE(1), 0 }, \ 
>>         { { SENSORS_FSCHMD_FAN_ALARM(nr), "fan" #nr "_alarm", \ 
>>                 SENSORS_FSCHMD_FAN(nr), NOMAP, R }, \ 
>>                 NOSYSCTL, VALUE(1), 0 }, \ 
>>         { { SENSORS_FSCHMD_FAN_FAULT(nr), "fan" #nr "_fault", \ 
>>                 SENSORS_FSCHMD_FAN(nr), NOMAP, R }, \ 
>>                 NOSYSCTL, VALUE(1), 0 } 
> 
> fan#_div should be RW, right?
> 

Right, thanks!

>> /* give up, use old name (probably won't work though...) */
>> /* known to be the same:
>> 	"alarms", "beep_enable", "vrm", "fan%d_div" (except old fscxxx drivers
>> 	which use fan%d_ripple, fixed using altsysname for new drv. GRR)
>> */
> 
> I don't think that you should have added this comment. What the original
> comment means is that fan%d_div in 2.4 drivers stays fan%d_div in 2.6,
> which is true. Whether other names also become fan%d_div for some
> drivers in 2.6 is irrelevant at this point and has already been handled
> before.
> 

Removed

>>   /* no error on failure as we get used for various FSC chips and not all 
>>      have the same amount of fan sensors */ 
> 
>>   /* no error on failure as we get used for various FSC chips and not all 
>>      have the same amount of temp sensors */ 
> 
> You could adjust the loops in print_fschmd() based on the chip type to
> fix this problem. This is what we do for other drivers.
> 
Done

> Other than that, your patch looks OK, well done, it wasn't an easy one.
> 
Thanks! Cycling home really helps :)

> As a side note, I am curious how the fscher driver was supposed to work
> before your patch. The driver creates fan#_div when libsensors lists
> fan#_ripple. So unless I'm missing something, it probably just wasn't
> working, and nobody ever bothered to report. Odd.
> 

It didn't work with "sensors -u", the normal "sensors" print code for the fsc 
chips using the old drivers doesn't show the divider, so there it worked fine.

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
