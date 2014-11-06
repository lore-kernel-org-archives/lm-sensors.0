From: Aravind Gopalakrishnan <aravind.gopalakrishnan@amd.com>
Date: Thu, 06 Nov 2014 15:17:52 +0000
Subject: Re: [lm-sensors] Kaveri [and Radeon] temps
Message-Id: <545B9120.4080106@amd.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <m31tph9wmt.fsf@carbon.jhcloos.org>
	<20141105232155.GA25189@roeck-us.net>
	<m3ppd18bnn.fsf@carbon.jhcloos.org>
	<20141105235022.GA26085@roeck-us.net>
In-Reply-To: <20141105235022.GA26085@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>, James Cloos <cloos@jhcloos.com>
Cc: dri-devel@lists.freedesktop.org, lm-sensors@lm-sensors.org

On 11/5/2014 5:50 PM, Guenter Roeck wrote:
> On Wed, Nov 05, 2014 at 06:34:20PM -0500, James Cloos wrote:
>>>>>>> "GR" = Guenter Roeck <linux@roeck-us.net> writes:
>> ...
>> GR> AMD CPUs are known report wildly off temperatures especially at
>> GR> low temperatures.
>>
>> Thanks.  After some further digging, I wonder whether Aravind's recent
>> patch might help?  The apu does have both PCI_DEVICE_ID_AMD_16H_M30H_NB_F3
>> and PCI_DEVICE_ID_AMD_16H_M30H_NB_F4 and lspci reports no driver for the
>> F4 device.
>>
> Aravind would have to comment; my understanding is that the F4 device
> reports the power, not the temperature. You could try to apply the patch
> and see if it makes a difference. Worst case there will be no change ;-).

Right, F4 is for reporting power values.
The recent patch was a bug fix for fam15h_power, so I don't think that's 
what you are looking for..

>> GR>  Does the temperature increase with load ?
>>
>> It seems to max out w/in a kelvin or two of the room's ambient temp.
>>
> Even under load ? Sounds weird.

Yeah, I have not come across such odd behavior neither. So not able to 
tell you what might be wrong..

> Question of course is if the chip really
> reports a useful temperature in the first place; this is something I can
> not answer, since I have neither a datasheet nor a system with that CPU.

Yes, the values reported are accurate and AFAIK there are folks who are 
interested to look into temperature/power values reported by hwmon, so I 
guess it's useful :)
I shall try and ask around if someone knows anything about incorrect 
values being exposed in the registers and let you know.

Thanks,
-Aravind

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
