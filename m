From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 02 May 2008 07:23:20 +0000
Subject: Re: [lm-sensors] [PATCH 03/10] hwmon: (lm85) Drop dead code
Message-Id: <20080502092320.1e66d9fa@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080412195552.421b4a28@hyperion.delvare>
In-Reply-To: <20080412195552.421b4a28@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 1 May 2008 22:16:12 -0700, Juerg Haefliger wrote:
> I still can't apply it (against 2.6.25):
> 
> juergh@jabba:~/src/linux-2.6/linux$ quilt push
> Applying patch 03_10.patch
> patching file drivers/hwmon/lm85.c
> Hunk #9 FAILED at 1544.
> Hunk #10 FAILED at 96.
> Hunk #11 FAILED at 201.
> 3 out of 11 hunks FAILED -- rejects in file drivers/hwmon/lm85.c
> 
> What am I missing?

I don't know, all my lm85 patches apply fine here on top of 2.6.25.

I don't want to spam the list by resending the full patch set after
each review, so I've copied all the patches to a temporary directory
on my home server:
  http://jdelvare.pck.nerim.net/sensors/lm85/
You can download the files from there and they should apply fine in
sequence. I'll also try to remember updating them when I refresh the
source. When you're done with the reviews, let me know and I'll resend
the whole series on the list.

Oh, and of course, if you review more than 3 patches, don't worry, you
get credit from me to review your future patches ;)

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
