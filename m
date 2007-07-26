From: Eric Sandeen <sandeen@sandeen.net>
Date: Thu, 26 Jul 2007 03:31:10 +0000
Subject: [lm-sensors] dme1737 very slow read...
Message-Id: <46A8157E.7040003@sandeen.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I was very happy to see dme1737 support added, thank you!  Now I can get
all the info out of my compaq sr1710nx cheapo server.  :)

It all works - I did notice, though, that when I run "sensors" it's very
slow to read the sysfs file:

write(1, "Adapter: SMBus PIIX4 adapter at "..., 37) = 37 <0.000055>
open("/sys/class/i2c-adapter/i2c-0/0-002e/in0_input", O_RDONLY) = 3
<0.000032>
fstat(3, {st_mode=S_IFREG|0444, st_size@96, ...}) = 0 <0.000009>
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0)
= 0x2b7f69d6b000 <0.000014>
read(3, "0\n", 4096)                    = 2 <1.535188>

1.53 seconds to read "0\n" !  :)

Any idea if this is a hardware or software delay?  I haven't yet dug
into profiling the kernel code to see what might be taking so long...

Thanks,

-Eric

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
