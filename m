From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 11 Oct 2009 13:37:58 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (thmc50) Stop using
Message-Id: <20091011153758.6c42f53b@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20091009132729.38bb060d@hyperion.delvare>
In-Reply-To: <20091009132729.38bb060d@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 11 Oct 2009 15:29:23 +0200, Krzysztof Helt wrote:
> On Fri, 9 Oct 2009 13:27:29 +0200
> Jean Delvare <khali@linux-fr.org> wrote:
> 
> > From: Jean Delvare <khali@linux-fr.org>
> > Subject: hwmon: (thmc50) Stop using I2C_CLIENT_MODULE_PARM
> > 
> > The thmc50 driver is the last user of I2C_CLIENT_MODULE_PARM, and I
> > would like to get rid of that macro.
> > 
> > Signed-off-by: Jean Delvare <khali@linux-fr.org>
> > Cc: Krzysztof Helt <krzysztof.h1@wp.pl>
> > ---
> 
> Tested-by: Krzysztof Helt <krzysztof.h1@wp.pl>

Excellent, thank you!

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
