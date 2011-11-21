From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 21 Nov 2011 13:07:07 +0000
Subject: Re: [lm-sensors] [PATCH v2 2/2] hwmon: (lm63) Add support for
Message-Id: <20111121140707.421a2bb8@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1321830618-15817-1-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1321830618-15817-1-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 21 Nov 2011 10:43:39 +0100, Jean Delvare wrote:
> What about bit 3 (USF) in this enhanced configuration register? When
> set, it would affect the way we encode and decode _max and _crit
> temperature limits, right?

BTW, if you agree but don't have time to work on this, I would be
perfectly fine with a check at probe time that would complain (and
eventually bail out) if the way the chip is configured is not properly
supported by the driver. If anyone needs the feature, it can be added
later.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
