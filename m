From: "John Brier" <johnbrier@gmail.com>
Date: Tue, 23 Dec 2008 06:03:58 +0000
Subject: Re: [lm-sensors] lm-sensors 2.10.1 with newer 2.6.x.x kernel can't
Message-Id: <f421b28c0812222203t138fa379qddfadbdd9d242d1c@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <f421b28c0812221450x5188180u1d21990775c42606@mail.gmail.com>
In-Reply-To: <f421b28c0812221450x5188180u1d21990775c42606@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Dec 22, 2008 at 5:50 PM, John Brier <johnbrier@gmail.com> wrote:
> [root@tb303 ~]# sensors

I should mention I do have sysfs mounted
sysfs on /sys type sysfs (rw)

I'm trying with a second kernel now

$ grep SYSFS /boot/config-2.6.27.10-JBstrikesagain
CONFIG_SYSFS_DEPRECATED=y
CONFIG_SYSFS_DEPRECATED_V2=y
CONFIG_ACPI_SYSFS_POWER=y
CONFIG_SYSFS=y

still no go.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
