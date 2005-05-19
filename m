From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:02 +0000
Subject: mkpatch works
Message-Id: <20030626152831.72c1943e.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <3EF5B5CE.6050103@paradyne.com>
In-Reply-To: <3EF5B5CE.6050103@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> The line which specifies CONFIG_I2C_PROC in i2c/mkpatch/Config.in is
> missing from the kernel file: drivers/i2c/Config.in.  Of course
> CONFIG_SENSORS depends on CONFIG_I2C_PROC so that's why I never saw
> it.  I'm not familiar w/ the guts of mkpatch - but I'll try to look at
> it unless someone else gets there first (hopefully... took a quick
> peek but I'm no Perl guru.)

Oh, I didn't know mkpatch was written in Perl. Maybe I can help?

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
