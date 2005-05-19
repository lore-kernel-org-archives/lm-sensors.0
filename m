From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:02 +0000
Subject: [rol@as2917.net: Need help for kernel 2.5.x ???]
Message-Id: <20030625152103.6bcdd4b0.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030622185659.GB2380@frodo.local>
In-Reply-To: <20030622185659.GB2380@frodo.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> > Paul, the version to start from is definitely CVS. 
> > 
> 
> Thanks very much...
> Any specific tag/release or a simple checkout will give me a 
> good place where to start with ?

No tag for lm_sensors, just checkout and it'll be OK. But if you also
need to checkout i2c code, you'll have to use tag lk2-4 for the i2c
repository. HEAD isn't used anymore and is just broken. lk2-4 may become
HEAD again someday (providing we find how to do this with CVS).

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
