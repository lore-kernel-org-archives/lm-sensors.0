From: MillTek <mill.tek@verizon.net>
Date: Thu, 05 Jul 2007 18:46:17 +0000
Subject: Re: [lm-sensors] new fintek f71882fg driver, feedback appreciated
Message-Id: <468D3C79.1060405@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <468D17A5.60902@hhs.nl>
In-Reply-To: <468D17A5.60902@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Could someone re-post the instructions for compiling and installing this 
driver please??


Thanks,
Jim

Hans de Goede wrote:
> Hi all,
>
> Here is the latest version of the fintek f71882fg driver, which BTW 
> will also work for the fintek f71883fg, which is identical except that 
> it has a p80 port multiplexed with the handshake lines of uart2 (p80 
> is a special port to driver 7 segments displays, now a days often used 
> to show post codes on the motherboard). Funny enough it even has the 
> same lpc device id as the 71882. Actually since the epox motherboard 
> which I use for testing ahs a 7 segments display for post codes, I 
> strongly suspect that the ep1308 is a 71883 not a 71882.
>
> Changes:
> -add in1-max (rw), beep (rw), alarm
> -add fanX beep (rw), alarm
> -add tempX beep (rw), alarm, fault
> -make tempX max, crit rw
> -make tempX max_hyst and crit_hyst absolute instead of relative
> -make tempX max_hyst rw
>
> Todo:
> -pwm support
>
> This beast has one complicated pwm part, I'll sleep a night on this 
> and then maybe write a sysfs interface proposal before I start coding.
>
> Regards,
>
> Hans
> ------------------------------------------------------------------------
>
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
