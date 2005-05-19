From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:03 +0000
Subject: Return code of i2c transaction ignored in lm87
Message-Id: <20040628215948.1d017a59.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.58.0406250822110.16214@malachi.lee.k12.nc.us>
In-Reply-To: <Pine.LNX.4.58.0406250822110.16214@malachi.lee.k12.nc.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > Please take a look at what is done in w83l785ts and tell me why it
> > woudln't solve you problem, if it actually doesn't.
> > 
> Just took a look, and that seems very reasonable.  If I did this in 
> the LM87 driver would this be an acceptable patch?

Yes, it certainly would.

> I still would like some way of notifing user space of such an error, 
> but if I had too, I could follow the syslog and get this (hackish, but
> it would work).  OTOH, if I took the aproach of the w83l785ts (what a
> name (-;), but yet also added an error proc entry so that a user space
> app could (if they choose) detect the error would this be a bad thing?

Blame Winbond for the chip name! ;)

I wouldn't call it "a bad thing" but I merely don't see any benefit. OK,
the user-space app will know that read errors occured and some values
are "old" values. Eventually it'll let the user now. And then what?

What's more, the retry code in the driver should solve all intermitent
read errors. If errors are permanent then there won't be any readings at
all and the user will notice anyway. Your own problem may differ but
these are the two common (and still rare) cases users will encounter.

So I wouldn't support such a change, sorry.

-- 
Jean Delvare
http://khali.linux-fr.org/
