From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:10 +0000
Subject: flex scanner jammed
Message-Id: <20030806175715.09c7f308.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030806172523.6ac44fe9.zdavatz@ywesee.com>
In-Reply-To: <20030806172523.6ac44fe9.zdavatz@ywesee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> Any idea how I can unload the client drivers?

"rmmod dmasound_pmac" should do it. If you have other drivers that use
i2c, remove them too.


-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
