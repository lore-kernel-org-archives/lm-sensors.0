From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:17 +0000
Subject: fan2 readout on Chaintech MB
Message-Id: <1063712534.3f66f71690bad@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <200308310230.14115.ljubo108@vip.hr>
In-Reply-To: <200308310230.14115.ljubo108@vip.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > My driver init code explicitely *stops* the chipset. No wonder you don't
> > see the values changing... Stupid me. That's fixed in CVS, if you were
> > kind enough to give it a try and tell me if it now works OK for you.
> 
> lm90 is working now:-))

Great :) Could you try adjusting limits, and also provide a sample output?

> Unfortunately I have new problems.
> I cant execute sensors -s, I'm getting this:
> 
> [root@localhost etc]# sensors -s
> it87-isa-0290: Can't access /proc file for writing;
> Run as root?
> 
> I've never had problems with sensors -s before.

Oh no! :( Not that problem again. We thought it was solved once for all...

We'd need as much details as possible about the conditions in which the problem
occurs, and first occured. Did you update lm_sensors recently? Which version
were using before? Which version are you using now? (I'd guess "latest CVS" as
the answer to the third question, but maybe you only updated the lm90.c file?)
Does the problem show only when the lm90 module is loaded (or has been loaded
since bootup)? What if you "hide" (rename, move, delete, whatever)
/etc/sensors.conf from sensors?

> and the other possible problem is this:
> sensors-detect advises to put adm1021 in modules, when I do that on boot it 
> crashes my machine. Well, I exclude adm1021 from modules, it seems that I 
> don't nedd it anyway but I wanted to report this because it did not
> hapenned before and I think I've had it before in my modules file.

For which I2C address does sensors-detect pretends the adm1021 module is
required? (and for which chipset?) Do you mean that older versions of
sensors-detect never told you that, and than newer versions do?

Any log messages when the adm1021 driver crashes your machine?

Jean Delvare



-------------------------------------------------
This mail sent through IMP: http://horde.org/imp/
