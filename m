From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 07 Apr 2011 07:29:55 +0000
Subject: Re: [lm-sensors] Any idea to support Fintek F71808A
Message-Id: <20110407092955.5ff3ea8e@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <BANLkTinFxPuMEuM-ZOandTcnAwxeWKgx5g@mail.gmail.com>
In-Reply-To: <BANLkTinFxPuMEuM-ZOandTcnAwxeWKgx5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 6 Apr 2011 13:47:45 -0700, D.B. Tsai wrote:
> Hi
> 
> Sure, I can take the risk of the disabling acpi resource conflict
> check, and I'm willing to test your code. Please let send me the code
> when you finish it. By the way, I'm using Ubuntu 11.04 with kernel
> 2.6.38-8-server, and wondering to know that when will the mainline
> kernel fix this conflict issue?

Never, as this isn't a bug per se. Your ACPI BIOS wants to control the
I/O ports, the kernels wants them too, and that's about it. If your
BIOS requests the I/O ports but doesn't use them, then it's a bug in
your BIOS.

Some vendors (Asus) request the I/O ports for a reason, and they
implement a proprietary interface on top of the hardware monitoring
chip. In this case it is possible to write an ACPI driver as a
replacement for the native driver. Unfortunately, most other vendors
which request the I/O ports don't implement anything like this.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
