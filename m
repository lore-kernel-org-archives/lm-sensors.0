From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 04 Jan 2012 20:23:05 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] drivers/hwmon: replaced strict_str*
Message-Id: <1325708585.2649.1.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1325707133-21063-1-git-send-email-fransmeulenbroeks@gmail.com>
In-Reply-To: <1325707133-21063-1-git-send-email-fransmeulenbroeks@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 2012-01-04 at 14:58 -0500, Frans Meulenbroeks wrote:
> replaced strict_strtol with kstrtol and
> replaced strict_strtuol with kstrtuol
> 
> This satisfies checkpatch -f
> Compile tested only: no warnings or errors given
> 
> Signed-off-by: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>

Applied.

On a side note, it is better if you can base base your patches on the
hwmon-next branch, not on hwmon-staging. The latter is experimental
only.

Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
