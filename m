From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:32 +0000
Subject: questions on i2c-isa
Message-Id: <20040104211502.2ea6d8dd.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040104165323.4a824f59.khali@linux-fr.org>
In-Reply-To: <20040104165323.4a824f59.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> For all i2c accesses you need an i2c bus address 0x00 - 0x7f.
> This concept doesn't work for isa busses.

Oh yeah I must be stupid. This is why there is isadump for them.

> > 2* Is i2c-isa broken in 2.6? The sensors-detect script says I should
> > use i2c-isa + via686a. I load both and have nothing in sensors. It
> > is with 2.6.1-rc1. It used to work with 2.4.x + i2c-2.8.x.
> 
> I reported a while back that via686a sometimes worked and sometimes
> didn't. Playing with rmmoding and modprobing the modules (in various
> combinations, including i2c-isa and i2c-core), seemed to make a
> difference, but I couldn't figure out what made it work or not and
> never got to the bottom of it.

I made a few tests on my A7V133-C, where there are two sensor chips:
via686a on i2c-isa and as99127f on i2c-viapro. This is with linux
2.6.1-rc1.

It turns out that whichever driver is loaded second will not detect
anything. If I load via686a first, it works and no as99127f is detected.
If I load w83781d first, no via686a is detected. And it's only a matter
of chip drivers. The order in which bus drivers are loaded doesn't
matter.

Can you reproduce something similar on your side?

This would tend to demonstrate that the problem doesn't necessarily come
from the via686a driver.

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
