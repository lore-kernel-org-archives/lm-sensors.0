From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 19 Sep 2008 20:46:08 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (it87) Fix fan tachometer reading
Message-Id: <20080919224608.4fda05a2@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <76366b180809162055x2eaa52d3l9fcce3272423bde2@mail.gmail.com>
In-Reply-To: <76366b180809162055x2eaa52d3l9fcce3272423bde2@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 16 Sep 2008 23:55:11 -0400, Andrew Paprocki wrote:
> The IT8712F v0.9.1 datasheet applies to revisions >= 0x8 (J).
> The driver was incorrectly attempting to enable 16-bit fan
> readings on rev 0x7 (I) which led to incorrect RPM values.
> 
> Signed-off-by: Andrew Paprocki <andrew@ishiboo.com>
> Tested-by: John Gumb <john.gumb@tandberg.com>
> ---
>  drivers/hwmon/it87.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)

Patch added to my hwmon tree, thank you. I'll send it to Linus shortly.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
