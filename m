From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 01 Jun 2011 16:57:15 +0000
Subject: Re: [lm-sensors] [PATCH v2] hwmon: (coretemp) Fix TjMax detection
Message-Id: <20110601185715.7fcd12ba@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1306943446-6107-1-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1306943446-6107-1-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 1 Jun 2011 08:50:46 -0700, Guenter Roeck wrote:
> Commit a321cedb12904114e2ba5041a3673ca24deb09c9 excludes CPU models 0xe, 0xf,
> 0x16, and 0x1a from TjMax temperature adjustment, even though several of those
> CPUs are known to have TiMax other than 100 degrees C, and even though the code
> in adjust_tjmax() explicitly handles those CPUs and points to a Web document
> listing several of the affected CPU IDs.
> 
> Reinstate original TjMax adjustment if TjMax can not be determined using the
> IA32_TEMPERATURE_TARGET register.

Tested on my 3 machines, looks alright.

Acked-by: Jean Delvare <khali@linux-fr.org>

> Note: This patch is a candidate for -stable [ .35 to .39]

Yes please.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
