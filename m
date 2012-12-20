From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 20 Dec 2012 09:45:10 +0000
Subject: Re: [lm-sensors] i2c tools build failure with gcc 4.6
Message-Id: <20121220104510.2fa8a0fb@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20121220010733.GA31336@roeck-us.net>
In-Reply-To: <20121220010733.GA31336-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Cc: lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi Guenter,

On Wed, 19 Dec 2012 17:07:33 -0800, Guenter Roeck wrote:
> Seen with latest i2c-tools from svn repository.

With the subversion repository having gone on vacation, "latest"
doesn't mean much :(

> gcc 4.6:
> 
> gcc-4.6  -Llib -li2c -o tools/i2cdetect tools/i2cdetect.o tools/i2cbusses.o
> tools/i2cdetect.o: In function `main':
> i2cdetect.c:(.text.startup+0x557): undefined reference to `i2c_smbus_write_quick'
> i2cdetect.c:(.text.startup+0x5e9): undefined reference to `i2c_smbus_read_byte'
> collect2: ld returned 1 exit status
> make: *** [tools/i2cdetect] Error 1
> 
> gcc-4.4:
> gcc-4.4  -Llib -li2c -o tools/i2cdetect tools/i2cdetect.o tools/i2cbusses.o
> 
> [ no error ]
> 
> Any idea ?

I'm using gcc 4.6.2 (from openSUSE 12.1) and "the latest
i2c-tools" (that would be from October 25th if I can trust the CHANGES
timestamp) builds just fine for me. OTOH this is a linking problem, not
building problem, so the version of "ld" may be more relevant. Are you
using the same version of "ld" in both cases?

The error messages suggest that gcc (and subsequently ld) doesn't find
the symbols exported by libi2c. I can't figure out any reason why it
would be so. Can you show us the output of "nm lib/libi2c.so.0.1.0"?
This is what I get here:

0000000000201e30 a _DYNAMIC
0000000000201fe8 a _GLOBAL_OFFSET_TABLE_
                 w _Jv_RegisterClasses
0000000000201e10 d __CTOR_END__
0000000000201e08 d __CTOR_LIST__
0000000000201e20 d __DTOR_END__
0000000000201e18 d __DTOR_LIST__
0000000000000f10 r __FRAME_END__
0000000000201e28 d __JCR_END__
0000000000201e28 d __JCR_LIST__
0000000000202028 a __bss_start
                 w __cxa_finalize@@GLIBC_2.2.5
0000000000000c90 t __do_global_ctors_aux
0000000000000850 t __do_global_dtors_aux
0000000000202020 d __dso_handle
                 U __errno_location@@GLIBC_2.2.5
                 w __gmon_start__
0000000000202028 a _edata
0000000000202038 a _end
0000000000000cc8 t _fini
00000000000007c8 t _init
0000000000000cd8 t _real_fini
0000000000000830 t call_gmon_start
0000000000202028 b completed.5890
0000000000202030 b dtor_idx.5892
00000000000008d0 t frame_dummy
0000000000000900 T i2c_smbus_access
0000000000000c00 T i2c_smbus_block_process_call
0000000000000a40 T i2c_smbus_process_call
0000000000000a70 T i2c_smbus_read_block_data
0000000000000950 T i2c_smbus_read_byte
00000000000009a0 T i2c_smbus_read_byte_data
0000000000000b30 T i2c_smbus_read_i2c_block_data
00000000000009f0 T i2c_smbus_read_word_data
0000000000000ad0 T i2c_smbus_write_block_data
0000000000000980 T i2c_smbus_write_byte
00000000000009d0 T i2c_smbus_write_byte_data
0000000000000ba0 T i2c_smbus_write_i2c_block_data
0000000000000940 T i2c_smbus_write_quick
0000000000000a20 T i2c_smbus_write_word_data
                 U ioctl@@GLIBC_2.2.5

This could also be a Makefile dependency issue... I can't remember
what, if anything, guarantees that the library is built before the
tools which use it.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
