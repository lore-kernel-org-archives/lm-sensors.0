From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 06 Apr 2011 12:23:34 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon/k10temp: add support for Fam15h
Message-Id: <20110406142334.7776e714@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1302079081-22572-1-git-send-email-andre.przywara@amd.com>
In-Reply-To: <1302079081-22572-1-git-send-email-andre.przywara@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 06 Apr 2011 12:57:53 +0200, Clemens Ladisch wrote:
> Andre Przywara wrote:
> > AMDs upcoming CPUs use the same mechanism for the internal
> > temperature reporting as the Fam10h CPUs, so we just needed to add
> > the appropriate PCI-ID to the list.
> > This allows to use the k10temp driver on those CPUs.
> > While at it change the Kconfig entry to be more generic.
> > 
> > Signed-off-by: Andre Przywara <andre.przywara@amd.com>
> 
> Acked-by: Clemens Ladisch <clemens@ladisch.de>
> 
> > ---
> >  Documentation/hwmon/k10temp |    3 ++-
> >  drivers/hwmon/Kconfig       |    4 ++--
> >  drivers/hwmon/k10temp.c     |    5 +++--
> >  3 files changed, 7 insertions(+), 5 deletions(-)

Applied, thanks. I've also added detection to sensors-detect [1], added
an entry in the wiki [2] and updated my standalone k10temp driver [3].

[1] http://dl.lm-sensors.org/lm-sensors/files/sensors-detect
[2] http://www.lm-sensors.org/wiki/Devices
[3] http://khali.linux-fr.org/devel/misc/k10temp/

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
