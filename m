From: michel@bouissou.net (Michel Bouissou)
Date: Mon, 11 Jul 2005 12:19:11 +0000
Subject: [lm-sensors] Fwd: [Bug 16755] [lm_sensors] ASSIGNED: [PATCH] Bad
Message-Id: <200507111217.35037@totor.bouissou.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <200507111118.03565@totor.bouissou.net>
In-Reply-To: <200507111118.03565@totor.bouissou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Le Lundi 11 Juillet 2005 11:41, Jean Delvare a ?crit :
> Salut Michel,

Salut :-)

> Unfortunately your report isn't as complete as it would need to be for
> us to help you. We would need to know:

So I'll try my best ;-)

> * Which version of the Linux kernel you are using.

That's a 2.6.12-3mib3v ;-) which means a custom compilation of the Mandrake's 
cooker 2.6.12-3

Let me add immediately that I have always had the same lm_sensors "double 
initialization needed problem" since I have this board (Gigabyte GA7-VAXP), 
and thru each and every version of 2.4.x or 2.6.x kernels, and every version 
of lm_sensors I ran on it, for a long time... I had just been too lazy to 
report the problem before, but this problem is not related to this precise 
kernel...

> * If this kernel has patches applied which could affect the i2c subsystem
> or the it87 driver, we need to know which they are and what they do.

Well, being a Mandrake kernel, it includes a number of patches from Mdk, which 
complete list I'm not aware of...

> * Which version of "sensors" and "libsensors" you are using.

These are Mandrake RPMs, I suppose the version is accurate...:
[root@totor etc]# rpm -qa | grep -i sensors
liblm_sensors3-devel-2.9.0-4mdk
lm_sensors-2.9.0-4mdk
liblm_sensors3-2.9.0-4mdk

> * If lm_sensors has patches applied, we need a list.

Uh... I'll try to get one from the source RPMs if you think it's absolutely 
necessary ;-))

> * What is your it87-compatible chip? IT8705? IT87012F? Which revision, if
> you happen to know? Is it accessed through the SMBus or as an ISA device?

ITE - IT8705F is written on the chip itself. lm_sensors accesses it thru the 
ISA bus.

> * The complete sensors initialization script used.

Please see attached. It's Mandrake's one... Just with my patch to call 
"sensors -s" a 2nd time if there are alarms.

> * Which limits exactly don't get set by the first "sensors -s"? All?

As far as I noticed, only the fans RPM thresholds are concerned.

> Please provide the output of "sensors" before the first "sensors
> -s", after the first "sensors -s" and after the second "sensors -s".

I don't have them on hand, but what I can tell from memory is that after the 
1st "sensors -s", the fans RPM thresholds are set to 5100+ something RPMs, 
which doesn't correspond at all to what I have in sensors.conf.

After the 2nd "sensors -s", they are set properly.

Here's the output of "sensors" with everything set properly here:

[root@totor etc]# sensors
lm90-i2c-0-4c
Adapter: SMBus Via Pro adapter at 5000
LM90 T?:     +48?C  (low  =   +15?C, high =   +60?C)
Athlon T?: +50.8?C  (low  = +15.0?C, high = +70.0?C)
LM90 Crit:   +70?C  (hyst =   +60?C)
CPU Crit:    +80?C  (hyst =   +70?C)

it87-isa-0290
Adapter: ISA adapter
CPU core:  +1.74 V  (min =  +1.66 V, max =  +1.84 V)
DDRAM:     +1.22 V  (min =  +1.17 V, max =  +1.33 V)
3v3 I/O:   +3.23 V  (min =  +3.14 V, max =  +3.47 V)
+5V:       +5.04 V  (min =  +4.76 V, max =  +5.26 V)
+12V:     +11.97 V  (min = +11.39 V, max = +12.61 V)
-12V:     -11.11 V  (min =  -7.17 V, max = -16.76 V)
-5V:       -6.28 V  (min =  -2.48 V, max = -10.02 V)
Stdby:     +5.09 V  (min =  +4.76 V, max =  +5.26 V)
CPU Fan:  2057 RPM  (min = 1599 RPM, div = 4)
BOX Fan:  1318 RPM  (min =  897 RPM, div = 8)


> * Anything in the logs?

Nothing special is visible when starting lm_sensors, but my kernel logs the 
following during its boot sequence:

it87: Found IT8705F chip at 0x290, revision 2
it87 1-0290: Detected broken BIOS defaults, disabling PWM interface

(What does this mean, btw ?)

> Please keep in mind that this is *expected* that reported alarms won't
> disappear immediately after changing the limits. You will always see
> them once after that, per chip design (you must not miss once-only
> alarms).

I understand, but what I observe prove that it's the thresholds that don't get 
set correctly as first "sensors -s" call, so it's not just an alarm 
problem...

Cheers.

-- 
Michel Bouissou <michel@bouissou.net> OpenPGP ID 0xDDE8AC6E
-------------- next part --------------
A non-text attachment was scrubbed...
Name: lm_sensors.gz
Type: application/x-gzip
Size: 1168 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050711/5bfcebc3/lm_sensors.gz
