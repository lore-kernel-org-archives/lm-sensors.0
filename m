From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:41 +0000
Subject: Why this output?
Message-Id: <20021114122117.4afc533a.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <B9F92C49.4411%zdavatz@ywesee.com>
In-Reply-To: <B9F92C49.4411%zdavatz@ywesee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> > One important thing to notice is that i2c and lm_sensors will use
> > information found un /usr/src/linux to
> What information will it look for here? For the source-tree (.config)?
Yes, kernel configuration options in .config, amongst other things.
Also, some things depend on the kernel version itself, and some
constants defined in the linux kernel sources are used.


-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
