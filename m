From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 05 Dec 2011 16:15:37 +0000
Subject: Re: [lm-sensors] 3 wire fan on 4 pin header (was
Message-Id: <20111205171537.5286e6ae@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 05 Dec 2011 17:34:15 +0530, Charles wrote:
> On 04/12/11 16:30, lm-sensors-request@lm-sensors.org wrote:
> > Date: Sun, 4 Dec 2011 11:03:45 +0100
> > From: Jean Delvare <khali@linux-fr.org>
> > 
> > Hi Charles,
> [snip]
> > On 4-pin headers, the PWM signal is separated from the power. So you
> > can't control a 3-wire fan plugged in a 4-pin header (the PWM signal is
> > on the unconnected pin [1].)
> > 
> > -- Jean Delvare
> 
> Hello Jean :)
> 
> I already replied to this but just realised I am controlling a 3-wire
> S-Flex SFF21E fan
> (http://www.scythe-usa.com/product/acc/002/sflex_detail.html) on a
> 4-wire port on an ASUS P8H76-V motherboard (works on both CHA_FAN and
> CHA_FAN2).
> 
> If the 4-pin fan header is regarded as a 3-pin header with an extra pin
> then the unconnected pin is the extra pin.
> 
> Perhaps ASUS have used an unconventional pinout ... ?

This would be very unlikely, these pin mappings are highly standard,
and any vendor deviating from this standard would expose themselves to
the customer's wrath ;) The manual clearly documents the 4th (extra)
pin as CPU FAN PWM, as expected.

I can imagine that Asus came up with a way to detect whether the fan
connector has 3 or 4 wires, and to route the PWM signal appropriately.
I see no mention of this in the manual though.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
