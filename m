From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:58 +0000
Subject: SMbus problem ?
Message-Id: <20030607103846.5259011d.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030602222815.14c7b37f.sesshoumaru@altern.org>
In-Reply-To: <20030602222815.14c7b37f.sesshoumaru@altern.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> > nVidia's nForce2 isn't supported in 2.7.0. It is supported in CVS
> > only. This means that you have to checkout i2c (lk2-4 branch) and
> > lm_sensors2 from CVS if you want to have a chance to have something
> > working.
> 
> Hmm...it seemed that lm_sensors2 isn't compatible with my motherboards
> i have the same errors.

I finally met Sesshoumaru on IRC and we fixed the problem.
Sensors-detect was missing support for the nForce2. I added support,
Sesshoumaru tested it and I had to slightly change the "match" string.
Now it is working OK.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
