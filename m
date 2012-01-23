From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 23 Jan 2012 09:11:07 +0000
Subject: Re: [lm-sensors] Support for SMBus based GMT G781 and G7811 temperature sensors.
Message-Id: <20120123101107.4ba687eb@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <EC359208AB4F4249B8EA5A0018A7B178@ISLA>
In-Reply-To: <EC359208AB4F4249B8EA5A0018A7B178@ISLA>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 23 Jan 2012 09:59:43 +0200, Mike Gorchak wrote:
> Hello, Jean!
> 
>  GR>>> never mind; no idea if G7811 ever really existed. I found version 1.3
>  GR>>> of the datasheet which describes both G781 and G781-1. Can you test
>  GR>>> the driver and sensors-detect if I send you a pointer to the code ?
>  ??>> It seems that this patch is ok, except for one thing.
>  ??>> Let me explain what I did. I added support for ACPI SMBus connected to
>  ??>> Embedded Controller to the lm-sensors (for a netbook without proper
>  ??>> ACPI support). There are two G781 sensors connected to this bus, one
>  ??>> to the address 0x4C and one to the 0x4D. Both sensors have 0x01 as
>  ??>> device id. But patch assumes that only G781-1 can be connected to the
>  ??>> 0x4D address.
>  JD> If they followed a naming logic similar to National Semiconductor, G781
>  JD> will have address 0x4C and G781-1 will have address 0x4D. They are
>  JD> basically the exact same chip except for the address, so the driver
>  JD> doesn't even need to know, other than the fact that both addresses 0x4C
>  JD> and 0x4D are possible.
> 
> Now driver checks only for 0x03 device id at address 0x4D, which is not 
> correct. 0x01 device id can be present at 0x4D address too. That's all I'd 
> like to say :)

Yes, yes, I agree and I'm sure Guenter does as well. Just give me a
moment to review his two patches, and then wait for him to wake up, get
dressed, have coffee or whatever, and resubmit ;)

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
