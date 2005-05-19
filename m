From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:10 +0000
Subject: failed again; vetctor 300
Message-Id: <20030806161812.03a544ff.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030805222340.3799d819.zdavatz@ywesee.com>
In-Reply-To: <20030805222340.3799d819.zdavatz@ywesee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> > Not really. Didn't you encounter this problem with lm_sensors 2.8.0?
> Can't remember, could be.

I was right, you had the problem and we solved it.

But since I forgot to commit the change, the new Makefile you downloaded
did not fix it. My bad.

Please get the new Makefile here:
http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/Makefile

Should fix the problem.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
