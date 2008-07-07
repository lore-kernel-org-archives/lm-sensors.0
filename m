From: "Andrew Paprocki" <andrew@ishiboo.com>
Date: Mon, 07 Jul 2008 13:56:02 +0000
Subject: Re: [lm-sensors] [PATCH 2/4] hwmon: it87 only create pwm1-3 sysfs
Message-Id: <76366b180807070656r2ecace2fh2c40fe6fb609d046@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1215427211-6001-2-git-send-email-andrew@ishiboo.com>
In-Reply-To: <1215427211-6001-2-git-send-email-andrew@ishiboo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Jul 7, 2008 at 8:19 AM, Jean Delvare <khali@linux-fr.org> wrote:
> On Mon, 7 Jul 2008 07:36:43 -0400, Andrew Paprocki wrote:
>> Ah ok, for the pwm1_freq. I suppose this can be left out entirely, or
>> should pwm1* always exist?
>
> pwm1* should exist as long as you have no reason to believe that the
> pwm1 pin is used for another function. I can't remember if the IT87xxF
> chips share pwm pins have alternate functions (but some other chips do,
> and our driver don't necessarily pay attention to that as they should.)
> And the same holds for all pwm files.

At least for the 8712, FAN_CTL1 has a dedicated pin, but all the other
FAN_CTL* pins are shared with other functions (such as joystick port,
or GPIO usage). Are the pwm* files actually used by anyone in
userspace for something other than controlling the fans?

>  It just seemed wrong to make pwm4/5 show up
>> when needed but not the others.
>
> Not sure what you mean with pwm4/5 but please keep in mind that it is
> perfectly possible to have pwm4 without fan4 or fan4 without pwm4, and
> same for pwm5 and fan5. Inputs and outputs don't have to be related in
> the way the numbers suggest. Quite often the chip internals assume that
> they do, but motherboard makers can be very dump in the way they wire
> the fans.

So in this particular case, FAN_CTL4 shares a pin with JSBB2 (Joystick
button 2) and GPIO27. Similarly, FAN_CTL5 shares a pin with JSBB1 and
GPIO26. Should pwm4* and pwm5* files always exist for the IT871[268]
just because the pins exist, even if the chip configuration reports
there is no fan4/fan5 connected?

In a related question, I saw this comment in the driver:
                                /* automatic pwm - not yet implemented, but
                                 * leave the settings made by the BIOS alone
                                 * until a change is requested via the sysfs
                                 * interface */

What needs to be implemented for automatic mode? As far as I can tell
in the datasheet, automatic mode changes the meaning of bits0-6 in the
CTL register to be a selection of temp1/temp2/temp3 instead of a
128-step PWM control value. I could take a stab at implementing
something for this if you know what you want it to look like. I assume
the sysfs pwm inputs would change meaning in automatic mode to only be
a 2 bit value indicating which temp to select? Is there anything more
complicated needed?

-Andrew

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
