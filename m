From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:17 +0000
Subject: Error in keywest patch
Message-Id: <20030914103846.62cf9f4c.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200309140057.11231.Manfred.Tremmel@iiv.de>
In-Reply-To: <200309140057.11231.Manfred.Tremmel@iiv.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> I'm compiling a new kernel on my PowerBook. I had a problem compiling 
> the sounddriver after patching i2c. I've found the installation-guide 
> and the patch to solve this: 
> linux-2.4.22-i2c-2.8.0-drivers-i2c-i2c-keywest.c.diff

Yes, we even had a new item on our main page that mentions this.

> But this patch is buggy! This line is added:
> 
> 		chan->adapter.name = THIS_MODULE;
> 
> this can not work, please replace it with
> 
> 		chan->adapter.owner = THIS_MODULE;

You're perfectly right, my mistake. I have been converting a dozen
drivers in a row and obviously bugged that one. It's now fixed.

> thanks for your great work.

And thanks a lot for reporting.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
