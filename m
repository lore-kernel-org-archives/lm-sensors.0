From: Robert Hancock <hancockrwd@gmail.com>
Date: Fri, 05 Mar 2010 02:09:04 +0000
Subject: Re: [lm-sensors] 2.6.33 on jetway nc81-lf board
Message-Id: <4B9067C0.6050907@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4B8C0598.2060000@xs4all.nl> <20100302213709.951ee97b.akpm@linux-foundation.org> <20100304091741.GA1995@andre-laptop> <4B8FC4F1.70605@xs4all.nl>
In-Reply-To: <4B8FC4F1.70605@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Udo van den Heuvel <udovdh@xs4all.nl>
Cc: Andre Prendel <andre.prendel@gmx.de>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

On 03/04/2010 08:34 AM, Udo van den Heuvel wrote:
> On 03/04/2010 10:17 AM, Andre Prendel wrote:
>> On Tue, Mar 02, 2010 at 09:37:09PM -0800, Andrew Morton wrote:
>>> (cc lm-sensors)
>>>
>>> On Mon, 01 Mar 2010 19:21:12 +0100 Udo van den Heuvel<udovdh@xs4all.nl>  wrote:
> (....)
>>>> No other sensor-related modules are loaded.
>>>>
>>>> What could be wrong?
>>
>> See lm-sensors FAQ Chapter3 #39:
>>
>>    http://www.lm-sensors.org/wiki/FAQ/Chapter3#Mysensorshavestoppedworkinginkernel2.6.31
>
> Thanks, but the explanation implies no real fix other than more
> consciously choosing to put system stability at risk.
> Is a better fix in the making?

I don't think a general fix is really possible at the kernel level. The 
problem is that there's no way for the kernel to tell for sure whether 
the BIOS AML or SMI code will attempt to access the sensor device. The 
fact that your BIOS defines AML operation regions that refer to the 
SMBus device is a hint that it may, but there's no programmatic way to 
tell for sure. If the kernel and BIOS end up attempting to poke the 
hardware monitoring chip at the same time, bad things are likely to 
happen (like ACPI thermal management not working properly causing 
overheating or critical shutdowns).

This problem isn't limited to Linux - loading software (at least that 
unapproved by the board manufacturer) on Windows that randomly pokes 
hardware sensors can cause similar problems if the BIOS attempts to 
access the same hardware.

The only real solution may be to check with the motherboard manufacturer 
to see if directly accessing the hardware sensors on that board is safe. 
(It's more likely to be OK on desktop machines than laptops, since they 
usually have less complex thermal/fan management, but there are no 
guarantees.)

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
