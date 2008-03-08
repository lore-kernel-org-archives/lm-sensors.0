From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 08 Mar 2008 10:15:56 +0000
Subject: Re: [lm-sensors] pc87360 and individual alarm files
Message-Id: <20080308111556.47da4ebe@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080213143140.49a511cc@hyperion.delvare>
In-Reply-To: <20080213143140.49a511cc@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jim,

On Wed, 05 Mar 2008 15:25:27 -0700, Jim Cromie wrote:
> Jean Delvare wrote:
> > Hi Jim,
> >
> > According to my records, all the hardware monitoring drivers have now
> > been updated to implement individual alarm files, except pc87360. I
> > know that you had been working on this several months ago. Do you have
> > an updated patch that I could review?
> >
> > Thanks,
> >   
> Hi Jean,
> 
> Sorry for late reply, Im not reading this list regularly.
> 
> now for the excuses :-/
> 
> Im away from that hardware, and from my hwmon working directories,
> for at least a month.  The last time I plugged the soekris box in,
> I had issues with NFS preventing a root mount, and thus any testing.
> 
> I have a vague recollection of doing individual alarm stuff,
> but I think it was for another driver (w83627hf)
> 
> Given enough time, I can do (and presuming I can eventually fix the NFS
> issue, test) the pc87360 conversion, are you ok with my constraints ?

Totally fine with me, I don't have time to work on it myself, and no
test hardware, so even if it takes some time, your help is very
appreciated.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
