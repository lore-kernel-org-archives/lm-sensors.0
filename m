From: Anton Vorontsov <anton@enomsg.org>
Date: Wed, 17 Apr 2013 01:32:41 +0000
Subject: Re: [lm-sensors] [PATCH v8 5/5] hwmon: add ST-Ericsson ABX500 hwmon driver
Message-Id: <20130417013241.GA18418@lizard.mcd26095.sjc.wayport.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1364991492-2421-1-git-send-email-hongbo.zhang@linaro.org>
 <1364991492-2421-6-git-send-email-hongbo.zhang@linaro.org>
 <20130403163155.GA18863@roeck-us.net>
In-Reply-To: <20130403163155.GA18863@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: Hongbo Zhang <hongbo.zhang@linaro.org>, khali@linux-fr.org, lm-sensors@lm-sensors.org, dwmw2@infradead.org, linaro-kernel@lists.linaro.org, STEricsson_nomadik_linux@list.st.com, linux-kernel@vger.kernel.org

On Wed, Apr 03, 2013 at 09:31:55AM -0700, Guenter Roeck wrote:
> On Wed, Apr 03, 2013 at 08:18:12PM +0800, Hongbo Zhang wrote:
> > Each of ST-Ericsson X500 chip set series consists of both ABX500 and DBX500
> > chips. This is ABX500 hwmon driver, where the abx500.c is a common layer for
> > all ABX500s, and the ab8500.c is specific for AB8500 chip. Under this designed
> > structure, other chip specific files can be added simply using the same common
> > layer abx500.c.
> > 
> > Signed-off-by: Hongbo Zhang <hongbo.zhang@linaro.org>
> 
> Acked-by: Guenter Roeck <linux@roeck-us.net>

Patches 1-5 applied, thanks a lot!

Anton

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
