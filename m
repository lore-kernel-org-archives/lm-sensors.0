From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 27 Jun 2015 14:39:09 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (dell-smm-hwon) Use a valid name attribute
Message-Id: <558EB58D.5080003@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1435411325-27428-1-git-send-email-gabriele.mzt@gmail.com>
In-Reply-To: <1435411325-27428-1-git-send-email-gabriele.mzt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Gabriele Mazzotta <gabriele.mzt@gmail.com>, pali.rohar@gmail.com, jdelvare@suse.de
Cc: gregkh@linuxfoundation.org, arnd@arndb.de, stevenhoneyman@gmail.com, Valdis.Kletnieks@vt.edu, jochen@penguin-breeder.org, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

On 06/27/2015 06:22 AM, Gabriele Mazzotta wrote:
> As per Documentation/hwmon/sysfs-interface, hwmon name attributes must
> not include '-', so replace 'dell-smm' with 'dell_smm'.
>
> Fixes: 039ae58503f3 ("hwmon: Allow to compile dell-smm-hwmon driver without /proc/i8k")
> Signed-off-by: Gabriele Mazzotta <gabriele.mzt@gmail.com>

Applied.

Pali, would be great if you can send me an Acked-by: before I send
the pull request to Linus.

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
