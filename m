From: tonu@jes.ee (Tonu Samuel)
Date: Sat, 31 Dec 2005 18:01:08 +0000
Subject: [lm-sensors] pca9538, pca9554 and LCD on top of them
Message-Id: <200512312001.08504.tonu@jes.ee>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Happy new i2c everybody :P

I have an LCD running on top of SMBUS and LCDPROC. I hated some cable running 
out of computer to LPT port, so I looked for alternatives. SMBUS is good way 
to connect LCD inside computer, so I made it for myself. Feel free to try 
out. Schematic, details and patches are here:

http://no.spam.ee/~tonu/i2clcd.xhtml
Ouch, again I reused my unapplied patch for pca9538. Now with pca9554 added 
(in your TODO for long time).


  T?nu

