From: Andrew Morton <akpm@linux-foundation.org>
Date: Wed, 06 Jun 2007 18:22:55 +0000
Subject: Re: [lm-sensors] 2.6.22-rc4-mm1 -- ERROR:
Message-Id: <20070606112255.3fad0d1d.akpm@linux-foundation.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <a44ae5cd0706061058u3566e0a4yf178b9e473d17395@mail.gmail.com>
In-Reply-To: <a44ae5cd0706061058u3566e0a4yf178b9e473d17395@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 6 Jun 2007 10:58:34 -0700 "Miles Lane" <miles.lane@gmail.com> wrote:

>   RELOCS  arch/i386/boot/compressed/vmlinux.relocs
> WARNING: Absolute relocations present
> Offset     Info     Type     Sym.Value Sym.Name
> c0102029 00535201   R_386_32 00000000  xen_irq_disable_direct_reloc
> c0102043 00722e01   R_386_32 00000000  xen_save_fl_direct_reloc
> c014440b 00588001   R_386_32 c0453000  __per_cpu_start
> c0144415 00588001   R_386_32 c0453000  __per_cpu_start
> c014441a 00588001   R_386_32 c0453000  __per_cpu_start
> c0144421 0064f101   R_386_32 c045a4a4  __per_cpu_end
> c014cf79 00588001   R_386_32 c0453000  __per_cpu_start
> c014cf7f 0064f101   R_386_32 c045a4a4  __per_cpu_end
> c014cf87 00588001   R_386_32 c0453000  __per_cpu_start
> c014cf8d 0064f101   R_386_32 c045a4a4  __per_cpu_end
> c014d4c2 00588001   R_386_32 c0453000  __per_cpu_start
> c014df8c 00588001   R_386_32 c0453000  __per_cpu_start
> c040f7d7 0064f101   R_386_32 c045a4a4  __per_cpu_end
> c040f7de 00588001   R_386_32 c0453000  __per_cpu_start
> c040f80d 00588001   R_386_32 c0453000  __per_cpu_start
> c040f81c 0064f101   R_386_32 c045a4a4  __per_cpu_end
> c040f821 00588001   R_386_32 c0453000  __per_cpu_start
> c040f82d 00588001   R_386_32 c0453000  __per_cpu_start

Yes, I got that and haven't had time to think about it yet.

The first two are Jeremy playing with our minds.  The others _might_ have
been triggered by use-the-new-percpu-interface-for-shared-data.patch and
define-new-percpu-interface-for-shared-data.patch, but I've dropped those
because they made Michal's machine hang anyway.


>   BUILD   arch/i386/boot/compressed/vmlinux.bin.all
>   GZIP    arch/i386/boot/compressed/vmlinux.bin.gz
>   LD      arch/i386/boot/compressed/piggy.o
>   LD      arch/i386/boot/compressed/vmlinux
>   OBJCOPY arch/i386/boot/vmlinux.bin
>   HOSTCC  arch/i386/boot/tools/build
>   BUILD   arch/i386/boot/bzImage
> Root device is (8, 11)
> Setup is 10116 bytes (padded to 10240 bytes).
> System is 1721 kB
> Kernel: arch/i386/boot/bzImage is ready  (#13)
>   Building modules, stage 2.
>   MODPOST 784 modules
> WARNING: vmlinux(.text+0xc0101183): Section mismatch: reference to
> .init.text:start_kernel (between 'is386' and 'check_x87')
> WARNING: vmlinux(.text+0xc02b3a5b): Section mismatch: reference to
> .init.text:kernel_init (between 'rest_init' and 'alloc_node_mem_map')
> WARNING: vmlinux(.text+0xc02b74d8): Section mismatch: reference to
> .init.text: (between 'iret_exc' and '_etext')
> WARNING: vmlinux(.text+0xc02b74e5): Section mismatch: reference to
> .init.text: (between 'iret_exc' and '_etext')
> WARNING: vmlinux(.text+0xc02b74f1): Section mismatch: reference to
> .init.text: (between 'iret_exc' and '_etext')
> WARNING: vmlinux(.text+0xc02b74fd): Section mismatch: reference to
> .init.text: (between 'iret_exc' and '_etext')
> WARNING: vmlinux(.text+0xc02b3b13): Section mismatch: reference to
> .init.text:__alloc_bootmem_node (between 'zone_wait_table_init' and
> 'fb_find_logo')
> WARNING: vmlinux(.text+0xc01ee474): Section mismatch: reference to
> .init.text:__alloc_bootmem (between 'vgacon_startup' and
> 'vgacon_scrolldelta')
> WARNING: vmlinux(.text+0xc02b7b6a): Section mismatch: reference to
> .init.text: (between 'iret_exc' and '_etext')
> WARNING: vmlinux(.text+0xc02b3b64): Section mismatch: reference to
> .init.data:logo_linux_clut224 (between 'fb_find_logo' and 'schedule')
> WARNING: vmlinux(.text+0xc02b7cb6): Section mismatch: reference to
> .init.text: (between 'iret_exc' and '_etext')
> ERROR: "input_register_polled_device" [drivers/hwmon/hdaps.ko] undefined!
> ERROR: "input_allocate_polled_device" [drivers/hwmon/hdaps.ko] undefined!
> ERROR: "input_free_polled_device" [drivers/hwmon/hdaps.ko] undefined!
> ERROR: "input_unregister_polled_device" [drivers/hwmon/hdaps.ko] undefined!
> ERROR: "input_register_polled_device" [drivers/hwmon/applesmc.ko] undefined!
> ERROR: "input_allocate_polled_device" [drivers/hwmon/applesmc.ko] undefined!
> ERROR: "input_free_polled_device" [drivers/hwmon/applesmc.ko] undefined!
> ERROR: "input_unregister_polled_device" [drivers/hwmon/applesmc.ko] undefined!

Kconfig bustage I guess.  Please send the .config.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
