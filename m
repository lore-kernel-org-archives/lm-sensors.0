From: azummo-lists@towertech.it (Alessandro Zummo)
Date: Wed, 21 Dec 2005 15:07:12 +0000
Subject: [lm-sensors] [RFC] RTC subsystem
Message-Id: <20051221160712.2d322f42@inspiron>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051220220022.4e9ff931@inspiron>
	<43A94811.4010704@hogyros.de>
In-Reply-To: <43A94811.4010704@hogyros.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Richter <Simon.Richter@hogyros.de>
Cc: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org, lm-sensors@lm-sensors.org, linux-arm-kernel@lists.arm.linux.org.uk, nslu2-developers@yahoogroups.com

On Wed, 21 Dec 2005 13:18:25 +0100
Simon Richter <Simon.Richter at hogyros.de> wrote:

> >   I've posted a proposal for a new RTC subsystem
> >  on lkml ( http://lkml.org/lkml/2005/12/20/220 ) .
> 
> I agree that there is room for improvement. Do you have a specific 
> structure in mind? Specifically,

 Hi Simon,
  the proposal actually had a fully-working patch attached :)

>   - which functions do you believe to be generic,
>   - how should multiple RTCs be handled,

 In my code, the first rtc that register is bound
 to /proc/driver/rtc and /dev/rtc (if those interfaces
 are compiled in, as they are all selectable).

 The other RTCs are available thru /sys/class/rtc/rtcX
 (again, if compiled in).

>   - are read-only (radio controlled) RTCs taken care of?

 You have full control of which functions you will provide
 to the upper layer. Obivously if you try to set the
 time on a read-only rtc, you will get an error.

> At present, I don't have time to help the cause, but I can provide 
> hosting for a git tree if desired.

 Thanks, I'll consider it if the need arises.

-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Turin, Italy

  http://www.towertech.it


