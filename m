From: Rudolf Marek <r.marek@assembler.cz>
Date: Wed, 10 Sep 2008 20:40:52 +0000
Subject: Re: [lm-sensors] New winbond chip: W83667HG
Message-Id: <48C830D4.6010402@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <200807072054.10321.phhusson@free.fr>
In-Reply-To: <200807072054.10321.phhusson@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Pierre

I have the datasheet! Can you post here some dumps so I can check it what is the 
real revision of the chip?

isadump 0x295 0x296 0

and also:

isadump 0x2e 0x2f  -k 0x87,0x87

Thank you.

Rudolf

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
