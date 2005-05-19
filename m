From: nuppla@gmx.at (fago)
Date: Thu, 19 May 2005 06:24:33 +0000
Subject: w83l785ts.c
Message-Id: <1073603698.1061.4.camel@ws1>
List-Id: <lm-sensors.vger.kernel.org>
References: <1073554584.3ffd2498612c6@imp.gcu.info>
In-Reply-To: <1073554584.3ffd2498612c6@imp.gcu.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

here the patch + the c.file
i hope i've made the patch correctly, it's my first ;)

i've another strange problem with the module. it works, but only if i
load it twice, so i have to load it, unload, and load again. only then
the new sysfs-files appear.

probably a silly fault in the code. would be nice if you could have a
look at it..

thanks, fago
-------------- next part --------------
A non-text attachment was scrubbed...
Name: w83l785ts.patch
Type: text/x-patch
Size: 10690 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040109/886f461b/w83l785ts.bin
-------------- next part --------------
A non-text attachment was scrubbed...
Name: w83l785ts.c
Type: text/x-c
Size: 8299 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040109/886f461b/w83l785ts-0001.bin
