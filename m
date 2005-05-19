From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:42 +0000
Subject: 2.6.11-mm2 vs audio for kino and tvtime
Message-Id: <XO42l8mC.1110444770.5508140.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <200503091927.24558.gene.heskett@verizon.net>
References: <20050308224441.2e29f895.akpm@osdl.org>
In-Reply-To: <20050308224441.2e29f895.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, linux1394-devel@lists.sourceforge.net, video4linux-list@redhat.com, sensors@stimpy.netroedge.com


Hi Gene,

> > I've dropped the "id" member of struct i2c_client, as it were
> > useless. Third-party driver authors now need to do the same.
>
> Aha!  As in just 'dd' any line containing the .id in vim?

Exactly. Don't kill all lines with .id though, only the i2c_client id
was dropped, and there are plenty of other ids in the media/video
drivers.

> > THRM is most likely a temperature you get from
> > /proc/acpi/thermal_zone, and isn't related with the w83627hf
> > driver.
>
> Humm, it is the highest temp reported, as is temp2 in gkrellm, so I
> had assumed it was somehow a dup of the diode in the cpu, or of the
> thermistor against the bottom of it inside the socket.  Wrong
> assumption?

Not necessarily wrong. It is possible that the same diode temperature is
read from the W83627HF chip by both the ACPI subsystem and by the
w83627hf driver. But if this is the case, I would be worried by
concurrent I/O accesses to the chip, which could possibly cause trouble.

--
Jean Delvare
