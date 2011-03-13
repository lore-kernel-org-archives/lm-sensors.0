From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 13 Mar 2011 14:00:22 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: New driver for SMSC SCH5627 hwmon
Message-Id: <20110313150022.1a33b9b4@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1299871683-3945-1-git-send-email-hdegoede@redhat.com>
In-Reply-To: <1299871683-3945-1-git-send-email-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

On Sun, 13 Mar 2011 13:39:34 +0100, Hans de Goede wrote:
> Hi,
> 
> On 03/12/2011 12:09 PM, Jean Delvare wrote:
> 
> Thanks for the review! I've prepared a new version of the
> patch addressing all your comments, below are some remarks
> from me wrt those comments which warrant a reply.

Thanks for the quick update. Below are my comments to some of your
comments:

> >> +static int sch5627_read_virtual_reg12(struct sch5627_data *data, u16 msb_reg,
> >> +				      u16 lsn_reg, int high_nibble)
> >> +{
> >> +	int msb, lsn = -1;
> >
> > Useless initialization, unless I'm blind.
> >
> >> +
> >> +	/* Read MSB first, this will cause the matching LSN to be latched */
> >
> > I.e. reverse from 16-bit values? How weird :(
> 
> Yep, this also means we cannot read the lsn register once for 2 12 bit reads,
> I had code for that (which the useless initialization you spotted was a left
> over of).

Why not? Can't you read MSB1, MSB2 and then LSN? If latching is done
per-nibble, that should work.

> >> +static int reg_to_rpm(u16 reg)
> >> +{
> >> +	if (reg = 0)
> >> +		reg = 1;
> >
> > This arbitrary decision is discussable. I presume that reg = 0 means an
> > error condition, either an internal one or a problem with the fan. This
> > would rather be reported to user-space as 0 (0 RPM) or a negative error
> > code (libsensors does handle -EIO gracefully) rather than an impossible
> > sped of 5400540 RPM.
> >
> 
> Agreed, since the app note says 0xFFFF is the fan fault value, we should
> really never see 0, so I've changed the code to return -EIO in this case.

And value 0xFFFF should probably be reported as 0 RPM, rather than 82
RPM as your driver does today.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
