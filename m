From: mds@paradyne.com (Mark D. Studebaker )
Date: Thu, 19 May 2005 06:23:54 +0000
Subject: what next (was Re: success on Asus P4S8X-X)
Message-Id: <3EA1D677.8080809@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Agreed that we need to make a decision.
"Finishing what Kyosti started" means getting it working AND submitting a patch to 2.4.

Your option a) may be necessary for the i2c side; for the sensors side,
simply adding back the owner and usage_count members of the structs
(or were they even taken out?).
Remember, sensors was never branched, only i2c.

If the fix to i2c-proc is the only thing we need to get the lk2-4 branch of
i2c working, go ahead and do that. Whatever we do, it will take some merging.
Do you know how to do CVS merging? I don't.
Even if we go back to 2.7.0 we will need to merge some stuff from the tree.

So what should we do?


Mark M. Hoffman wrote:
> * Fabrice Bellet <fabrice@bellet.info> [2003-04-13 16:23:38 +0200]:
> 
> 
>>So I added support for the SiS963 bridge in i2c-sis645.c. The patch is
>>attached for version 2.7.0 (merging code from the CVS too).
> 
> 
> Thank you.  You are the second person to submit such a patch.  I'm
> not sure what to do with it, because CVS tag lk2-4 is broken and
> has been abandoned for many weeks now.
> 
> At this point, if nobody is interested in finishing what Kyosti
> started, I think we should either a) re-branch from 2.7.0 to support
> kernel 2.4 or b) announce in bold type on the sensors homepage that
> 2.7.0 is *it* for 2.4.
> 
