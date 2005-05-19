From: mistercool@adelphia.net (Bruce Miller)
Date: Thu, 19 May 2005 06:23:52 +0000
Subject: sensors-detect patch
Message-Id: <3E937EA9.7090506@adelphia.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Sensor guys;

I hope this is an acceptable way to post a (possible) patch.
lm_sensors' sensors-detect is failing to detect my w83781d,
but a simple change fixes it.

I'm a little confused by the differences in the versions I've got
handy:  I've installed RedHat Linux 9, which includes lm_sensors
2.6.5-5, in which sensors-detect has the subroutine:

sub outb
{
  my $towrite = pack "C", ($_[1] & 0xff);
  ...

I also had a version 2.7.0 floating around on my disk, which has
as the 1st line:
  my $towrite = pack "C", $_[1];
without any masking.  That looks like a regression (and causes perl
to complain about `wrapping' a character) or perhaps RH modified thier
version to elliminate the message.

At any rate, I'm guessing that
  my $towrite = pack "C", ($_[1] & 0x7f);
is more appropriate. (ie. masking the high bit as well).
At least, that enables sensors-detect to detect my hardware (hopefully)
correctly.

Hope this helps; and Thanks for a really useful package!

Bruce
