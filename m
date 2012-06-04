From: "R, Durgadoss" <durgadoss.r@intel.com>
Date: Mon, 04 Jun 2012 16:55:28 +0000
Subject: Re: [lm-sensors] [PATCH RFC] hwmon: (coretemp) Improve support for	TjMax detection on Atom CPUs
Message-Id: <4D68720C2E767A4AA6A8796D42C8EB5912EAB0@BGSMSX101.gar.corp.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1338827851-702-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1338827851-702-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

> -----Original Message-----
> From: lm-sensors-bounces@lm-sensors.org [mailto:lm-sensors-bounces@lm-
> sensors.org] On Behalf Of Guenter Roeck
> Sent: Monday, June 04, 2012 10:08 PM
> To: lm-sensors
> Cc: Guenter Roeck
> Subject: [lm-sensors] [PATCH RFC] hwmon: (coretemp) Improve support for
> TjMax detection on Atom CPUs
> 
> Atom CPUs don't have a register to retrieve TjMax. Detection so far is
> incomplete. Use the X86 model ID to improve it.
> 

Thanks for the patch...

> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> Wonder if we can improve TjMax detection for Atom CPUs with this code.
> Anyone with Atom CPUs out there for some testing ?

I can test it out on the Medfield platform (Atom based).
But its Tjmax is 90 C. I don't see any 90 C values in your array.
is there a reason behind it ?
Or we can add as we find more models ?

Thanks,
Durga

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
