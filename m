From: "R, Durgadoss" <durgadoss.r@intel.com>
Date: Mon, 04 Jun 2012 17:05:30 +0000
Subject: Re: [lm-sensors] [PATCH RFC] hwmon: (coretemp) Improve support for TjMax detection on Atom CPUs
Message-Id: <4D68720C2E767A4AA6A8796D42C8EB5912EAE7@BGSMSX101.gar.corp.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1338827851-702-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1338827851-702-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

[big cut.]
> 
> If you look closely at the patch, you will notice that the Atom code
> starts with
> 
>      tjmax = 90000;
> 
> 90 degrees C is thus the default case. The table only includes values
> for CPUs with a different tjmax. That keeps the table a bit smaller.
> 

Oh got it...and it makes sense. I will try in a couple of days and reply here.

Thanks,
Durga

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
