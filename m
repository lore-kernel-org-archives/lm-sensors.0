From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 03 Jun 2007 16:59:52 +0000
Subject: Re: [lm-sensors] Jetway J7F2 with f71805: PWM not working
Message-Id: <20070603185952.1598e864@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1180813726137@dmwebmail.belize.chezphil.org>
In-Reply-To: <1180813726137@dmwebmail.belize.chezphil.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Phil,

On Sat, 02 Jun 2007 20:48:46 +0100, Phil Endecott wrote:
> localhost:/sys/devices/platform/f71805f.656# for i in pwm*; do echo -n 
> $i ': '; cat $i; done
> pwm1 : 0
> pwm1_enable : 1
> pwm1_freq : 187500
> pwm1_mode : 1
> pwm2 : 0
> pwm2_enable : 1
> pwm2_freq : 187500
> pwm2_mode : 1
> pwm3 : 0
> pwm3_enable : 1
> pwm3_freq : 187500
> pwm3_mode : 1
> 
> (I hope I have understood this correctly; 'enable=1' means manual 
> control, and 'pwm=0' means off, right?)

Yes.

> So, has anyone else had any experience with this board?  Has PWM been 
> known to work with other boards with this chip?  Is it common for fan 
> connectors to not have PWM control?

I have a Jetway K8M8MS motherboard with a Fintek F71805F chip, where
pwm1 controls fan1. So I am reasonably certain that fan speed control is
properly implemented by my f71805f driver. However, you are not the
first one to report about being enable to control the fans using this
driver. It seems to be common that motherboard manufacturers don't
bother wiring things properly :(

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
