From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 04 Jun 2005 23:21:36 +0000
Subject: [lm-sensors] Re: [PATCH 2.6.12-rc5-mm1 3/3] i2c: modify sensors
Message-Id: <20050604232201.2c1c0f45.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050602033727.GD4906@jupiter.solarsys.private>
In-Reply-To: <20050602033727.GD4906@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Yani,

> > That being said, I'd be curious to see a system with more than 10
> > hardware monitoring chips (record so far is 6 on the Tyan S4882
> > board).
> 
> Actually record is 60 if you include bmcsensors :-), some server IPMI
> BMCs seem to have an insane number of sensors.

Hm, I really mean sensor chips, not channels. bmcsensors will still show
as a single chip, with many sensor channels, right?

-- 
Jean Delvare
