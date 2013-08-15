From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 15 Aug 2013 04:29:12 +0000
Subject: Re: [lm-sensors] reading on-die temperature sensor of AMD A10 5700 processor
Message-Id: <520C5918.7000004@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAFSPGzQyxOOhjawcQj=wH+k1b=OC1gGf6CKWoU89TWVTykNcOQ@mail.gmail.com>
In-Reply-To: <CAFSPGzQyxOOhjawcQj=wH+k1b=OC1gGf6CKWoU89TWVTykNcOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 08/14/2013 09:16 PM, Dev, Kapil wrote:
> Hi,
>
> Sorry for the verbose email. I am trying to read the temperature value as accurately as possible, that's why.
>
> It is evident that there are some computations happening internally before these values are reported. Here is what I have to say about the 4.5C reported value.
>
> I am using A10 5700 APU amd processor. It has bulldozer architecure (http://www.cpu-world.com/CPUs/Bulldozer/TYPE-A10-Series.html). Bulldozer architecture corresponds to 15h micro-architecture family  (http://en.wikipedia.org/wiki/List_of_AMD_CPU_microarchitectures). So, I looked at the official manual of 15h family http://support.amd.com/us/Processor_TechDocs/42301_15h_Mod_00h-0Fh_BKDG.pdf). And, I found the following:
>
> Page 219 and 393 (figure-14) of the document mention that bits 31:21 (11 bits) of the register D18F3xA4 denote the current temperature of the die as reported by temperature calculation circuit (TCC). The maximum value that could be represented by 11 bits is 2048 (2047, but ignore this for now) and they want to translate that to 256. So, I think the magic number 125 is obtained by computing 256/2048*1000. Line number 66-68 in k10temp.c (as downloaded from the drivers' link) use 125 as the factor to compute the value to be reported. I guess the factor of 1000 would be taken care somewhere else inside the kernel.
>
The kernel reports the temperature to userland in milli-degrees Celsius.

> It also means that the lowest resolution of reading the temperature is 0.125C, which might mean that we could get a sub-degree resolution in temperature reading?
>
... which also answers this question.

> I got a little confused about the way temperature-computation is explained on page 393. The interpretation of D18F3xA4[31:21] seems to be different based on the D18F3xA4[17:16] bits. Something similar, but not exactly the same thing, is implemented in k10temp.c in lines 85-90. The value (D18F3xA4[18:16]) is multiplied by 500 and then 52000 is added to it. While, on page 393, I see <(CurTmp[10:2]*0.5)-49>. In line 89 of k10temp.c, the hysteresis is computed as (D18F3xA4[27:24])*500,  i.e. four bits are used. While on page 393, three bits (equivalent to 0.125*8 = 1C) is used as hysteresis. Am I understanding things correctly here?
>
The 0.5 -> 500 is due to the conversion to milli-degrees.
Adding Clemens to the thread - maybe he can help with the rest. I am not really an expert on AMD CPUs.

> Also, if I want to apply any further correction to the reported raw values, I guess I just need to put following piece of code in /etc/sensors3.conf file:
>
> -------------------------------------------------------------
> chip "k10temp-*"
>       compute temp1 (@+correction),(@-correction)
> -------------------------------------------------------------
>
> This should add correction to the temp1 value under PCI adapter alone and not to the temp1 value under ISA adapter?
>
Yes, something like that.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
