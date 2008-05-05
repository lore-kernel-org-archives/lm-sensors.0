From: Paulius Zaleckas <paulius.zaleckas@teltonika.lt>
Date: Mon, 05 May 2008 20:01:02 +0000
Subject: Re: [lm-sensors] [Patch] max1236-9 ADC support
Message-Id: <481F677E.9040303@teltonika.lt>
List-Id: <lm-sensors.vger.kernel.org>
References: <481F3FD6.6090605@cam.ac.uk>
In-Reply-To: <481F3FD6.6090605@cam.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jonathan Cameron wrote:
> +/* The max123x registers */
> +#define MAX123X_SETUP_BYTE(a)     0x80 | a
> +#define MAX123X_CONF_BYTE(a)      0x00 | a

Avoid defining macros like this. Should be:
#define MAX123X_SETUP_BYTE(a)     (0x80 | (a))
#define MAX123X_CONF_BYTE(a)      (0x00 | (a)) /* what is the point to OR it with 0x00??? */

For example MAX123X_SETUP_BYTE(0x02 & 0x03) & 0x01 in your case will be expanded as:
0x80 | 0x02 & 0x03 & 0x01 = 0x80
in my case:
(0x80 | (0x02 & 0x03)) & 0x01 = 0x00

As you can see the result will be totally different!

Regards,
Paulius Zaleckas


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
