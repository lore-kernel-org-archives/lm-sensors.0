From: vbordug@ru.mvista.com (Vitaly Bordug)
Date: Wed, 28 Dec 2005 18:59:25 +0000
Subject: [lm-sensors] I2C for ppc 8xx
Message-Id: <43B2E08D.4010901@ru.mvista.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean,
I have a working example of ppc 8xx family I2C within 2.6 kernel,
and I am wondering how to push it upstream.

It seems there are no official "merge point" between lm_sensors stuff and linus git, since
i2c repo contains, for instance, 8xx algo once 2.6 does not.

Another interesting thing is i2c-mpc.c stuff which exists  the mainline but does not in the lm_sensors and i2c repos.

Hereby I am confused a bit how to proceed properly.

TIA!

-- 
Sincerely,
Vitaly

