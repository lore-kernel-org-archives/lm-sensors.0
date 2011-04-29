From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 29 Apr 2011 17:04:43 +0000
Subject: Re: [lm-sensors] [PATCH] Move ACPI power meter driver to hwmon
Message-Id: <1304096683.31666.289.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110429185312.1c5bbd84@endymion.delvare>
In-Reply-To: <20110429185312.1c5bbd84@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: LM Sensors <lm-sensors@lm-sensors.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Darrick J. Wong" <djwong@us.ibm.com>, Len Brown <lenb@kernel.org>

On Fri, 2011-04-29 at 12:53 -0400, Jean Delvare wrote:
> As discussed earlier, the ACPI power meter driver would better live
> in drivers/hwmon, as its only purpose is to create hwmon-style
> interfaces for ACPI 4.0 power meter devices. Users are more likely to
> look for it there, and less likely to accidentally hide it by
> unselecting its dependencies.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Cc: "Darrick J. Wong" <djwong@us.ibm.com>
> Cc: Guenter Roeck <guenter.roeck@ericsson.com>
> Cc: Len Brown <lenb@kernel.org>

Acked-by: Guenter Roeck <guenter.roeck@ericsson.com>



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
