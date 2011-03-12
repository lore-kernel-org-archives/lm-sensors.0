From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 12 Mar 2011 12:24:03 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: New driver for SMSC SCH5627 hwmon
Message-Id: <20110312132403.2c59c733@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1299871683-3945-1-git-send-email-hdegoede@redhat.com>
In-Reply-To: <1299871683-3945-1-git-send-email-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> On Fri, 11 Mar 2011 20:28:03 +0100, Hans de Goede wrote:
> >  Documentation/hwmon/sch5627 |   23 ++
> >  drivers/hwmon/Kconfig       |    9 +
> >  drivers/hwmon/Makefile      |    1 +
> >  drivers/hwmon/sch5627.c     |  849 +++++++++++++++++++++++++++++++++++++++++++
> >  4 files changed, 882 insertions(+), 0 deletions(-)
> >  create mode 100644 Documentation/hwmon/sch5627
> >  create mode 100644 drivers/hwmon/sch5627.c

Oh, and it would be nice if you could add an entry for the new driver
in MAINTAINERS.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
