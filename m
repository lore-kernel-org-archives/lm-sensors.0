From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 28 Mar 2012 19:55:59 +0000
Subject: Re: [lm-sensors] [PATCH] acpi_power_meter: fix lockdep spew due to non-static lock class
Message-Id: <1332964559.21301.144.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <20120328191147.GK25886@redacted.bos.redhat.com>
In-Reply-To: <20120328191147.GK25886@redacted.bos.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kyle McMartin <kyle@redhat.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "khali@linux-fr.org" <khali@linux-fr.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "djwong@us.ibm.com" <djwong@us.ibm.com>

On Wed, 2012-03-28 at 15:11 -0400, Kyle McMartin wrote:
> Similar to a30dcb4f which fixed asus_atk0110.ko, I recently received a
> bug report from someone hitting the same issue in acpi_power_meter.
> 
> [   13.963168] power_meter ACPI000D:00: Found ACPI power meter.
> [   13.963900] BUG: key ffff8802161f3920 not in .data!
> [   13.963904] ------------[ cut here ]------------
> [   13.963915] WARNING: at kernel/lockdep.c:2986
> 	lockdep_init_map+0x52f/0x560()
> 
> So let's fix that up for them by statically declaring the
> lockdep_class_key.
> 
> Signed-off-by: Kyle McMartin <kyle@redhat.com>
> 
Applied.

Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
