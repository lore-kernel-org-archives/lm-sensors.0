From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:03 +0000
Subject: PC87366 with the net4801
Message-Id: <200406280836.i5S8aexf097012@zone3.gcu-squad.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200406240822.i5O8M634041403@zone3.gcu-squad.org>
In-Reply-To: <200406240822.i5O8M634041403@zone3.gcu-squad.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


(Voluntarily not CCing the Soekris list, since your questions not related)

>This is somewhat off topic, but I thought I should mention it. I'm assuming
>that lm sensors uses the min and max settings to configure the chip so that
>it will return an alert status when a reading is outside the specified
>range.

Correct.

>How about a mode (command line switch, perhaps) that simply compares the
>readings with the min and max settings and prints the ALARM status
>appropriately, without any dependence on the chip? In cases like this
>where the critical limits don't really work properly, this would simplify
>shell scripts and other programs that depend on ALARM being there.

The case of the PC87366 is rather isolated, most chips work properly. I
don't really feel like rewriting in software what belongs to hardware
and is correctly implemented by 95% of the chips our there.

Also consider that the problem is not only to change the conditions in
which we print "ALARM" in sensors. Since you cannot use the critical
temperature registers of the PC87366's thermistor channels, for example
(else it'll trigger bogus hardware alarms, which in turn can trigger
actions), this means that you would have to store the "software
critical limit" in a different place. This means that not only
"sensors" but the driver would need to be reworked, and this isn't
going to happen (simply because I don't see how this would fit in the
common chip interface we designed). Another possibility would be for a
GUI sensors-like program to allow the user to add arbitrary software
limits to just about any measured value. The command-line "sensors"
program can hardly do that since it's a one shot program (unless we go
on with am additional configuration file for this kind of problem, but
frankly it doesn't sound worth it).

>Along this vein, why isn't it already being done this way? I'm not asking to
>be a smartass -- I'm sure there are some very good reasons for it. For
>example, I suppose some chips might use these critical limits to trigger an
>audible alert.

You're correct, alarms can trigger audible alerts, but not only that.
They can alter fan speeds, change CPU speeds or modes, generate
interrupts, power the system down, etc... It really depends on the chip
and how it is wired. For this reason it is important to present hardware
alarms to the user.

Second, as said earlier, why would we reprogram in software what most
chip do pretty well in hardware? Not only it's a waste of time and
energy, but hardware alarms are safer because they are sampled
continuously, not only when one runs "sensors".

Another feature of hardware alarms is that you cannot miss them. Most
chips remember alarms until they are read at least once. Admittedly it
confuses the newcomers because you can see alarms for conditions that
have already gone. But it definitely helps confirmed users to know that
such conditions happened and may have triggered hardware actions.

>Or perhaps there already is such a thing and I just don't know about it :)

No, there is no such thing.

Jean Delvare
