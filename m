From: david_knierim@earthlink.net (David Knierim)
Date: Thu, 19 May 2005 06:25:29 +0000
Subject: Error loading lm93
Message-Id: <41DDA457.3040502@earthlink.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,
    I have a box running Red Hat 9, i2c 2.9.1 and lm_sensors 2.9.0.  I 
have also verified that I have this same issue with the lm_sensors 
version from CVS downloaded October 25, 2004.   This box has an LM87 at
i2c location lm87-i2c-0-2d and an lm93 at i2c location lm93-i2c-0-2e.

If I load the lm93 driver but not the lm87 driver, the following message 
is logged by dmesg:
lm93.o version 2.9.0 (20041228)
lm93.o: disabled SMBus block data transactions
lm93.o: detect failed, bad manufacturer id 0x02

When I run sensors, a message that no sensors are found is printed.

I can do an i2cdump of the lm93 and the manufacturer ID (at location 
0x3e) is 0x01.  A dump of the lm87 shows 0x02 at location 0x3e.

I unloaded the lm93 driver and loaded the lm87 driver.   Then the lm93 
driver loads without incident and both drivers are happy.

Is this normal behavior?

Thanks!

David
