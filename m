From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 27 Feb 2010 12:55:53 +0000
Subject: Re: [lm-sensors] Support for Intel S3420GP
Message-Id: <20100227135553.3e1ff48b@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <d2bb89841002171611l5311b3a0i13e144ad9cf88a32@mail.gmail.com>
In-Reply-To: <d2bb89841002171611l5311b3a0i13e144ad9cf88a32@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi David,

On Wed, 17 Feb 2010 16:11:47 -0800, david jeong wrote:
> I've been getting a series of these messages:
> 
>  CPU3: Temperature above threshold, cpu clock throttled (total events = 60949)
>  CPU7: Temperature above threshold, cpu clock throttled (total events = 60949)
>  CPU3: Temperature/speed normal
>  CPU7: Temperature/speed normal
> 
> And I'd like to have some way of testing these messages as credible
> error messages.
> 
> I have a SUPERMICRO CSE-833T chassis that comes with 6 fans that are
> all powered, and I've applied Arctic Silver to my Intel X3460
> heatsink.  I'm baffled at the idea that the CPU is getting enough
> cooling.
> 
> First, any suggestions on other ways to validate these error messages?

You can always test the temperature of the heatsink with your bare
finger, or using an external thermometer. You may also be able to check
the temperature reported in the BIOS, as almost all BIOS display
hardware monitoring data these days.

> And second, does the ls_sensor chip have support for the Intel S3420GP
> motherboard?
> 
> I'm not sure if these are sensible questions, but please do ask me to
> clarify where needed.

lm-sensors is a software package, not a chip. And no, we have no idea
if your hardware is supported. Your best chance is certainly to run our
sensors-detect script and see what it finds.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
