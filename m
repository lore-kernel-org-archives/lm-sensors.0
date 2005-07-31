From: adobriyan@gmail.com (Alexey Dobriyan)
Date: Sun, 31 Jul 2005 22:49:53 +0000
Subject: [lm-sensors] Re: [PATCH 2.6] (10/11) hwmon vs i2c, second round
Message-Id: <20050731205650.GA3963@mipter.zuzino.mipt.ru>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050731205933.2e2a957f.khali@linux-fr.org> <20050731220224.23136906.khali@linux-fr.org>
In-Reply-To: <20050731220224.23136906.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, Greg KH <greg@kroah.com>

One nitpicking comment and two observations:

On Sun, Jul 31, 2005 at 10:02:24PM +0200, Jean Delvare wrote:
> I see very little reason why vid_from_reg and vid_to_reg are inlined.
> The former is not exactly short,

1)
				   and their arguments aren't known at
compile time,

[Compiler can optimise them away _completely_ if both arguments are known at
compile time or significantly of only one is known.]

> and they are never called in speed critical areas. Uninlining them should
> cause little performance loss if any, and saves a signficant space and
> compilation time as well.

2) VID_FROM_REG is asking for removal from lm85.

3) vid_to_reg is used only by atxp1.

