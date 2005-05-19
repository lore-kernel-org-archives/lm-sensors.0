From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:17 +0000
Subject: lm_sensors-2.4.5 on RedHat 8.0 default kernel
Message-Id: <20030916213508.206b8707.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <01cd01c37bae$35422880$1701a8c0@ALEC>
In-Reply-To: <01cd01c37bae$35422880$1701a8c0@ALEC>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> Hi!
> 
>  There is problem during compilation "lm_sensors-2.4.5"
> on RedHat 8.0 kernel "2.4.18-14" (default installation kernel).
> 
>  As it is known, RedHad uses deeply patced kernel with
> "i2c" v2.6.3 built-in. It is _very_ difficult to change "i2c"
> to new version, so I need to build old "lm_sensors-2.4.5"

Why don't you build lm_sensors 2.6.3 instead? Usually, the good thing to
do is to use a i2c version and a lm_sensors version as close as
possible.

What's more, I know that Red Hat provide packages for lm_sensors for
quite a good time now. Why don't you simply use them?

And, finally, it is not _that_ difficult to change i2c to a new version,
as long as you don't use the newest 2.8.x releases. You don't have to
patch your kernel. So you could think of installing i2c 2.7.0 and
lm_sensors 2.7.0 instead of using older versions.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
