From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 25 Feb 2009 09:11:21 +0000
Subject: Re: [lm-sensors] [RFC] lm-sensors-3.1.0: Create /etc/sensors.d
Message-Id: <20090225101121.40619588@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090225084923.GA4434@ubuntu>
In-Reply-To: <20090225084923.GA4434@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Andre,

On Wed, 25 Feb 2009 09:49:23 +0100, Andre Prendel wrote:
> lm-sensors-3.1.0 will introduce multiple configuration files support. The
> related directory /etc/sensors.d is not created by default. Maybe we
> should do that during installation, shouldn't we?

I agree. While this directory isn't required, its presence will make
people realize that they can put configuration files there. Want to
give it a try?

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
