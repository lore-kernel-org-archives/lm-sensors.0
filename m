From: Trent Piepho <tpiepho@freescale.com>
Date: Sat, 20 Sep 2008 00:56:38 +0000
Subject: Re: [lm-sensors] lost alarms with it87
Message-Id: <Pine.LNX.4.64.0809191613550.3476@t2.domain.actdsltmp>
List-Id: <lm-sensors.vger.kernel.org>
References: <efa7127e0809191511q36658c1bse469db9d76e46127@mail.gmail.com>
In-Reply-To: <efa7127e0809191511q36658c1bse469db9d76e46127@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 20 Sep 2008, Hector Lahoz wrote:
> Ok, we won't use interrupts. Now, I'd like to have some kind of signal
> that warns about CPU going above max temperature. For example, through
> sensord. But the problem is that some seconds after the alarm is
> triggered the ALARM message of sensors does not appear any more.
> Shouldn't the alarm bit remain set until it is read? And if it's only
> read by show_* functions (i.e. it87_update_device() ), why does it go
> away?

It might depend on how the device is programmed.  For example, with the LM63
in it's default alarm mode (which the driver neither checks nor sets), alarms
work like this:

When an alarm condition occurs the bit in the alarm register is set.  It
remains set until the register is read.  It whatever condition caused the
alarm goes away, it still says set.

When the alarm register is read, it is cleared (and the alert# IRQ pin is
disabled).  It doesn't matter if the condition still exists or not, the
register is always cleared.

When the chip does its next temp conversion, which it does automatically 16
times per second by default, it will again set the alarm bit in the register
if the condition still exists.  However, the alert# pin will remain disabled. 
It needs to be turned back on manually, which the driver doesn't do.

If something besides the lm63 driver (like i2cdump or ACPI) reads the alarm
register before the driver does then the driver might not see the alarm.

The LM63 can be put into alarm comparator mode.  In this mode the alarm bit
remains set after the register is read.  If the condition no longer exists
after a temp conversion, the bit is cleared, even if the register hasn't been
read yet.  In this mode it's not possible to not see an alarm if it exists
when the driver checks, but it's also not possible to see an alarm for a
condition that no longer exists.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
