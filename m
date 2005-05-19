From: yani.ioannou@gmail.com (Yani Ioannou)
Date: Thu, 19 May 2005 06:25:47 +0000
Subject: Fwd: Fwd: [PATCH 2.6] bmcsensors
Message-Id: <25381867050331090259a2ede7@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <2538186705033012523d671b5f@mail.gmail.com>
In-Reply-To: <2538186705033012523d671b5f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Thanks Mark :),

In fact i2c-ipmi is virtually unchanged from 2.4 compared to the
changes in bmcsensors (it should probably still have Mark as module
author but I didn't want him having to answer questions from people on
my code).

I know it seems like a hack - it is, but I think with reason. I agree
with mds that it is nice to have a centralized system in Linux for
accessing sensor information (regardless of it being on i2c or ipmi)
through the lm_sensors sysfs interface, rather than use something like
ipmitool to read BMC sensors and lm_sensors to read others, especially
considering the amount of software out there already using the
lm_sensors interface.

Certainly many people I've been in contact with seem to think this is
true too (hence the demand for bmcsensors), and I'm all for giving
people the choice. i2c-ipmi is in my opinion just an (unfortunate) way
of fitting into the current lm_sensors driver model, there are other
places in the patch that bmc_sensors differs from all the other i2c
based drivers too and had to do its own thing for the same reason.

Yani

On Thu, 31 Mar 2005 11:08:06 -0500, Mark Studebaker <mds@mds.gotdns.com> wrote:
> Jean Delvare wrote:
> > Hi Yani,
> >
> > Could you please explain to us what i2c-ipmi does? I understand it acts
> > as an interface between the bmcsensors driver and something else, but I
> > yet have to learn what that other thing is, and why an interface is
> > needed at all. As I understand it, i2c-ipmi is no I2C or SMBus master
> > driver, but a kind of hack much like the i2c-isa driver is. I don't
> > exactly enjoy the way i2c-isa works, and I plan to get rid of it at some
> > point in time (hopefully in a near future), so let's not do something
> > equally ugly here.
> >
> > Thanks,
> 
> Don't pick on Yani too hard, he's just porting what I wrote.
> i2c-ipmi is indeed a bridge between bmcsensors and the IPMI subsystem.
> There's some documentation in doc/busses/i2c-ipmi and you can also
> look at the code in 2.4.
> 
> Yes it's a little bit of a hack but I thought this architecture was the best way to get
> IPMI data out through the sensors API. Sure there are other ways  to do  it and
> you could use some full-blown IPMI app but this is  a good way to get people
> the info that gets hidden behind all the IPMI stuff - i.e.  their sensor  info.
> 
> I think the  dummy driver approach has value for those who want to present data
> via the sensors  API. As you may recall I did something similar for hard drive
> temperatures (S.M.A.R.T)  a  while  back.
> 
> If you have a better way to do dummy  bus drivers let's hear it but
> let's not ban  dummy bus drivers (or new dummy bus drivers anyway) altogether.
> 
> mds
> 
>
