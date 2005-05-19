From: weisz@vcpc.univie.ac.at (Willy Weisz)
Date: Thu, 19 May 2005 06:24:36 +0000
Subject: Ticket # 1523
Message-Id: <400FCFDF.5090704@vcpc.univie.ac.at>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Please withdraw ticket number 1523 for the following reasons:

1. p4b_smbus isn't needed anymore for kernels 2.6.x, so there is
   no need to compile it.
2. p4b_smbus.o wouldn't even be loaded as the new kernel objects
   need an extension of .ko not .o
3. I looked at the wrong file, when making my changes to the
   Makefile. Your comment in the ticket entry shouldn't
   be a question, but bluntly state that my suggestion is wrong.

Sorry for my opening that ticket, I only found out later that
kernels 2.6.x don't need p4b_smbus anymore.

Best regards

Willy Weisz
-----------------------------------------------------------
Willy Weisz

European Centre for Parallel Computing at Vienna (VCPC)
                 Liechtensteinstrasse 22
                 A-1090 Wien
Tel: (+43 1) 4277 - 38824          Fax: (+43 1) 4277 - 9388
                e-mail: weisz@vcpc.univie.ac.at

