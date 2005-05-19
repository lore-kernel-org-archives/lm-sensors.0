From: slade@goembedded.com (Slade Maurer)
Date: Thu, 19 May 2005 06:25:13 +0000
Subject: Temperature sensor support
Message-Id: <04090718250100.01233@localhost.localdomain>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

We are developing a board that uses a 64-bit MIPS Linux 2.4-20 real-time 
kernel and has a MAXIM MAX1617A temp sensor hanging on a SMBbus.

We hav some code that runs as a character-ish driver for the BIOS already.

I am curious what it would we would could do to support your group to get 
your lm_sensor code running our platform soon? 

It does not look like it currently does support this (please correctly me if 
I am wrong).

Our schedule is very tight, although the driver would not be terribly 
difficult to write, so it would be wonderful to have your code base support 
it. We are thinking of a proc_fs file that shows temp stats or just a simple 
modular character driver that reads the temp when requested.

Thank you for your time!

  -Slade
