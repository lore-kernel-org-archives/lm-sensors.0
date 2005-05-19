From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:40 +0000
Subject: two small questions when compile lm_sensors
Message-Id: <F0CC4AHh.1109319741.9408490.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <FF9D611BFCDB1E42B37FAA148096BECE24564F@weshml03.winbond.com.tw>
In-Reply-To: <FF9D611BFCDB1E42B37FAA148096BECE24564F@weshml03.winbond.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Chunhao,

> Question 1:
> Error appears when compile the module kernel/chips/bmcsensors.o
>
> The message is attached in this mail. The strange thing is that:
> I remember that when I compiled lm_sensors-2.9.0 for the first time
> (right after installed my Redhat9), this error did NOT appear.

This is a known bug in lm_sensors 2.9.0, which has since been fixed in
CVS.
http://archives.andrew.net.au/lm-sensors/msg28802.html

The reason why you did not have the error at first is that the bmcsensors
module is only compiled if the underlying kernel has IPMI support. Maybe
your original kernel didn't have. I never included IPMI support myself
so far (I don't need it) which is why the compilation error slipped
into 2.9.0 without me noticing. Now I do include it but just in order to
find out compilation errors before we release.

> Now, I have to comment out the module bmcsensors from the file
> kernel/chips/Module.mk

That's OK then, as you don't really need that driver anyway.

> Question 2:
> Occasionally, when I compiled lm_sensors-2.9.0(or i2c-2.9.0), it took me
> very long time(maybe several hours) to finish compiling. The "*.d" files
> in lm_sensors-2.9.0/kernel/chips/ (or i2c-2.9.0/kernel/*.d) were
> produced(refreshed) again and again.
>
> When I interrupt the compile, this phenomenon sometimes continues, or
> disappear: once, I re-compile it on the second day, this strange
> phenomena disappeared.
>
> I can not find the reason about it, Can you?

Yeah, I remember similar reports about the CVS version. This was caused
by a misproperly configured clock. If your clock is set in the past,
make is not able to satisfy dependancies and might loop forever. When
this happens, just check that the clock is correct and that no file in
the lm_sensors tree has time in the future.

Hope that helps,
--
Jean Delvare
