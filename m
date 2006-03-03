From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 03 Mar 2006 08:30:56 +0000
Subject: [lm-sensors] w83627ehf fan control
Message-Id: <aseBbf5V.1141374656.2047650.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi David,

On 2006-03-03, David Hubbard wrote:
> I have an nvidia 430 chipset on my motherboard and an integrated
> w83627ehf. I'm interested in developing the driver for it. In this
> post:
> http://lists.lm-sensors.org/pipermail/lm-sensors/2005-December/014820.html
> you mention that several other people are also developing the fan
> control capabilities. I can't find other information online, so I'll
> be starting from scratch.
>
> What I'd like to do:
> * add fan speed control (PWM)
> * add control (and documentation) of the "Smart Fan" feature (Thermal
> Cruise, Speed Cruise, maybe more)
>
> I'm working from this datasheet:
> http://www.winbond-usa.com/products/winbond_products/pdfs/PCIC/W83627EHF_EHG_1_1.pdf
>
> I'll probably finish it this weekend, so you could save me a day's
> worth of work if you already have this stuff done. Otherwise, I'll
> send you a patch.

You should have contacted the lm-sensors mailing-list rather than me
directly, so I am replying to this list. I am no more involved in the
w83627ehf driver development, but others on the list are.

Yuan Mu and Rudolf Marek (in Cc) have been working on extending my
preliminary w83627ehf driver, and things are in good shape already,
although some more tweaking work seems to be needed. You can certainly
help with this, by reviewing and testing Rudolf's version of the patch
(he has the latest one and is working on it right now.) Please
synchronize with Rudolf (preferably on the list in case others want to
participate) so that you don't duplicate the effort.

Note that the base for any w83627ehf patch that will be sent to me (as
the hwmon subsystem maintainer) now should be based on the w83627ehf
driver as found in the latest -mm releases, that is, including this
cleanup patch from Yuan Mu:

http://khali.linux-fr.org/devel/i2c/linux-2.6/hwmon-w83627ehf-use-attr-arrays.patch

Thanks,
--
Jean Delvare

