From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 02 Nov 2012 15:24:04 +0000
Subject: Re: [lm-sensors] [PATCH 9/9] hwmon: (it87) Report thermal sensor type as Intel PECI if appropriate
Message-Id: <20121102162404.777cd2d8@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1351448401-13985-10-git-send-email-linux@roeck-us.net>
In-Reply-To: <1351448401-13985-10-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 1 Nov 2012 20:09:00 -0700, Guenter Roeck wrote:
> One would think so, but that doesn't fit with Jean's observation that he has to
> enter -128 degC (or possibly 128 degC) for a decent temperature reading.
> 
> Jean, does the temperature increase if you put load onto the system ?

Yes.

> And which value in temp3_offset makes the reported temperature match the
> temperature reported by k10temp ?

temp3_offset value of 116000 makes them match.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
