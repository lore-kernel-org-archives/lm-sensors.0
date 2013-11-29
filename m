From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 29 Nov 2013 08:12:48 +0000
Subject: Re: [lm-sensors] How can temp_crit for virtual device be set?
Message-Id: <20131129091248.1be6012e@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <5297B848.4080906@gmail.com>
In-Reply-To: <5297B848.4080906@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Thomas,

Please don't top-post.

On Fri, 29 Nov 2013 09:00:04 +0100, Thomas Mitterfellner wrote:
> OK, thanks for that clarification. Do you have a tip on how I could go
> about to  set it through ACPI?

I think it used to be overridable with boot parameters and/or procfs
attributes but I seem to recall this feature was removed from the
kernel some times ago. You'll have to ask the ACPI people for the
current status.

I'm afraid the only possibility left is to customize your DSDT and
override the DSDT with your modified copy at boot time.

> Who (which program/demon/whatever) is responsible for creating this virtual
> device and its settings?

The kernel itself is doing it, based on ACPI tables / BIOS information.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
