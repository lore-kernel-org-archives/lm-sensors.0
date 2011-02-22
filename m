From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 22 Feb 2011 21:19:45 +0000
Subject: Re: [lm-sensors] [PATCH v4 00/10] hwmon: (w83627ehf) Add support
Message-Id: <1298409585.24938.343.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1297712143-7431-1-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1297712143-7431-1-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Ian,

On Tue, 2011-02-22 at 13:31 -0500, Ian Dobson wrote:
> 
> --------------------------------------------------
> From: "Guenter Roeck" <guenter.roeck@ericsson.com>
> Sent: Tuesday, February 22, 2011 5:16 PM
> To: "Jean Delvare" <khali@linux-fr.org>
> Cc: "Ian Dobson" <i.dobson@planet-ian.com>; "Andy Lutomirski" 
> <luto@mit.edu>; "Randy Dunlap" <rdunlap@xenotime.net>; 
> <binximeng@gmail.com>; <lmsensors@tapanitarvainen.fi>; 
> <andrea.rizzolo@gmail.com>; <jeff.sadowski@gmail.com>; 
> <lm-sensors@lm-sensors.org>; <linux-doc@vger.kernel.org>
> Subject: Re: [PATCH v4 00/10] hwmon: (w83627ehf) Add support for NCT6775F 
> and NCT6776F
> 
> > On Mon, 2011-02-14 at 14:35 -0500, Guenter Roeck wrote:
> >> The following patch series adds support for NCT6775F and NCT6776F to the
> >> w83627ehf driver. It also includes some cleanup and adds support for
> >> the fourth temperature sensor on W83677HG-B.
> >>
> >> v4:
> >> - Store rpm instead of raw fan speed readings
> >> - For NCT6775F, increase fan divisor if the fan speed reads 0
> >>   [ On NCT6775F, fan speed readings can return 0 instead of 0xff if the
> >>     fan divisor value is too low ]
> >> - Separate changes into more patches to simplify review
> >>
> >> v3:
> >> - Documentation: Remove references to datasheets which no longer exist
> >> - Documentation: Add information about limits of SmartFan IV support.
> >> - SmartFan III mode is not supported on NCT6776F, so remove related 
> >> attributes
> >>   and refuse to configure it.
> >> - (additional patch) Improve support for chips with 16-bit fan count 
> >> registers
> >>
> >> v2:
> >> - W83677HG-B does share the AUXTIN/VIN3 pin, so we can not skip this 
> >> check.
> >> - Cosmetic changes to fix a couple of checkpatch errors and to undo some
> >>   unnecessary formatting changes in patch 5.
> >> - Patch 1 introduced a bug in temp_to_reg which was fixed in a later 
> >> patch.
> >>   Modified code to not introduce the bug in the first place.
> >> - Two dev_dbg messages were changed to dev_info for testing. Changed back
> >>   to dev_dbg.
> >>
> >> The patched driver can be downloaded as stand-alone driver from
> >> http://www.roeck-us.net/linux/drivers/w83627ehf/
> >
> > Feedback, anyone ?
> >
> > Even if you don't have time to review the code, a "Tested-by" would be
> > appreciated as well.
> >
> > Thanks,
> > Guenter
> >
> >
> 
> Hi Guenter,
> 
> You can add a tested by ian dobson (i.dobson@planet-ian.com) for a nct6776f 
> on a Asus p8p67 pro
> 
Thanks!

> I've also looked at the code, although I'm not a long term kernel hacker I 
> understand/program in C and various other languages for my job and I've not 
> seen anything major wrong with the code, so a Reviewed by might also be 
> accepable. Note I'm still running a patched version with the 1.5 second 
> caching disabled.

If you see something minor in the code which you think might be
improved, please let me know. It doesn't have to be a major issue.

> I had a look at the tacho signal from the CPU fan with my oscilloscope and 
> sometimes I see a small dropout during high part of the signal. The signal 
> doesn't drop to 0, just about 30-50%. Do you know the switching point for 
> tacho signal? In the documentation they talk about a TTL signal so low is 
> below 20% and high is over 50% and the fan is outputting as signal in the 
> "undefined area" every so often.
> 

min/typ/max:

Input Low Threshold Voltage Vt- 0.5 0.8 1.1 V
Input High Threshold Voltage Vt+ 1.6 2.0 2.4 V
Hystersis VTH 0.5 1.2 V

How long is the dropout time ? 

Maybe you can check control register F0h (FANIN de-bouncer Register) in
Logical Device B. Bit 1..5 reflect sysfanin, cpufanin, auxfanin0,
auxfanin1, and auxfanin2. Bit is 1 if the de-bouncer is enabled, 0
otherwise. If it is not enabled on your system, maybe you can enable it
and see if it makes a difference.

Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
