From: "David Hubbard" <david.c.hubbard@gmail.com>
Date: Mon, 15 Oct 2007 17:35:54 +0000
Subject: Re: [lm-sensors] [ patch .24-rc0 5/5 ] SuperIO locks coordinator -
Message-Id: <4dfa50520710151035j2ed8ce27x9e8c4d6ec676eeef@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4712F66F.8040806@gmail.com>
In-Reply-To: <4712F66F.8040806@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Axel,

On 10/15/07, Axel Thimm <Axel.Thimm@atrpms.net> wrote:
> On Sun, Oct 14, 2007 at 11:34:11PM -0700, David Hubbard wrote:
> > Hi Jim, Axel,
> >
> > On 10/14/07, David Hubbard <david.c.hubbard@gmail.com> wrote:
> > > Hi Jim,
> > >
> > > On 10/14/07, Jim Cromie <jim.cromie@gmail.com> wrote:
> > > > 05 - use superio-locks in rest of drivers/hwmon/*.c
> > > >
> > > > this patch is compile-tested only, please review for sanity before you
> > > > try running them.  Things to look for - missing superio_release(),
> > > > opportunities to use superio_devid(), superio_inw(), etc.
> > > >
> > > >
> > > > Signed-off-by:  Jim Cromie <jim.cromie@gmail.com>
> > > > ---
> > > > hwmon-superio-others
> > > >  Kconfig      |    6 +++
> > > >  f71805f.c    |   86 +++++++++++++++-------------------------------
> > > >  it87.c       |   80 +++++++++++++++---------------------------
> > > >  smsc47b397.c |   63 ++++++++++++---------------------
> > > >  smsc47m1.c   |   69 +++++++++++++------------------------
> > > >  vt1211.c     |   70 +++++++++++++------------------------
> > > >  w83627ehf.c  |  110 +++++++++++++++++++++++++----------------------------------
> > >
> > > I'll test on w83627ehf hardware and report.
> > >
> > > David
> >
> > This appears to be pasted in and needs to be updated:
> > printk(KERN_WARNING "pc87360: superio port not detected, "
> >
> > I am unable to clone the hwmon.git repository. I believe the git port
> > is blocked by my ISP, and I may be able to get it opened, but I tried
> > cloning this way, and failed:
> >
> > $ git clone http://lm-sensors.org/kernel?p=kernel/mhoffman/hwmon-2.6.git
> > hwmon.git
> > Initialized empty Git repository in hwmon.git/.git/
> > Cannot get remote repository information.
> > Perhaps git-update-server-info needs to be run there?
> >
> > Axel, is this something easy to fix on the server side?
>
> Looks more like a broken URL, where did you get the above? The correct
> one is:
> git://lm-sensors.org/kernel/mhoffman/hwmon-2.6.git
>
> HTH
> --
> Axel.Thimm at ATrpms.net

I can't connect to any git servers on the git port. Can you please
look at the http url?

David

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
