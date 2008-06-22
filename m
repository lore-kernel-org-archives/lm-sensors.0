From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Sun, 22 Jun 2008 18:07:41 +0000
Subject: Re: [lm-sensors] [REGRESSION, ABI] Re:  LMSENSORS: 2.6.26-rc,
Message-Id: <485E94ED.10602@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <485DA11C.7050906@keyaccess.nl> <485DFF35.6080008@hhs.nl>	<485E505F.8010306@keyaccess.nl> <485E61DE.6020202@hhs.nl> <485E6F12.4010307@keyaccess.nl>
In-Reply-To: <485E6F12.4010307@keyaccess.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: linux-acpi@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, "Mark M. Hoffman" <mhoffman@lightlink.com>, Linux Kernel <linux-kernel@vger.kernel.org>, lm-sensors@lm-sensors.org

Rene Herman wrote:
> On 22-06-08 16:29, Hans de Goede wrote:
> 
>> Rene Herman wrote:
>>> This is an ABI breakage issue and an unfortunate one at that:
>>>
>>
>> No it is not, in 2.6.26rcX, the acpi thermalzones have grown a hwmon 
>> interface, that is they register a hwmon device so that "sensors" and
> 
> [ ... ]
> 
> Now what? Yes it is. 2.6.25.7 works and 2.6.26-rcX with the same config 
> options and the same userspace does not.

Know what? No it isn't. Just because some random userspace apps breaks because 
certain _assumptions_ no longer hold true, does not make something an ABI breakage.

I agree with you that the results are still no good though.

Know something else? I've just stopped caring about this issue, I'm not the 
author of the changes causing said breakage. I'm merely an lm_sensors (both 
userspace and kernel space) developer who was heavily involved in getting this 
fixed for lm_sensors-3.0.2, and I believe that adding yet another kconfig 
option which we then carry for years and years is _not_ a good solution. Some 
userspace utlities like udev sit very close to the kernel and sometimes an 
kernel update mandates a new udev. To me this is much the same.

But at the end of the day, I do not feel responsible for this as I'm not the 
author of the code causing the breakage. I'm just someone who knows the ins and 
outs and tried to help, but given the treatment and thanks I've been getting 
for my help I'm stopping with helping now.

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
