From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:46 +0000
Subject: emc6d102 support
Message-Id: <20050327173124.1964daa5.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200502011003.40803.rafael.espindola@gmail.com>
In-Reply-To: <200502011003.40803.rafael.espindola@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Rafael,

> The attached patchs add support for the extended precision ADC present
> in the  emc6d102 and adm1027. The kernel patch also redefines some
> macros to  explicitly use SCALE. This change makes then more readable.

I applied the user-space part of your patch, thanks (and sorry for the
delay). The kernel part seems to be for the 2.6 kernel, not for
lm_sensors CVS. Greg accepted this kernel patch recently. Do you have
something similar for lm_sensors CVS? It would be great to at least
support the emc6d102 there too, even if we don't support the extended
precition (which might be a bit hard anyway due to the lack of
flexibility of the procfs interface anyway).

Please tell us if you have something ready, or plan to propose such a
patch. If not I'll give it a try.

Thanks,
-- 
Jean Delvare
