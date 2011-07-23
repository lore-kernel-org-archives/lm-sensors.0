From: Tejun Heo <tj@kernel.org>
Date: Sat, 23 Jul 2011 10:17:14 +0000
Subject: Re: [lm-sensors] [PATCH 8/8] rtc: class idr converted to ida and
Message-Id: <20110723101714.GM21089@mtj.dyndns.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1311352886-4047-1-git-send-email-jic23@cam.ac.uk>
 <1311352886-4047-9-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1311352886-4047-9-git-send-email-jic23@cam.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, rtc-linux@googlegroups.com, osd-dev@open-osd.org, linux-scsi@vger.kernel.org, dri-devel@lists.freedesktop.org, jkosina@suse.cz, naota@elisp.net, rusty@rustcorp.com.au, paulmck@linux.vnet.ibm.com, namhyung@gmail.com, randy.dunlap@oracle.com, cabarnes@indesign-llc.com, akpm@linux-foundation.org, airlied@redhat.com, thellstrom@vmware.com, johnpol@2ka.mipt.ru, JBottomley@parallels.com, bhalevy@panasas.com, bharrosh@panasas.com, a.zummo@towertech.it, guenter.roeck@ericsson.com, khali@linux-fr.org, airlied@linux.ie

On Fri, Jul 22, 2011 at 05:41:17PM +0100, Jonathan Cameron wrote:
> This is the one use of an ida that doesn't retry on receiving -EAGAIN.
> I'm assuming do so will cause no harm and may help on a rare occasion.
> 
> Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>

And all conversions seem correct to me.  Please feel free to add

Reviewed-by: Tejun Heo <tj@kernel.org>

Thank you.

-- 
tejun

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
