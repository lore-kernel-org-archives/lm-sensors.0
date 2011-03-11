From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 11 Mar 2011 00:29:11 +0000
Subject: Re: [lm-sensors] RFC: nct6776f support in the w83627ehf and fan
Message-Id: <20110311002911.GA30156@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <BE6F61DB46364D4B839ED3F50CDFDFAB@portable2>
In-Reply-To: <BE6F61DB46364D4B839ED3F50CDFDFAB@portable2>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Robert,

On Thu, Mar 10, 2011 at 07:04:55PM -0500, Robert Kaiser wrote:
> Guenter Roeck schrieb:
> > Agreed. But you might be able to see the DIMM temperatures (if you have DDR3)
> > by loading the "jc42" module.
> 
> Hmm, doesn't seem to work, after loading jc43, I don't see anything new 
> appearing in sensors output.
> 
jc42, not jc43.

> > Actually, I just had a look at the code again. Turns out there is a bug; you see
> > the labels associated with NCT6776F, not NCT6775F. Real values should be "PECI Agent 0"
> > instead of "SMBUSMASTER 1", "PECI Agent 1" instead of "SMBUSMASTER 2",
> > and "PCH_CHIP_TEMP" instead of "PCH_CHIP_CPU_MAX_TEMP". I'll fix that immediately.
> 
> Ah, that makes sense, even if it's interesting that the PCH Chip is so 
> much hotter than the CPU, but then it doesn't have a fan attached to it 
> and still enough work, so sounds reasonable. And "PECI Agent 0" being 
> similar to the values from coretemp is also probably reasonable, as IIRC 
> PECI means something similar to that, right?
> 
No idea, but I guess so.

> > So the temperatures you see as "SMBUSxxx" are really temperatures reported by the CPU.
> > Just don't ask me why the CPU would report 0 degrees C ;).
> 
> The i7-2600K is just an incredibly cool CPU, I guess. ;-)
> 
Yes, and if you wire it up correctly you may be able to use it as refrigerator heat pump ;).

I copied a new version of the standalone driver to http://www.roeck-us.net/linux/drivers/w83627ehf/,
in case you want to give it a try.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
