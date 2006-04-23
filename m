From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 23 Apr 2006 18:39:55 +0000
Subject: [lm-sensors] Kernel fault from ACPI when using W83627EHG on
Message-Id: <20060423203955.c9f5dba7.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060420235351.9D72212ED4@bluewhale.planbit.co.uk>
In-Reply-To: <20060420235351.9D72212ED4@bluewhale.planbit.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Roger,

When starting a new thread, please do NOT use the "reply" function of
your e-mail client on a random post. This confuses users of threading
e-mail clients a lot.

> Although booting with "acpi=off" is a workaround, I would _really_ like to
> have ACPI running as it means that the power button on the front of the box
> does a controlled shutdown (rather than a hard power-off) if pressed briefly
> as well as a few other nice features.

The various ACPI features can be built modular. You could try this, and
only load the parts you need (e.g. ac, button) and not the ones which
are probably responsible for the crash (e.g. thermal). This might help
you survive for now, and isolate the problem within acpi.

And this definitely needs to be reported to the acpi people (bugzilla?)

-- 
Jean Delvare

