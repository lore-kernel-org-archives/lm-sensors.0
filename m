From: ajohnson@lastaccess.com (Andrew D. Johnson)
Date: Thu, 19 May 2005 06:25:03 +0000
Subject: PC87366 with the net4801
Message-Id: <1088379356.1ypc0qo0i1uo@lastaccess.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200406240822.i5O8M634041403@zone3.gcu-squad.org>
In-Reply-To: <200406240822.i5O8M634041403@zone3.gcu-squad.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun 27 Jun 2004 03:29:00 PM CDT Jean Delvare <khali@linux-fr.org> said:

> 3* You'll notice that critical limits on thermistors don't make any
> sense. If you try to set them to a reasonable value, it'll trigger
> alarms. I think it's due to a design error by National Semiconductor,
> but they didn't come back to me about this. I plan to plain discard this
> "feature" from the driver since it's likely to bring more trouble to the
> users than help them.

This is somewhat off topic, but I thought I should mention it. I'm assuming that
lm sensors uses the min and max settings to configure the chip so that it will
return an alert status when a reading is outside the specified range.

How about a mode (command line switch, perhaps) that simply compares the
readings with the min and max settings and prints the ALARM status
appropriately, without any dependence on the chip? In cases like this where the
critical limits don't really work properly, this would simplify shell scripts
and other programs that depend on ALARM being there.

Along this vein, why isn't it already being done this way? I'm not asking to be
a smartass -- I'm sure there are some very good reasons for it. For example, I
suppose some chips might use these critical limits to trigger an audible alert.

Or perhaps there already is such a thing and I just don't know about it :)

--
Andrew D. Johnson
PGP Fingerprint: 77BD 80B1 4918 1D98 9EBF 2E62 073B 9B31 A1DC 41F4
KeyID: 0xA1DC41F4
