From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:31 +0000
Subject: update to ticket 855
Message-Id: <3CC0E6F4.3CBCAF53@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.33.0204011057360.4335-100000@hypatia.phys.uwm.edu>
In-Reply-To: <Pine.LNX.4.33.0204011057360.4335-100000@hypatia.phys.uwm.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

One thing you can do is use 'prog/dump/i2cdump 0 0x2d'
to dump the registers of the chip.
Look for either FF at the alarm registers at 0x41 and 0x42,
or maybe all FF's.
This will eliminate the adm1025 driver as the problem.

If so then the problem is the bus driver or the chip itself.

What bus driver are you using?


Kevin Flasch wrote:
> 
> Hi,
> 
> In regards to ticket #855, which I submitted last week, I found I get the same
> errors when using lm_sensors-2.6.3, so upgrading to the latest stable version
> did not help.
> 
> Thanks!
> 
> Kevin
> 
> --
>  ----------------------------------------
>    Kevin James Flasch
>    http://www.uwm.edu/~kflasch/kflasch.gpg
