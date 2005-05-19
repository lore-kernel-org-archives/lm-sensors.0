From: mds@mds.gotdns.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:25:47 +0000
Subject: Fwd: Fwd: [PATCH 2.6] bmcsensors
Message-Id: <424C2066.8020303@mds.gotdns.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <2538186705033012523d671b5f@mail.gmail.com>
In-Reply-To: <2538186705033012523d671b5f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Hi Yani,
> 
> Could you please explain to us what i2c-ipmi does? I understand it acts
> as an interface between the bmcsensors driver and something else, but I
> yet have to learn what that other thing is, and why an interface is
> needed at all. As I understand it, i2c-ipmi is no I2C or SMBus master
> driver, but a kind of hack much like the i2c-isa driver is. I don't
> exactly enjoy the way i2c-isa works, and I plan to get rid of it at some
> point in time (hopefully in a near future), so let's not do something
> equally ugly here.
> 
> Thanks,


Don't pick on Yani too hard, he's just porting what I wrote.
i2c-ipmi is indeed a bridge between bmcsensors and the IPMI subsystem.
There's some documentation in doc/busses/i2c-ipmi and you can also
look at the code in 2.4.

Yes it's a little bit of a hack but I thought this architecture was the best way to get
IPMI data out through the sensors API. Sure there are other ways  to do  it and
you could use some full-blown IPMI app but this is  a good way to get people
the info that gets hidden behind all the IPMI stuff - i.e.  their sensor  info.

I think the  dummy driver approach has value for those who want to present data
via the sensors  API. As you may recall I did something similar for hard drive
temperatures (S.M.A.R.T)  a  while  back.

If you have a better way to do dummy  bus drivers let's hear it but
let's not ban  dummy bus drivers (or new dummy bus drivers anyway) altogether. 

mds
