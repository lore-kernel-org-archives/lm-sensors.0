From: Samuel Ortiz <sameo@linux.intel.com>
Date: Fri, 11 Sep 2009 10:58:21 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon w83627hf: add mfd support.
Message-Id: <20090911105820.GB6149@sortiz.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1252585810-5336-2-git-send-email-giometti@linux.it>
In-Reply-To: <1252585810-5336-2-git-send-email-giometti@linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Rodolfo,

On Fri, Sep 11, 2009 at 09:42:23AM +0200, Rodolfo Giometti wrote:
> On Thu, Sep 10, 2009 at 02:56:09PM +0200, Jean Delvare wrote:
> > Hi Rodolfo,
> > 
> > Don't bother including Frodo L. and Mark S. in the discussions, they
> > have left the lm-sensors project years ago.
> 
> Ok. I just sent the letter to them in order to inform about my
> proposal...
> 
> > On Thu, 10 Sep 2009 14:30:10 +0200, Rodolfo Giometti wrote:
> > > The file has been splitted up into two parts:
> > > 
> > > * drivers/mfd/w83627hf.c         - detects the chip and define proper
> > >                                    platform devices into mfd support
> > > 
> > > * drivers/hwmon/hwmon-w83627hf.c - implements the driver for hwmon
> > >                                    functionality only
> > > 
> > > The patch also fixes up some non reentrant code and some C-style issues.
> > > 
> > > Signed-off-by: Rodolfo Giometti <giometti@linux.it>
> > > ---
> > >  drivers/hwmon/Kconfig                          |    2 +-
> > >  drivers/hwmon/Makefile                         |    2 +-
> > >  drivers/hwmon/{w83627hf.c => hwmon-w83627hf.c} |  373 +++++-------------------
> > 
> > This name change will break all users of the driver. The sensors-detect
> > script points the user to "w83627hf" and typically writes this value to
> > an init script or configuration file. The w83627hf driver doesn't
> > auto-load (yet) so this is a requirement.
> > 
> > Assuming that the hwmon part depends on the MFD part, I'd rather keep
> > "w83627hf" as the hwmon part name, and name the new MFD part
> > "w83627hf-core" or similar. I agree it's not so nice but at least it
> > doesn't break compatibility.
> 
> I agree. So I'm going to keep w83627hf name for hwmon part name and
> using w83627hf-core for the new MFD part. Then I'll repost my patch.
That would be nice. The MFD part looks good to me, so please post a new patch
and I'll queue it.

Cheers,
Samuel.


> Thanks for your attention,
> 
> Rodolfo
> 
> -- 
> 
> GNU/Linux Solutions                  e-mail: giometti@enneenne.com
> Linux Device Driver                          giometti@linux.it
> Embedded Systems                     phone:  +39 349 2432127
> UNIX programming                     skype:  rodolfo.giometti
> Freelance ICT Italia - Consulente ICT Italia - www.consulenti-ict.it



-- 
Intel Open Source Technology Centre
http://oss.intel.com/

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
