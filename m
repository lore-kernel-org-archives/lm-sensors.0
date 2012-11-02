From: Hans de Goede <hdegoede@redhat.com>
Date: Fri, 02 Nov 2012 16:28:31 +0000
Subject: Re: [lm-sensors] f71882fg not showing motherboard temps
Message-Id: <5093F4AF.1020005@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <5091A80D.3090101@embarqmail.com>
In-Reply-To: <5091A80D.3090101@embarqmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

On 11/02/2012 02:22 PM, Logan Freijo wrote:
> On 11/2/2012 5:09 AM, Hans de Goede wrote:
>> Hi,
>>
>> On 11/02/2012 06:29 AM, Logan Freijo wrote:
>>
>> <snip>
>>
>>> Device 09 no longer shows up.
>>> ls -lR /sys/bus/pnp/devices/00\:09/
>>> and
>>> cat /sys/bus/pnp/devices/00\:09/id
>>> return "No such file or directory"
>>>
>>
>> Yeah, that is due to the pnpacpi=off option you
>> are using, please boot without that (or any other
>> special options), and then repeat the 2 above
>> commands. This will give us an idea if it will be
>> feasible to fix this in a way which will not
>> require passing those special kernel cmdline
>> options.
>>
>> Regards,
>>
>> Hans
>>
> Alright. Here is ls -lR /sys/bus/pnp/devices/00\:09/
>
> /sys/bus/pnp/devices/00:09/:
> total 0
> lrwxrwxrwx 1 root root    0 Nov  2 09:18 driver -> ../../../bus/pnp/drivers/system
> lrwxrwxrwx 1 root root    0 Nov  2 09:18 firmware_node -> ../../LNXSYSTM:00/device:00/PNP0A03:00/device:17/PNP0C02:03
> -r--r--r-- 1 root root 4096 Nov  2 09:18 id
> -r--r--r-- 1 root root 4096 Nov  2 09:18 options
> drwxr-xr-x 2 root root    0 Nov  2 09:18 power
> -rw-r--r-- 1 root root 4096 Nov  2 09:18 resources
> lrwxrwxrwx 1 root root    0 Nov  2 09:17 subsystem -> ../../../bus/pnp
> -rw-r--r-- 1 root root 4096 Nov  2 09:17 uevent
>
> /sys/bus/pnp/devices/00:09/power:
> total 0
> -rw-r--r-- 1 root root 4096 Nov  2 09:18 async
> -rw-r--r-- 1 root root 4096 Nov  2 09:18 autosuspend_delay_ms
> -rw-r--r-- 1 root root 4096 Nov  2 09:18 control
> -r--r--r-- 1 root root 4096 Nov  2 09:18 runtime_active_kids
> -r--r--r-- 1 root root 4096 Nov  2 09:18 runtime_active_time
> -r--r--r-- 1 root root 4096 Nov  2 09:18 runtime_enabled
> -r--r--r-- 1 root root 4096 Nov  2 09:18 runtime_status
> -r--r--r-- 1 root root 4096 Nov  2 09:18 runtime_suspended_time
> -r--r--r-- 1 root root 4096 Nov  2 09:18 runtime_usage
>

Good, no other drivers are using this pnp-id, but:

>
> And  cat /sys/bus/pnp/devices/00\:09/id
>
> PNP0c02

But this is bad news, this is the general pnp ID for reserving
resources, without specifying a driver to use them ...

This could mean that your ACPI code is using the device, and
the firmware authors are reserving it in a funky way. More likely
this is just a BIOS misfeature of some sorts...

Anyways there is little we can do here to fix things, as we can
not make the f71882fg driver claim that pnp id.

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
