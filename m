From: henryvician@gmail.com (Henry)
Date: Thu, 28 Jul 2005 15:41:52 +0000
Subject: [lm-sensors] Fancontrol
Message-Id: <1122557829.1153.13.camel@localhost.localdomain>
List-Id: <lm-sensors.vger.kernel.org>
References: <1122217880.3578.8.camel@localhost.localdomain>
In-Reply-To: <1122217880.3578.8.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


will the echo ...>/sys/busi2c/...  have any effect when I kill
the /sbin/fancontrol script?
I mean will it control the fan?

I thought that all those files are for the fancontrol script to operate.
If I kill the fancontrol script then no matter what the values are in in
the files the fan is still spinning like crazy

Henry 
On Thu, 2005-07-28 at 10:19 +0200, Rudolf Marek wrote:
> Hello,
> 
> It seems the best would be to disable the fancontrol script it must load from /etc/
> you can see it active with ps ax command.
> 
> Unfortunately I'm not very familiar with fancontrol stuff and I dont know your Linux distribution but here is general steps:
> 
> Steps for manual control:
> 
> 1) disable (or delete fancontrol script that loads on startup of computer)
> 2) go to /sys/bus/i2c/devices/0-290/   (the directory 0-290 might be different, just inspect every directory in devices/ and find that one with "pwm1" ... files)
> 3) to change fan speed do: echo 128 > pwm1  (or pwm2 etc depends how is your fan connected, values are from 0=stop 255=fullspeed)
> 4) you can use pwmconfig to tell you the correlation values between fanspeed and PWM value.
> 5) put the echo ... > /sys/bus/....  line somewhere to startup scripts.
> 
> I hope this helps.
> 
> Regards
> 
> Rudolf
> 

