From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Sun, 15 Jul 2007 08:51:20 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon/f71805f: List the F71805F/FG as
Message-Id: <4699E008.70204@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070715103606.3375e2bb@hyperion.delvare>
In-Reply-To: <20070715103606.3375e2bb@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



Jean Delvare wrote:
> The Fintek F71806F/FG is compatible with the F71872F/FG, so it is
> already supported by the f71805f hardware monitoring driver. In fact,
> both chips have the same chip ID, so the driver can't even
> differentiate between them.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>

Looks good to me.

Not really sure if this is appropriate:
Acked-by: Hans de Goede <j.w.r.degoede@hhs.nl>

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
