From: mds@paradyne.com (Mark D. Studebaker )
Date: Thu, 19 May 2005 06:23:57 +0000
Subject: w83791d
Message-Id: <3ED7FCB2.7050303@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3ECBB576.2090509@google.com>
In-Reply-To: <3ECBB576.2090509@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I got the sensors patch to apply fine.
But the w83781d.c patch is too far off from CVS to apply cleanly.
Would you please merge with CVS and send us a new patch.
thanks
mds

Ross Biro wrote:
> 
> Here's a patch against 2.7.0 that seems to make the w83791d readable.  I 
> haven't tested setting anything with it, and I've only really looked at 
> the voltage and temperature outputs.
> 
> I've also included a patch to 2.7.0 sensors to make the sensors program 
> work with the w83791d chip.
> 
> Again these patches have not been thoroughly tested, but seem to work in 
> the few cases that I've tried.
> 
>     Ross
> 
> 
