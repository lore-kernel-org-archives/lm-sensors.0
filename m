From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 21 Apr 2008 07:33:40 +0000
Subject: Re: [lm-sensors] ASUS P5E-VM DO and unknown chip with ID 0x0b00
Message-Id: <20080421093340.77896505@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <48077504.4000905@frugalware.org>
In-Reply-To: <48077504.4000905@frugalware.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Gabriel,

On Thu, 17 Apr 2008 18:04:20 +0200, Gabriel C wrote:
> Probably OT here but I've tested linux-next from yesterday and I got the following ACPI warning for w83627ehf :
> 
> ...
> 
> [   19.960897] w83627ehf: Found W83627DHG chip at 0x290
> [   19.961068] ACPI: I/O resource w83627ehf [0x295-0x296] conflicts with ACPI region HWRE [0x290-0x299]
> [   19.961145] ACPI: Device needs an ACPI driver
> 
> ...

Not off-topic at all, thanks for reporting. This basically suggests that
ACPI and the w83627ehf driver may try to access the same resource
without synchronization. Unfortunately at the moment we have no
infrastructure to handle this problem properly. So, to be on the safe
side, you should either use the ACPI drivers (fan, thermal) OR the
w83627ehf driver, but NOT all at once. Otherwise you may notice random
bogus readings on either end, some of which may trigger unexpected ACPI
events (like CPU throttling or even emergency shutdown.)

It is also possible that this is a false positive and the ACPI code
isn't accessing the device at all. Note that your ACPI BIOS declared
0x290-0x299 as the I/O region for this device, which is complete crap.
This shows once more that BIOS on mainstream PC is really a
second-class citizen which we shouldn't trust. Sigh.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
