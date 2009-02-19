From: Rudolf Marek <r.marek@assembler.cz>
Date: Thu, 19 Feb 2009 08:21:51 +0000
Subject: Re: [lm-sensors] w83793 driver for RHEL 5.2 x86_64
Message-Id: <499D169F.3070606@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <499C7EE4.5070200@assembler.cz>
In-Reply-To: <499C7EE4.5070200@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

Please CC the list!

maluyao napsal(a):
> My blade server is SuperMicro. The motherboard is B7DBE.
> 
> While run "i2cdump 0 0x2f" , it show me :
> 
> No size specified (using byte-data access)
> Error: Could not open file `/dev/i2c-0' or `/dev/i2c/0': No such file or 
> directory

You dont have device nodes in /dev/  for i2c
Can you create them?

crw-rw---- 1 root root 89, 0 2009-02-07 19:37 /dev/i2c-0


> I update w83793.c from kernel-2.6.28  and the proble still occur.

try to unload the "thermal" module from acpi.

rmmod thermal
sensors

> while I try to compiling w83793.c form 2.6.27.18. It show me too many
> error. I thinks something conflict with kernel-2.6.18-128.el5 .

Yes this is expected. You need to use version which is in the kernel.

Rudolf


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
