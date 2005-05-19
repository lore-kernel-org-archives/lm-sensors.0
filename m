From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:26 +0000
Subject: System hanging using CSB5 chip with 2.8.1
Message-Id: <20031125222925.702dce28.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031125211801.35736.qmail@web14522.mail.yahoo.com>
In-Reply-To: <20031125211801.35736.qmail@web14522.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


>   When doing a sensors-detect the system just ends up hanging.
> (...)
>   6. Sensors Version: 2.8.1

Probably caused by a bad wordaround introduced in the i2c-piix4 module.
I commited a fix to our CVS repository a few years ago. Please check
lm_sensors2 out (see
http://secure.netroedge.com/~lm78/download.html#cvs) and give it a try
(don't forget to unload old modules before trying to load them anew).

You do not need to change anything to i2c, updating lm_sensors2 is
enough.

If it still doesn't work, let us know.

And if it does work, let us know too, please :)

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
