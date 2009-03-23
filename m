From: DaNiMoTh <jjdanimoth@gmail.com>
Date: Mon, 23 Mar 2009 19:47:15 +0000
Subject: Re: [lm-sensors] new driver for adt746x.. need some hints
Message-Id: <7b71803f0903231247m54406e5akd3afe77a9b664042@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <7b71803f0903221448m56cf985ev977bb1892e6c5702@mail.gmail.com>
In-Reply-To: <7b71803f0903221448m56cf985ev977bb1892e6c5702@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

2009/3/23 DaNiMoTh <jjdanimoth@gmail.com>:
> 2009/3/23 Jean Delvare <khali@linux-fr.org>:
>> On Sun, 22 Mar 2009 22:48:13 +0100, DaNiMoTh wrote:
> The problem is that (set_pwm_tmin) is written but I can't test it. How
> I can write to this value ( RW by spec ) ?
> If I do
> echo "50" > /sys/class/hwmon/hwmon0/device/pwm1_auto_point1_temp
> it returns me a permission denied. I tried echo -n "50", echo -n 50
> ... Without any win.
>
Found the problem: I was using sudo. Log in as root and doing echo
numbers > file, it works.

> Also, what is the right way to control the pwm ( like pwmX_enable,
> pwmX, pwmX_auto_* ) ? In the module itself ( but I don't see any " Set
> limit of temp1 to 80C" or "Set the temperature which fan starts to
> 60C" in the adt7470 code ), using a manual script that do these
> modifications on sysfs ( in a way that I don't know ) or by lm_sensors
> (also in a way that I don't know) ?
>
I try to answer myself: the right way is by fancontrol.

It is really right?

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
