From: thijs@thijsbakx.nl (Thijs Bakx)
Date: Thu, 19 May 2005 06:23:59 +0000
Subject: Fw: Some very strange problems with lm-sensors
Message-Id: <003c01c32fff$1429de40$1200a8c0@twit>
List-Id: <lm-sensors.vger.kernel.org>
References: <000501c32ffe$afb61410$1200a8c0@twit>
In-Reply-To: <000501c32ffe$afb61410$1200a8c0@twit>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Just to be sure, The output i gave u  is what i get AFTER that i made
/dev/i2c files by myself.
----- Original Message ----- 
From: "Thijs Bakx" <thijs@thijsbakx.nl>
To: <sensors@stimpy.netroedge.com>
Cc: "Lennard" <lennard.klein@planet.nl>
Sent: Wednesday, June 11, 2003 11:48 AM
Subject: Some very strange problems with lm-sensors


> As i said in the subject in short the problem is that i can?t find any
> sensors
> on my asus a7v8-x with lm-sensors. I have patched my kernel , 2.4.20, with
> the
> correct patches and compiled the kernel with all lmsensors and i2c
support.
> But still no sensors were found, then i tried to compile everything as
> modules
> and now sensors-detect gives us some sensors. Although when I modprobe
them
> and then try ?sensors ? again it still says no sensors found. I even tried
> to
> get those sensors to work with the forced undectable sensors method but
> then ./i2cdetect 0 says it can?t open /dev/i2c-0. And I found out
> that /dev/i2c-0 indeed not exists.
>
> I think I have tried just everything i could so thats why I decided to ask
> it
> here. I hope i gave enough info otherwise you can just mail me.
>
> Is there any irc channel or something were a lot of lm-sensors users hang
> out ?
>
>
> The output of i2cdetect:
>
> fulgor:/home/admin/twit/downloads/lm_sensors-2.7.0/prog/detect#
./i2cdetect
> 0
>   WARNING! This program can confuse your I2C bus, cause data loss and
worse!
>   I will probe file /dev/i2c-0
>   You have five seconds to reconsider and press CTRL-C!
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
>  00: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
>  10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
>  20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
>  30: 30 31 XX XX XX XX XX 37 XX XX XX XX XX XX XX XX
>  40: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
>  50: 50 51 XX XX XX XX XX XX XX XX XX XX XX XX XX XX
>  60: XX XX XX XX XX XX XX XX XX 69 XX XX XX XX XX XX
>  70: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
>
