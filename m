From: "David Hubbard" <david.c.hubbard@gmail.com>
Date: Thu, 18 Oct 2007 18:44:17 +0000
Subject: Re: [lm-sensors] [ patch .24-rc0 5/5 ] SuperIO locks coordinator -
Message-Id: <4dfa50520710181144g3b8cb261ved455dbdb3a7a235@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4712F66F.8040806@gmail.com>
In-Reply-To: <4712F66F.8040806@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jim,

Three things:

1) This appears to be pasted in and needs to be updated for each driver:
printk(KERN_WARNING "pc87360: superio port not detected, "

I found it in the following places in patch 5/5:
$ grep -n pc87360 jim_05.patch
107:+           printk(KERN_WARNING "pc87360: superio port not detected, "
257:+           printk(KERN_WARNING "pc87360: superio port not detected, "
443:+           printk(KERN_WARNING "pc87360: superio port not detected, "
547:+           printk(KERN_WARNING "pc87360: superio port not detected, "
834:+           printk(KERN_WARNING "pc87360: superio port not detected, "

2) There's a compile warning in drivers/hwmon/superio_locks.c:
  CC [M]  drivers/hwmon/superio_locks.o
drivers/hwmon/superio_locks.c: In function 'superio_probe_reserve':
drivers/hwmon/superio_locks.c:44: warning: unused variable 'rc'

3) superio_find() does not correctly find the w83627ehf:
# modprobe w83627ehf
[   84.162869] initializing with 3 reservation slots
[   84.188669] got devid 3, want 8850
[   84.188671] no devid:8850 at port:2e
[   84.188684] got devid 3, want 8860
[   84.188685] no devid:8860 at port:2e
[   84.188698] got devid 3, want a020
[   84.188700] no devid:a020 at port:2e
[   84.188712] got devid f, want 8850
[   84.188713] no devid:8850 at port:4e
[   84.188726] got devid f, want 8860
[   84.188727] no devid:8860 at port:4e
[   84.188740] got devid f, want a020
[   84.188741] no devid:a020 at port:4e
[   84.188742] pc87360: superio port not detected, module not intalled.
FATAL: Error inserting w83627ehf
(/lib/modules/2.6.23-git8/kernel/drivers/hwmon/w83627ehf.ko): No such
device

Your suggestion about sending the superio-enter sequence seems right:
it sees the port, but it doesn't see the devid. I added a whole bunch
of printks and I think the mask value is wrong (it gets a devid of
8863 on my w83627ehf, and what we want is the 8860, not the 3, on port
0x2e; 0x4e gives 0xffff.)

So what I changed:
Index: linux-2.6.23-git8/drivers/hwmon/w83627ehf.c
=================================--- linux-2.6.23-git8/drivers/hwmon/w83627ehf.c	2007-10-18
12:05:02.000000000 -0700
+++ linux-2.6.23-git8/drivers/hwmon/w83627ehf.c	2007-10-18
12:36:21.000000000 -0700
@@ -79,7 +79,7 @@
 #define SIO_W83627EHF_ID	0x8850
 #define SIO_W83627EHG_ID	0x8860
 #define SIO_W83627DHG_ID	0xa020
-#define SIO_ID_MASK		0xFFF0
+#define SIO_ID_MASK		0xF

 static struct superio* gate;

@@ -1426,7 +1426,7 @@
 	superio_enter(gate);
 	val = superio_devid(gate);

-	switch (val & SIO_ID_MASK) {
+	switch (val & (~SIO_ID_MASK)) {
 	case SIO_W83627EHF_ID:
 		sio_data->kind = w83627ehf;
 		sio_name = sio_name_W83627EHF;
I didn't look at how other drivers do it, but I suspect if I had this
problem, w83627hf will have it too. Is this line in superio_locks.c
(around line 80, except I've patched up mine):
mydevid &= ~ where->devid_mask;

Is it correct to invert the mask? Is every other driver inverting the
mask first? It seems you would want to flip the bits in the mask
constants, rather than invert every mask before using it. I didn't
find anywhere else that devid_mask was used.

OK, so enough rambling. With the mask changed, I get:
[ 1246.391103] initializing with 3 reservation slots
[ 1246.392371] superio_locks init: enter seq 87 port 2e
[ 1246.392374] superio_locks init: enter seq 87 port 2e
[ 1246.392376] superio_locks init: select devid: 20 port 2e
[ 1246.392379] superio_locks init: high devid: 8800 from port 2f
[ 1246.392380] superio_locks init: select devid+1: 21 port 2e
[ 1246.392383] superio_locks init: whole devid: 8863 from port 2f
[ 1246.392384] superio_locks init: mask devid: 8863 & ~ f = 8860
[ 1246.392386] got devid 8860, want 8850
[ 1246.392387] no devid:8850 at port:2e
[ 1246.392388] superio_locks init: enter seq 87 port 2e
[ 1246.392390] superio_locks init: enter seq 87 port 2e
[ 1246.392392] superio_locks init: select devid: 20 port 2e
[ 1246.392394] superio_locks init: high devid: 8800 from port 2f
[ 1246.392396] superio_locks init: select devid+1: 21 port 2e
[ 1246.392398] superio_locks init: whole devid: 8863 from port 2f
[ 1246.392400] superio_locks init: mask devid: 8863 & ~ f = 8860
[ 1246.392402] superio_locks: superio port region already claimed
[ 1246.392403] allocating slot 0, addr 2e for device 8860
[ 1246.392404] found devid:8860 port:2e users:1
[ 1246.392413] w83627ehf: Found W83627EHG chip at 0x290
[ 1246.392455] w83627ehf w83627ehf.0: Failed to request region 0x5-0x6
[ 1246.392460] w83627ehf: probe of w83627ehf.0 failed with error -16

Looking at that, I noticed this in your patch:
 /* w83627ehf_find() looks for a '627 in the Super-I/O config space */
-static int __init w83627ehf_find(int sioaddr, unsigned short *addr,
-                                struct w83627ehf_sio_data *sio_data)
+static int __init w83627ehf_find(struct w83627ehf_sio_data *sio_data)
 {
        static const char __initdata sio_name_W83627EHF[] = "W83627EHF";
        static const char __initdata sio_name_W83627EHG[] = "W83627EHG";
        static const char __initdata sio_name_W83627DHG[] = "W83627DHG";

-       u16 val;
+       u16 val, addr;
        const char *sio_name;

I don't think that is correct. We should return addr from
w83627ehf_find into sensors_w83627ehf_init where you patched:
@@ -1496,7 +1483,7 @@ static struct platform_device *pdev;
 static int __init sensors_w83627ehf_init(void)
 {
        int err;
-       unsigned short address;
+       unsigned short address = 0;
        struct resource res;
        struct w83627ehf_sio_data sio_data;

This line:
	if (!(pdev = platform_device_alloc(DRVNAME, address))) {

uses the address to reserve the region (which should be 0x290 on my
machine) where the ISA interface to the w83627ehf is found. Then the
w83627ehf is used like some normal PnP device, with ports in the ISA
space.

Hmm... so I hope this is valuable feedback. I could put together a
patch that undoes the change in the handling of addr, but I thought
I'd just shoot you back an email instead. So I'm lazy. :-)

David

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
