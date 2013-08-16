From: Ian Pilcher <arequipeno@gmail.com>
Date: Fri, 16 Aug 2013 16:34:49 +0000
Subject: Re: [lm-sensors] it87.fix_pwm_polarity
Message-Id: <kulkb1$66m$1@ger.gmane.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <kuasuu$1j8$1@ger.gmane.org>
In-Reply-To: <kuasuu$1j8$1@ger.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 08/12/2013 09:54 AM, Ian Pilcher wrote:
> I am setting up a Thecus N5550 NAS, and I found that the it87 driver
> disables PWM control of the drive bay fan (it87.656/pwm3) unless I pass
> the fix_pwm_polarity parameter.  Once I add that parameter, fan control
> appears to work just fine.
> 
> Does this setting actually invert the voltage that is supplied to the
> fan?  If so, does this have the potential to damage the fan itself (or
> other components)?

Anyone?

-- 
====================================
Ian Pilcher                                         arequipeno@gmail.com
Sometimes there's nothing left to do but crash and burn...or die trying.
====================================


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
