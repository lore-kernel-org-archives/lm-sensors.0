From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 05 Nov 2009 09:29:11 +0000
Subject: Re: [lm-sensors] [PATCH] sensord: Don't name our variables "alarm"
Message-Id: <20091105102911.075e5bbc@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20091104102719.12f309cb@hyperion.delvare>
In-Reply-To: <20091104102719.12f309cb@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 4 Nov 2009 20:26:49 +0100, Andre Prendel wrote:
> On Wed, Nov 04, 2009 at 10:27:19AM +0100, Jean Delvare wrote:
> > "alarm" is a glibc function, don't use this identifier for our own
> > variables to prevent any confusion.
> 
> Looks good. I see you made this patch on the top of my patch
> series. Patch applies without conflicts.

Thanks for the review. Patch committed.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
