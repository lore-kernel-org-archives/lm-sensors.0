From: Hans de Goede <hdegoede@redhat.com>
Date: Mon, 22 Nov 2010 19:26:18 +0000
Subject: Re: [lm-sensors] lm-sensors config file for Asus K8N-DL motherboard
Message-Id: <4CEAC3DA.6090502@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <AANLkTinYEMqSH_PMmVOqV4bn1a9qFoagtVo4AHpG=57H@mail.gmail.com>
In-Reply-To: <AANLkTinYEMqSH_PMmVOqV4bn1a9qFoagtVo4AHpG=57H@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

On 11/22/2010 06:06 PM, no tellin wrote:
> Hi Hans,
>
> On Sun, Nov 21, 2010 at 5:03 AM, Hans de Goede<hdegoede@redhat.com>  wrote:
>> Hi,
>>
>>
>>
>> On 11/20/2010 09:41 PM, no tellin wrote:
>>>
>>> /etc/sensors.d/asus_k8n-dl.conf
>>
>> Hmm, most asus board now a days do not allow direct access to their
>> hwmon ic's (the resources for the i2c controller/  the superio ports
>> are marked as reserved in acpi).
>>
>> Did you try this with a recent kernel ? Normally the kernel should
>> disallow access to the relevant hwmon ic's and the asus_atk0110 driver
>> which gives access to hwmon info through an asus specific acpi
>> interface should autoload.
>>
>> <snip>
>>
>>> # Warning: 'sensors-detect' will report the wrong Winbond I2C chip.
>>> Board inspection
>>> # and the official manual both indicate 'w83792d'.
>>
>> Hmm, was this with a recent sensors-detect? If so that seems like
>> a bug in sensors-detect to me, can you please start a separate
>> thread about this?
>>
>> Regards,
>>
>> Hans
>>
>>
>
> Kernel:
>
> # uname -a
> Linux slizard 2.6.35.4 #1 SMP Sat Aug 28 00:05:36 EDT 2010 x86_64 AMD
> Opteron(tm) Processor 242 AuthenticAMD GNU/Linux
>
>
> Sensors detect:
>
> Now follows a summary of the probes I have just done.
> Just press ENTER to continue:
>
> Driver `w83627hf':
>    * ISA bus, address 0x290
>      Chip `Winbond W83627THF/THG Super IO Sensors' (confidence: 9)
>

Hmm, it finds an isa winbond chip, but you're using a winbond chip
through i2c. Did it ask if you also wanted to probe i2c ? Can you
please re-run sensors-detect and let it probe i2c busses too ?

>
> lm_senors version:
>
> # emerge -s lm_sensors
> Searching...
> [ Results for search key : lm_sensors ]
> [ Applications found : 1 ]
>
> *  sys-apps/lm_sensors
>        Latest version available: 3.2.0
>        Latest version installed: 3.1.2-r1
>        Size of files: 161 kB
>        Homepage:      http://www.lm-sensors.org/
>        Description:   Hardware Monitoring user-space utilities
>        License:       GPL-2 LGPL-2.1
>
>
> FWIW, I don't believe the K8N-DL includes support for asus_atk0110.
> The board dates back to 2005 and was never continued in later
> revisions.

Ah, it could indeed be then that it does not support aus_atk0110.

Thanks & Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
