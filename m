From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 15 Aug 2013 05:30:47 +0000
Subject: Re: [lm-sensors] reading on-die temperature sensor of AMD A10 5700 processor
Message-Id: <520C6787.3010903@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAFSPGzQyxOOhjawcQj=wH+k1b=OC1gGf6CKWoU89TWVTykNcOQ@mail.gmail.com>
In-Reply-To: <CAFSPGzQyxOOhjawcQj=wH+k1b=OC1gGf6CKWoU89TWVTykNcOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 08/14/2013 09:32 PM, Dev, Kapil wrote:
>
>
> On Thu, Aug 15, 2013 at 12:29 AM, Guenter Roeck <linux@roeck-us.net <mailto:linux@roeck-us.net>> wrote:
>
>     On 08/14/2013 09:16 PM, Dev, Kapil wrote:
>
>         Hi,
>
>         Sorry for the verbose email. I am trying to read the temperature value as accurately as possible, that's why.
>
>         It is evident that there are some computations happening internally before these values are reported. Here is what I have to say about the 4.5C reported value.
>
>         I am using A10 5700 APU amd processor. It has bulldozer architecure (http://www.cpu-world.com/__CPUs/Bulldozer/TYPE-A10-__Series.html <http://www.cpu-world.com/CPUs/Bulldozer/TYPE-A10-Series.html>). Bulldozer architecture corresponds to 15h micro-architecture family  (http://en.wikipedia.org/wiki/__List_of_AMD_CPU___microarchitectures <http://en.wikipedia.org/wiki/List_of_AMD_CPU_microarchitectures>). So, I looked at the official manual of 15h family http://support.amd.com/us/__Processor_TechDocs/42301_15h___Mod_00h-0Fh_BKDG.pdf <http://support.amd.com/us/Processor_TechDocs/42301_15h_Mod_00h-0Fh_BKDG.pdf>). And, I found the following:
>
>         Page 219 and 393 (figure-14) of the document mention that bits 31:21 (11 bits) of the register D18F3xA4 denote the current temperature of the die as reported by temperature calculation circuit (TCC). The maximum value that could be represented by 11 bits is 2048 (2047, but ignore this for now) and they want to translate that to 256. So, I think the magic number 125 is obtained by computing 256/2048*1000. Line number 66-68 in k10temp.c (as downloaded from the drivers' link) use 125 as the factor to compute the value to be reported. I guess the factor of 1000 would be taken care somewhere else inside the kernel.
>
>     The kernel reports the temperature to userland in milli-degrees Celsius.
>
>
>         It also means that the lowest resolution of reading the temperature is 0.125C, which might mean that we could get a sub-degree resolution in temperature reading?
>
>     ... which also answers this question.
>
>
> Thanks! Does it mean that I can change the k10temp.c to read milli-degree C. I have always seen integer readings.
>
No. The value in the sysfs attribute file is already reported in milli-degrees C;
this is what the driver prints. The sensors command converts it into degrees C.
If the sensors command reports 4.5 degrees C, the sysfs attribute value is 4500.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
