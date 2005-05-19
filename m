From: John.Morris@spirentcom.com (Morris, John)
Date: Thu, 19 May 2005 06:24:14 +0000
Subject: Adapter driver for opencores I2C fpga
Message-Id: <629E717C12A8694A88FAA6BEF9FFCD440224B380@brigadoon.spirentcom.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <629E717C12A8694A88FAA6BEF9FFCD440224B33D@brigadoon.spirentcom.com>
In-Reply-To: <629E717C12A8694A88FAA6BEF9FFCD440224B33D@brigadoon.spirentcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> From: Jean Delvare [mailto:khali@linux-fr.org]
> Sent: Saturday, August 23, 2003 12:36 PM
> To: Morris, John
> Cc: sensors@Stimpy.netroedge.com
> Subject: Re: Adapter driver for opencores I2C fpga
> 
> 
> 
> > Is this of interest?
> 
> Yes, I think it's of interest, as long as at least one other 
> user around
> the world will be able to use your driver (but I'm not the 
> authority wrt
> that topic).

I'll document it a bit more, then the list can debate.

> 
> I'd like you to tell me if the LM83 driver works OK for you. 
> It has been
> only slightly tested so far.

Yes, it works fine, though I have modified it quite a lot. The version I 
got with the 2.8.0 release had four repeats of essentially the same code, 
apart from register addresses, so I merged them into a single function.
I then added some extra status information. I was planning to look at the
latest in CVS on Monday or Tuesday to see if I had duplicated any effort
before offering this code back.
