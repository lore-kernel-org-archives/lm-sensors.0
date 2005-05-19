From: ivanovich@menta.net (Ivanovich)
Date: Thu, 19 May 2005 06:24:33 +0000
Subject: Kernel 2.6.0 and i2c-viapro posible Bug
Message-Id: <200401091955.55007.ivanovich@menta.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <OLEKJGKIEPMKIGIPLDBNCEKJCDAA.nnilles@skycop.net>
In-Reply-To: <OLEKJGKIEPMKIGIPLDBNCEKJCDAA.nnilles@skycop.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

Jean Delvare wrote:

>> I thinks that thgere is  probably a bug in I2c-viapro module,
>> cuz when i load i2c-viapro after loading w82781d, my computer  just
>> put very slow..., i try loading as modules in the kernel or built in,
>> in both cases i have the same problem.
>>
>> I use 2.6.0 Vanilla Kernel sources.
>> Please i will really apreciate if some one responde to this
>> mail, put my adress in the CC field please cuz i not in the LKML.
>> If someone need another information about my computer, config..
>> or somehting more, just ask for it.
>>
>> Thanks.
> 
> Tested this on my own system with similar hardware (as far as i2c is
> concerned) under 2.6.1-rc2. I did not experience any slowdown.
> 
> Could you please provide the following information:
> 
> * Output of "lspci -n".
> 
> * Can you reproduce the problem with a 2.4.24 kernel and i2c+lm_sensors
>   2.8.2?
> 
> * Can you reproduce the problem with a 2.6.1-rc2 kernel?
> 
> * Can you reproduce the problem without ACPI support enabled into your
>   kernel?
> 
> * Does the slowdown affect only the hard-disk drive?
> 
> * Does the speed come back to normal if you remove i2c-viapro?
> 
> * Does the slowdown occur if you load i2c-viapro before w83781d?
> 
> Yeah, I know, this is much work, but we need a hint to start digging.
> 
> Thanks.
> 


>> ACPI: RSDT (v001 ASUS???CUV4X_E?
I have this very same board CUV4X_E and the same problem too (present in 2.6.0 
and before)
The workaround i found is to not initialize the chip "modprobe w83781d init=0"

And answering some of your questions, yes, the slowdown is global, not only 
disk and it doesn't gets better if you unload the modules.

It's fixed in 2.6.1? going to download+compile and see if it works. 
Thanks!
