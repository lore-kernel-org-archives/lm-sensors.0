From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 11 Jul 2008 13:38:31 +0000
Subject: Re: [lm-sensors] [PATCH 2/4] hwmon: it87 only create pwm1-3 sysfs
Message-Id: <20080711153831.0854486e@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1215427211-6001-2-git-send-email-andrew@ishiboo.com>
In-Reply-To: <1215427211-6001-2-git-send-email-andrew@ishiboo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Andrew,

On Mon, 7 Jul 2008 09:56:02 -0400, Andrew Paprocki wrote:
> On Mon, Jul 7, 2008 at 8:19 AM, Jean Delvare <khali@linux-fr.org> wrote:
> > pwm1* should exist as long as you have no reason to believe that the
> > pwm1 pin is used for another function. I can't remember if the IT87xxF
> > chips share pwm pins have alternate functions (but some other chips do,
> > and our driver don't necessarily pay attention to that as they should.)
> > And the same holds for all pwm files.
> 
> At least for the 8712, FAN_CTL1 has a dedicated pin, but all the other
> FAN_CTL* pins are shared with other functions (such as joystick port,
> or GPIO usage). Are the pwm* files actually used by anyone in
> userspace for something other than controlling the fans?

In theory the PWM signals could be used for anything, but in practice,
the motherboard manufacturer decides, and thankfully I am not aware of
any other use than fan control. The it87 driver assumes that PWM pins
are used for fan speed control.

If pins have shared functions, then the it87 driver should check that
each pin is indeed used for PWM before in exports it to user-space.
I've just taken a quick look at the IT8705F datasheet and all 3 PWM
pins can be used for other functions. The default is PWM so the driver
probably gets it right in most cases, but we should still add a check.
And apparently, same is true of the fan tachometer inputs.

Are you up to write a patch implementing this? I can help with review
and testing.

> > (...)
> > Not sure what you mean with pwm4/5 but please keep in mind that it is
> > perfectly possible to have pwm4 without fan4 or fan4 without pwm4, and
> > same for pwm5 and fan5. Inputs and outputs don't have to be related in
> > the way the numbers suggest. Quite often the chip internals assume that
> > they do, but motherboard makers can be very dump in the way they wire
> > the fans.
> 
> So in this particular case, FAN_CTL4 shares a pin with JSBB2 (Joystick
> button 2) and GPIO27. Similarly, FAN_CTL5 shares a pin with JSBB1 and
> GPIO26. Should pwm4* and pwm5* files always exist for the IT871[268]
> just because the pins exist, even if the chip configuration reports
> there is no fan4/fan5 connected?

Again, FAN_CTL4 is NOT related to "fan 4 being connected". Not that you
can know for sure whether a given fan input has a fan connected anyway,
but even if you could, you should never assume a correlation between
fanN and pwmN, for motherboard makers can wire the chip in completely
unexpected ways. I've made that mistake before...

As written above, what needs to be checked is whether a given pin is
configured for fan speed monitoring or control, or for an alternative
function. If the pin is not configured for a hardware monitoring
function then the it87 driver shouldn't expose it (it won't work
anyway.)

> 
> In a related question, I saw this comment in the driver:
>                                 /* automatic pwm - not yet implemented, but
>                                  * leave the settings made by the BIOS alone
>                                  * until a change is requested via the sysfs
>                                  * interface */
> 
> What needs to be implemented for automatic mode? As far as I can tell
> in the datasheet, automatic mode changes the meaning of bits0-6 in the
> CTL register to be a selection of temp1/temp2/temp3 instead of a
> 128-step PWM control value. I could take a stab at implementing
> something for this if you know what you want it to look like. I assume
> the sysfs pwm inputs would change meaning in automatic mode to only be
> a 2 bit value indicating which temp to select? Is there anything more
> complicated needed?

Please take a look at Documentation/hwmon/sysfs-interface. There's more
than temperature channel selection. The more difficult part is the
interface to let the user select the different trip points that define
the speed/temperature response curve.

The fact that some registers have a different meaning depending on the
mode is indeed a problem. I didn't give it much thought, and won't have
the time to. If you give it a try, just do things the way you think is
best, and whoever disagrees will speak up.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
