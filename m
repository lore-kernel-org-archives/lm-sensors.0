From: Jean Delvare <jdelvare@suse.de>
Date: Mon, 07 Jul 2014 16:38:29 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (adc128d818) Drop write support on inX_input attributes
Message-Id: <20140707183829.799f780a@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1404742496-14493-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1404742496-14493-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon,  7 Jul 2014 07:14:56 -0700, Guenter Roeck wrote:
> Writes into input registers doesn't make sense, even more so since
> the writes actually ended up writing into the maximum limit registers.
> Drop it.

W-o-w :D Good catch!

Reviewed-by: Jean Delvare <jdelvare@suse.de>

-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
