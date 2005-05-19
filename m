From: timm@fnal.gov (Steven Timm)
Date: Thu, 19 May 2005 06:25:39 +0000
Subject: Cross-compile
Message-Id: <Pine.LNX.4.58.0502241106300.6330@boxer.fnal.gov>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Since version 2.8.8 of i2c and lm_sensors, I am discovering 
that the kernel modules are different sizes when compiled under
i686 and under athlon architectures.  And what is compiled on 
i686 doesn't work on athlon, and vice versa.  Is this supposed
to be happening?  Is there any way to compile a generic i386
version that works on both?

Steve Timm


------------------------------------------------------------------
Steven C. Timm, Ph.D  (630) 840-8525  timm@fnal.gov  http://home.fnal.gov/~timm/
Fermilab Computing Div/Core Support Services Dept./Scientific Computing Section
Assistant Group Leader, Farms and Clustered Systems Group
Lead of Computing Farms Team
