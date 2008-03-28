From: Matt Roberds <mattroberds@cox.net>
Date: Fri, 28 Mar 2008 01:52:59 +0000
Subject: Re: [lm-sensors] sensors.conf question
Message-Id: <Pine.LNX.4.64.0803272049110.2934@birdbird.example.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <47EA7AB3.4000701@givemefish.com>
In-Reply-To: <47EA7AB3.4000701@givemefish.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 26 Mar 2008, www.givemefish.com wrote:
> The output from the sensors command lists 8 temperatures (temp1 -
> temp8).  Having searched the sensors.conf file, I find nowhere where
> temp8 is listed.  I don't see anywhere that appears to correspond to
> the temp1 - temp8 label lines.

These names are generated in the driver, "before" sensors.conf gets at
the data.  Once you know which one is which (see below), you can set
labels in sensors.conf like

label temp1 "CPU temp"
label temp2 "Beer fridge temp"

etc.

> I'm not sure what these temperatures correspond to.

You have to have documentation from your motherboard manufacturer to
know for sure.  Failing that, if the BIOS displays the temperatures, you
can compare the readings you get there to the readings that sensors
gives you to figure out which one is which.  If you have multiple CPUs
or multiple cores, and have the ability to run a CPU-intensive program
on only one CPU or core, you can do that and see which temperature goes
up significantly.

Matt Roberds


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
