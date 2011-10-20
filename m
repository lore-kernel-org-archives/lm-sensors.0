From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 20 Oct 2011 14:28:15 +0000
Subject: Re: [lm-sensors] [PATCH 2/3] hwmon: (w83627ehf) Uninline
Message-Id: <1319120895.3720.271.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 2011-10-20 at 03:08 -0400, Jean Delvare wrote:
> Helper function is_word_sized has grown too much to be kept inline. It
> was OK when there were only 6 word-sized registers but support for new
> devices have made the list much longer. The function is also called
> from more places than before.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Cc: Guenter Roeck <guenter.roeck@ericsson.com>
> ---

Applied to -next.

Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
