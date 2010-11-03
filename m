From: Henrik Rydberg <rydberg@euromail.se>
Date: Wed, 03 Nov 2010 14:45:28 +0000
Subject: Re: [lm-sensors] [PATCH 1/8] hwmon: applesmc: Relax the severity of
Message-Id: <4CD17588.1090601@euromail.se>
List-Id: <lm-sensors.vger.kernel.org>
References: <1288511434-5662-1-git-send-email-rydberg@euromail.se> <1288511434-5662-2-git-send-email-rydberg@euromail.se> <20101102160343.GA30515@ericsson.com>
In-Reply-To: <20101102160343.GA30515@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <guenter.roeck@ericsson.com>
Cc: Jean Delvare <khali@linux-fr.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>

On 11/02/2010 05:03 PM, Guenter Roeck wrote:

> Hi Henrik,
> 
> On Sun, Oct 31, 2010 at 03:50:27AM -0400, Henrik Rydberg wrote:
>> The device init is used to reset the accelerometer. Failure to reset
>> is not severe enough to stop loading the module or to resume from
>> hibernation.  This patch relaxes failure to a warning and drops
>> output in case of success.
>>
>> Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
>> ---
>>  drivers/hwmon/applesmc.c |   24 ++----------------------
>>  1 files changed, 2 insertions(+), 22 deletions(-)
>>
>> diff --git a/drivers/hwmon/applesmc.c b/drivers/hwmon/applesmc.c
>> index d7a5b75..375e464 100644
>> --- a/drivers/hwmon/applesmc.c
>> +++ b/drivers/hwmon/applesmc.c
>> @@ -458,21 +458,8 @@ static int applesmc_device_init(void)
>>  	mutex_lock(&applesmc_lock);
>>  
> Since the callers of applesmc_device_init() now all don't check the return value,
> it might make sense to declare it as void and not bother returning an error.
> 
> Otherwise looks good.


Sounds good, will change.

Henrik

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
