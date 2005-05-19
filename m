From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:43 +0000
Subject: [RFC 2.6] sensor chips sysfs interface change (long)
Message-Id: <20040221155819.7bc58609.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040218220845.361341c9.khali@linux-fr.org>
	<20040221131318.GA31688@babylon.d2dc.net>
In-Reply-To: <20040221131318.GA31688@babylon.d2dc.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Zephaniah E. Hull" <warp@mercury.d2dc.net>
Cc: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com, greg@kroah.com

> I would like to further suggest the renaming of 'sensor<n>' to
> 'temp<n>_sensor' or 'temp<n>_type', in the interest of being
> consistent.

Correct. I was precisely thinking of something similar :) For the sake
of completeness, here is the list of renames that I plan to do:

temp<n>_hyst  -> temp<n>_max_hyst or temp<n>_crit_hyst
sensor<n>     -> temp<n>_type
pwm<n>        -> fan<n>_pwm
pwm<n>_enable -> fan<n>_pwm_enable
vid           -> in<n>_ref

I think that this should define a self-explanatory and easily extendable
interface. There are a few "technical" terms remaining (in, pwm, vrm),
but since these are the words used in the sensors domain, I feel like we
better keep them as they are.

Thanks a lot for your constructive comment, I appreciate that.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
