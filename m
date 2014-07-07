From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 07 Jul 2014 16:48:01 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (adc128d818) Drop write support on inX_input attributes
Message-Id: <20140707164801.GA8256@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1404742496-14493-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1404742496-14493-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Jul 07, 2014 at 06:38:29PM +0200, Jean Delvare wrote:
> On Mon,  7 Jul 2014 07:14:56 -0700, Guenter Roeck wrote:
> > Writes into input registers doesn't make sense, even more so since
> > the writes actually ended up writing into the maximum limit registers.
> > Drop it.
> 
> W-o-w :D Good catch!
> 
No, embarrassing ;-)

grep input *.c | grep WUSR

> Reviewed-by: Jean Delvare <jdelvare@suse.de>
> 
Thanks!

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
