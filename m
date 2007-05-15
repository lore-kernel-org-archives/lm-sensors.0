From: Rudolf Marek <r.marek@assembler.cz>
Date: Tue, 15 May 2007 23:51:17 +0000
Subject: Re: [lm-sensors] hwmon/w83627ehf
Message-Id: <464A4775.9070200@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <4dfa50520705132035l219dfd4bibaaab442fa3992f4@mail.gmail.com>
In-Reply-To: <4dfa50520705132035l219dfd4bibaaab442fa3992f4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

100% Agree, I wanted to write that too but have no time :/

Btw david. You can set the HEFRAS bit in CR26 to move your superio to 0x4e/4f.
(write 0x40 to 0x26 + key)

I tried that  and now I got same err
...
Ending clean XFS mount for filesystem: dm-2
w83627ehf: unsupported chip ID: 0xffff
ruik:/home/ruik#

I think test for 0xffff should be there. I think ISA decodes empty spaces as 0xff.

Rudolf

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
