From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 13 Oct 2011 15:08:52 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] hwmon: (w83627ehf) Move fan pins check
Message-Id: <1318518532.3720.60.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <20111013164314.15a0d872@endymion.delvare>
In-Reply-To: <20111013164314.15a0d872@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 2011-10-13 at 10:43 -0400, Jean Delvare wrote:
> Move the check of fan pin usage to a separate function. This improves
> readability, and will make it easier to integrate chip-specific
> conditions.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>

Acked-by: Guenter Roeck <guenter.roeck@ericsson.com>



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
