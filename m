From: bhayward@gmail.com (Brian Hayward)
Date: Thu, 16 Mar 2006 07:33:44 +0000
Subject: [lm-sensors] DFI Lan Party SLI-DR Expert shuts off when it87 is
Message-Id: <a33b5feb0603152333t5f7dcc28i24b235e39d595706@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

First off, when running sensors-detect, if I select "yes" for the next
question, the computer turns off.
Next adapter: SMBus nForce2 adapter at 1c40
Do you want to scan it? (YES/no/selectively):

The computer just powers down, as if I turned the switch off.  No warning or
anything.

If I select NO to the 1c40 nForc2 option and then YES to all others - the
computer does not power off until I modprobe it87.

I've tried:
   modprobe it87
   modprobe it87 force_it87=9191,0x290
Same problem either way, immediate shutdown.

Checking the messages file after bootup, these are the last entrys before
the shutdown:

Mar 16 01:13:14 kobold kernel: i2c /dev entries driver
Mar 16 01:19:09 kobold kernel: it87: Found IT8712F chip at 0x290, revision 7

Then I get messages from booting back up.

If I load all suggested modules _except_ it87, it does not shut down and it
also does not show any CPU/Fanspeed redouts when I type "sensors".

Do you have any suggestions?

Thanks,
Brian Hayward
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060316/=
d289f03b/attachment.html
