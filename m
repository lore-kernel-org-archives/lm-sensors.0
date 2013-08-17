From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 17 Aug 2013 19:12:23 +0000
Subject: Re: [lm-sensors] apparent bug?
Message-Id: <520FCB17.6070501@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <520FB230.3090007@gmail.com>
In-Reply-To: <520FB230.3090007@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 08/17/2013 10:26 AM, thuifr wrote:
> Hello,
>
> I'm running Ubuntu 12.04 LTS and having trouble getting the sensors detected (assuming that there are any).  I posted this question to askubuntu, and the suggestion was that this is a bug (seems doubtful, but there you are).
>
> The question, with lshw and other data, is here:
>
>
> http://askubuntu.com/questions/333498/
>

If sensors-detect does not detect a sensor, there are a number of possibilities.

1) There is no sensor.
2) The sensor types are not known to sensors-detect
3) The bus to which the sensors are connected does not have a driver
4) sensors-detect has a bug

I don't see anything in your logs suggesting that the problem would be #4.
Your first step should be to answer #1 to #3 before concluding that there
is a bug in sensors-detect.

FWIW, nothing in the manual suggests that there might be a sensor on this board.
Given that, claiming that there would or even might be be a bug seems to be a bit
far-stretched.

Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
