From: adubourg@free.fr (Alexis Dubourg)
Date: Thu, 19 May 2005 06:23:40 +0000
Subject: Ticket #1002 : kernel compile error - i2c 2.6.5/dmi_scan.c
Message-Id: <1032787009.3d8f1441afc82@imp.free.fr>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> If I try to compile it as a module, (which i?d rather not do) I
> get this error
[...]

I was able to compile the i2c-piix4.o module without a warning by
adding "dmi_scan.o" to the end of the "export-objs" declaration, in
i2c-2.6.5/mkpatch/mkpatch.pl (line #549), then using the "Patching
the kernel" method (compilation option 3).

Hope this helps,

-- 
Alexis Dubourg
