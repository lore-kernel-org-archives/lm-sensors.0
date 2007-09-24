From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 24 Sep 2007 16:54:03 +0000
Subject: Re: [lm-sensors] [PATCH] Remove error message if die-code is missing
Message-Id: <20070924185403.196e3d37@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070924082613.GA2787@hall.aurel32.net>
In-Reply-To: <20070924082613.GA2787@hall.aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Aurelien,

On Mon, 24 Sep 2007 10:26:13 +0200, Aurelien Jarno wrote:
> The simple patch below removes the error message if the die-code entry
> is missing in /sys. It has been removed from the 2.6 kernels for a long
> time.
> 
> It is still present for 2.4 kernels though, so we should keep the code
> reading this entry.

Patch applied, thanks.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
