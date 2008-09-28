From: =?iso-8859-1?Q?=D3scar_Fuentes?= <ofv@wanadoo.es>
Date: Sun, 28 Sep 2008 20:55:33 +0000
Subject: Re: [lm-sensors] Does this makes any sense?
Message-Id: <zllst2gq.fsf@telefonica.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <4p40uijp.fsf@telefonica.net>
In-Reply-To: <4p40uijp.fsf@telefonica.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Rudolf Marek <r.marek@assembler.cz> writes:

> Maybe the IO stresses the CPU more.

mprime is FPU and memory intensive. The I/O for the compiler is
reading and writing on the disk, which means memory I/O, but nowhere as
intensive as mprime.

If the average of the temperature on the CPU cores is indicative of the
T_c (the temperature metrology spec used by Intel) while compiling the
CPU should be much above the temperature at maximum load, per Intel's
spec (71 degrees measured at the geometrical center of the CPU).

Another strange thing is the difference among cores. This seems to be
always true: Core0 Temp > Core1 Temp > Core2 Temp > Core3 Temp, with
differences of up to 20 degrees among Core0 and Core3.

-- 
Oscar

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
