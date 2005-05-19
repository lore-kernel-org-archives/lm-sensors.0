From: danielrj@mail.dk (Daniel Rune Jensen)
Date: Thu, 19 May 2005 06:24:43 +0000
Subject: lm_sensors i2c-amd756 detection trouble
Message-Id: <20040221130738.960A.DANIELRJ@mail.dk>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031209143722.46F5.DANIELRJ@mail.dk>
In-Reply-To: <20031209143722.46F5.DANIELRJ@mail.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > Sorry about the lousy code but i am not a programmer, just
> > needed it to load :) And it works quite fine from cvs.
> 
> Possible but it wasn't correct (and gcc was nice enough to warn us). The
> i2c bus wasn't unregistered at module unload (you can try...). I've
> hopefully fixed that in CVS. Can you please try and confirm that it
> works for you?
> 
> Thanks.
> 
> -- 
> Jean Delvare
> http://www.ensicaen.ismra.fr/~delvare/
Hi there :)
Actually you were correct, module wasn't unloading and giving a load of
1.0 on the box just sitting there. It seems to be working now, and can
be unloaded.

Best Regards
-- 
Daniel Rune Jensen <danielrj@mail.dk>
