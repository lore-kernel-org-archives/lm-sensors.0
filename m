From: menscher@uiuc.edu (Damian Menscher)
Date: Thu, 19 May 2005 06:24:34 +0000
Subject: lm-sensors: w83627hf.c (fwd)
Message-Id: <5705323910D7D2118E3400C00D0062C102CD622D@phyexha.physics.uiuc.edu>
List-Id: <lm-sensors.vger.kernel.org>
References: <200304061852.h36Iq8uf000590@shire.frodo.local>
In-Reply-To: <200304061852.h36Iq8uf000590@shire.frodo.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I wrote in April 2003 that I have an Intel SE7505VB2 motherboard with
the Winbond W83627HF chip.  My motherboard somehow manages to monitor 6
fans, but this chip can only handle 3 fans.  How it monitored 6 was a
mystery.  You responded that you didn't know, but I should tell you if I
figured it out.

In July 2003 I got an email from Kevin Schuchmann <kschuchm@us.ibm.com>
who suggested I read the Intel specification more closely, specifically
section 3.3.1.  Apparently Intel is using two of the GPIOs on the
Winbond chip (GPIO13 and GPIO15 on pins 125 and 123, respectively) as
FanSlct1# and FanSlct2#.  It's not clear that they're using the second
one, but the first (which is definitely being used) would be enough to
act as a toggle for which "bank" of fans to monitor.  The Intel
documentation lists this as output:
  Function select: CR2A<7>=1 & CR2A<3>=1 & LD7[F0h]<3>=0
  Data: LD7[F1h]<3>
The Winbond documentation indicates it is general purpose I/O port 1 bit
3 (from the table in section 1.8 of their documentation).

The Intel spec sheet is available online at:
ftp://download.intel.com/support/motherboards/server/se7505vb2/tps.pdf

The Winbond spec sheet is available online at:
http://www.winbond.com/PDF/sheet/w83627hf.pdf

If you have time, there are a few of us out there that would appreciate
it if you could add support for this configuration.

Damian Menscher
-- 
-=#| Physics Grad Student & SysAdmin @ U Illinois Urbana-Champaign |#=-
-=#| 488 LLP, 1110 W. Green St, Urbana, IL 61801 Ofc:(217)333-0038 |#=-
-=#| 4602 Beckman, VMIL/MS, Imaging Technology Group:(217)244-3074 |#=-
-=#| <menscher@uiuc.edu> www.uiuc.edu/~menscher/ Fax:(217)333-9819 |#=-
