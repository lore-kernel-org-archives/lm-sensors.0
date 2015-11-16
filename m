From: Punit Agrawal <punit.agrawal@arm.com>
Date: Mon, 16 Nov 2015 19:37:14 +0000
Subject: Re: [lm-sensors] [v2] hwmon: (scpi) skip unsupported sensors properly
Message-Id: <9hh1tbprb11.fsf@e105922-lin.cambridge.arm.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1446052651-9024-1-git-send-email-sudeep.holla@arm.com>
	<20151116175920.GA15811@roeck-us.net>
In-Reply-To: <20151116175920.GA15811@roeck-us.net> (Guenter Roeck's message of
	"Mon, 16 Nov 2015 09:59:20 -0800")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>, lm-sensors@lm-sensors.org

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
>> Acked-by: Guenter Roeck <linux@roeck-us.net>
>
> In the assumption that this patch can now be applied, I queued it up
> for the next -rc.

Looks like our emails crossed on the wire. :)

Thanks for applying the patch.

Punit

>
> Guenter
>
>> ---
>>  drivers/hwmon/scpi-hwmon.c | 21 +++++++++++----------
>>  1 file changed, 11 insertions(+), 10 deletions(-)
>> 

[...]


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
