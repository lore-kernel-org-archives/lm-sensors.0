From: david_knierim@earthlink.net (David Knierim)
Date: Thu, 19 May 2005 06:25:16 +0000
Subject: Data block transactions fail on i2c-i801 controller?
Message-Id: <13938324.1095712833883.JavaMail.root@scooter.psp.pas.earthlink.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi,
   I'm working with server based on Intel 7520 (Lindenhurst) chipset.   This uses the i2c-i801 bus driver.   An lm93 is attached to this bus.    If I load the lm93 in it's default mode, which "allows SMBus block data transactions if the host supports them", it takes a long time for sensors to run.   This is the output of "time":
real    0m10.901s
user    0m0.010s
sys     0m0.010s

If the lm93 is loaded with it's disable_block mode, which disables data block transactions, the operation is much faster:
real    0m1.261s
user    0m0.010s
sys     0m0.010s


In both cases, there are no errors logged to dmesg or /var/log/messages.   The output is correct in both cases.   The data block transaction mode just takes a lot longer to complete.


Any ideas??

David
