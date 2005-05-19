From: torvalds@osdl.org (Linus Torvalds)
Date: Thu, 19 May 2005 06:25:12 +0000
Subject: [BK PATCH] I2C update for 2.6.8-rc1
Message-Id: <Pine.LNX.4.58.0408241721330.17766@ppc970.osdl.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040715000527.GA18923@kroah.com> <1093384722.8445.10.camel@tdi>
 <20040824220450.GE11165@kroah.com>
In-Reply-To: <20040824220450.GE11165@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <greg@kroah.com>
Cc: Alex Williamson <alex.williamson@hp.com>, akpm@osdl.org, linux-kernel <linux-kernel@vger.kernel.org>, sensors@Stimpy.netroedge.com



On Tue, 24 Aug 2004, Greg KH wrote:
> 
> If someone can come up with a patch that works for everyone, I'll be
> glad to apply it.

Hmm.. Why exactly does the PCI layer re-locate the IO ports?

Afaik, ACPI requesting the region shouldn't matter. The 
"request_resource()" should still be happy..

Ahh. I see the problem. Because the ACPI code allocates the sub-resources, 
the request_resource thing is indeed not happy.

How about this _trivial_ change? Does that fix things for you guys? Can 
you send the /proc/ioport output if this works out for you, just so that 
we can see?

(The difference between "request_resource()" and "insert_resource()" is 
that the latter accepts pre-existing sub-resources that the firmware might 
have allocated within the resource we have..)

		Linus

=== arch/i386/pci/i386.c 1.16 vs edited ==--- 1.16/arch/i386/pci/i386.c	2003-07-31 16:47:19 -07:00
+++ edited/arch/i386/pci/i386.c	2004-08-24 17:36:10 -07:00
@@ -142,7 +142,7 @@
 				DBG("PCI: Resource %08lx-%08lx (f=%lx, d=%d, p=%d)\n",
 				    r->start, r->end, r->flags, disabled, pass);
 				pr = pci_find_parent_resource(dev, r);
-				if (!pr || request_resource(pr, r) < 0) {
+				if (!pr || insert_resource(pr, r) < 0) {
 					printk(KERN_ERR "PCI: Cannot allocate resource region %d of device %s\n", idx, pci_name(dev));
 					/* We'll assign a new address later */
 					r->end -= r->start;
