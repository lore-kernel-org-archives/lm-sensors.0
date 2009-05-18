From: Andre Prendel <andre.prendel@gmx.de>
Date: Mon, 18 May 2009 11:02:39 +0000
Subject: Re: [lm-sensors] [PATCH RFC 0/2] tmp401: Add support for
Message-Id: <20090518110239.GB4535@ubuntu>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090514092819.GC6644@ubuntu>
In-Reply-To: <20090514092819.GC6644@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, May 18, 2009 at 12:18:10PM +0200, Hans de Goede wrote:
> 
> 
> On 05/18/2009 11:37 AM, Andre Prendel wrote:
> > Having a closer look at the datasheet
> >
> > http://focus.ti.com/docs/prod/folders/print/tmp411.html
> >
> > , I've seen two ways to reset the history.
> >
> > 1. Writing any value to the history registers (0x30-0x37). That should
> > reset all these registers. I've attached a patch (delta) doing this. Hans,
> > could you please test this one. echo "1">  .../temp_reset_history
> > should reset the history for tempX_lowest (0xFFF0) and tempX_highest (0x0000).
> >
> > 2. SOFTWARE RESET
> >
> > Writing the first e-mail I meant this command in my question. You can
> > find it in datasheet under SOFTWARE RESET. This command restores the
> > power-on values to all registers (including limits etc.).
> >
> > I'd prefer 1. for reseting the history. That's what I'd expect from
> > temp_reset_history.
> >
> 
> Ack, I think 1 is much better too.
> 
> > BTW, what about write-only attributes? I've seen a reset functionality
> > in the fscpos driver (so I did it like that). show_temp_reset always
> > returns 1. Using WO attributes could make more sense, but in
> > sysfs-interface I can only see RO and RW.
> >
> 
> The fscpos driver is an old obsolete driver, so not the best place to look
> for inspiration. I think that using 0200 as rights for something like
> temp_reset_history makes perfect sense.
> 
> I've tested you're latest patch and temp_reset_history works as advertised.
> 
> If you fix the mode for the temp_reset_history, and do a new patch adding
> docs, then I think this is good to go to Jean's tree for merging into 2.6.31.
> Jean do you agree?

Alright, I will do so.

> 
> Regards,
> 
> Hans

Thanks,
Andre

> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
