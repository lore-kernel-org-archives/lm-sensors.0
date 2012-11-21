From: Luca Tettamanti <kronos.it@gmail.com>
Date: Wed, 21 Nov 2012 16:27:20 +0000
Subject: Re: [lm-sensors] Getting alarms using lm-sensors
Message-Id: <CAKPcRGpT1pbbub_wnd1Ha-4b0Y+qdoaAqTR1PrwYCdZqt4RZZQ@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <201211160616.qAG6GnV2010183@mx3.lsn.net>
In-Reply-To: <201211160616.qAG6GnV2010183@mx3.lsn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Nov 20, 2012 at 2:42 PM, Luca Tettamanti <kronos.it@gmail.com> wrote:
> On Sat, Nov 17, 2012 at 5:13 PM, Leslie Rhorer <lrhorer@mygrande.net> wrote:
>>> >> You can try loading the module forcing the use of a different ACPI
>>> >> interface:
>>> >> rmmod asus_atk0110
>>> >> modprobe asus_atk0110 new_if=1
>>> >
>>> > No, that didn't work.  Loading the module with the new_if=1 parm issues
>>> an
>>> > error:
>>> >
>>> > FATAL: Error inserting asus_atk0110
>>> > (/lib/modules/2.6.32-5-amd64/kernel/drivers/hwmon/asus_atk0110.ko):
>>> Unknown
>>> > symbol in module, or unknown parameter (see dmesg)
>>> >
>>> > And from dmesg:
>>> >
>>> > [25982.929792] asus_atk0110: Unknown parameter `new_if'
>>>
>>> What kernel are you using?
>>
>> 2.6.32-5-amd64
>
> Ah, it's too old, it does not support the override. Can you send me a
> copy of this file:
> /sys/firmware/acpi/tables/DSDT (or /proc/acpi/dsdt if you don't have
> the sysfs file).
> I'll see if there might be a problem with the detection heuristic.

Nope, there's only one interface (GITM), the BIOS probably has
hard-coded labels and does not read the ACPI table.

Luca

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
