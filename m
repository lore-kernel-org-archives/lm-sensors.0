From: nils.faerber@kernelconcepts.de (Nils Faerber)
Date: Thu, 19 May 2005 06:25:15 +0000
Subject: SMBus device access
Message-Id: <1094815915.26391.781.camel@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <1094810411.26391.757.camel@localhost>
In-Reply-To: <1094810411.26391.757.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Oh, and while we are at it ;)
The PIC I have hanging to the SMBus not only has a display connectoed to
it but also some push buttons, i.e. user input.
It is not perfectly clear to me how I should best query those buttons.
Is it possible for the SMBus to generate interrupts on button presse or
do I have to poll those?
At least at first glance it seems that the SIS96x does not use
interrupts at all...

Thanks again!
Regards
  nils faerber

-- 
kernel concepts          Tel: +49-271-771091-12
Dreisbachstr. 24         Fax: +49-271-771091-19
D-57250 Netphen          Mob: +49-176-21024535
--
