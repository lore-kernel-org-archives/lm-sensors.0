From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 21 Sep 2012 13:18:40 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] hwmon: (mcp3021) Add MCP3221 support
Message-Id: <20120921131840.GB26844@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1348225462-16767-2-git-send-email-schuchmann@schleissheimer.de>
In-Reply-To: <1348225462-16767-2-git-send-email-schuchmann@schleissheimer.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Sep 21, 2012 at 01:04:22PM +0200, Sven Schuchmann wrote:
> This Patch adds support for mcp3221 chip to the
> mcp3021 driver.
> 
> Signed-off-by: Sven Schuchmann <schuchmann@schleissheimer.de>

Applied to -next. Minor comment:

[ ... ]
> +	tristate "Microchip MCP3021/MCP3221"

We prefer "MCP3021 and compatibles". I had to touch that line anyway
to resolve a conflict in -next, so I changed that; no need to resubmit.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
