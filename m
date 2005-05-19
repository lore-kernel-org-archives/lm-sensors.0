From: ajohnson@lastaccess.com (Andrew D. Johnson)
Date: Thu, 19 May 2005 06:25:02 +0000
Subject: PC87366 with the net4801
Message-Id: <1088302042.5b1pl2m0dzb4@lastaccess.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200406240822.i5O8M634041403@zone3.gcu-squad.org>
In-Reply-To: <200406240822.i5O8M634041403@zone3.gcu-squad.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri 25 Jun 2004 08:15:57 AM CDT Jean Delvare <khali@linux-fr.org> said:
> OTOH, if you receive a similar message when reconfiguring the Super-I/O
> chip (command starting with "isaset 0x2e 0x2f"), then this is *not* OK
> and you'll have to report to me.

Ok, that went fine... but unfortunately the results aren't much better now. As
usual, I've attached the command output.

> >The configuration file I'm using is a slightly tweaked version of something
> >you had posted to a mailing list. I'll attach it. Below is the output I see
> >from sensors using it. It obviously still needs some tweaking. Some of the
> >voltage calculations must be inappropriate in this case.

I'm now back to using the default configuration file, tweaked slightly (ignoring
fans now, for instance). It's also included in the attachment.

> >Is Soekris going to have to let us know how the voltage inputs are wired
> >before we can have any idea what these represent?
>
> Yes, definitely. There's nothing we can do without them telling us what
> each voltage channel is supposed to measure, and which resistors are in
> use.

Okay, I'm going to compose an email to them concerning what information is
needed. What more is needed for proper temperature monitoring, if anything?

> BTW, do you have an idea on what the Vcore for your CPU is supposed to be?

The processor is a NS Geode SC1100. I've googled around for a few minutes, but
I've not yet been able to figure out what the core voltage is. That'll be
another question in my email to Soekris.

Btw, I am using the newer version of the driver, now.

Thanks much,

--
Andrew D. Johnson
PGP Fingerprint: 77BD 80B1 4918 1D98 9EBF 2E62 073B 9B31 A1DC 41F4
KeyID: 0xA1DC41F4
-------------- next part --------------
A non-text attachment was scrubbed...
Name: output.txt.gz
Type: application/x-gzip-compressed
Size: 1339 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040626/23e50fa3/output.txt.bin
