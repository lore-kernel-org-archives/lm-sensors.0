From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 11 Mar 2011 01:07:57 +0000
Subject: Re: [lm-sensors] RFC: nct6776f support in the w83627ehf and fan
Message-Id: <20110311010757.GA30471@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <BE6F61DB46364D4B839ED3F50CDFDFAB@portable2>
In-Reply-To: <BE6F61DB46364D4B839ED3F50CDFDFAB@portable2>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Mar 10, 2011 at 07:58:44PM -0500, Robert Kaiser wrote:
> Guenter Roeck schrieb:
> > On Thu, Mar 10, 2011 at 07:04:55PM -0500, Robert Kaiser wrote:
> >> Guenter Roeck schrieb:
> >>> Agreed. But you might be able to see the DIMM temperatures (if you have DDR3)
> >>> by loading the "jc42" module.
> >>
> >> Hmm, doesn't seem to work, after loading jc43, I don't see anything new
> >> appearing in sensors output.
> >>
> > jc42, not jc43.
> 
> Right. I actually did a |modprobe jc42| and that didn't bring anything 
> new up in |sensors| output - but of course then I made a typo in here...
> 
Too bad. So either you don't have DDR3 (unlikely), or Intel didn't wire it up to an i2c bus.

> >>> So the temperatures you see as "SMBUSxxx" are really temperatures reported by the CPU.
> >>> Just don't ask me why the CPU would report 0 degrees C ;).
> >>
> >> The i7-2600K is just an incredibly cool CPU, I guess. ;-)
> >>
> > Yes, and if you wire it up correctly you may be able to use it as refrigerator heat pump ;).
> 
> Hmm, I guess I have to look up _those_ plans! ;-)
> 
> > I copied a new version of the standalone driver to http://www.roeck-us.net/linux/drivers/w83627ehf/,
> > in case you want to give it a try.
> 
> Tested and works, thanks!
> 
Thank you!

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
