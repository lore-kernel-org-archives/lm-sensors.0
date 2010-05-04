From: Henrik Rydberg <rydberg@euromail.se>
Date: Tue, 04 May 2010 11:15:51 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: applesmc: Add temperature sensor
Message-Id: <4BE001E7.9030605@euromail.se>
List-Id: <lm-sensors.vger.kernel.org>
References: <1272966929-14501-1-git-send-email-rydberg@euromail.se> <20100504120638.70244e8e@hyperion.delvare>
In-Reply-To: <20100504120638.70244e8e@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, Alex Murray <murray.alex@gmail.com>

Jean Delvare wrote:
[...]
>> @@ -1578,6 +1717,8 @@ static int __init applesmc_init(void)
>>  		}
>>  		ret = sysfs_create_file(&pdev->dev.kobj,
>>  						temperature_attributes[i]);
> 
> Missing error handling.
> 
>> +		ret = sysfs_create_file(&pdev->dev.kobj,
>> +						label_attributes[i]);
>>  		if (ret)
>>  			goto out_temperature;
>>  	}
>

Shoot, my bad review. Will send a new patch. While at it, the same function
seems to leak fan attribute groups. Want me to correct such issues (in another
patch)?

Henrik


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
