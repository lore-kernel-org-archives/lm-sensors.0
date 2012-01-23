From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 23 Jan 2012 07:06:00 +0000
Subject: Re: [lm-sensors] Support for SMBus based GMT G781 and G7811 temperature sensors.
Message-Id: <20120123070600.GA15210@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <EC359208AB4F4249B8EA5A0018A7B178@ISLA>
In-Reply-To: <EC359208AB4F4249B8EA5A0018A7B178@ISLA>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Jan 23, 2012 at 01:02:20AM -0500, Mike Gorchak wrote:
> Hello, Guenter!
> 
>  GR> never mind; no idea if G7811 ever really existed. I found version 1.3
>  GR> of the datasheet which describes both G781 and G781-1. Can you test the
>  GR> driver and sensors-detect if I send you a pointer to the code ?
> 
> It seems that this patch is ok, except for one thing.
> 
> Let me explain what I did. I added support for ACPI SMBus connected to 
> Embedded Controller to the lm-sensors (for a netbook without proper ACPI 
> support). There are two G781 sensors connected to this bus, one to the 
> address 0x4C and one to the 0x4D. Both sensors have 0x01 as device id. But 
> patch assumes that only G781-1 can be connected to the 0x4D address.
> 
> Thanks for the fast answer! :)
> 
> With best regards, Mike Gorchak.  E-mail: lestat@i.com.ua 
> 
Hi Mike,

can you send me the output of i2cdump for both chips ?

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
