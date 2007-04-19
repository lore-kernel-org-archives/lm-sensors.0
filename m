From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 19 Apr 2007 13:39:43 +0000
Subject: Re: [lm-sensors] watch dog use on W83627THF
Message-Id: <20070419153943.03edc525@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <36ba31bd0704180523p44867846pe304f4ef99bbd26e@mail.gmail.com>
In-Reply-To: <36ba31bd0704180523p44867846pe304f4ef99bbd26e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Nick,

On Wed, 18 Apr 2007 13:23:20 +0100, Nick Upson wrote:
> I have a need to use the hardware watch dog timer on this chip from
> fedora core 5.
> 
> There is a sample program which seems to be related on
> http://www.commell.com.tw/support/support.htm but it's for windows
> 
> Has anyone done this, Can I do it via lm_sensors?

No, watchdogs features are not supported by lm-sensors. You should
take a look in drivers/char/watchdog in the Linux kernel source tree,
there are 5 watchdog drivers for Winbond chips. None of them seem to
support the W83627THF device at the moment, but I guess that it
shouldn't be too hard to extend one of these drivers based on the
information in the W83627THF datasheet.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
