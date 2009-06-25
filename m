From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 25 Jun 2009 09:21:28 +0000
Subject: Re: [lm-sensors] HowTo Asus P5Q, W83667HG vs ATK0110 - fancontrol
Message-Id: <20090625112128.46254e57@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090624094735.GA16670@punzenstreichler.doom>
In-Reply-To: <20090624094735.GA16670@punzenstreichler.doom>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 24 Jun 2009 16:23:50 +0200, Konstantin Kletschke wrote:
> What I wonder, is there any success report pwm controlling cpu fan from
> userspace with this W83667HG-A chip?
> 
> Meanwhile I read many reports not achieving this. There are two other
> fan header (3-PIN non PWM) and many people connect their fans there and
> doing DC regulation, even on windows platform (the other pin on some
> p5q-xxx boards are able to do DC regulating there, I don't know if mine
> is able to do yet).

Additional question: does the BIOS offer options to enable/disable
automatic fan speed control? If so, please list them all, and check
what is their effect on the pwm* values (including pwm*_enable)
reported by the w83627ehf driver.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
