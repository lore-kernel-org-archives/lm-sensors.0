From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:20 +0000
Subject: adm1026 driver port for kernel 2.6.X
Message-Id: <GNXY8AG6.1098776962.4770080.khali@gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041018210758.GB14960@penguincomputing.com>
In-Reply-To: <20041018210758.GB14960@penguincomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


>Ok.  Let's try this:
>
>pwm1                    {0-255}   Actual PWM/DAC value, single interface to
>                                  both registers.
>pwm1_auto_pwm_min       {0-255}   Scaled to {0-15}, single interface to both
>                                  registers.
>pwm1_enable             {0-2}     Fan control:  off, manual, and automatic,
>                                  respectively
>pwm1_mode               {0-1}     0 (default) is PWM control of fans, 1 is
>                                  DAC.

Fine with me. You may even rename pwm1_mode to pwm1_dac or use text
strings as the values (say "pwm" and "dac") so as to make the
interface self-explaining. Not a big deal anyway, and we obviously lack
the knowledge of other chips with similar functionality to decide what
the smartest move would be. We can always change it afterwards if such
chips arise. I don't think it'll happen though, since DAC have
completely disappeared from newer chips.

--
Jean Delvare
