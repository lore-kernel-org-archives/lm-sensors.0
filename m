From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 13 May 2008 15:42:40 +0000
Subject: Re: [lm-sensors] [PATCH 3/3 RESEND 2] hwmon (dme1737): add support
Message-Id: <20080513174240.7919a00e@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0805130807s5f45bf3eq73d2b17be48cb52e@mail.gmail.com>
In-Reply-To: <191fb4ca0805130807s5f45bf3eq73d2b17be48cb52e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 13 May 2008 08:07:43 -0700, Juerg Haefliger wrote:
> Add support for the SCH5027. The differences to the DME1737 are:
> - No support for programmable temp offsets
> - In auto mode, PWM outputs stay on min value if temp goes below low threshold
>   and can't be programmed to fully turn off
> - Different voltage scaling
> - No VID input
> 
> Signed-off-by: Juerg Haefliger <juergh at gmail.com>
> 
> ---
> Incorporated suggestions from Jean Delvare's 2nd review.

Acked-by: Jean Delvare <khali@linux-fr.org>

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
