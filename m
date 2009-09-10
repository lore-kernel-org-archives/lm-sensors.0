From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 10 Sep 2009 12:56:09 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon w83627hf: add mfd support.
Message-Id: <20090910145609.200ee1f0@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1252585810-5336-2-git-send-email-giometti@linux.it>
In-Reply-To: <1252585810-5336-2-git-send-email-giometti@linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Rodolfo,

Don't bother including Frodo L. and Mark S. in the discussions, they
have left the lm-sensors project years ago.

On Thu, 10 Sep 2009 14:30:10 +0200, Rodolfo Giometti wrote:
> The file has been splitted up into two parts:
> 
> * drivers/mfd/w83627hf.c         - detects the chip and define proper
>                                    platform devices into mfd support
> 
> * drivers/hwmon/hwmon-w83627hf.c - implements the driver for hwmon
>                                    functionality only
> 
> The patch also fixes up some non reentrant code and some C-style issues.
> 
> Signed-off-by: Rodolfo Giometti <giometti@linux.it>
> ---
>  drivers/hwmon/Kconfig                          |    2 +-
>  drivers/hwmon/Makefile                         |    2 +-
>  drivers/hwmon/{w83627hf.c => hwmon-w83627hf.c} |  373 +++++-------------------

This name change will break all users of the driver. The sensors-detect
script points the user to "w83627hf" and typically writes this value to
an init script or configuration file. The w83627hf driver doesn't
auto-load (yet) so this is a requirement.

Assuming that the hwmon part depends on the MFD part, I'd rather keep
"w83627hf" as the hwmon part name, and name the new MFD part
"w83627hf-core" or similar. I agree it's not so nice but at least it
doesn't break compatibility.

>  drivers/mfd/Kconfig                            |   14 +
>  drivers/mfd/Makefile                           |    1 +
>  drivers/mfd/w83627hf.c                         |  251 ++++++++++++++++
>  include/linux/mfd/w83627hf.h                   |   68 +++++
>  7 files changed, 411 insertions(+), 300 deletions(-)
>  rename drivers/hwmon/{w83627hf.c => hwmon-w83627hf.c} (85%)
>  create mode 100644 drivers/mfd/w83627hf.c
>  create mode 100644 include/linux/mfd/w83627hf.h

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
