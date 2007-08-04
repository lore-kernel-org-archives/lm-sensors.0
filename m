From: Rudolf Marek <r.marek@assembler.cz>
Date: Sat, 04 Aug 2007 20:09:21 +0000
Subject: Re: [lm-sensors] Hardware monitoring on Asus A6JM laptop
Message-Id: <46B4DCF1.4000407@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <46B395DF.30504@free.fr>
In-Reply-To: <46B395DF.30504@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

I dont think it is a good idea to enable the SMbus when they disable it. It has
the the chip ADT7463 which servers as thermal control for whole notebook. The
chip is in automatic mode. Fan full at 90C. Fans stop at 55C.

Perhaps ACPI methods poke with that chip too. First it must be check if they do!
If so, the access must not be allowed!

Rudolf





_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
