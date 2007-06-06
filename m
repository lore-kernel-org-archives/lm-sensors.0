From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 06 Jun 2007 15:43:22 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] hwmon/sis5595: Convert to a platform
Message-Id: <20070606174322.47704ec5@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070603174224.44353a33@hyperion.delvare>
In-Reply-To: <20070603174224.44353a33@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 6 Jun 2007 17:26:45 +0200, Ivo Manca wrote:
> I can't get _anything_ to enter my logs. Is there something required, 
> besided enabling the hwmon debugging messages? I've tried to find more 
> information about logging on the web, but couldn't find anything relevant.

Hmmm. Try unloading i2c-sis630 and i2c-sis5595 first, then reload
sis5595?

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
