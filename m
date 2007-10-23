From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Tue, 23 Oct 2007 11:03:00 +0000
Subject: Re: [lm-sensors] [PATCH v4] i5k_amb: New memory temperature sensor
Message-Id: <20071023110300.GA30546@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070716202807.GD2619@tree.beaverton.ibm.com> <20070716221429.GF2619@tree.beaverton.ibm.com> <20070730033840.GG31314@jupiter.solarsys.private> <20070730192606.GD2795@tree.beaverton.ibm.com> <200707302141.l6ULfAnT021069@e1.ny.us.ibm.com> <20070731183706.GG2795@tree.beaverton.ibm.com> <20071016125429.GG3731@jupiter.solarsys.private> <20071016230657.GA6408@tree.beaverton.ibm.com> <20071018131550.GA3526@jupiter.solarsys.private> <20071018202243.GF31309@tree.beaverton.ibm.com>
In-Reply-To: <20071018202243.GF31309@tree.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Darrick J. Wong" <djwong@us.ibm.com>
Cc: lm-sensors@lm-sensors.org, Jeff Garrett <jgarrett@teamhpc.com>, Vadim Zeitlin <vadim@zeitlins.org>, linux-kernel <linux-kernel@vger.kernel.org>

Hi Darrick:

* Darrick J. Wong <djwong@us.ibm.com> [2007-10-18 13:22:43 -0700]:
> New driver to read FB-DIMM temperature sensors on systems with the
> Intel 5000 series chipsets.
> 
> Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>
> ---
> 
>  drivers/hwmon/Kconfig   |   10 +
>  drivers/hwmon/Makefile  |    1 
>  drivers/hwmon/i5k_amb.c |  531 +++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/pci_ids.h |    3 
>  4 files changed, 545 insertions(+), 0 deletions(-)

Applied to hwmon-2.6.git/testing, thanks.

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
