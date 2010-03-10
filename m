From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 10 Mar 2010 15:07:02 +0000
Subject: Re: [lm-sensors] Wrong temperatures reported for Core2Duo CPU in
Message-Id: <20100310160702.025dd476@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <781687b2e6d2a27726f35a316f5bf821.squirrel@webmail.nodivisions.com>
In-Reply-To: <781687b2e6d2a27726f35a316f5bf821.squirrel@webmail.nodivisions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Hi Anthony,

On Tue, 9 Mar 2010 18:28:10 -0800, lmsensorslist@nodivisions.com wrote:
> Hello,
> 
> I have an Intel DG965WH motherboard with an Intel Core2Duo CPU which seems
> to report incorrect core temperatures:
> 
> $ sensors
> coretemp-isa-0000
> Adapter: ISA adapter
> Core 0:      +74.0°C  (high = +86.0°C, crit = +100.0°C)
> 
> coretemp-isa-0001
> Adapter: ISA adapter
> Core 1:      +73.0°C  (high = +86.0°C, crit = +100.0°C)
> 
> ~75C is the idle temperature; when the CPU is busy it's more like 85C, and
> sometimes even 90C+.  I think this is wrong because a) that just seems
> insanely high; b) the CPU heatsink is warm, not hot, to the touch; and c)
> it's been running like this almost 24/7 for about 3.5 years, which I doubt
> it would have survived if it were really that hot.  I also have 2 hard
> disks in this PC which report ~32C and ~41C (from the hddtemp command)
> which seems much more reasonable.

The value is reported by the CPU itself. The coretemp kernel driver is
just passing it through. While the value is reported relative to the
critical limit, and we have had this critical limit wrong for some
models in the past, this is irrelevant here: the fact is that your CPU
runs over its high limit when loaded. I've never seen any Intel Core2
CPU reaching such a high temperature. This can mean only 2 things:
* You happen to have a CPU with defective thermal sensors. The fact
  that both cores agree makes me skeptical, but then again, as I have
  no idea how the internal sensors could go wrong, it might as well
  happen to both sensors at once.
* Your heatsink and fan are not doing their job properly. This is my
  favorite theory at this point.

I would not be surprised that the CPU survives 3.5 years at these
temperatures. You are still below the critical limit.

Hard disk drive temperature is a totally different thing. Assuming
there is some space between the CPU and the HDD (and there always is on
a desktop board) there is no reason for these temperature to match.

> I originally had the Intel heatsink+fan on there, and then I switched to a
> Rosewill RCX-Z300, which is supposed to be cooler and quieter.  But either
> way the reported temperature is super high.  I'm also confident that
> there's good contact from the heatsink to the thermal compound to the CPU,
> so I don't think that's an issue.

This is the most likely problem though.

> The main reason this bothers me is that the CPU fan is always running
> really fast and thus is really loud.  This drives me crazy.  Over the
> years I've tried several times to solve this, to no avail; and supposedly
> something from Intel was always just around the corner -- is the new Intel
> QST SDK something that might help?  The "sensors" output above is the full
> output from that command, so I believe my motherboard/chipset is just not
> well supported at all, which I gather is due to this heretofore-secret
> Intel stuff.

The QST SDK might let us provide support for motherboard sensors, but
this will not change the values reported by the coretemp driver. Best
you can hope is extra temperature sensors for comparison purpose.
However, as for the HDD temperature sensors, sensors placed on a
different location on the motherboard don't tell you much about the CPU
temperature.

What you can do is check the temperatures reported by the BIOS. It's
difficult to know where the BIOS gets the values from, though...

> (...)
> If anyone can shed any light on this, in particular how I can get the fan
> to spin slower or (even better) get these temperatures to be correct, I
> would really appreciate it.

Fan control is not possible with only the coretemp driver, sorry. You
might look in the BIOS options for an automatic fan speed control
option, but given how hot your CPU already is, I wouldn't dare enabling
it.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
