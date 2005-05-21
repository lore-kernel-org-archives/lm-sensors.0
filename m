From: Darth_Sebulba05@phreaker.net (Chris J. Friesen)
Date: Sat, 21 May 2005 19:43:25 +0000
Subject: [lm-sensors] Asus K8N-DL & lm-sensors
Message-Id: <20050521134235.7826f985@Sebulba02>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,
  I have recently tried to get lm-sensors working on my new Asus K8N-DL and
with the help of ruik on irc, we have been able to find the 792 chip.

It seems to detect the voltages alright, but the fans and temperature come up
as zero.

CPU Fan:     0 RPM  (min =    0 RPM, div = 128)              ALARM  (beep)

Attached are my lspci, sensors-detect and /proc/ioports.

Its running Debian with lm-sensors 2.9.1, kernel 2.6.8 .

Thanks for the assistance,
  Chris

-- 
Public Key:
http://darthsebulba.is-a-geek.org/Key/Darth_Sebulba05-at-phreaker-net_pub.key
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 307 bytes
Desc: not available
Url : http://lists.atrpms.net/pipermail/lm-sensors/attachments/20050521/c22c9a69/attachment.bin
