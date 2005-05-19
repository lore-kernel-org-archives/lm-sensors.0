From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:24:29 +0000
Subject: [PATCH] Re: SOLVED: Ticket #1409
Message-Id: <3FDBAD95.50043413@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <hv4qyqwf5r.fsf_-_@rasputin.ws.nextra.no>
In-Reply-To: <hv4qyqwf5r.fsf_-_@rasputin.ws.nextra.no>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

sorry this got lost for 2 months.
Applied to CVS.

Bj?rn Mork wrote:
> 
> Bj?rn Mork <bjorn@mork.no> writes:
> > Mark Studebaker <mds@paradyne.com> writes:
> >
> >> If you port over the super i/o code from one of the 3 drivers listed
> >> above
> >> and send us a patch we'll include it.
> >
> > OK.  Will do.
> 
> Here's the patch as promised.  Took the code from smsc47m1.c.  It
> currently only changes behaviour for the IT8712F since I cannot test
> on any other IT87-chips, and the comments in sensors-detect made me
> uncertain whether they really use the same key/exit sequence.
> 
> Also changed sensors-detect somewhat to support longer devids and exit
> sequences.  Don't know if you'll approve my perl though...
> 
> Bj?rn
> 
> 
> 
>    lm_sensors2.diffName: lm_sensors2.diff
>                    Type: text/x-patch
