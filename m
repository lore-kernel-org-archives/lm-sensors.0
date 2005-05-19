From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:11 +0000
Subject: i2c & lm_sensors for RH
Message-Id: <20030811112724.0c1c883b.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030802172008.GA10034@puariko.nirvana>
In-Reply-To: <20030802172008.GA10034@puariko.nirvana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> I have uploaded
> 
> o latest RH kernel with i2c/lm_sensors 2.8.0 patched in
> o lm_sensors 2.8.0 userland
> o bttv with i2c 2.8.0 patches
> o ivtv with i2c 2.8.0 patches
> o saa7134 with i2c 2.8.0 patches
> 
> for the current three RH releases (9, 8.0 and 7.3)
> at http://atrpms.physik.fu-berlin.de/

I linked to it from our news page and our download page.

> Many thanks for all the help!!! I hope those rpms will be helpful to
> the lm_sensors community!

Well, many thanks to you :)

> There is another i2c application that break with the i2c changes:
> lirc. At least the current CVS code bails out. Could you provide a
> patch for the CVS bits (non-CVS is far to old)? :)

I am currently unable to check the CVS tree out, due to a stale read
lock it seems. I'll try again later and let you know when a patch is
ready.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
