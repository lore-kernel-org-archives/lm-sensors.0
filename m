From: philippe.roubach@free.fr (ROUBACH Philippe)
Date: Sun, 29 Jan 2006 18:19:32 +0000
Subject: [lm-sensors] pwmconfig minstart minstop problem
Message-Id: <200601291919.32588.philippe.roubach@free.fr>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello

1. My config
Asus A7N8X-X with asb100 and w83l785ts
Q-fan features disabled

MDV 2006
kernel 2.6.12.15mdk-1-1mdk
lm_sensors-2.9.1-4mdk
liblm_sensors3-2.9.1-4mdk

2. pwmconfig pb

the first part of pwmconfig works well
- pwm discovery
- correlation generation
- speed control works during these steps

but when we try to layout the discovered pwm and we want to use minstart or 
minstop test that does not work.
Fan is not stopped
fan speed is not increased
fan speed is not decreased

after quitting pwconfig i have no control over fan speed with echo control.
i must restart my PC to have again control over fan speed.

I think perhaps there is a bad management with enable/disable state or else?

3. fancontrol pb

fancontrol use raw values, not computed values.
it will be better to use ?values  from lm_sensors software?

in my case
- raw cpu fan speed must be divided by 2
- raw cpu temperature must be divided by 1.305

thanks in advance
-- 
Philippe ROUBACH

