From: 4ernov <4ernov@gmail.com>
Date: Wed, 02 Feb 2011 07:31:20 +0000
Subject: Re: [lm-sensors] How to distinguish sensors on Xeon multi-socket
Message-Id: <AANLkTikHtJA7H0DUnHdhLXtr=axvG6idj-S1j8AFPdmc@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <201102012323.13215.4ernov@gmail.com>
In-Reply-To: <201102012323.13215.4ernov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

No, they're don't support HyperThread but the sensors apparently not
duplicated, i.e. there're sensor 'Core 0' for 1st processor and 'Core
0' for 2nd and that's right as these are separate cores. What is
similar is their labels and that's the problem.

2011/2/2 David Anderson <davea42@gmail.com>:
> On 02/01/2011 12:23 PM, Alexey Chernov wrote:
>>
>> Hello,
>>
>> I have two socket motherboard with two Xeon's 5345 installed on them, so
>> overall it's 8 cores. Using lm_sensors all of them are detected correctly
>> out
>> of the box, but the problem is that after certain Linux kernel upgrade (I
>> believe it's somewhere around 2.6.32) matching kernel on both processors
>> started to be called identically. I have two 'Core 0', two 'Core 1' etc.
>> and
>> it drives mad many applications which use lm_sensors. Here's the output of
>> 'sensors' command:
>>
> If your Xeon's support HyperThread and you have that turned on in your BIOS
> then that doubles the CPU count Linux sees (try 'cat /proc/cpuinfo').
>
> But that does not double the sensors count for me (2 Xeon 5670's with
> HyperThread on in BIOS).
> I'm no lm-sensors expert...
>
> david anderson
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
