From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 01 Dec 2009 08:37:16 +0000
Subject: Re: [lm-sensors] LPC47M192-NC Fans
Message-Id: <20091201093716.740a4a07@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <alpine.OSX.2.00.0911301621550.346@blackbird.local>
In-Reply-To: <alpine.OSX.2.00.0911301621550.346@blackbird.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Sean,

On Mon, 30 Nov 2009 18:08:46 -0500 (EST), Sean Fidler wrote:
> Thanks for your assistance.
> 
> Please find the requested information below: output of sensors-detect,
> /proc/ioports and the kernel log entry after attempting to load smsc47m1
> 
> ##############################
> #sensors-detect revision 5249# 
> ##############################
> (...)
> Some Super I/O chips may also contain sensors. We have to write to
> standard I/O ports to probe them. This is usually safe.
> Do you want to scan for Super I/O sensors? (YES/no): Probing for Super-I/O at 0x2e/0x2f
> Trying family `National Semiconductor'...                   No
> Trying family `SMSC'...                                     Yes
> Found `SMSC LPC47M15x/192/997 Super IO Fan Sensors'
>      (but not activated)

I see. The fan sensors block is disabled, which is why sensors-detect
doesn't pick it up...

> (...)
> Nov 30 17:44:21 ubuntu kernel: [  728.046978] smsc47m1: Found SMSC LPC47M15x/LPC47M192/LPC47M997
> Nov 30 17:44:21 ubuntu kernel: [  728.046997] smsc47m1: Device is disabled, will not use

... and neither does the smsc47m1 driver.

Please look in your BIOS if there is any option to enable fan speed
monitoring and/or control. BTW, does the BIOS display any voltage,
temperature or fan speed data?

If you can't find a suitable option in your BIOS, we can try to
manually enable the fan sensors block. However, in most cases disabled
sensors block are disabled because they are effectively unused
(physically not wired on the board.) So there are good chances that
this will not lead us anywhere. Do you have any reason to believe that
fan speed can be monitored and/or controlled on this system in the
first place?

If you want to continue, I will need the output of the following
command:

isadump -k 0x55 0x2e 0x2f 0x0a

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
