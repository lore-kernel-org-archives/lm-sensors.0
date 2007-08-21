From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 21 Aug 2007 09:07:34 +0000
Subject: Re: [lm-sensors] Questions about sysfs
Message-Id: <20070821110734.4e9b1e8c@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <5628d8010708170444i76bdc033t900cec37a726e2c1@mail.gmail.com>
In-Reply-To: <5628d8010708170444i76bdc033t900cec37a726e2c1@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 21 Aug 2007 15:29:30 +0800, dave jones wrote:
> Thanks.  I used 2.10.0. After installing lm-sensors 2.10.4 without modifying
> my driver, run pwmconfig, the result is:
> 
> Found the following devices:
>    hwmon0/device is w83l786ng
> 
> Found the following PWM controls:
>    hwmon0/device/pwm1
> hwmon0/device/pwm1_enable stuck to 1
> Failed to set pwmhwmon0/device/pwm1 to full speed
> Something's wrong, check your fans!
> 
> Did I miss something? Why it can't detect my fans? Thank you.

This is a driver issue. The script attempted to set the fan to full
speed, but failed. As I said before, we can't help you with this
without seeing the source code.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
