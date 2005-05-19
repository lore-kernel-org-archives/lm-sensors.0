From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:34 +0000
Subject: Linux 2.6 and CONFIG_ISA
Message-Id: <1074005072.400404506dd11@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

After reading the following post on LKML:
http://marc.theaimsgroup.com/?l=linux-kernel&m7377669427411&w=2
I did some research about how ISA and I2C are supposed to interact
through the different Kconfig files in Linux 2.6. Here are my
conclusions, on which I'd like to have feedback and comments.

#1 In arch/i386/Kconfig, it is suggested that ISA busses are old and
deprecated, and that new machines don't have one. This is wrong. Recent
motherboards *do* have an ISA bus. They do not have ISA *slots* which
is quite different. I think that this information should be added to
CONFIG_ISA's help (and possibly backported to Linux 2.4).

#2 The Elektor is an ISA card (at least according to
i2c/busses/Kconfig), so I'd expect it to depend on ISA. It doesn't, nor
does it in Linux 2.4. Should be fixed?

#3 The ELV and Velleman adapters are said to depend on ISA, while I
don't see any reason why they would. They are parallel port adapters.
The dependancy doesn't exit in our CVS repository nor in Linux 2.4.

#4 The i2c-isa driver depends on ISA. This is a problem because most
people won't have ISA support selected, but are likely to need i2c-isa.
This is the problem described in the post on LKML those URL is given
above. I think I remember seeing a way to do reverse-dependancies in
Kconfigs (i.e. if B is selected, then A is automatically selected) but
cannot find an example of that anymore. This is done with the "select"
directive if I'm not mistaking. Thus I'd suggest to use it in this
case. Another point raised here is wether i2c-isa really does depend on
ISA. Looking through the code, it doesn't, at least not directly. OTOH
i2c-sensor does as soon as any adapter uses the isa algorithm (which
for some reason seems to be included in i2c-sensors instead of being in
i2c-isa -- I guess there is a reason for that but I did not look deep
enough into the code to tell what it is). As long as only i2c-isa does
use that algorithm it doesn't make much different I guess, still its
not very clean. No proposal here.

After listening to your remarks and comments, I could submit a patch to
fix whatever needs to be.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
