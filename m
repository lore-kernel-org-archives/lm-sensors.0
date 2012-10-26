From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 26 Oct 2012 07:27:52 +0000
Subject: Re: [lm-sensors] w83627ehf: Wrong values reported after resuming from suspend/hibernation
Message-Id: <20121026092752.18c535ad@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <50856051.5070803@gmx.at>
In-Reply-To: <50856051.5070803@gmx.at>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

On Thu, 25 Oct 2012 17:41:15 -0700, Guenter Roeck wrote:
> On Thu, Oct 25, 2012 at 04:49:01PM -0700, Guenter Roeck wrote:
> > > I don't get it. I have double checked my code and I don't see how this
> > > is possible. Plus Guenter's testing was successful...
> >
> > Doesn't work for me either on NCT6776F. Some of the data is restored, which is
> > not the case if I use the "old" driver, so I must have used the correct driver.
>
> Hi Jean,
> 
> I found the problem. The NCT6776F has the wrong bank selected when resuming.
> 
> It started working for me after adding
> 
> 	data->bank = 0xff;
> 
> to the beginning of the resume function. This forces the bank register to be
> updated when the first chip access is done.

Wow, very good catch, thanks a lot. That explains it all. I couldn't
see this in the dumps I asked for, as these dumps do force the bank to
a specific value.

Now I think we have a bug in the w83627ehf driver. data->bank is never
initialized, so it default to 0 per kzalloc of data. If the driver
reads a register from bank 0 first, and this wasn't the currently
selected bank at hardware level, it will read from the wrong register.

We are lucky that the driver always reads register
NCT6775_REG_TEMP_SOURCE[0] = 0x621 first for the NCT677x chips. For
other chips only registers 0x50-0x5F are banked. For the W83667HG and
W83667HG-B we read W83627EHF_REG_TEMP_CONFIG[2] = 0x252 first so we
are lucky once more. For older chips we could be in trouble depending
on the initial bank setting and chip configuration.

I'll send a fixup patch in a minute.

> It might make sense to do this for all chips with bank registers.

Depends on how bank switching is implemented. For example the w83627hf
driver doesn't make any assumption on the currently selected bank, it
always sets the bank (even if it is 0) before accessing a register in
the banked area. Which is why my own testing with the w83627hf driver
was successful.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
