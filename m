From: Philip Pokorny <ppokorny@penguincomputing.com>
Date: Tue, 26 Oct 2010 15:04:22 +0000
Subject: Re: [lm-sensors] k10temp is detected but not shown
Message-Id: <487D65BF-2B35-4FBF-95AD-C4869C07E16E@penguincomputing.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <578838.74607.qm@web111714.mail.gq1.yahoo.com>
In-Reply-To: <578838.74607.qm@web111714.mail.gq1.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



On Oct 26, 2010, at 7:15 AM, Jean Delvare <khali@linux-fr.org> wrote:

> Hi Clemens,
>
> On Tue, 26 Oct 2010 15:53:29 +0200, Clemens Ladisch wrote:
>> Jean Delvare wrote:
>>>>> Doh. You are aware that Core i7 CPUs are made by Intel and  
>>>>> Family 10h
>>>>> (aka K10) CPUs are made by AMD, aren't you? They are different CPU
>>>>> models, they don't have to be designed the same way.
>>>>
>>>> I know that :)
>>>> I thought maybe that is a standard and each cpu temperature must  
>>>> be show
>>>> separetly.
>>>
>>> There is no such standard.
>>
>> And on the newest CPUs, Intel has switched to one temperature  
>> sensor per
>> package.
>
> Really? Starting with which CPU model?
>
>>> On Tue, 26 Oct 2010 06:06:53 -0700 (PDT), Mahmood Naderan wrote:
>>>> One more question, Is it possible to find out which two modules  
>>>> are tied to one
>>>> processor?
>>>
>>> Modules?

I suspect he has Magny Cours processors. They are multi-chip modules  
with two CPU chips per package. /proc/cpuinfo will tell you which  
cores are in which sockets.



>>>> Is it true that [00c3 and 00cb] are for one physical cpu and  
>>>> [00d3 and 00db] are
>>>> for the other cpu?
>>
>> I conclude from this question that you have two CPUs, and that each  
>> CPU
>> has two temperature sensors.
>>
>> The temperature sensor is part of the PCI device that associated with
>> the CPU's internal northbridge.  IIRC the six-core CPUs have two
>> northbridges, for whatever technical reason, so they present two
>> temparature sensors to the OS.
>>
>> It looks as if the two sensors in each CPU have the same value.  Is  
>> this
>> always the case?
>>
>> (I don't know where the c3/cb/d3/db names come from.)
>
> This is the PCI bus number in compact hexadecimal form:
>
> 00:18.3 -> 00c3
> 00:19.3 -> 00cb
> 00:1a.3 -> 00d3
> 00:1b.3 -> 00db
>
> We had to find a unique ID to differentiate between them, and that ID
> had to fit in an int to make libsensors happy.
>
>>> All entries in cpuinfo look the same, so I can't explain why some  
>>> have
>>> the critical limit and some don't.
>>
>> The limit is set by the BIOS.  I'd guess the BIOS knows that two  
>> sensors
>> are actually the same, an so doesn't bother to set the limit on the
>> superfluous ones.
>>
>> I'll look into the datasheet to see if this situation (two  
>> northbridges
>> per CPU) is documented and can be detected so that the driver can  
>> ignore
>> these superfluous sensors.
>
> If these sensors exist, I see no valid reason to ignore them. Two
> sensors can be useful, to slightly increase the resolution by  
> combining
> them, or simply in case one of them get unreliable for whatever  
> reason.
>

If these are Magny Cours, then they are definitely different sensors  
and they come from the different CPU chips in the package. If you ran  
a load on only one CPU chip:

$ numactl --cpunodebind=0 mprime -b4 -t

You should see the temperatures diverge for the sensors in the same  
socket.

Phil P. 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
