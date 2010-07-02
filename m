From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 02 Jul 2010 14:59:47 +0000
Subject: Re: [lm-sensors] Driver for MAX6696 temperature sensor
Message-Id: <20100702165947.6113bcb8@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100701011831.GA6915@ericsson.com>
In-Reply-To: <20100701011831.GA6915@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 2 Jul 2010 07:14:06 -0700, Guenter Roeck wrote:
> On Fri, Jul 02, 2010 at 05:53:45AM -0400, Jean Delvare wrote:
> > Of course it really depends on what each limit does. "warn" would
> > probably be the lowest high limit, only warning the user / admin that
> > some action will be taken later if the temperature keeps raising.
> > 
> > Maybe temp[1-*]_emergency would be better than temp[1-*]_crit2?
> > 
> Since it would be the highest limit, temp[1-*]_emergency sounds really good. 

Feel free to submit a documentation patch adding this then.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
