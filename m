From: m.pedersen@lancaster.ac.uk (jmp)
Date: Thu, 19 May 2005 06:24:36 +0000
Subject: KT400a / VT8235
Message-Id: <1075054310.1451.12.camel@flaptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1075043549.1154.39.camel@flaptop>
In-Reply-To: <1075043549.1154.39.camel@flaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 2004-01-25 at 18:05, Jean Delvare wrote:
> Enable ACPI and its "Thermal Zone" option while
> configuring your kernel, and then browse /proc/acpi for information.
> Especially the 'thermal_zone" subdirectory could be of interest to you.

thx, I have done this - the reason I was fooling around with lm_sensors
is because my /proc/acpi/thermal_zone/THRM/temperature always says "75"
- it never changes - and through Google I came to lm_sensors...

;-(


