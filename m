From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 22 Nov 2011 17:08:59 +0000
Subject: Re: [lm-sensors] Cross Compiling for ARM
Message-Id: <1321981739.2730.104.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <BLU162-W147C2EEC02769A3F8016868EC80@phx.gbl>
In-Reply-To: <BLU162-W147C2EEC02769A3F8016868EC80@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 2011-11-22 at 09:03 -0500, Trevor Shiwnath wrote:
> Hello,
> 
> This is my first time sending an email to a mailing list, so please
> bare with me. I have an Embedded ARM-Linux system running kernel
> version 2.6.27 and I wanted to cross compile lm-sensors version 3.3.1
> onto it. I am a little familiar with cross compiling and editing
> makefiles for my device. When I change "CC" in the make file from gcc
> to arm-linux-gcc, it compiles fine, but when I transfer the program
> files onto my Embedded system and attempt to run "sensors", it tells
> me "sensors: '/lib/libsensors.so.4' is not an ELF file". What could I
> possibly change in the makefile to make the libraries compile properly
> with the ARM-Linux environment?

Presumably your cross compiler and/or lijnker should have an option to
generate ELF output, and it doesn't do so by default. Check out what the
option is and add it to CFLAGS and/or LDFLAGS.

Guenter





_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
