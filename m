From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Thu, 11 Oct 2007 12:23:24 +0000
Subject: Re: [lm-sensors] PATCH: hwmon-fschmd-new-driver-v3.patch
Message-Id: <20071011122324.GF3994@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <470B7BEE.1010004@hhs.nl>
In-Reply-To: <470B7BEE.1010004@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi:

* Jean Delvare <khali@linux-fr.org> [2007-10-09 15:52:19 +0200]:
> Hi Hans,
> 
> On Tue, 09 Oct 2007 15:02:38 +0200, Hans de Goede wrote:
> > This patch adds a new merged driver for FSC sensor chips, it merges the fscher
> > and fscpos drivers and adds support for the FSC Scylla, Heracles and Heimdall
> > chips.
> > 
> > This 3rd version of the patch has a few issues found during review of the fixed
> > 2nd version, thanks to Jean Delvare!
> > 
> > Signed-off-by: Hans de Goede <j.w.r.degoede@hhs.nl>
> 
> Looks alright now.
> 
> Acked-by: Jean Delvare <khali@linux-fr.org>
> 
> > ---
> > 
> > Jean, I've also attached a diff to the previous patch for easy review.
> 
> I appreciate the effort, but next time, don't bother: "quilt snapshot"
> does the job at my end.

Seconded; git makes it easy see this if I need it.  Also, having two patches
in a single email confuses git's mail handling functions.  Anyway, it's
applied to hwmon-2.6.git/testing with customary whitespace cleanups; thanks.

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
