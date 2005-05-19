From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:33 +0000
Subject: w83l785ts.c
Message-Id: <1073638074.3ffe6abac2cda@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <1073554584.3ffd2498612c6@imp.gcu.info>
In-Reply-To: <1073554584.3ffd2498612c6@imp.gcu.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> here the patch + the c.file
> i hope i've made the patch correctly, it's my first ;)

Does look very good at first sight :) except for a few indentation
issues and extra blank lines, but I'll take care of that.

> i've another strange problem with the module. it works, but only if
> i load it twice, so i have to load it, unload, and load again. only
> then the new sysfs-files appear.
> 
> probably a silly fault in the code. would be nice if you could have
> a look at it..

Will do. Can you provide the relevant part of "dmesg" as you do the
operation? Maybe it'll help.

Also, is it *always* failing the first time you run it, or does it
*randomly* fail?

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
