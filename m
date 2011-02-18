From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 18 Feb 2011 16:08:23 +0000
Subject: Re: [lm-sensors] [PATCH] lm85: extend to support emc6d103 chips
Message-Id: <20110218160823.GA28258@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4D5E343702000078000329C1@vpn.id2.novell.com>
In-Reply-To: <4D5E343702000078000329C1@vpn.id2.novell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Feb 18, 2011 at 10:50:32AM -0500, Jan Beulich wrote:
> >>> On 18.02.11 at 16:38, Guenter Roeck <guenter.roeck@ericsson.com> wrote:
> > On Fri, Feb 18, 2011 at 09:54:56AM -0500, Jean Delvare wrote:
> >> Hallo Jan,
> >> 
> >> On Fri, 18 Feb 2011 08:18:26 +0000, Jan Beulich wrote:
> >> > The interface is identical emc6d102, so all that needs to be added are
> >> > some definitions and their uses.
> >> > 
> >> > Registers apparently missing in emc6d103:A2 compared to emc6d103:A0,
> >> > emc6d103:A1, and emc6d102 (according to the data sheets), but used
> >> > unconditionally in the driver: 62[5:7], 6D[0:7], and 6E[0:7]. For that
> >> > reason, A2 stepping chips don't get enabled for the time being.
> >> 
> >> The EMC6D103 datasheet on smsc.com doesn't mention revision A2, so I'm
> >> curious where you got this information?
> >> 
> > Ah, this made me look.
> > 
> > This is really EMC6D103S.
> > See http://www.smsc.com/media/Downloads_Public/Data_Sheets/6d103s.pdf.
> > 
> > So it should not be listed as step A2, but separately as EMC6D103S
> > (and it does not have to be mentioned in the code for now, since it is
> > really a different chip).
> 
> No. While revision 0.3 indeed only talks about A0 and A1, revision
> 0.4 even states 0x6A (where 0x68 is A0 and 0x69 is A1) to be the
> default in the version/stepping register.
> 
The datasheet on the SMSC web site is version 0.3 from 2007, the datasheet
at http://www.datasheetcatalog.org/datasheets2/15/1543596_1.pdf
is version 0.4 from 2005. Confusing. 

On the other side, SMSC also has the datasheet for EMC6D103S with ID 0x6a
on their web site. Maybe they relabeled rev A2 as EMC6D103S to avoid confusion
due to the changed functionality.

My take is that we should go with SMSC and list it as EMC6D103S.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
