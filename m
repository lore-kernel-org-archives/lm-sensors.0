From: John.Morris@spirentcom.com (Morris, John)
Date: Thu, 19 May 2005 06:24:14 +0000
Subject: LM83 test resport (was:  Adapter driver for opencores I2C fpga)
Message-Id: <629E717C12A8694A88FAA6BEF9FFCD440224B397@brigadoon.spirentcom.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> From: Morris, John [mailto:John.Morris@spirentcom.com]
> Sent: Sunday, August 24, 2003 7:35 PM
> To: 'sensors@Stimpy.netroedge.com'
> Subject: RE: Adapter driver for opencores I2C fpga
> 
> 
> > From: Jean Delvare [mailto:khali@linux-fr.org]
> > Sent: Saturday, August 23, 2003 12:36 PM
> > To: Morris, John
> > Cc: sensors@Stimpy.netroedge.com
> > Subject: Re: Adapter driver for opencores I2C fpga
> > 
> 
> Yes, it works fine, though I have modified it quite a lot. 
> The version I 
> got with the 2.8.0 release had four repeats of essentially 
> the same code, 
> apart from register addresses, so I merged them into a single 
> function.
> I then added some extra status information. I was planning to 
> look at the
> latest in CVS on Monday or Tuesday to see if I had duplicated 
> any effort
> before offering this code back.

Heh - the latest code in CVS has exactly the same changes, almost
word for word, as I had made. So I have junked my code and am
using the CVS version instead. 

It continues to work just fine, within the limits of testing:
we use the /proc interface to look at sensor values, but none
of the application level stuff like sensors-detect - we made
the boards, so we already know what chips are on them :-)
