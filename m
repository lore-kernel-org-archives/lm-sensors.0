From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:15 +0000
Subject: i2c, lm_sensors, and 2.4.22
Message-Id: <20030905235839.5e4fe2a9.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> I guess I am quick.  I did however patch the kernel (2.4.22) with the 
> cumulative patch provided and noticed that my BTTV device started
> giving Segmentation Faults (like it did in 2.4.21 without your patch).
> I'm not sure of what's wrong, but I can provide some more info if you
> need (or want) it to try to fix the problem.

I'm a bit astonished since I have been having success reports by other
users. Another thing I am wondering about is why you say the patches are
cumulative. My patches are *not* cumulative. There are two different
(big) patches, one for 2.4.21, one for 2.4.22. You really have to start
from a fresh 2.4.22 tree before applying the new 2.4.22 patch. If you
thing my page is unclear about that, let me know and I'll add details
where they are needed.

If you still can't get it to work, please detail which procedure you are
using, and in particular where you do get your source tree from, how you
apply my patch and which patch or set of patches it is, wether the patch
command returns warnings, wether the compilation then returns warnings,
and so on.

I myself tried the new 2.4.22 patch with my DC10+ and it worked OK. If
something's wrong, it must be something specific to the BTTV modules.

>  On Sun, 31 Aug 2003, Jean Delvare wrote:
> 
> > 
> > > I saw that you updated
> > > 
> > > http://www.ensicaen.ismra.fr/~delvare/devel/i2c
> > 
> > Yeah, you're quick, the updated wasn't even finished ;)
> > 
> > > to include the patch for 2.4.22.  However, it seems that the
> > > permissions aren't set right on the file because I get a
> > > "Forbidden" message in my browser when trying to access it.
> > 
> > I moved the patches into subdirectories and forgot to update all
> > links in the web page. That's all fixed now.
> > 
> > I tested the whole think quickly and it seems to work. More testing
> > will be welcome of course, since I just don't have the time to fully
> > test everything. I'm *very* busy these days (taking a new job
> > tomorrow)...
> > 
> > Thanks for your patience and let me know how it works for you! :)
> > 
> > -- 
> > Jean Delvare
> > http://www.ensicaen.ismra.fr/~delvare/
> > 
> 
> #####################################################################
> ######
> Troy Henderson                  Office: Blocker Building 619
> Department of Mathematics       Phone : (979) 845-7769
> Texas A&M University            E-mail: thenders@math.tamu.edu
> College Station, TX 77845       URL   :
> http://www.math.tamu.edu/~thenders
> #####################################################################
> ######
> 


-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
