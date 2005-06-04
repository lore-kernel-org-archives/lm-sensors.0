From: yani.ioannou@gmail.com (Yani Ioannou)
Date: Sat, 04 Jun 2005 22:32:25 +0000
Subject: [lm-sensors] Re: [PATCH 2.6.12-rc5-mm1 3/3] i2c: modify sensors
Message-Id: <253818670506041232845297a@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050602033727.GD4906@jupiter.solarsys.private>
In-Reply-To: <20050602033727.GD4906@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 6/4/05, Jean Delvare <khali@linux-fr.org> wrote:
> Hi Greg,
> 
> > > [1] I personally prefer more leading zeros, or better yet none at
> > > all.
> >
> > Sure, just an example, use what you want.  More is always nice to keep
> > things sorted sanely.
> 
> ls -v is nice for that purpose too. I would better improve sorting
> algorithms were needed than add arbitrary limits were not needed.
> 
> That being said, I'd be curious to see a system with more than 10
> hardware monitoring chips (record so far is 6 on the Tyan S4882 board).

Actually record is 60 if you include bmcsensors :-), some server IPMI
BMCs seem to have an insane number of sensors.

Yani
