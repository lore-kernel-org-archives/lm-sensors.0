From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:24:09 +0000
Subject: w83781d family detection
Message-Id: <20030804024723.GA29235@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030726112657.79c34e37.khali@linux-fr.org>
In-Reply-To: <20030726112657.79c34e37.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

* Jean Delvare <khali@linux-fr.org> [2003-07-31 09:20:16 +0200]:
> 
> > > I will do the changes on our driver tomorrow, test, commit, let you
> > > test, and then submit a patch for 2.6.
> > 
> > Oops... I thought you already committed this.  So I haven't actually
> > tested it yet - but you probably knew that.  If you pass a patch to
> > the list first I'll give it a go.
> 
> My fault, I tested it yesterday but had to go before I could commit it.
> Now this is done.
> 
> It works OK for me (as99127f, w83781d, w83782d).
> 
> Could you (and everyone who can) test the changes? I'd like to ensure it
> doesn't break anything. I suggest we wait some times before submitting
> the changes for inclusion into the 2.6 kernel (it is in no way a
> critical fix).

It works OK on ASB100 Bach as well.

> > > 1* Leave everything unchanged.
> > > 2* Limit AS199237F and ASB100 to addres 0x2d.
> > > 3* Leave the whole 0x28-0x2f range possible but give the chips a
> > > lower confidence if address isn't 0x2d.
> > > 
> > > I'm in favor of solution 3.
> > 
> > I wouldn't mind limiting ASB100 to 0x2d, actually.  I don't recall
> > ever seeing it anywhere else - but if it is, we'll find out soon
> > enough. ;) Or choice 3 is fine too.
> 
> We can have slightly different strategies in sensors-detect and the
> drivers themselves. I will apply solution 3 to sensors-detect. Feel free
> to accept only address 0x2d for your Bach-only driver.

OK, I'll probably do that.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
