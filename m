From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 06 Apr 2006 06:35:24 +0000
Subject: [lm-sensors] ali1563 problems
Message-Id: <20060406083524.672cae7a.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <000001c657ef$bd81d2c0$937ba8c0@genesis>
In-Reply-To: <000001c657ef$bd81d2c0$937ba8c0@genesis>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jo,

> The contents of /proc/ioports:
> 
> regawebdev proc # cat ioports
> (...)
> 0295-0296 : pnp 00:07

OK, that's what I suspected then. You have PNP ACPI enabled, and before
2.6.15, the w83627hf driver doesn't work properly with this option
enabled.

Your options are:
1* Upgrade to a 2.6.15+ kernel.
Or:
2* Boot with pnpacpi=off.
Or:
3* Recompile your kernel with CONFIG_PNPACPI disabled.

-- 
Jean Delvare

