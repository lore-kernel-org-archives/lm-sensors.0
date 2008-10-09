From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 09 Oct 2008 11:47:02 +0000
Subject: Re: [lm-sensors] [PATCH 09/12] ibmpex: Automatically load on IBM
Message-Id: <20081009134702.7e0e977d@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081007011909.12701.96969.stgit@elm3a70.beaverton.ibm.com>
In-Reply-To: <20081007011909.12701.96969.stgit@elm3a70.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 8 Oct 2008 11:09:53 -0700, Darrick J. Wong wrote:
> [dropping linux-scsi from cc]

Yeah, someday you'll have to tell me why you included it in the first
place ;)

> On Wed, Oct 08, 2008 at 02:01:58PM +0200, Jean Delvare wrote:
> > Is there no way to have an alias at the IPMI level? That is, alias on
> > the device itself rather than the systems it is in? This would avoid the
> > foreseeable requirement to add entries every time new machines are
> > released.
> 
> I'm not sure how one would construct this--the only way to find out if
> there's a PEX/AEM device is to send raw IPMI commands and see if we get
> back the correct set of bytes.  Otherwise, the BMC answering IPMI
> requests looks exactly the same as a non-AEM/PEX BMC. 

OK.

> > But if there is no such way then I am fine applying this patch (except
> > that I'd sort the entries). I also suspect that the last "*" should
> > actually be ":*"?
> 
> Nope.  The pn string actually contains extended model number data:
> 
> IBMSystemx3650-[7979AC1]-
>                 ^^^^----- There can be several MNs, which change across
>                           speed bump/warranty options.
>                     ^^^-- This depends on the option package you specify
>                           when you buy the machine.
> 
> So I stop looking at the family number (3650).  I suppose it would be
> wise to include the dash just in case we ever go to 5 digit family
> numbers ("x35351").

OK, I'll add the dash then. What about this one:

"dmi:bvnIBM:*:pnIBM3850M2/x3950M2*"

Should I add a trailing dash as well?

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
