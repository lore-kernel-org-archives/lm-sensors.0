From: ianp <braveheart_leo@yahoo.com>
Date: Wed, 19 Feb 2014 02:43:32 +0000
Subject: Re: [lm-sensors] W83627DHG-P sensor shows a single voltage monitor for +5V and +12V on in4?
Message-Id: <1392777812.30750.YahooMailNeo@web160506.mail.bf1.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1392773023.4498.YahooMailNeo@web160503.mail.bf1.yahoo.com>
In-Reply-To: <1392773023.4498.YahooMailNeo@web160503.mail.bf1.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> On Wednesday, February 19, 2014 10:00 AM, Guenter Roeck <linux@roeck-us.net> wrote:

> That is not the same address, it is the same raw value.
> The voltage registers are at address 0x20 .. 0x26 in above table.
> 

Hmmm, I must have been looking at it the wrong way then. So if it's the 
raw value that is the same for both monitors, can I trust that the +5V 
and +12V values are accurate?

Lastly, how can you separately show +5V and +12V in lm-sensors if both share a sinlge monitor on in4?


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
