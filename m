From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 11 Jan 2010 08:35:18 +0000
Subject: Re: [lm-sensors] hwmon: (coretemp) Check the sensor existence
Message-Id: <20100111093518.069d2a8b@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100108160144.GA23650@owl>
In-Reply-To: <20100108160144.GA23650@owl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Adam,

On Mon, 11 Jan 2010 16:29:44 +1000, Adam Nielsen wrote:
> >>> [1] http://www.intel.com/Assets/PDF/manual/253668.pdf
> >> $ wget http://www.intel.com/Assets/PDF/manual/253668.pdf
> >> --2010-01-08 19:05:33--  http://www.intel.com/Assets/PDF/manual/253668.pdf
> >> Resolving www.intel.com... 88.221.93.91, 88.221.93.112
> >> Connecting to www.intel.com|88.221.93.91|:80... connected.
> >> HTTP request sent, awaiting response... 403 Forbidden
> >> 2010-01-08 19:05:33 ERROR 403: Forbidden.
> >> $ 
> > 
> > I can access the above link at external, I don't know why. Try the link:
> > http://www.intel.com/products/processor/manuals/ or google "253668.pdf".
> 
> Try this instead:
> 
> $ wget http://www.intel.com/Assets/PDF/manual/253668.pdf --user-agent=""
> 
> Fixes the 403 for me :-)

Probably Intel protecting themselves from web suckers. Thanks for the
tip :)

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
