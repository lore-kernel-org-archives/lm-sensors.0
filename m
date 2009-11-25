From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 25 Nov 2009 08:51:24 +0000
Subject: Re: [lm-sensors] "modprobe coretemp" fails in Fedora Core 12
Message-Id: <20091125095124.3cd558b4@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1414.66.169.133.216.1258873116.squirrel@webmail.myamigos.us>
In-Reply-To: <1414.66.169.133.216.1258873116.squirrel@webmail.myamigos.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 22 Nov 2009 00:58:36 -0600 (CST), jrickman@myamigos.us wrote:
> When running "modprobe coretemp" in Fedora Core 12, the module fails to load.
> 
> Output from /var/log/messages:
> Nov 22 00:30:15 acer-nas-01 kernel: i2c /dev entries driver
> Nov 22 00:30:20 acer-nas-01 kernel: coretemp: Unknown CPU model 1c
> Nov 22 00:30:20 acer-nas-01 kernel: coretemp: Unknown CPU model 1c
> Nov 22 00:33:15 acer-nas-01 kernel: coretemp: Unknown CPU model 1c
> Nov 22 00:33:15 acer-nas-01 kernel: coretemp: Unknown CPU model 1c
> 
> Server is Acer H340 NAS with Intel Atom 230 CPU. Also tested on SuperMicro
> MBD-X7SLA-H-O motherboard with Atom 330 CPU.
> 
> Both systems have the following files loaded:
> lm_sensors.x86_64              3.1.1-4.fc12
> lm_sensors-libs.x86_64         3.1.1-4.fc12
> 
> Is there a solution to this problem?

Support for the Intel Atom was only added to the coretemp driver in
kernel 2.6.32, which should be released within a week or two now.

When kernel 2.6.32 is released, you will have to upgrade to this
kernel, or backport the coretemp driver from that kernel to the one
you're running.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
