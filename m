From: yani.ioannou@gmail.com (Yani Ioannou)
Date: Sun, 05 Jun 2005 01:35:48 +0000
Subject: [lm-sensors] Re: [PATCH 2.6.12-rc5-mm1 3/3] i2c: modify sensors
Message-Id: <253818670506041635e1c50e5@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050602033727.GD4906@jupiter.solarsys.private>
In-Reply-To: <20050602033727.GD4906@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 6/4/05, Jean Delvare <khali@linux-fr.org> wrote:
> Hi Yani,
> 
> > > That being said, I'd be curious to see a system with more than 10
> > > hardware monitoring chips (record so far is 6 on the Tyan S4882
> > > board).
> >
> > Actually record is 60 if you include bmcsensors :-), some server IPMI
> > BMCs seem to have an insane number of sensors.
> 
> Hm, I really mean sensor chips, not channels. bmcsensors will still show
> as a single chip, with many sensor channels, right?

Ah yes, sorry, I read that wrong. Each BMC will show as a single
'chip'/hwmon device with many sensors, although it is really
interfacing to many chips itself.

Yani
