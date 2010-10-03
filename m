From: Jonathan Cameron <jic23@cam.ac.uk>
Date: Sun, 03 Oct 2010 11:21:17 +0000
Subject: Re: [lm-sensors] [RFC PATCH 2/9] hwmon: lis3: regulator control
Message-Id: <4CA8672D.2070801@cam.ac.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <1285933616-16044-1-git-send-email-samu.p.onkalo@nokia.com>	 <1285933616-16044-3-git-send-email-samu.p.onkalo@nokia.com>	 <4CA76CDA.4040803@cam.ac.uk> <1286083558.2064.35.camel@noppispoppis.nmp.nokia.com>
In-Reply-To: <1286083558.2064.35.camel-Vo7XL3ix0D0UEupzmRo7jhl4MBrZKKet0E9HWUfgJXw@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: samu.p.onkalo-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org
Cc: "eric.piel-VkQ1JFuSMpfAbQlEx87xDw@public.gmane.org" <eric.piel-VkQ1JFuSMpfAbQlEx87xDw@public.gmane.org>, "khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org" <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>, "kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org" <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org" <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>


...
>> subtle change here... Out of intererst, why did the top level lis3_dev
>> structure ever exist?  (you can tell I haven't looked closely at this driver
>> before!) Can remove_fs return an error? 
> 
> Remove fs returns always 0. 
> 
> There are couple of bigger changes which somebody should do to this
> driver:
> - Change static lis3_dev structure to a dynamically allocated one//generalize
Definitely.
> - Add proper error handling to the driver.

Agreed, hopefully someone will step up and do it (good job for a starting out
kernel dev perhaps?)



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
