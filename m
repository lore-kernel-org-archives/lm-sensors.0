From: Phil Pokorny <ppokorny@penguincomputing.com>
Date: Mon, 05 Dec 2011 19:05:46 +0000
Subject: Re: [lm-sensors] 3 wire fan on 4 pin header (was
Message-Id: <CAAek22F9ekcHcEn3V-NmEXtSZS3Emht=uL-4gBmqeqZu6WmHPA@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20111205171537.5286e6ae@endymion.delvare>
In-Reply-To: <20111205171537.5286e6ae@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Dec 5, 2011 at 8:15 AM, Jean Delvare <khali@linux-fr.org> wrote:
> On Mon, 05 Dec 2011 17:34:15 +0530, Charles wrote:
>> On 04/12/11 16:30, lm-sensors-request@lm-sensors.org wrote:
>> > Date: Sun, 4 Dec 2011 11:03:45 +0100
>> > From: Jean Delvare <khali@linux-fr.org>
>> >
>> > Hi Charles,
>> [snip]
>> > On 4-pin headers, the PWM signal is separated from the power. So you
>> > can't control a 3-wire fan plugged in a 4-pin header (the PWM signal is
>> > on the unconnected pin [1].)

Some motherboards have BIOS settings to switch between PWM control and
voltage/3-wire control.  (I saw this in an ASUS BIOS for the CPU fan
header).  But your essential point is correct, that a header
configured to use PWM to control fan speed will not work with a 3-pin
fan.

>> Hello Jean :)
>>
>> I already replied to this but just realised I am controlling a 3-wire
>> S-Flex SFF21E fan
>> (http://www.scythe-usa.com/product/acc/002/sflex_detail.html) on a
>> 4-wire port on an ASUS P8H76-V motherboard (works on both CHA_FAN and
>> CHA_FAN2).
>>
>> If the 4-pin fan header is regarded as a 3-pin header with an extra pin
>> then the unconnected pin is the extra pin.
>>
>> Perhaps ASUS have used an unconventional pinout ... ?
>
> This would be very unlikely, these pin mappings are highly standard,
> and any vendor deviating from this standard would expose themselves to
> the customer's wrath ;) The manual clearly documents the 4th (extra)
> pin as CPU FAN PWM, as expected.

On more than one ASUS motherboard, I have encountered 4-pin headers
that *do not drive* the PWM pin and instead do voltage control of the
fan speed.  This is most common on the chassis fan headers.  They are
4-pin headers, but they don't have an active PWM signal and you can't
enable it in the BIOS.  I asked ASUS about it and they said it wasn't
possible to generate PWM signals on those headers.

When you plug a 4-pin, PWM controlled fan into such a header, the PWM
signal is floating and so the PWM fan will run at "full speed", but
the variable voltage will result in the fan speed changing under the
control of the motherboard.

> I can imagine that Asus came up with a way to detect whether the fan
> connector has 3 or 4 wires, and to route the PWM signal appropriately.
> I see no mention of this in the manual though.

I don't think it's that clever.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
