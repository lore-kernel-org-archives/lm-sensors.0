From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 14 Apr 2008 15:36:24 +0000
Subject: Re: [lm-sensors] [PATCH] Add virtual hwmon device support to
Message-Id: <20080414173624.681e3a86@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080409152330.2900add8@hyperion.delvare>
In-Reply-To: <20080409152330.2900add8@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 9 Apr 2008 15:23:30 +0200, Jean Delvare wrote:
> Hi all,
> 
> As Zhang Rui is adding hwmon support to the generic thermal zone driver
> [1], we need to add support for virtual hwmon devices to libsensors.
> The hwmon devices created by Rui's code do not have any parent device,
> they are purely virtual, and libsensors doesn't expect this. There's a
> bug reported in Red Hat's bugzilla already [2].
> 
> [1] http://lists.lm-sensors.org/pipermail/lm-sensors/2008-April/022791.html
> [2] https://bugzilla.redhat.com/show_bug.cgi?idC7637
> 
> Here's a proposed implementation for virtual devices support:
> 
> ---
>  doc/libsensors-API.txt |   14 ++++++++++++++
>  lib/access.c           |    2 ++
>  lib/data.c             |    5 +++++
>  lib/sensors.h          |    3 ++-
>  lib/sysfs.c            |   32 +++++++++++++++++++++++---------
>  5 files changed, 46 insertions(+), 10 deletions(-)
> (...)

This patch is now applied to SVN.


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
