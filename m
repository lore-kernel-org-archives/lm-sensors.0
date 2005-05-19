From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:43 +0000
Subject: 2.7.0 testings
Message-Id: <20021204180642.67a49816.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20021127213903.5b84866d.khali@linux-fr.org>
In-Reply-To: <20021127213903.5b84866d.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> why did you back out MODPREF in the makefiles?
> I liked it the way it was... is there any way to keep
> $KERNELVERSION???

The new way doesn't work anymore since I modified the LINUX := lines. If
the build symlink was not found, it would use /usr/src/linux as the base
source tree but would install the modules in
/lib/modules/$KERNELVERSION, which may not match the version present in
/usr/src/linux.

An alternative is to use the same "if [ -L ... ]" thing for MODPREF as I
used for LINUX. I can do it if you really want me to do so, but frankly,
I don't see the idea. The way things are right now work, so?

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
