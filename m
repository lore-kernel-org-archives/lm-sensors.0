From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 08 Jun 2006 09:05:37 +0000
Subject: [lm-sensors] [PATCH] New VID codes for Intel Core and Conroe
Message-Id: <20060608110537.83b12965.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <447815E5.5060601@sh.cvut.cz>
In-Reply-To: <447815E5.5060601@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Rudolf,

> > Jean, thanks for the review. Here comes updated patch. I hope that it is OK.
> > 
> > This patch adds support for two new VID codes, supporting Intel mobile Core
> > processors and new Conroe based platforms.

It seems that the official VRD 11.0 documentation is now available from
Intel:
http://www.intel.com/design/processor/applnots/313214.htm

It includes an "Extended VRD 10.0" VID table. I seem to understand that
the CPUs may alternatively use this table or the VRD 11.0 table you
added support for. I don't really understand what would make a CPU use
one rather than the other though. Can you please investigate? Then your
patch might need some more work. At least it would be nice to point to
the official location for the VRD 11.0 table.

Thanks,
-- 
Jean Delvare

