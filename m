From: Manfred.Tremmel@iiv.de (Manfred Tremmel)
Date: Thu, 19 May 2005 06:24:17 +0000
Subject: Error in keywest patch
Message-Id: <200309140057.11231.Manfred.Tremmel@iiv.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

I'm compiling a new kernel on my PowerBook. I had a problem compiling 
the sounddriver after patching i2c. I've found the installation-guide 
and the patch to solve this: 
linux-2.4.22-i2c-2.8.0-drivers-i2c-i2c-keywest.c.diff

But this patch is buggy! This line is added:

		chan->adapter.name = THIS_MODULE;

this can not work, please replace it with

		chan->adapter.owner = THIS_MODULE;

thanks for your great work.

-- 
Machs gut    | http://www.iivs.de/schwinde/buerger/tremmel/
             | http://packman.links2linux.de/
Manfred      | http://www.knightsoft-net.de
