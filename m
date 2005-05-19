From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:08 +0000
Subject: w83781d family detection
Message-Id: <20030731092016.5a6a881d.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030726112657.79c34e37.khali@linux-fr.org>
In-Reply-To: <20030726112657.79c34e37.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> > I will do the changes on our driver tomorrow, test, commit, let you
> > test, and then submit a patch for 2.6.
> 
> Oops... I thought you already committed this.  So I haven't actually
> tested it yet - but you probably knew that.  If you pass a patch to
> the list first I'll give it a go.

My fault, I tested it yesterday but had to go before I could commit it.
Now this is done.

It works OK for me (as99127f, w83781d, w83782d).

Could you (and everyone who can) test the changes? I'd like to ensure it
doesn't break anything. I suggest we wait some times before submitting
the changes for inclusion into the 2.6 kernel (it is in no way a
critical fix).

> > > AFAIK, Bach is I2C only.  Mine reads 0 from 0x48.

OK, I update that in sensors-detect. We could use the fact that Asus
chips have 0 at 0x48 in our detection routines. We still need
confirmation of this for the AS99127F rev.2 though (but I don't think
any of us has one?) I suspect that this chip will be more
Winbond-compatible that the other two, since it has the Winbond
manifacturer's ID. BTW, the w83781 module won't load without forcing it
with an AS99127F rev.2 if it hasn't its address at 0x48, as the Winbond
chips do. Well, we'll see if anyone complains.

> > 1* Leave everything unchanged.
> > 2* Limit AS199237F and ASB100 to addres 0x2d.
> > 3* Leave the whole 0x28-0x2f range possible but give the chips a
> > lower confidence if address isn't 0x2d.
> > 
> > I'm in favor of solution 3.
> 
> I wouldn't mind limiting ASB100 to 0x2d, actually.  I don't recall
> ever seeing it anywhere else - but if it is, we'll find out soon
> enough. ;) Or choice 3 is fine too.

We can have slightly different strategies in sensors-detect and the
drivers themselves. I will apply solution 3 to sensors-detect. Feel free
to accept only address 0x2d for your Bach-only driver.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
