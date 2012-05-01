From: Ian Pilcher <arequipeno@gmail.com>
Date: Tue, 01 May 2012 14:07:31 +0000
Subject: Re: [lm-sensors] Does ACPI conflict also happen on MS/Windows?
Message-Id: <jnoqn3$43g$1@dough.gmane.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <BAY171-W203D195E39237603879A63F7280@phx.gbl>
In-Reply-To: <BAY171-W203D195E39237603879A63F7280@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 04/30/2012 09:55 AM, Jean Delvare wrote:
> Most likely they would "work", because they simply do not check the
> ACPI conflict in the first place. So they run but not reliably, exactly
> the same as running Linux with acpi_enforce_resources=lax.

On a slightly related note, I've always been a bit bemused by the this
message:

  If an ACPI driver is available for this device, you should use it
  instead of the native driver

What is an "ACPI driver"?  (AFAIK, ACPI is built into the BIOS of a
system and interpreted by the OS; I've never heard of an ACPI driver.)

Is there any hardware for which ACPI actually provides the same level of
information that "legacy" access does?  Every system I've dealt with
over the last few years provides a single temperature reading via ACPI
(generally CPU surface temperature) -- no other temperatures, no fans,
no voltages.  Am I buying the wrong stuff?

Just wondering ...

-- 
====================================
Ian Pilcher                                         arequipeno@gmail.com
"If you're going to shift my paradigm ... at least buy me dinner first."
====================================


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
