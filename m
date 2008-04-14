From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 14 Apr 2008 15:28:11 +0000
Subject: Re: [lm-sensors] D201GLY2 Ubuntu 7.10 fan control
Message-Id: <20080414172811.2e9e1aa8@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <f7fb2140804061737l73447d24n50b5ef11b2179557@mail.gmail.com>
In-Reply-To: <f7fb2140804061737l73447d24n50b5ef11b2179557@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 14 Apr 2008 07:17:16 -0800, Mini Stac wrote:
> Ok good progress. Using su I am able to echo in values to pwm1_enable and
> successfully control fanspeed with echo to pwm1!! However I am still unable
> to get pwmconfig to work, it seems it still cannot set any values (if I set
> pwm1_enable to 1 before running, pwmconfig will stop the fan, but still
> reports pwm1 stuck to 0, manual control mode not supported...).

OK... If you can change the values manually then it means that the
w83627ehf driver is OK (as I expected) and the problem is with the
pwmconfig script, or with bash. Same problem as ticket #2305:
http://www.lm-sensors.org/ticket/2305

Which version of bash are you running? It would be great if you could
try a different version, for example a self-built bash 2.05b, which is
known to behave properly. No need to install it, just build it locally,
and use it to run pwmconfig:
/path/bash /path/pwmconfig

> As I am completely new to linux, I am not sure now if I am running pwmconfig
> correctly. I downloaded the 3.1.01 package and extracted pwmconfig; renamed
> it pwmconf3101 and ran it under su by typing in /path/pwmconf3101

That's fine.

> I tried creating a fancontrol config file manually and it seems to be
> working ok so far (running with sudo), I guess I can try to tune the
> settings manually if I can't get pwmconfig to work.

Indeed tuning the configuration file manually is easy. IMHO it's even
easier than with pwmconfig once you know the syntax.

> Thanks so much for your assistance with this!

You're welcome.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
