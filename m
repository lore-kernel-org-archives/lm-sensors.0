From: mgreer@mvista.com (Mark A. Greer)
Date: Wed, 07 Dec 2005 01:54:40 +0000
Subject: [lm-sensors] [PATCH 2.6.15-rc5-mm1] i2c: i2c-mv64xxx -
Message-Id: <20051207015440.GD21553@mag.az.mvista.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051207014449.GA21553@mag.az.mvista.com>
In-Reply-To: <20051207014449.GA21553@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Dec 06, 2005 at 06:44:49PM -0700, Mark A. Greer wrote:
> The busses/i2c-mv64xxx.c driver doesn't currently compile because of an
> incorrect argument to dev_err().  This patch fixes that.
> 
> [Since it currently doesn't compile, I'm hoping this can get in ASAP.]
> 
> Signed-off-by: Mark A. Greer <mgreer at mvista.com>
> --

Oops, I meant to thank Jeremy Nadke <jenadke at wisc.edu> for pointing this out.

Mark

