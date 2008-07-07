From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 07 Jul 2008 12:19:52 +0000
Subject: Re: [lm-sensors] [PATCH 2/4] hwmon: it87 only create pwm1-3 sysfs
Message-Id: <20080707141952.34aaf31d@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1215427211-6001-2-git-send-email-andrew@ishiboo.com>
In-Reply-To: <1215427211-6001-2-git-send-email-andrew@ishiboo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Andrew,

(No top-posting please.)

> On Mon, Jul 7, 2008 at 7:25 AM, Jean Delvare <khali@linux-fr.org> wrote:
> > On Mon,  7 Jul 2008 06:40:09 -0400, Andrew Paprocki wrote:
> >> This patch only creates the pwmN_enable, pwmN, and pwmN_freq
> >> sysfs interface files if the corresponding fanN is enabled by
> >> the chip.
> > Nack. PWM1 may control fan2, etc.

On Mon, 7 Jul 2008 07:36:43 -0400, Andrew Paprocki wrote:
> Ah ok, for the pwm1_freq. I suppose this can be left out entirely, or
> should pwm1* always exist?

pwm1* should exist as long as you have no reason to believe that the
pwm1 pin is used for another function. I can't remember if the IT87xxF
chips share pwm pins have alternate functions (but some other chips do,
and our driver don't necessarily pay attention to that as they should.)
And the same holds for all pwm files.

 It just seemed wrong to make pwm4/5 show up
> when needed but not the others.

Not sure what you mean with pwm4/5 but please keep in mind that it is
perfectly possible to have pwm4 without fan4 or fan4 without pwm4, and
same for pwm5 and fan5. Inputs and outputs don't have to be related in
the way the numbers suggest. Quite often the chip internals assume that
they do, but motherboard makers can be very dump in the way they wire
the fans.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
