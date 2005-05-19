From: morris@wolfman.com (Jim Morris)
Date: Thu, 19 May 2005 06:23:58 +0000
Subject: soloution to tickets 1263 & 1223
Message-Id: <3EE39074.8020804@wolfman.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This seems to happen on newer perl versions. It is fatal in as much as 
the sensors are not detected. The solution appears to be to simply add & 
0x7f to the pack statement at line 1138 of sensors_detect...

sub outb
{
   my $towrite = pack( "C", $_[1] & 0x7f);


hope this helps
