From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:51 +0000
Subject: asb100 question
Message-Id: <20040411095409.56655e3b.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200404111158.58208.gar@reapl.net>
In-Reply-To: <200404111158.58208.gar@reapl.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > asb100-i2c-2-48
> > Adapter: SMBus nForce2 adapter at 5500
> > ERROR: Can't get alarm data!
> > ERROR: Can't get IN data! (0x0001)
> > ERROR: Can't get IN data! (0x0002)
> > ERROR: Can't get IN data! (0x0003)
> 
> <etc>
> 
> Hmmm, looks to me like you have an old libsensors somewhere which is
> getting in the way.  See also FAQ 4.27 here:
> 
> http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/doc/lm_sensors-FAQ.html#Section%204.27

I just updated that entry BTW. The same error could be caused by a
kernel/sensors mismatch for Linux 2.6 users (although that's not the
case here), so I pointed that out here too.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
