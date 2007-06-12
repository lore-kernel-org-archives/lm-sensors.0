From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Tue, 12 Jun 2007 17:42:29 +0000
Subject: Re: [lm-sensors] sis5595
Message-Id: <466EDB05.5060504@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <200307161427.08403.linux@1g6.biz>
In-Reply-To: <200307161427.08403.linux@1g6.biz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Hi Ivo,
> 
> If you can't get additional information, you can label in4 "CPU Temp",
> observe the reading over a period of time, and set arbitrary limits
> accordingly. Unfortunately we have no way to tell "sensors" that a
> voltage input is actually a temperature value.
> 

Is it possible other motherboards manufacturers have done something similar?
Ifso would it be an idea to add a driver flag to rename all the in4 sysfs attr 
to tempX sysfs attr, without changing the way how things are read?

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
