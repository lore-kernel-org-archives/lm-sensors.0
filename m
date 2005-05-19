From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:57 +0000
Subject: pwmconfig fix
Message-Id: <20040509214802.5a713c8a.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040506215442.GA31272@nospam.com>
In-Reply-To: <20040506215442.GA31272@nospam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Why not take the highest working divisor? You can check this I think
> by re-reading the fan*_div after echoing a new value. At least, that's
> what I did...

Because a higher divisor means a poor accuracy at higher speeds. The
divisor is really a range vs. accuracy tradeoff. Read doc/fan-divisor
for details, or doc/chips/pc87366 (in CVS).

> No, it's not the full speed. Some combinations entered manual give
> even higher values: I can get to 3500rpm.
> (...)
> Now I echo values in another xterm, and I see the fan stabilizing to
> different values depending on the sequence of value which I echo-d. So
> there is some kind of state somewhere.

OK, that's strange ;)

PWM isn't as easy as it seems to be. The modulations are made on a base
frequency. Maybe you fan doesn't like this frequency and behaves
strangely because of that. Usually, drivers don't allow the user to
tweak the frequency, but most chips are able to change it. Read the
datasheet for your chip and try changing the value manually (using
isaset or i2cset), maybe it'll help.

-- 
Jean Delvare
http://khali.linux-fr.org/
