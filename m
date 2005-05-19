From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:16 +0000
Subject: i2c, lm_sensors, and 2.4.22
Message-Id: <20030909212953.576bea36.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030905235839.5e4fe2a9.khali@linux-fr.org>
In-Reply-To: <20030905235839.5e4fe2a9.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> I appologize for the false alarm.  It seems that other BTTV software
> was able to handle it just fine.  It must have just been a problem
> with XAWTV.  Anyway, thanks for the response.

If XawTV can crash our modules, and wether or not other programs do,
that's still bad, and that's still our fault. I will try again with my
own Miro PCTV Pro as soon as possible (but that's at least one week and
probably more) with XawTV (which I always use BTW) and see if I can get
it to crash.

> By the way, have you noticed whether or not these changes have been
> incorporated into 2.4.23(pre) yet?  Any chance they will show up in
> the final 2.4.23 version?

They sure have not been, for "everyone" is waiting for me to write a
clean patch and submit it. I (and with me, the whole LM Sensors team and
most users) really would like our new i2c subsystem incorporated into
2.4.23, because the more we wait, the more conflicts are likely to
happen with other merges, and the more work I have.

The next step at the moment is to release i2c-2.8.1, and that's not my
job (which is great because I wouldn't have the time). Hopefully it will
happen within the next few days, and I'll submit a patch to the LKML a
few days later. So please be patient and go on testing :)

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
