From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 24 Feb 2009 09:25:41 +0000
Subject: Re: [lm-sensors] W83667HG on ASUS P6T6 WS Revolution
Message-Id: <20090224102541.3492bdff@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <498B944A.3060502@ioerror.us>
In-Reply-To: <498B944A.3060502@ioerror.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Gong Jun,

On Tue, 24 Feb 2009 16:49:53 +0800, JGong@nuvoton.com wrote:
> Dear Jean,
> 
> So far, the w83667hg's pin 109(in6 and temp3's shared pin) selection is
> only decided by BIOS.

Can you please clarify what you mean by "decided by BIOS"? Do you mean
that the BIOS is writing something to the chip to configure pin 109? Or
do you mean that the BIOS author has the knowledge of the board and
displays either in6 or temp3 depending on the board's wiring?

> So maybe the user has to config the value with the help of its own
> BIOS readings, and then disables the meaningless output in the
> sensors.conf file.

This is really not ideal from a usability perspective.

Why don't we simply trust bit 0 of register 0x52 in bank 2? After all,
your original code changes this bit to switch between temp3 and in6, so
it would seem reasonable that the BIOS sets it to the right value as
well.

So I propose the following approach:
* Make the driver trust bit 0 of register 0x52 in bank 2. If the bit is
  set, create in6 attributes but not temp3 attributes. If it is clear,
  create temp3 attributes but not in6 attributes. Issue a debug message
  explaining the decision. For the W83667HG only, of course; for older
  chips we keep always creating all attributes.
* If it is ever found that some motherboard doesn't properly initialize
  this configuration bit, try to get the manufacturer to fix the BIOS.
  If we fail, either add a per-motherboard override in the driver, or
  add a module parameter or a sysfs attribute to let the user override
  the default configuration.

What do you think? It would be great to get this solved quickly so that
support for the W83667HG makes it into kernel 2.6.30.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
