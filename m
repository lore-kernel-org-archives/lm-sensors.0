From: Kaiwan N Billimoria <kaiwan@designergraphix.com>
Date: Fri, 24 Oct 2008 08:26:00 +0000
Subject: Re: [lm-sensors] [PATCH RESEND] hwmon: lm70: TI TMP121 support.
Message-Id: <1224836040.15167.11.camel@kaiwan-1>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081022080423.GB11169@roarinelk.homelinux.net>
In-Reply-To: <20081022080423.GB11169@roarinelk.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 2008-10-23 at 11:37 -0700, David Brownell wrote:
> Right, but afaik the lm70 code was only
> tested with drivers/spi/spi_lm70llp.c and
> that has a byte order handling bug.
> 
> Kaiwan Billimoria is the only person I
> know who could test fixes to the LM70
> and LM70LLP support ... Kaiwan, could
> you give that a try?
> 
> - Dave
> 
Sure Dave.
Pl point me to the latest patch(es) and help in clarifying what 
exactly the bug is; been a while...  :-)

And of course, if you already have a fix i'll test it on the lm70llp
board.

- kaiwan.




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
