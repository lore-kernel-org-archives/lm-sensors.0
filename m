From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 28 Jul 2005 10:21:33 +0000
Subject: [lm-sensors] Fancontrol
Message-Id: <42E89519.90606@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <1122217880.3578.8.camel@localhost.localdomain>
In-Reply-To: <1122217880.3578.8.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

It seems the best would be to disable the fancontrol script it must load from /etc/
you can see it active with ps ax command.

Unfortunately I'm not very familiar with fancontrol stuff and I dont know your Linux distribution but here is general steps:

Steps for manual control:

1) disable (or delete fancontrol script that loads on startup of computer)
2) go to /sys/bus/i2c/devices/0-290/   (the directory 0-290 might be different, just inspect every directory in devices/ and find that one with "pwm1" ... files)
3) to change fan speed do: echo 128 > pwm1  (or pwm2 etc depends how is your fan connected, values are from 0=stop 255=fullspeed)
4) you can use pwmconfig to tell you the correlation values between fanspeed and PWM value.
5) put the echo ... > /sys/bus/....  line somewhere to startup scripts.

I hope this helps.

Regards

Rudolf

