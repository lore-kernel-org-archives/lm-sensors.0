From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 17 Jul 2012 01:11:15 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] hwmon: (applesmc) Ignore some temperature registers
Message-Id: <20120717011115.GB22234@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1342423091-330-1-git-send-email-rydberg@euromail.se>
 <1342423091-330-2-git-send-email-rydberg@euromail.se>
In-Reply-To: <1342423091-330-2-git-send-email-rydberg@euromail.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Guenter Roeck <guenter.roeck@ericsson.com>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

On Mon, Jul 16, 2012 at 09:18:11AM +0200, Henrik Rydberg wrote:
> Not all sensors in the T range are useful temperatures.  This patch
> creates a subset of sensors to be exported to userland, excluding the
> unknown types.
> 
> Signed-off-by: Henrik Rydberg <rydberg@euromail.se>

Applied to -next.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
