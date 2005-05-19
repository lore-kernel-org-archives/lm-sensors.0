From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:07 +0000
Subject: w83781d family detection
Message-Id: <20030727231856.35b21faf.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030726112657.79c34e37.khali@linux-fr.org>
In-Reply-To: <20030726112657.79c34e37.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> Nice.  I tested this against Bach just now.  Timely too, since I'm
> doing an independent driver for that chip.  Anyone have a preference
> for the name?  If not it will be "bach.c".

I would have chosen asb100, but well it's you writing the driver ;) And
the name ain't really important (unless you choose something as explicit
as "bt6dz1kb" of course) so do just as you want.

> > Similar changes should be made to the w83781d driver itself, but I
> > would like my changes to be tested before that. My tests were
> > successful on three chips I own (AS99127F rev.1, W83781D and
> > W83782D) but more tests would be welcome.
> 
> Seems to work on Bach.  Will you do a patch for 2.6?  Otherwise I can.

I will do the changes on our driver tomorrow, test, commit, let you
test, and then submit a patch for 2.6.

> AFAIK, Bach is I2C only.  Mine reads 0 from 0x48.

And is at I2C address 0x2d I suppose? Anyway, unless we are sure these
chips have no address selection pins, we can't conclude. However, I
expect them to be pin-to-pin compatible with their Winbond counterparts,
and as such are unlikely to have address selection pins. We have three
possibilities:

1* Leave everything unchanged.
2* Limit AS199237F and ASB100 to addres 0x2d.
3* Leave the whole 0x28-0x2f range possible but give the chips a lower
confidence if address isn't 0x2d.

I'm in favor of solution 3.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
