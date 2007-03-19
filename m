From: r.marek@assembler.cz (Rudolf Marek)
Date: Mon, 19 Mar 2007 06:31:11 +0000
Subject: [lm-sensors] coretemp - take3
Message-Id: <45FE2E2F.4010004@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <45FDC7A4.9070601@assembler.cz>
In-Reply-To: <45FDC7A4.9070601@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Alexey,

Maybe OpenVZ needs both safe and unsafe variants in msr-on-cpu?

>> On URL bellow is current version of coretemp driver.
>>
>> http://ssh.cz/~ruik/patches/
>>
>> What was fixed? I fixed the issues Jean pointed out, I created separate patch
>> for ...msr_safe stuff.
>>   
> In arch/i386/lib/msr-on-cpu.c, I'm not sure if you really need to create
> 2 versions of the functions (safe and unsafe). Anyway, no one uses these
> functions in the kernel yet, so I think you can simply convert them to
> safe versions.


-snip-

I will answer the rest in the evening.

Rudolf

