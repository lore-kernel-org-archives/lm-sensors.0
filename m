From: Punit Agrawal <punit.agrawal@arm.com>
Date: Mon, 15 Feb 2016 18:38:18 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] hwmon: (scpi) add energy meter support
Message-Id: <8760xpakf9.fsf@e105922-lin.cambridge.arm.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1455028377-12728-1-git-send-email-sudeep.holla@arm.com>
	<1455028377-12728-2-git-send-email-sudeep.holla@arm.com>
In-Reply-To: <1455028377-12728-2-git-send-email-sudeep.holla@arm.com> (Sudeep
	Holla's message of "Tue, 9 Feb 2016 14:32:57 +0000")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Guenter Roeck <linux@roeck-us.net>, lm-sensors@lm-sensors.org, Jean Delvare <jdelvare@suse.com>

Sudeep Holla <sudeep.holla@arm.com> writes:

> SCPI specification v1.1 adds support for energy sensors. This patch
> adds support for the same.
>
> Cc: Punit Agrawal <punit.agrawal@arm.com>

  Reviewed-by: Punit Agrawal <punit.agrawal@arm.com>

> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/hwmon/scpi-hwmon.c    | 8 ++++++++
>  include/linux/scpi_protocol.h | 1 +
>  2 files changed, 9 insertions(+)
>

[...]


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
