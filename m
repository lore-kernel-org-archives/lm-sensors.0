From: mds@paradyne.com (Mark D. Studebaker )
Date: Thu, 19 May 2005 06:24:06 +0000
Subject: [patch] i2c-ali1535 fixup
Message-Id: <3F19EE58.5030301@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030711223230.GA24311@unpunk.com>
In-Reply-To: <20030711223230.GA24311@unpunk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

thanks for the patch, especially since it's against CVS.

Our users have had some trouble with this driver and perhaps this will help.
Unfortunately the patch is huge due to your renaming of most of the #defines,
and changing almost every printk,
so it's a little difficult to see what really changed.

Since I can't test this perhaps you could give us some more info
on the changes.

Also you imply in the comments that you fixed a lot of problems in 1535 that
still exist in 15x3 (which I wrote). If true, could you elaborate on the
fixes that may be appropriate for 15x3 as well.

mds



Matt Mercer wrote:
> Hi,
> 
> I have been maintaining a reworked version of the i2c-ali1535 driver since
> the lm_sensors 2.7.0 snapshot. I have merged my changes with the current cvs
> head.  Would be cool to see this get passed up to the kernel at this point.
> 
> Summary of changes:
> - improved device initialization
> - improved smbus initialization and error handling
> 
> 
> Thanks
> Matt Mercer
> fee@users.sourceforge.net
> 
> 
> 
