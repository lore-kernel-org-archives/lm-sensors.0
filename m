From: Matt Roberds <mattroberds@cox.net>
Date: Sat, 16 Aug 2008 00:17:08 +0000
Subject: Re: [lm-sensors] Single Sensor Check
Message-Id: <Pine.LNX.4.64.0808151859110.28092@birdbird.example.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <06d401c8ff06$1103d690$330b83b0$@com>
In-Reply-To: <06d401c8ff06$1103d690$330b83b0$@com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 15 Aug 2008, sensored@CubicC.com wrote:
> Hello, all!  I need to add a check for an alarm to a single sensor in
> my C program, and I'd like to do so without the overhead of calling
> out to an external program and parsing its output (plus all the
> error-checking, etc.).

Assuming a Unix-ish environment: write a script (in shell, Perl, etc)
that calls sensors for you, parses the output, and creates a short file
with the information you need.  Put the script in cron, and/or have it
run continuously.  In your C program, read in the short file (whose
format you control) and act on it appropriately.  Add checking to avoid
race conditions, etc, but also remember that most sensors and alarms
don't update all that fast; if it really does matter if you catch the
alarm now or 2 seconds from now, you need a different approach.

> I have been having some issues compiling lm-sensors (so that I can
> step through with a debugger), so perhaps you can help me short-circuit
> this process a little:

You should be able to run the sensors-detect script in the lm-sensors
package without compiling the entire package; this should at least tell
you if the sensor chip you have is supported.

> Is there a way to read the value of a sensor (all it throws is ALARM or
> nothing) from somewhere (e.g. in a protected area of memory)?

Yes.  This is 100% dependent on the hardware you are using and will even
change between different revisions of a particular motherboard.  If you
have control over what hardware is used, then get the data sheet for the
sensor/monitoring chip being used and read it; it should describe how to
access the chip.  If there is an lm-sensors driver for that chip, look
at it as well to see what you need to do.

Matt Roberds


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
