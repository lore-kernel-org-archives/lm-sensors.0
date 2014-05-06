From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Date: Tue, 06 May 2014 15:53:04 +0000
Subject: Re: [lm-sensors] coretemp.0 folder contents changed
Message-Id: <53690560.1070403@linux.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <5367C6A7.5020008@linux.intel.com> <20140505173231.GA25644@roeck-us.net> <20140506135558.3cafd062@endymion.delvare> <5368FDB6.3000107@linux.intel.com>
In-Reply-To: <5368FDB6.3000107@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <jdelvare@suse.de>
Cc: "Yu, Fenghua" <fenghua.yu@intel.com>, Linux Kernel <linux-kernel@vger.kernel.org>, lm-sensors@lm-sensors.org

On 05/06/2014 08:20 AM, Srinivas Pandruvada wrote:
> On 05/06/2014 04:55 AM, Jean Delvare wrote:
>> Hi Guenter, Srinivas,
>>
>> On Mon, 5 May 2014 10:32:31 -0700, Guenter Roeck wrote:
>>> On Mon, May 05, 2014 at 10:13:11AM -0700, Srinivas Pandruvada wrote:
>>>> for kernel : 3.15.rc3 .
>>>>
>>>> Is there any change in the coretemp? Previously we used to see,
>>>> tempx data (like temp2_input, temp2_max etc.)
>>>> /sys/devices/platform/coretemp.0/.
>>> That isn't where you are supposed to look for hwmon attributes.
>> Actually I used to recommend looking there when people were not using
>> libsensors (e.g. for pwmconfig / fancontrol or custom scripts.) This
>> path had the great merit of being stable across reboots, while hwmon
>> class device numbers are not (or at least they aren't guaranteed to be.)
> I maintain thermal daemon, which was using the path. So once Ubuntu 
> upgrade kernel,
> this will break. So I have to make sure that corresponding user space 
> change is submitted.
> I don't want to depend on too many libraries as it also runs on many 
> embedded platforms
> where many library pre-builts don't exists.
>>> (...)
>>> To give you the background, hwmon attributes are in the process of
>>> being moved from the parent device to the hwmon device, or from
>>> /sys/class/hwmon/hwmonX/device/ to /sys/class/hwmon/hwmonX/,
>>> as part of an effort to streamline the code and make it more
>>> consistent and maintainable.
>> I am just realizing that we are also losing the stability of hardware
>> device based paths with that move :( I suppose I shouldn't have
>> bothered adding support for this to fancontrol.
>>
>> Don't get me wrong, I still believe this is the right move, but I fear
>> that the question of persistent hwmon device names will resurface every
>> now and then again. libsensors offers a solution but 1* it lacks
>> support for pwm attributes and 2* it doesn't help with shell or perl
>> scripts such as pwmconfig and fancontrol.
> Also when using Android like platform with limited library support,
> we have to make sure that libsensor exists.
>
>
Also some documents which can be downloaded from intel.com, refers to 
this path.
http://www.intel.com/content/www/us/en/intelligent-systems/cpu-monitoring-dts-peci-paper.html
So we need to request document owners to update path. But it is possible 
that OEM/ODMs also
has similar documents or refer to such documentation.

> Thanks,
> Srinivas
>
>
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
