From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:37 +0000
Subject: Tellerstats, Computer Hardware Statistics
Message-Id: <pT0OxCEG.1108373919.2908350.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Morgan,

On 2005-02-14, Morgan Read wrote:
> Basically, I have a laptop with the mc1066 chip in that seems to be
> doing _very_ strange things at start up.  I've set up the mc1066 part of
> sensors.conf so:
>
>    label temp 		"Board"
>    label remote_temp	"CPU"
> (...)
>    set temp_low			40
>    set temp_over		54
>    set remote_temp_low		55
>    set remote_temp_over		69

Setting low temps to 40 degrees doesn't sound like a sane thing to do.
This means that temperatures below 40 degrees C will trigger an alarm. I
do not personally consider it a problem when my systems run at 25
degrees C. In fact, down to 15 degrees C seems to be fairly acceptable
for any hardware, so you could just set the low limits to this.

BTW, are you sure you have an MC1066? That's a rare chip as far as I
know. What laptop is this? Care to provide a dump of the chip (using
i2cdump)?

> Boot starts; fan off; fan slow; fan off; boot ends.  I log in, sensors
> reports settings as above, cpu temp climbs to 69, fan cuts in, the
> values reset to: cpu high 127 (!!!); cpu low 55; board high 55; board
> low -55 (!!!).  Then, cpu temp drops to (perhaps) 54, fan stops, the
> values reset to: cpu high 70 (?); cpu low -55 (!!!); board high 55;
> board low -55 (!!!).

Looks like a chip reset to me (IIRC 55/70/-55 are the chip defaults for
the adm1021/max1617 family). 127 also might have a special meaning, I'd
need to get my hands on a MC1066 datasheet to make sure.

> The cpu temp climbs to 70, the fan cuts in and then things seem to
> stabilise around cpu 57-62.
>
> Or something like that!  Mad?

Admittedly odd overall.

> So, I'm trying to work out what on earth's going on?

What version of lm_sensors are you using exactly? With what kernel? I
remember we reworked the init process of the adm1021 driver some months
ago, so if you're using a somewhat old version, you might get an
improvement by simply updating it.

--
Jean Delvare
