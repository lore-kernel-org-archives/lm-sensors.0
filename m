From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 28 Oct 2012 21:44:39 +0000
Subject: Re: [lm-sensors] [PATCH 2/9] hwmon: (it87) Save voltage register values in 2-dimensional array
Message-Id: <20121028224439.65f3c487@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1351448401-13985-3-git-send-email-linux@roeck-us.net>
In-Reply-To: <1351448401-13985-3-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 28 Oct 2012 11:19:54 -0700, Guenter Roeck wrote:
> Reduces code size (more than 600 bytes on x86_64),
> and gets rid of some checkpatch errors.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/hwmon/it87.c |  135 +++++++++++++++++++-------------------------------
>  1 file changed, 52 insertions(+), 83 deletions(-)
> (...)

Acked-by: Jean Delvare <khali@linux-fr.org>

I'll review the rest of this series tomorrow, good night.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
