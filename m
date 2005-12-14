From: mrenzmann@otaku42.de (Michael Renzmann)
Date: Wed, 14 Dec 2005 16:53:23 +0000
Subject: [lm-sensors] Backport of lm77.c for 2.4.x
Message-Id: <1134579204.4459.189.camel@gimli>
List-Id: <lm-sensors.vger.kernel.org>
References: <1134463317.4459.36.camel@gimli>
In-Reply-To: <1134463317.4459.36.camel@gimli>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi.

On Tue, 2005-12-13 at 21:08 +0100, Jean Delvare wrote:
> > Currently I think of putting Tmin, Tmax and T into the "temp" proc file,
> > and:
> > a. Tcrit and Thyst into two distinct files, or
> > b. Tcrit and Thyst into one file.
> > 
> > Suggestions?
> I'm fine with this proposal, with a preference for option (b).

I decided to choose option (a) nevertheless. I felt that having Tcrit
and Thyst might lead to confusions, making users think that Thyst is
only related to Tcrit, for example. The driver therefore currently has
the following proc files: temp, temp_crit, temp_hyst and alarms.

> My personal opinion is that this kind of tuning should be done by the
> BIOS, as the system manufacturer should know whether the fault queue is
> needed for the hardware combination used and the expected conditions of
> the system.

Agreed.

On the other hand WRAPs don't offer BIOS support for this feature. I'm
not sure if it is needed at all, but it might still be handy for some
people out there. I made it a compile time decision: when
LM77_FAULT_QUEUE is defined, the fault queue will be enabled on every
chip (LM77 only, of course) the driver takes care of. By default that
feature is turned off.

Do you think this is an acceptable compromise?

> to work on this. I have no idea how difficult this would be. Please
> realize that hardware monitoring is a risky area when it comes to
> stopping chips. Any hardware monitoring chip can virtually be used to
> control the cooling of the system.

Oh, yes, indeed. I didn't think of that before, when I introduced
shutting down the LM77 once the driver is unloaded. In case of the WRAPs
one would expect that the "pull reset when Tcrit is reached" feature is
working even without the driver being loaded (anymore). I removed
shutdown mode support.

> I also wonder if the power consumption of these chips is high enough to
> simply care about it.

Good point :)


Well, it seems that the backport is done then. I'll test the driver a
bit more locally. If I don't find any further problems/bugs, I'll send
it to the list during the next days.


Another question: which is the right place to talk about the scx200_acb
driver? I've done some modifications of the version that can be found in
Kernel 2.4.32 so that it correctly recognizes and handles SC1100-based
systems as well - 2.6.x handles this correctly, but 2.4.x only probes
for SCx200-type systems.

Bye, Mike


