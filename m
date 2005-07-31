From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 31 Jul 2005 14:24:27 +0000
Subject: [lm-sensors] [PATCH 2.6] hwmon: kill cast abuses
Message-Id: <20050731142354.4baa68ba.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050729214552.041842e4.khali@linux-fr.org>
In-Reply-To: <20050729214552.041842e4.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg, all,

Quoting myself:
> Some hardware monitoring drivers use needless casts to long.
> Especially, three Winbond drivers use many of them. Let's clean this
> up for the sake of code readability, if nothing else.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> 
>  drivers/hwmon/adm1026.c  |    2 +-
>  drivers/hwmon/it87.c     |    4 ++--
>  drivers/hwmon/lm85.c     |    4 ++--
>  drivers/hwmon/w83627hf.c |   29 ++++++++++++++---------------
>  drivers/hwmon/w83781d.c  |   29 ++++++++++++++---------------
>  drivers/hwmon/w83792d.c  |   14 +++++++-------
>  6 files changed, 40 insertions(+), 42 deletions(-)

Please don't apply that patch, it might not be as innocent as it looks.
I don't seem to understand the assembly code changes it causes. I'll
need to have an assembly expert take a look and explain it to me.

Thanks,
-- 
Jean Delvare
