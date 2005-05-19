From: zayets@comcast.net (Rob)
Date: Thu, 19 May 2005 06:25:23 +0000
Subject: Please list which file to etc/rc* file modiify
Message-Id: <1101158295.2715.0.camel@Oneniisama>
List-Id: <lm-sensors.vger.kernel.org>
References: <1100659621.2956.12.camel@Oneniisama>
In-Reply-To: <1100659621.2956.12.camel@Oneniisama>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

can you walk  me through how to change those values?  are we still
messing with the conf file?

Rob


On Sun, 2004-11-21 at 13:41, Jean Delvare wrote:
> > [root@Oneniisama rob]# strace sensors -s
> > execve("/usr/bin/sensors", ["sensors", "-s"], [/* 62 vars */]) = 0
> > (...)
> 
> The output seems totally normal, so I don't understand what's going on.
> This would seem to accuse the chip driver more than the sensors program.
> 
> Please try changing the values manually and see how it is going. For
> example, do:
> 
> cat /sys/bus/i2c/devices/1-002d/fan_div1
> echo 4 > /sys/bus/i2c/devices/1-002d/fan_div1
> (wait 3 seconds)
> cat /sys/bus/i2c/devices/1-002d/fan_div1
> 
> If it doesn't return 4 then the chip driver is faulty, or, more likely,
> the chip itself. Could be that the chip is locked in read-only mode. We
> do not have a datasheet for the ASB100 so it's hard to tell.
