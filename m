From: Luca Tettamanti <kronos.it@gmail.com>
Date: Tue, 21 Jul 2009 10:57:57 +0000
Subject: Re: [lm-sensors] [PATCH] asus_atk0110: fix limit readings
Message-Id: <68676e00907210357w4aa962d6o32e149eb33aa5012@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090721092742.GA11055@nb-core2.darkstar.lan>
In-Reply-To: <20090721092742.GA11055@nb-core2.darkstar.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Jul 21, 2009 at 12:36 PM, Jean Delvare<khali@linux-fr.org> wrote:
> Hi Luca,
>
> On Tue, 21 Jul 2009 11:27:42 +0200, Luca Tettamanti wrote:
>> On newer Asus boards the "upper" limit of a sensor is encoded as delta from the
>> "lower" limit. Fix the driver to correctly handle this case.
>> Note that the bug is purely cosmetic.
>
> I don't see how it would be only cosmetic, if the driver was reporting
> wrong upper limits before.

I mean that it didn't affect the correct operation of the thresholds
(at least in the firmware).

Luca

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
