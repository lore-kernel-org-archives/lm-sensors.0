From: Rudolf.Bernatzky@plg.de (Bernatzky Rudolf)
Date: Thu, 19 May 2005 06:23:53 +0000
Subject: lm-sensors support for ASUS chip ASB100 Bach
Message-Id: <795E03B0F1E26C449762C0EDF5F5659140F50F@Exchange.16.172.in-addr.arpa>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi there,
I would need some guidance from your experts.
We are a small company in Germany manufacturing and developing PCs,
servers, self service terminals and so on.
I have here a Linux Server with INTEL board P4B533 with the ASUS
ASB100-A Bach chip on board.
I also have the configuration register specification from ASUS of the
ASB100 ASUS ASIC under confidential NDA.
I am supposed to solve the deficiencies and problems of the lm-sensor
driver with the chip.
I have studied a lot of the documents on your web site and I have the
impression that the job is to big for me alone. I am mainly busy with
"C-program" diagnostic tools under good old DOS. But I can imagine that
we somehow could cooperate in order to get the thing fixed.
I could modify either the "lm78.c" source or the "w83781d.c" source
whichever would be more appropriate and comment and mark it properly.
Additionally I assume I would have to modify the sensors.conf file
according to vendor specification.
Alternatively I could generate a list of chip features with functions
and address offsets and command code. With the latter alternative I am
unsure with regard to the legal aspects. What do you think?
If you have any other idea how we could cooperate and accomplish the
job, I am open to your proposals.
Looking forward to your opinion, with kind regards
 
Rudolf Bernatzky
PLG AG - Abt. SOFTRON
Lise-Meitner Str. 3-5
D 86156 Augsburg
Germany
Tel.:   xx49-821-4086-142
Fax:    xx49-821-4086-111
E-Mail: rudolf.bernatzky@plg.de
 
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20030410/9504dfe6/attachment.html
