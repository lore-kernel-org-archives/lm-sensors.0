From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 17 Sep 2009 13:57:55 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon w83627hf: add mfd support.
Message-Id: <20090917155755.2b47bc0d@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1252585810-5336-2-git-send-email-giometti@linux.it>
In-Reply-To: <1252585810-5336-2-git-send-email-giometti@linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 17 Sep 2009 15:51:20 +0200, Rodolfo Giometti wrote:
> On Thu, Sep 17, 2009 at 03:34:50PM +0200, Jean Delvare wrote:
> > Hi Rodolfo,
> > 
> > On Fri, 11 Sep 2009 17:07:05 +0200, Rodolfo Giometti wrote:
> > > The file has been splitted up into two parts:
> > 
> > Spelling: split (it's an irregular verb.)
> > 
> > > 
> > > * drivers/mfd/w83627hf-core.c      - detects the chip and define proper
> > >                                      platform devices into mfd support
> > > 
> > > * drivers/hwmon/w83627hf.c         - implements the driver for hwmon
> > >                                      functionality only
> > > 
> > > The patch also fixes up some non reentrant code and some C-style issues.
> > 
> > Sounds wrong. Mixing coding style cleanups with real changes makes
> > reviewing much harder. You'll have to move these changes to a separate
> > patch I'm afraid.
> 
> Ok, I'll repropose a patch.
> 
> I prefer propose a patch with real changes only, is that correct even
> if checkpatch.pl says no? :)

If you run checkpath.pl on the patch and not the source files, it won't
complain about the parts you're not touching.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
