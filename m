From: Punit Agrawal <punit.agrawal@arm.com>
Date: Mon, 16 Nov 2015 18:00:31 +0000
Subject: Re: [lm-sensors] [PATCH v2] hwmon: (scpi) skip unsupported sensors properly
Message-Id: <9hh6111rfi8.fsf@e105922-lin.cambridge.arm.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1446041283-19702-1-git-send-email-sudeep.holla@arm.com>
	<1446052651-9024-1-git-send-email-sudeep.holla@arm.com>
	<20151029045931.GA17127@roeck-us.net>
In-Reply-To: <20151029045931.GA17127@roeck-us.net> (Guenter Roeck's message of
	"Wed, 28 Oct 2015 21:59:31 -0700")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, Jean Delvare <jdelvare@suse.com>

Hi Guenter,

Guenter Roeck <linux@roeck-us.net> writes:

> On Wed, Oct 28, 2015 at 05:17:31PM +0000, Sudeep Holla wrote:
>> Currently it's assumed that firmware exports only the class of sensors
>> supported by the driver. However with newer firmware or SCPI protocol
>> revision, support for newer classes of sensors can be present.
>> 
>> The driver fails to probe with the following warning if an unsupported
>> class of sensor is encountered in the firmware.
>> 
>> sysfs: cannot create duplicate filename
>> 	'/devices/platform/scpi/scpi:sensors/hwmon/hwmon0/'
>> ------------[ cut here ]------------
>> WARNING: at fs/sysfs/dir.c:31
>> Modules linked in:
>> 
>> CPU: 0 PID: 6 Comm: kworker/u12:0 Not tainted 4.3.0-rc7 #137
>> Hardware name: ARM Juno development board (r0) (DT)
>> Workqueue: deferwq deferred_probe_work_func
>> PC is at sysfs_warn_dup+0x54/0x78
>> LR is at sysfs_warn_dup+0x54/0x78
>> 
>> This patch fixes the above issue by skipping through the unsupported
>> class of SCPI sensors.
>> 
>> Fixes: 68acc77a2d51 ("hwmon: Support thermal zones registration for SCP temperature sensors")
>> Fixes: ea98b29a05e9 ("hwmon: Support sensors exported via ARM SCP interface")
>> Cc: Guenter Roeck <linux@roeck-us.net>
>> Reviewed-by: Punit Agrawal <punit.agrawal@arm.com>
>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>
> Acked-by: Guenter Roeck <linux@roeck-us.net>
>
>> ---
>>  drivers/hwmon/scpi-hwmon.c | 21 +++++++++++----------
>>  1 file changed, 11 insertions(+), 10 deletions(-)
>> 
>> Hi Guenter,
>> 
>> Either me/Punit will need ping you once the original driver is merged
>> via arm-soc so that you can pick this after that. Alternatively we
>> can push it via arm-soc but I wouldn't rush for that as it's not that
>> urgent. Is that fine with you ?
>> 
> Either way is fine with me.

Now that rc1 is tagged, could you please pick this fix? It makes the
driver more robust when faced with changes to the firmware interface.

>
> Guenter
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
