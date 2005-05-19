From: dave.antliff@paradise.net.nz (David Antliff)
Date: Thu, 19 May 2005 06:24:23 +0000
Subject: Temp Sensor on Asus A7V8X - Ticket 1358
Message-Id: <Pine.LNX.4.55.0310292207260.13390@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.55.0310291645560.11719@localhost>
In-Reply-To: <Pine.LNX.4.55.0310291645560.11719@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> David: If you want to try this, you'll need to add a section "asb100-*" to
> your /etc/sensors.conf.  Copying the existing "as99127f-*" section would be
> a good start.

Hi Mark, thanks for your work on this.

I got the cvs version of lm_sensors2 and i2c, built it, and installed the
asb100 driver. I cut and pasted the as99127f-* section as you suggested. I
now have these readings:

M/B Temp: 24.00 (temp1)
  temp1_over: 60.00 (temp1_over)
  temp1_hyst: 127.00 (temp1_hyst)
CPU Temp: 48.00 (temp2)
  temp2_over: 120.00 (temp2_over)
  temp2_hyst: 100.00 (temp2_hyst)
temp3: 24.00 (temp3)
  temp3_over: 240.00 (temp3_over)
  temp3_hyst: 200.00 (temp3_hyst)
temp4: 25.00 (temp4)
  temp4_over: 80.00 (temp4_over)
  temp4_hyst: 75.00 (temp4_hyst)

Note temp3 and temp4 - these correlate with the Asus Probe (Asus
diagnostics software for Windows) readings I get in windows on the same
m/b - CPU 25C and M/B 24C. I therefore conclude that temp3 is the M/B and
temp4 is the CPU. Temp2 could do with some work, but I'm not too bothered
about that at the moment.

However, there's the strange bit - I just noticed that neither these
temp3/4 readings nor the Asus Probe readings in Windows match the BIOS!

For example, with Asus Probe and lm_sensors/asb100 readings of:

Asus Probe M/B = temp3 = 24
Asus Probe CPU = temp4 = 26

The BIOS displays the readings as:

M/B = 24
CPU = 23

I rebooted several times to confirm this. It seems the BIOS readings are
not only swapped, but different from the software readings.

Can you explain this somehow?

However with that driver and temp3 and 4, I now have readings that match
Asus Probe. Thank you very much!

Cheers,
David.
