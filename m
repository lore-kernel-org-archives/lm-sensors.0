From: "Justin Piszcz" <jpiszcz@lucidpixels.com>
Date: Fri, 06 Apr 2012 20:24:57 +0000
Subject: Re: [lm-sensors] Supermicro X7SPA-HF: in4 ALARM
Message-Id: <021401cd1433$56049180$020db480$@lucidpixels.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <01fa01cd1430$fed0b990$fc722cb0$@lucidpixels.com>
In-Reply-To: <01fa01cd1430$fed0b990$fc722cb0$@lucidpixels.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



-----Original Message-----
From: Jean Delvare [mailto:khali@linux-fr.org] 
Sent: Friday, April 06, 2012 4:19 PM
To: Justin Piszcz
Cc: lm-sensors@lm-sensors.org
Subject: Re: [lm-sensors] Supermicro X7SPA-HF: in4 ALARM

On Fri, 6 Apr 2012 16:08:12 -0400, Justin Piszcz wrote:
> Hello,
> 
> Was curious why the max voltage does not show up properly for in4 (VDIMM)
> for this X7SPA-HF using lm sensors 3.3.1 or 3.3.2?
> 
> On the sensor reading page for IPMI:
> VDIMM	Normal	1.84 Volts

You should not mix IPMI with native Linux hardware monitoring driver.
There is no mutual exclusion on device access, and havoc can (and will)
happen.

Ah, good to know!

>     ignore intrusion0

Did you run "sensors -s" after changing the configuration file?

Whoops, missed this, thanks, that was it-- if the board's built-in IPMI monitoring (accessible via IPMI web interface) is going to interfere with lm_sensors, its probably best not to use it and just refer to the IPMI via the web interface?

Justin.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
