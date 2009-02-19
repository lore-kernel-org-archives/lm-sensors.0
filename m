From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 19 Feb 2009 17:42:43 +0000
Subject: Re: [lm-sensors] [RFC] Support of chassis intrusion detection
Message-Id: <20090219184243.45d64553@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090217230215.5106b6c0@hyperion.delvare>
In-Reply-To: <20090217230215.5106b6c0@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Matt,

On Thu, 19 Feb 2009 07:00:23 -0600 (CST), Matt Roberds wrote:
> On Wed, 18 Feb 2009, Jean Delvare wrote:
> > On Wed, 18 Feb 2009 07:20:34 -0600 (CST), Matt Roberds wrote:
> 
> > The question is, what point would there be in having more than one
> > chassis intrusion detector?
> 
> This is only hypothetical - I haven't seen a case with more than one
> switch.  Having said that: I *have* used a rackmount server case that had
> a lockable door on the front that covered the drive bays.  If you wanted
> to add or remove hardware, though, you had to slide the case out of the
> rack on its rails, and remove the top of the case.  I could see somebody
> wanting to have two switches: one on the drive bay door and one on the
> top.  In normal operation, maybe somebody comes along every so often and
> swaps a CD/DVD or something, so you want a notification or maybe a
> warning when the drive bay door is open.  But nobody is supposed to be
> taking the top off of the case, so you want to scream and stop the world
> when the top of the case is open.  (On the other hand, who switches
> disks anymore?  Get your updates from the network, and have a backup
> server instead of local backups.)

That's an interesting scenario, thanks for pointing it out. This
probably justifies that we go for intrusion0_alarm instead of
chassis_intrusion_alarm.

> (...)
> > The point which makes me reluctant to go for multiple inputs is how
> > we are going to handle clearing them with "sensors". Should "sensors
> > --clear-intrusion" clear them all? Or do we need to provide a
> > parameter specifying which intrusion detector needs to be cleared?
> 
> Is it possible for sensors to know how many there are?

Yes, with a non-trivial amount of code. Currently, sensors processes
inputs on the fly. If we want to change its behavior based on the
number of inputs of a given type, we either have to do two passes, or
we have to store the values first, then decide, and then do something
with the values.

> (...) That way, if
> there's just one, "sensors --clear-intrusion" just clears that one,
> but if there's more than one, it says "error: which one do you want?"

We could indeed do that. We would have to come up with a way to
uniquely identify each inputs, but this can be done (and would be
needed for other reasons anyway.)

> Or maybe --clear-intrusion, by default, always clears the "first"
> sensor found, only clearing a different one if given an argument.

I am not a big fan of optional arguments to command line parameters.
These tend to make command lines ambiguous.

> (This might lead to surprises if the sensors get enumerated in a
> different order with a reboot or new driver or whatever.)

Well, there are two different possibilities here: two chips each with
one intrusion detection input, and one chip with two intrusion
detection inputs. In the former case, the order might indeed change,
which is why I mentioned the need for a way to uniquely identify
inputs. In the latter case, the order will never change for a given
chip, however it could change from one chip to the next, which could be
inconvenient for admins.

All in all this discussion tends to underline the lack of uniform way
to query sensor information from one board to the next. But this is a
vast problem, to be solved later.

Note that my idea of "sensors --clear-intrusion" is what came out of my
mind first, but this might not be the best idea. Maybe we instead want
to have a dedicated tool for reporting and clearing intrusions. Or have
both: "sensors --clear-intrusion" clears all flags and is meant for the
simple cases, and if we need something finer-grained we write a
dedicated tool.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
