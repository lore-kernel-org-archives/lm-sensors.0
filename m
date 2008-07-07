From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 07 Jul 2008 07:33:10 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: it87 support for 16-bit fan reading
Message-Id: <20080707093310.4b7eb75a@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <76366b180802102232o60442894gfca038eb4b6f181d@mail.gmail.com>
In-Reply-To: <76366b180802102232o60442894gfca038eb4b6f181d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 6 Jul 2008 20:57:12 -0400, Andrew Paprocki wrote:
> The it8712 chip supports 16-bit fan tachometers in revisions >= 0x07.
> Revisions >= 0x08 dropped support for 8-bit fan divisor registers. The
> patch enables 16-bit fan readings on all revisions >= 0x07 just like
> the it8716 and it8718 chips.
> 
> Signed-off-by: Andrew Paprocki <andrew@ishiboo.com>
> ---
>  Documentation/hwmon/it87 |    9 +++++----
>  drivers/hwmon/it87.c     |   32 ++++++++++++++++++++++----------
>  2 files changed, 27 insertions(+), 14 deletions(-)

Acked-by: Jean Delvare <khali@linux-fr.org>

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
