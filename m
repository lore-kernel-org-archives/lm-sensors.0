From: Jeff Rickman <jrickman@myamigos.us>
Date: Tue, 10 May 2011 14:08:06 +0000
Subject: Re: [lm-sensors] Will there ever be EMC6w201 support?
Message-Id: <4DC946C6.7000508@myamigos.us>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110414034609.476411A9866@localhost.localdomain>
In-Reply-To: <20110414034609.476411A9866@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 5/10/2011 8:54 AM, Jeff Rickman wrote:
> On 5/9/2011 2:42 PM, Jean Delvare wrote:
>> Hi Jeff,
>>
>> On Sun, 08 May 2011 22:32:16 -0500, Jeff Rickman wrote:
>>> What Harry's comments tell me is the original "i8k" code lacks
>>> appropriate code to operate in a SMP environment. I think the Console
>>> messages are trying to say that for "non-programmers" like myself.
>>>
>>> Note these differences:
>>> - Harry has a single CPU; I have 2 CPU.
>>
>> This is a valuable observation. I presume that these CPUs are too old
>> to be multicore, best they could have it hyperthreading. Harry, can you
>> please share the contents of /proc/cpuinfo?
>>
>> Jeff, could you please try booting with parameter max_cpus=1? I wonder
>> if it would make a difference. If it does, that would confirm your
>> theory.
>>
>>> - We both run the same Dell BIOS A07 code.
>>> - Harry's Linux kernel is slightly older than my 2.6.35.12-90 Fedora
>>> code.
>>> - I think we would all agree that Jean's changes do not cause my crash
>>> since that code works on Harry's machine but not on mine.
>>>
>>> Time permitting, I will start doing the research to submit a properly
>>> documented bug against Fedora Core 14 regarding this code. I suspect
>>> this issue will also reside in FC15 so that is another point to check if
>>> time allows. jean raises the real question: does anyone in the Fedora
>>> team want to fix this?
>>
>> I've seen this nug hit an openSUSE user (on a laptop with one
>> multi-core CPU), so it's definitely not specific to Fedora. It may be
>> related to the version of gcc used by the distribution though. If
>> Fedora people aren't interested, we may open a bug on
>> bugzilla.kernel.org instead.
>>
>>> In closing, I agree with Harry: it is very nice to have some hardware
>>> monitoring in a Dell platform.
>>
>> I'm glad you like it :)
>>
>
> I checked for any packages that could manipulate the CPU frequency. I
> only found "cpuspeed". I removed the "cpuspeed" package and rebooted to
> ensure a known state. Attempting to install the "stock i8k" module
> causes a crash. Reboot to return to known state.
>
> I changed the "maxcpus=4" in "grub.conf" to "maxcpus=1". Reboot.
>
> Attempt to load "stock i8k" module. Crash. "/proc/cpuinfo" shows 1 CPU.
>
> Return system to previous configuration with "cpuspeed" and reboot.
>
> My only other choice would be to physically pull CPU2, leaving CPU1 in
> the system, but we know that config should work based on Harry's testing.
>

Forgot to add....

The crashdump info looked the same in all cases. The Console messages 
looked the same in all cases...complaint about SMP.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
