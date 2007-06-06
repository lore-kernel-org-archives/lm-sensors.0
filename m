From: "Ivo Manca" <pinkel@gmail.com>
Date: Wed, 06 Jun 2007 15:47:36 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] hwmon/sis5595: Convert to a platform
Message-Id: <015401c7a852$026d2340$0601a8c0@pinkeltje>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070603174224.44353a33@hyperion.delvare>
In-Reply-To: <20070603174224.44353a33@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Yeah, it seems like this was the problem.
Strange though, since it did work in my 2.6.19 kernel.
Loading them in the way sensors-detect suggest (first i2c-sis5595, then 
sis5595), gives me the following output:

Jun  6 15:23:01 localhost kernel: i2c-dev: adapter [SMBus SIS5595 adapter at 
0438] registered as minor 0
Jun  6 15:23:02 localhost kernel: i2c-adapter i2c-0: ioctl, cmd=0x705, 
arg=0xbf886b54
Jun  6 15:23:03 localhost kernel: i2c-adapter i2c-0: ioctl, cmd=0x5401, 
arg=0xbfa9e818
Jun  6 15:23:03 localhost kernel: i2c-adapter i2c-0: i2c ioctl, cmd: 0x5401, 
arg: 0xbfa9e818
Jun  6 15:23:03 localhost kernel: i2c-adapter i2c-0: ioctl, cmd=0x705, 
arg=0x82ff3c0
Jun  6 15:23:03 localhost kernel: i2c-adapter i2c-0: ioctl, cmd=0x703, 
arg=0x09
Jun  6 15:23:03 localhost kernel: i2c-adapter i2c-0: ioctl, cmd=0x720, 
arg=0x82ff550
Jun  6 15:23:03 localhost kernel: i2c-adapter i2c-0: SMBus busy (0400). 
Resetting...
Jun  6 15:23:03 localhost kernel: i2c-adapter i2c-0: Failed! (400)


Then it repeats:
Jun  6 15:23:07 localhost kernel: i2c-adapter i2c-0: ioctl, cmd=0x703, 
arg=0x77
Jun  6 15:23:07 localhost kernel: i2c-adapter i2c-0: ioctl, cmd=0x720, 
arg=0x82ff550
Jun  6 15:23:07 localhost kernel: i2c-adapter i2c-0: SMBus busy (0400). 
Resetting...
Jun  6 15:23:08 localhost kernel: i2c-adapter i2c-0: Failed! (400)

Where it changes the 0x77 from 0x09 to 0x77
Bug or feature?

Ivo
----- Original Message ----- 
From: "Jean Delvare" <khali@linux-fr.org>
To: "Ivo Manca" <pinkel@gmail.com>
Cc: "LM Sensors" <lm-sensors@lm-sensors.org>
Sent: Wednesday 6 June 2007 17:43
Subject: Re: [lm-sensors] [PATCH 1/2] hwmon/sis5595: Convert to a platform 
driver


> On Wed, 6 Jun 2007 17:26:45 +0200, Ivo Manca wrote:
>> I can't get _anything_ to enter my logs. Is there something required,
>> besided enabling the hwmon debugging messages? I've tried to find more
>> information about logging on the web, but couldn't find anything 
>> relevant.
>
> Hmmm. Try unloading i2c-sis630 and i2c-sis5595 first, then reload
> sis5595?
>
> -- 
> Jean Delvare 


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
