From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 30 Apr 2012 14:55:02 +0000
Subject: Re: [lm-sensors] Does ACPI conflict also happen on MS/Windows?
Message-Id: <20120430165502.5ee8a697@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <BAY171-W203D195E39237603879A63F7280@phx.gbl>
In-Reply-To: <BAY171-W203D195E39237603879A63F7280@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Allen,

On Mon, 30 Apr 2012 14:33:38 +0000, Allen Weiner wrote:
> lm-sensors doesn't work on my motherboard (Biostar TA890FXE) due to a conflict with ACPI (as documented in the lm-sensors FAQ).
> 
> My PC runs Linux only. I'm curious if my PC were to also run MS/Windows, would the hardware monitoring programs available for Windows, such as HWMonitor, also not work due to conflict with ACPI?

Most likely they would "work", because they simply do not check the
ACPI conflict in the first place. So they run but not reliably, exactly
the same as running Linux with acpi_enforce_resources=lax.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
