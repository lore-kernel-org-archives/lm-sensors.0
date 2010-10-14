From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 14 Oct 2010 13:30:06 +0000
Subject: Re: [lm-sensors] [PATCH 3/3] hwmon: (lm85) Add support for ADT7468
Message-Id: <20101014133006.GE19951@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101014100002.66ab5504@endymion.delvare>
In-Reply-To: <20101014100002.66ab5504@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Oct 14, 2010 at 04:00:02AM -0400, Jean Delvare wrote:
> The ADT7468 supports a high-frequency PWM output mode where all PWM
> outputs are driven by a 22.5 kHz clock. Add support for this mode, and
> document it, as it may surprise the user that setting one PWM output
> frequency also affects the other PWM outputs.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Cc: Darrick J. Wong <djwong@us.ibm.com>

Acked-by: Guenter Roeck <guenter.roeck@ericsson.com>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
