From: Jeff Rickman <jrickman@myamigos.us>
Date: Mon, 09 May 2011 03:32:16 +0000
Subject: Re: [lm-sensors] Will there ever be EMC6w201 support?
Message-Id: <4DC76040.2020908@myamigos.us>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110414034609.476411A9866@localhost.localdomain>
In-Reply-To: <20110414034609.476411A9866@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 5/8/2011 10:27 AM, Harry G McGavran Jr wrote:
> On Sun, 8 May 2011 14:29:05 +0200 Jean Delvare wrote:
>> On Sun, 08 May 2011 06:19:11 -0500, Jeff Rickman wrote:
>>> On 5/8/2011 1:27 AM, Jean Delvare wrote:
>>>> Did you try loading this original i8k driver? Did it work? What are the
>>>> contents of /proc/i8k then?
>>>
>>> [testing with original "i8k" module]
>>> (1) Removed new "i8k" module from /lib/modules tree
>>> (2) Checked "/proc/i8k". No such file or directory
>>> (3) Copied original "i8k" module back to it's location in:
>>> /lib/modules/`uname -r`/drivers/char
>>> (4) Ran "depmod -a"
>>> (5) Rebooted PC to obtain known stable state
>>>
>>> After reboot...
>>> (6) Checked "/proc/i8k". No such file or directory
>>> (7) Checked "lsmod". "i8k" is not loaded
>>> (8) Attempted to load original "i8k" but it crashed.
>>>       Crash output is attached.
>>> (9) Rechecked "/proc/i8k". No such file or directory
>>> (10) Rebooted PC to return to known stable state
>>
>> This means that my changes aren't responsible for the crash, nor is the
>> fact of building the driver standalone. So I will leave it to the
>> Fedora kernel maintainers to resolve, if you care and if they are
>> interested.
>>
>> --
>> Jean Delvare
>
>
> Hi Jean (and others) ---
>
> This morning I got up to find a number of messages in this thread.
>
> I will comment in some of the queries made of me in it so that
> people have the info, but it looks like things are pretty good anyway.
>
> I have a single CPU Dell 670 with the A07 BIOS. I'm running Ubuntu Lucid
> with the 2.6.32-31 kernel.
>
> I didn't have any trouble with i2c_dev, i2c_801, the new i8k or
> emc6w201.
>
> I've now uninstalled the i8kutils package and i8k, and am using
> only libsensors to monitor with. I'm guessing i8k really applies
> only to Dell Insirion Laptops, but in any event emc6w201 gives
> me everything in a much easier way to deal with.
>
> Thanks again Jean! (I'm keeping your hints list at hand...)
>
>
> 	Harry McGavran
>
>
>

What Harry's comments tell me is the original "i8k" code lacks 
appropriate code to operate in a SMP environment. I think the Console 
messages are trying to say that for "non-programmers" like myself.

Note these differences:
- Harry has a single CPU; I have 2 CPU.
- We both run the same Dell BIOS A07 code.
- Harry's Linux kernel is slightly older than my 2.6.35.12-90 Fedora code.
- I think we would all agree that Jean's changes do not cause my crash 
since that code works on Harry's machine but not on mine.

Time permitting, I will start doing the research to submit a properly 
documented bug against Fedora Core 14 regarding this code. I suspect 
this issue will also reside in FC15 so that is another point to check if 
time allows. jean raises the real question: does anyone in the Fedora 
team want to fix this?

In closing, I agree with Harry: it is very nice to have some hardware 
monitoring in a Dell platform.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
