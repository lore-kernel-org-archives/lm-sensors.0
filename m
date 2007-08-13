From: "Juerg Haefliger" <juergh@gmail.com>
Date: Mon, 13 Aug 2007 16:55:30 +0000
Subject: Re: [lm-sensors] [PATCH] [159/2many] MAINTAINERS - DME1737 HARDWARE
Message-Id: <191fb4ca0708130955l5ee0d263o4e01c4caa96bf811@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <46bff993.7OEwF3qQrioxyBDU%joe@perches.com>
In-Reply-To: <46bff993.7OEwF3qQrioxyBDU%joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "joe@perches.com" <joe@perches.com>
Cc: torvalds@linux-foundation.org, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org

On 8/12/07, joe@perches.com <joe@perches.com> wrote:
> Add file pattern to MAINTAINER entry
>
> Signed-off-by: Joe Perches <joe@perches.com>
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 70e5070..2fafb83 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1553,6 +1553,7 @@ P:        Juerg Haefliger
>  M:     juergh@gmail.com
>  L:     lm-sensors@lm-sensors.org
>  S:     Maintained

+F:     Documentation/hwmon/dme1737

> +F:     drivers/hwmon/dme1737.c
>
>  DOCBOOK FOR DOCUMENTATION
>  P:     Randy Dunlap
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
