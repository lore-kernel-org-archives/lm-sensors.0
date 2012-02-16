From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 16 Feb 2012 06:51:53 +0000
Subject: Re: [lm-sensors] help with setup / chip support
Message-Id: <20120216075153.0de73b8e@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAP4ecBN-YdCqfetiJG2-o_SW8kEWcXNFA2eSQRQNvT7LsRHGog@mail.gmail.com>
In-Reply-To: <CAP4ecBN-YdCqfetiJG2-o_SW8kEWcXNFA2eSQRQNvT7LsRHGog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Kenneth,

On Wed, 15 Feb 2012 18:36:40 -0800, Kenneth Cox wrote:
> Here is the results of sensors-detect as promised:
> 
> # sensors-detect revision 5946 (2011-03-23 11:54:44 +0100)
> # System: To Be Filled By O.E.M. To Be Filled By O.E.M.

Obviously this is useless data, I've added a filter to sensors-detect.

> # Board: ASRock A75M-HVS
> (...)
> Driver `to-be-written':
>   * ISA bus, address 0x290
>     Chip `Nuvoton NCT6776F Super IO Sensors' (confidence: 9)

Obviously this is your monitoring chip. A more recent version of
sensors-detect [1] would have told you to use the w83627ehf driver. If
you run kernel 2.6.39 or later it should work (mostly) fine. For older
kernels, or if you are affected by a bug in the early support, Guenter
Roeck has a standalone version of the driver [2] which you could try if
the web server works for you (it doesn't for me at the moment.) I also
have a standalone version of the w83627ehf driver [3] but it isn't as
up-to-date as Guenter's.

[1] http://dl.lm-sensors.org/lm-sensors/files/sensors-detect
[2] http://roeck-us.net/linux/drivers/
[3] http://khali.linux-fr.org/devel/misc/w83627ehf/

Hope that helps,
-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
