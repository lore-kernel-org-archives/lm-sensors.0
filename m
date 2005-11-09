From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 09 Nov 2005 12:15:26 +0000
Subject: [lm-sensors] reset=1 required for PWM control on Asus P4P800
Message-Id: <idxHy9Lq.1131534154.9976140.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051106224429.533f13b7@heffalump.sk2.org>
In-Reply-To: <20051106224429.533f13b7@heffalump.sk2.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Jacques,

On 2005-11-08, Jacques Facquet wrote:
> This solved my problem too.
> dmesg
> Trying to free nonexistent resource <00000290-00000297>
> (after reloading the driver)
>
> w83627hf 9191-0290: If reset=1 solved a problem you were having,
> please report!
>
> Soltek QBic EQ-3401A-V2
>
> request_region(address, WINB_EXTENT, w83627hf_driver.name) return an
> error, without checking this error, the driver load but I have an
> error in unloading it.

According to a previous post on this list, you have been hacking the code
yourself, so please don't complain about the errors you get as a
consequence of this.

The I/O region conflict error you have is absolutely not related to the
reset change, it's much older. It's caused by PNPACPI since 2.6.10,
and has been fixed recently. See bug #4014 for additional information:
  http://bugzilla.kernel.org/show_bug.cgi?id@14
If you don't want to upgrade kernels, the workaround is to disable
PNPACPI, either when configuring your kernel or on the boot command line
(pnpacpi=off).

Thanks,
--
Jean Delvare
