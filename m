From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 02 Nov 2009 13:23:28 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon w83627hf: add mfd support.
Message-Id: <20091102142328.25b9073b@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1252585810-5336-2-git-send-email-giometti@linux.it>
In-Reply-To: <1252585810-5336-2-git-send-email-giometti@linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Rodolfo,

On Thu, 1 Oct 2009 15:53:50 +0200, Samuel Ortiz wrote:
> > On Thu, 24 Sep 2009 14:01:11 +0200, Rodolfo Giometti wrote:
> > > The file has been splitted up into two parts:
> > > 
> > > * drivers/mfd/w83627hf-core.c      - detects the chip and define proper
> > >                                      platform devices into mfd support
> > > 
> > > * drivers/hwmon/w83627hf.c         - implements the driver for hwmon
> > >                                      functionality only
> > > 
> > > Signed-off-by: Rodolfo Giometti <giometti@linux.it>
> > > ---
> > >  drivers/hwmon/Kconfig        |    1 +
> > >  drivers/hwmon/w83627hf.c     |  376 ++++++++++++------------------------------
> > >  drivers/mfd/Kconfig          |   15 ++
> > >  drivers/mfd/Makefile         |    1 +
> > >  drivers/mfd/w83627hf-core.c  |  186 +++++++++++++++++++++
> > >  include/linux/mfd/w83627hf.h |  118 +++++++++++++
> > >  6 files changed, 428 insertions(+), 269 deletions(-)
> > >  create mode 100644 drivers/mfd/w83627hf-core.c
> > >  create mode 100644 include/linux/mfd/w83627hf.h
> > (...)
> > The rest starts looking good.
>
> Same here. As far as the MFD part is concerned, it's fine with me except for
> this one missing WARN_ON().
> I'll wait until we get Jean's ack for the hwmon part, and push it through my
> for-next branch.

Any news from this patch? It would be great to have it ready for merge
in kernel 2.6.33.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
