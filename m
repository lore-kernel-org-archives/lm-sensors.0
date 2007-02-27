From: r.marek@assembler.cz (Rudolf Marek)
Date: Tue, 27 Feb 2007 21:17:05 +0000
Subject: [lm-sensors] hwmon-vid: Unknown VRM version of your x86 CPU
Message-Id: <45E49FD1.80506@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <43834A86.6090205@sh.cvut.cz>
In-Reply-To: <43834A86.6090205@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello all,

Jean, good catch. I check the Intel datasheet and lowest limit is also 0.7V so 
it must be this.

I also read the VIA datasheet of Eden CPU at 90nm (which core is called Esther)
http://www.via.com.tw/en/downloads/datasheets/processors/eden_90nm170.zip
                                                                                   .
The CPUID family 6 model A core of the VIA Eden is shared with other VIA 
processors. To identify these brand variants, use the MSR instruction to read 
register 1153h and use the Exclusive OR (XOR)
function between bit fields 21:20 and 19:18.

Also:

VIA Eden Type:0  Fam: 6  Model: 10 Stepping: Begins at 9

Btw the datasheet contains also the Table which is identical to Intel one (page 26)

I will check the other processor not in the table and prepare a patch.

Rudolf

