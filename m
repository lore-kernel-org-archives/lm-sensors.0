From: nicolas.boulay@ifrance.com (Nicolas Boulay)
Date: Thu, 19 May 2005 06:23:40 +0000
Subject: Compile problem when EISA support is removed from the .config file
Message-Id: <200210100836.01d7@th00.opsion.fr>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I have a asus SMP board, the a7m266-d. I run mandrake linux 8.2 with
kernel 2.4.18.

I had problem by compiling lm_sensors. They were some strange compiling
error some about isa bus. 

My motherboard does have any isa slot, so i had remove the support of
the isa inside the make menuconfig program but without installing a new
kernel.

To solve the problem, i simply do a "make mrproper" inside the linux
source and run "make menuconfig" (leave default option like EISA
support) and then a "make dep". I don't know if "make dep" do really
something usefull. 

After doing a "make mrproper", the make of lm_sensors complain about the
miss of the /usr/src/linux/.config file.

So, from my point of view, lm_sensors make didn't like that the EISA
support is remove from the .config file.

nicO

______________________________________________________________________
Etudiant: Wanadoo t'offre le Pack eXtense Haut D?bit soit 150,92 euros
d'?conomies ! Clique ici : http://www.ifrance.com/_reloc/mail.etudiant

