From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 09 Feb 2011 18:17:02 +0000
Subject: Re: [lm-sensors] [PATCH v2] hwmon: Consider LM64 temperature offset
Message-Id: <20110209181702.GA19998@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110208152815.GA13436@ericsson.com>
 <1297245094-13681-1-git-send-email-eibach@gdsys.de>
In-Reply-To: <1297245094-13681-1-git-send-email-eibach@gdsys.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dirk Eibach <eibach@gdsys.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "khali@linux-fr.org" <khali@linux-fr.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>

Hi Dirk,

On Wed, Feb 09, 2011 at 04:51:34AM -0500, Dirk Eibach wrote:
[ ... ]
> +/* temp2_crit can only be set once which should be job of the bootloader */
> +static SENSOR_DEVICE_ATTR(temp2_crit, S_IRUGO, show_remote_temp8,
> +	NULL, 2);

That only applies to lm63, though. It can be rewritten anytime on LM64.
That would be a separate patch, though, to not mix improvements with bug fixes.

Otherwise, looks good, so I'll apply it with an added remark that the restriction
only applies to lm63.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
