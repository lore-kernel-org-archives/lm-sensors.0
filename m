From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 20 Nov 2012 03:42:03 +0000
Subject: Re: [lm-sensors] [PATCH 328/493] hwmon: remove use of __devinitdata
Message-Id: <20121120034203.GC27264@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1353349642-3677-328-git-send-email-wfp5p@virginia.edu>
In-Reply-To: <1353349642-3677-328-git-send-email-wfp5p@virginia.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Nov 19, 2012 at 01:24:37PM -0500, Bill Pemberton wrote:
> CONFIG_HOTPLUG is going away as an option so __devinitdata is no
> longer needed.
> 
> Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
> Cc: Jean Delvare <khali@linux-fr.org> 
> Cc: Guenter Roeck <linux@roeck-us.net> 
> Cc: lm-sensors@lm-sensors.org 

Acked-by: Guenter Roeck <linux@roeck-us.net>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
