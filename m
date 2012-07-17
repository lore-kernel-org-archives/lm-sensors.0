From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 17 Jul 2012 01:10:51 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] hwmon: (applesmc) Allow negative temperature values
Message-Id: <20120717011051.GA22234@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1342423091-330-1-git-send-email-rydberg@euromail.se>
In-Reply-To: <1342423091-330-1-git-send-email-rydberg@euromail.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Guenter Roeck <guenter.roeck@ericsson.com>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

On Mon, Jul 16, 2012 at 09:18:10AM +0200, Henrik Rydberg wrote:
> There are many userland reports of sensors with unreasonably small and
> large temperatures. There seem to be several reasons for this:
> 
> Firstly, the major sensor type (sp78) is actually a signed number.
> This explains why some sensors show very small or large values - they
> are in fact all small, but of different sign.
> 
> Secondly, the other sensor type (1-hex) is not properly understood; it
> may be that it is not a temperature after all.
> 
> Thirdly, some sensors are differential in nature, showing changes over
> time rather than absolute numbers.  This explains why those values are
> small and of varying sign.
> 
> This patch interprets the sp78 type as signed short, but keeps the
> original scaling. For other types, -EINVAL is returned, since the
> nature of those sensors is unknown.
> 
> Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
> ---

Applied to -next.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
