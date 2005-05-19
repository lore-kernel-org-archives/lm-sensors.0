From: mds@paradyne.com (Mark D. Studebaker )
Date: Thu, 19 May 2005 06:23:50 +0000
Subject: Can't compile lm_sensors: `CONFIG_X86_L1_CACHE_SHIFT' undeclared
Message-Id: <3E79291A.3040504@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030314213346.GA4748@ualberta.ca>
In-Reply-To: <20030314213346.GA4748@ualberta.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

If your headers are in /usr/include you don't need to set I2C_HEADERS.
Are /usr/include/linux and /usr/include/asm symlinks into /usr/src/linux/include/[asm,linux] ?

Rob Park wrote:
> Hello,
> 
> I'm having trouble compiling lm_sensors. I'm using kernel 2.4.20,
> lm_sensors 2.7.0, and i2c 2.7.0. i2c support is disabled in my kernel,
> and I'm doing compilation option #1.
> 
> $ grep -i 'i2c' /usr/src/linux/.config
> # I2C support
> # CONFIG_I2C is not set
> 
> First of all, /usr/src/linux *does* contain the build tree of the
> currently running kernel.
> 
> Secondly, i2c-2.7.0 installed just fine, as far as I can tell. I can
> load the i2c modules, and /usr/include/linux/i2c.h contains this line:
> 
> #define I2C_VERSION "2.7.0"
> 
> I've changed the lm_sensors Makefile to reflect this. I2c version 2.6.1
> headers are located in /usr/src/linux/include/linux, so I've made sure
> that the Makefile has 'I2C_HEADERS=/usr/include' in it.
> 
> When I try to compile, I get this error:
> 
> gcc  -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/include -I/usr/src/linux/include   -O2   -c kernel/busses/i2c-ali1535.c -o kernel/busses/i2c-ali1535.o
> cc1: warning: changing search order for system directory "/usr/local/include"
> cc1: warning:   as it is the same as non-system directory "/usr/include"
> cc1: warning: changing search order for system directory "/usr/include"
> cc1: warning:   as it has already been specified as a non-system directory
> In file included from /usr/include/linux/prefetch.h:13,
>                  from /usr/include/linux/list.h:6,
>                  from /usr/include/linux/module.h:12,
>                  from kernel/busses/i2c-ali1535.c:57:
> /usr/include/asm/processor.h:56: `CONFIG_X86_L1_CACHE_SHIFT' undeclared here (not in a function)
> /usr/include/asm/processor.h:56: requested alignment is not a constant
> make: *** [kernel/busses/i2c-ali1535.o] Error 1
> 
> The four cc1 warnings should just be because /usr/local is a symlink to
> /usr on my system. As far as I know, that shouldn't affect anything
> (plenty of other stuff compiles just fine, and has those warnings).
> 
> If it matters, my CPU is an AMD Athlon XP 1700+, and my mainboard is an
> Asus A7V8X. What's going wrong? How do I fix it?
> 
> Thanks, I *really* appreciate your help with this --> I want to know my
> CPU temperature! ;)
> 
