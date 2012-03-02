From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 02 Mar 2012 16:32:17 +0000
Subject: Re: [lm-sensors] [PATCH v2 4/4] hwmon: (f75375s) Catch some attempts to write to r/o registers
Message-Id: <1330705937.23014.277.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1330463755-5763-5-git-send-email-mail@microschulz.de>
In-Reply-To: <1330463755-5763-5-git-send-email-mail@microschulz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 2012-02-28 at 16:15 -0500, Nikolaus Schulz wrote:
> It makes no sense to attempt to manually configure the fan in auto mode,
> or set the duty cycle directly in closed loop mode.  The corresponding
> registers are then read-only.  If the user tries it nonetheless, error out
> with EINVAL instead of silently doing nothing.
> 
> Signed-off-by: Nikolaus Schulz <mail@microschulz.de>

Applied (with minor formatting cleanup) to -next.

Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
