From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 18 Feb 2011 16:46:08 +0000
Subject: Re: [lm-sensors] [PATCH] lm85: extend to support emc6d103 chips
Message-Id: <20110218174608.235d3480@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4D5E343702000078000329C1@vpn.id2.novell.com>
In-Reply-To: <4D5E343702000078000329C1@vpn.id2.novell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 18 Feb 2011 08:08:23 -0800, Guenter Roeck wrote:
> On Fri, Feb 18, 2011 at 10:50:32AM -0500, Jan Beulich wrote:
> > >>> On 18.02.11 at 16:38, Guenter Roeck <guenter.roeck@ericsson.com> wrote:
> > > On Fri, Feb 18, 2011 at 09:54:56AM -0500, Jean Delvare wrote:
> > >> The EMC6D103 datasheet on smsc.com doesn't mention revision A2, so I'm
> > >> curious where you got this information?
> > >> 
> > > Ah, this made me look.
> > > 
> > > This is really EMC6D103S.
> > > See http://www.smsc.com/media/Downloads_Public/Data_Sheets/6d103s.pdf.
> > > 
> > > So it should not be listed as step A2, but separately as EMC6D103S
> > > (and it does not have to be mentioned in the code for now, since it is
> > > really a different chip).
> > 
> > No. While revision 0.3 indeed only talks about A0 and A1, revision
> > 0.4 even states 0x6A (where 0x68 is A0 and 0x69 is A1) to be the
> > default in the version/stepping register.
>
> The datasheet on the SMSC web site is version 0.3 from 2007, the datasheet
> at http://www.datasheetcatalog.org/datasheets2/15/1543596_1.pdf
> is version 0.4 from 2005. Confusing. 

I have an old copy of the datasheet, from 2004, version 0.3. I suspect
that the 2007 document is simply a reformatted copy of the 2004
document to comply with the layout of the day at SMSC. Which means that
SMSC apparently "lost" the 0.4 version from 2005. Might as well have
been on purpose if Guenter is right and revision A2 of the chip became
the EMC6D103S.

Anyway, I hope SMSC are better at designing and implementing chips than
at handling documents and deciding names ;)

> On the other side, SMSC also has the datasheet for EMC6D103S with ID 0x6a
> on their web site. Maybe they relabeled rev A2 as EMC6D103S to avoid confusion
> due to the changed functionality.
> 
> My take is that we should go with SMSC and list it as EMC6D103S.

It's really difficult to tell from the datasheets. Jan, maybe you could
try to take a look at the device physically to see how it is labelled?

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
