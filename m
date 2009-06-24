From: Konstantin Kletschke <konsti@ku-gbr.de>
Date: Wed, 24 Jun 2009 12:32:45 +0000
Subject: Re: [lm-sensors] HowTo Asus P5Q, W83667HG vs ATK0110 - fancontrol
Message-Id: <20090624123245.GB16923@punzenstreichler.doom>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090624094735.GA16670@punzenstreichler.doom>
In-Reply-To: <20090624094735.GA16670@punzenstreichler.doom>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

Am 2009-06-24 14:10 +0200 schrieb Jean Delvare:

> Note that the >> doesn't buy you anything, > is enough. These are
> virtual files.

My zsh has no_clobber enabled and the shell insists on >> even on
virtual files therefore :-) 

> This is very odd. Which kernel are you running exactly? I have a hard

Exactly I am running 2.6.30-rc7, the guy reporting this in the ubuntu
forum did this februrary 28th, so on another kernel.

> time understanding how this can happen at all. Does writing to pwm3
> change the value of pwm2, too?

echo into pwm1 changes nothing:

> cat pwm1 pwm2 pwm3
77
55
78
> echo "99" >> pwm1
> cat pwm1 pwm2 pwm3
77
55
78

echo into pwm2 changes pwm1:

> cat pwm1 pwm2 pwm3
77
55
78
> echo "99" >> pwm2
> cat pwm1 pwm2 pwm3
99
55
78

echo into pwm3 changes pwm3:

> cat pwm1 pwm2 pwm3
99
55
78
> echo "100" >> pwm3
> cat pwm1 pwm2 pwm3
99
55
100

Regards, Konsti



-- 
GPG KeyID EF62FCEF
Fingerprint: 13C9 B16B 9844 EC15 CC2E  A080 1E69 3FDA EF62 FCEF

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
