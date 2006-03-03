From: david.c.hubbard@gmail.com (David Hubbard)
Date: Fri, 03 Mar 2006 19:44:02 +0000
Subject: [lm-sensors] Fan control w83627hf vs w83627ehf
Message-Id: <4dfa50520603031144t4bf0006auf60e52adc2bc13bd@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Marcus,

On 3/3/06, Marcus J?gemar <marcus.jagemar at gmail.com> wrote:
>  Some time ago I made a quick hack for my motherboard that uses the w83627hf
> driver and implemented a simple thermal cruise mode (this was about a year
> ago). Anyhow, in later kernels I haven't been able to get it working but to
> be honest I havn't  tried that hard.
>
>  Do you know if it is the same driver for w83627ehf and w83627hf? In that
> case I would be interested in trying your driver to see if I can get my
> computer to spin down the fan.

The w83627hf and w83627ehf are separate drivers, though they are
closely related. The data sheets for each of the chips are available
online at:
http://www.winbond.com/PDF/sheet/w83627hf.pdf
http://www.winbond-usa.com/products/winbond_products/pdfs/PCIC/W83627EHF_EHG_1_1.pdf

Note that the w83627ehg is just a lead (Pb) free chip, but otherwise
identical to the w83627ehf. I'm not exactly sure what the w83627f (or
w83627ef) are supposed to be, but I believe they do not have the
hardware monitoring features. I have a w83627ehf.

These chips do a lot more than monitor temperatures and control fans,
but the other devices have their own drivers. (The floppy controller,
game port, serial and parallel ports all use the normal PC drivers.
Then there is a set of GPIO pins, but these may be used differently
for each motherboard, such as trigger a thermal monitor interrupt.)

I think the w83627ehf driver split from the w83627hf because the
w83627ehf has the ability to automatically adjust the PWM fan output
based on a temperature input ("thermal cruise"), or an RPM input ("fan
speed cruise"). The w83627hf does not. This could actually be done in
a single driver that detects what features the chip supports and then
populates sysfs. The cruise modes aren't that exciting--a shell script
could do so much more for you than this hardware. The main reason for
the driver would be to turn the cruise modes off, since the BIOS may
turn them on at boot.

Actually, I don't know why the w83627ehf and w83627hf are separate
drivers. Can anyone explain that to me?

Cheers!
David

