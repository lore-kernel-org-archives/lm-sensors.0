From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 16 Mar 2006 11:09:43 +0000
Subject: [lm-sensors] alarm files one file per sensor vs file with
Message-Id: <2JBVFTvW.1142507383.8724770.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <441940D4.2050107@hhs.nl>
In-Reply-To: <441940D4.2050107@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


On 2006-03-16, Hans de Goede wrote:
> > We will go with individual alarm files, as I had been proposing. I will
> > not have the time to submit a new documentation patch before next week,
> > but basically it's just what my previous patch was saying. Follow the
> > same naming scheme for beep, alarm_mask and shutdown (the later two
> > being only used by your driver AFAIK.)
>
> Ok,  got a link handy to the patch you're talking about? Otherwise I'll
> scim the archives.

This post:
http://lists.lm-sensors.org/pipermail/lm-sensors/2006-March/015502.html

Or you can get the patch file directly from here:
http://khali.linux-fr.org/devel/i2c/linux-2.6/hwmon-sysfs-interface-individual-alarm-files.patch

--
Jean Delvare

