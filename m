From: mbm@livewiredev.com (MBM Support)
Date: Thu, 19 May 2005 06:24:20 +0000
Subject: Iwill MPX2 - LM83/LM90 confusion
Message-Id: <FJEPJHGHDGKMMPFFGCLOOEONEJAA.mbm@livewiredev.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1065536622.3f82cc6ee9ab5@imp.gcu.info>
In-Reply-To: <1065536622.3f82cc6ee9ab5@imp.gcu.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

the LM90 only allows 1 smbus adress and thus there can not be 2

Iwill switches the input from the 2 cpu's, put a certain pin high and you
get cpu0, put it low and you get cpu1 on the SAME LM90

Jean has the code and it is based on info gotten from IWill

Regards, Alex

- Please always attach all previous mails !
----------------------------------------------------------------------
The Motherboard Monitor:
http://mbm.livewiredev.com/
----------------------------------------------------------------------
For long you live and high you fly,
And smiles you'll give and tears you'll cry,
And all you touch and all you see,
Is all your life will ever be.
----------------------------------------------------------------------



-----Original Message-----
From: Jean Delvare [mailto:khali@linux-fr.org]
Sent: dinsdag 7 oktober 2003 17:20
To: lamar@synque.com
Cc: sensors@stimpy.netroedge.com; mbm@livewiredev.com
Subject: Re: Iwill MPX2 - LM83/LM90 confusion




> One more item, I hope this isn't noise, but there may be two(!)
> LM90s/LM83s on the MPX2.

Maybe, maybe not. Running 2.8.1's sensors-detect will tell you that (and
possibly more).

> At any rate, I had seen the 2.8.1 but was loathe to install it
> because:
> 1) I'd just installed 2.8.0

This means you'd have installed 2.8.1 easily, since the procedure hasn't
changed ;)

> 2) 2.8.1 was beta

In now way it is. What made you think it could be?

> But if you invested the time to write it the least I can do is
> install and test it.

If you wan't LM90 support, you want 2.8.1. It's that simple ;)

> Question: why does the i2c version always have to increase
> to support lm_sensors?

Because most sensor chips are located on the I2C bus (aka SMBus).

> Are you upgrading i2c to handle devices that lm_sensors will use?

Yes, sort of. We add utility functions, remove unused ones, adapt
internal structures to reflect kernel policy changes, and so on. You do
not always need the exact same version of i2c and lm_sensors, but since
we also fix bugs it i2c, you always want to update i2c to match the
version of lm_sensors you plan to install.

Let us know how 2.8.1 does work for you :)
Thanks.

--
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

-------------------------------------------------
This mail sent through IMP: http://horde.org/imp/
