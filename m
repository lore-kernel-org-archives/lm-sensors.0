From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 12 Apr 2010 19:07:58 +0000
Subject: Re: [lm-sensors] Fancontrol script improvement
Message-Id: <20100412210758.5855808e@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <v2i360a8e031004120952zcee44b71l896d64a4ecf88914@mail.gmail.com>
In-Reply-To: <v2i360a8e031004120952zcee44b71l896d64a4ecf88914@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Martin,

Please don't top-post.

On Mon, 12 Apr 2010 21:20:12 +0300, Martin Vool wrote:
> this is also a good idea, but what about the already existsing
> configuration files? This method would probably break already
> existsing fancontrol configurations?

I don't think that preserving the fancontrol configuration file format
is a goal we want to follow. In fact, my voice would go to the exact
opposite: the current fancontrol configuration file format has already
grown way further than was originally intended, and we have reached the
understandability limits some times ago already. Anyone willing to do
anything more complex than fancontrol is doing today, should start by
defining a better configuration file format.

> (i always could write my own python script, but i think the community
> prefers shell scripting for compatibility reasons?)

Some may have such preference, but I don't. For the records, there was
a rewrite of fancontrol in perl years ago. It was dismissed not because
it was bad, but because it was redundant (it was basically a perfect
clone of the shell script variant, not taking benefit of the power of
perl.) It aimed at being permanently compatible with the original
script, so the weight of the perl interpreter was hard to justify.

However, we have reached the limits of the current implementation. Not
only the configuration file isn't flexible enough, but more
importantly, the sysfs interface to the chips is used directly, while
using libsensors would be much better. We currently lack the
temperature scaling / offsets, as well as all the labels, that would
make configuration much easier. We also lack permanent device names. So
we really want a new implementation that uses libsensors, and that
means a higher level language than shell scripting. C is the easiest
candidate. python would be just as valid, but you first must write a
python binding to libsensors.

> Anyways i thought that just a simple patch by someone who does
> shellscripting would be very cool :-)

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
