From: schnobs@babylon-kino.de (Christian Schnobrich)
Date: Thu, 19 May 2005 06:24:37 +0000
Subject: low fan speed = zero?
Message-Id: <1075413640.699.38.camel@pferd.babel>
List-Id: <lm-sensors.vger.kernel.org>
References: <1075385890.672.19.camel@pferd.babel>
In-Reply-To: <1075385890.672.19.camel@pferd.babel>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Don, 2004-01-29 at 20:50, Jean Delvare wrote:

> > 2400 and over -- a value that's unlikely to be reached even on the
> > hottest summer's day.
> 
> Tell me the brand of your hardware and fan. I'd really appreciate it if
> such a low fan speed was sufficent to keep my systems cold during
> summer.
> 
<showoff mode>

It's an Athlon650 -- total power consumption measured as 120W (+-5W).
The case fans make between 1800-2100rpm while maintaining 35-40 degrees
Centigrade. (temperature measured by sticking an thermometer into the
air exhaust; the Mobo sensor reports 31 C).

Actually, I did some crude case modding. If someone's interested, I'd
gladly describe the whole setup -- I'm mighty proud of it. But the
general concept is that several slow fans make less (and less annoying)
noise than a single, fastgoing fan.
</showoff mode>

> What you are after is called fan divisor. Since you didn't tell us which
> specific driver you are using, my comments will be generic.

Doh. I've seen and ignored that file, under the believe that "fan
divisior" merely relates to some fans giving twice as many clicks per
revolution.
Following that advice did help. Thanks, now I get the readings I
expected.

cu,
Schnobs
