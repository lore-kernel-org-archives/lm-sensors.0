From: david.c.hubbard@gmail.com (David Hubbard)
Date: Fri, 19 Jan 2007 06:31:52 +0000
Subject: [lm-sensors] Asus P5B Deluxe / Winbond 83627DHG
Message-Id: <4dfa50520701182231y50358df0mfc4dc083ff675237@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4dfa50520612211313g7906f3b0kbf8d7aebb2ddcda9@mail.gmail.com>
In-Reply-To: <4dfa50520612211313g7906f3b0kbf8d7aebb2ddcda9@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Daniel,

Thanks for the report! I hope we can resolve your setup. Let's go with
the newest version -- apply the patch or copy the file, your choice.
(For others who read this later, the patch is intended for 2.6.20-rc1.
2.6.19.2 is missing one patch updating a Rudolf's email address). If
the module loads, there should be files in sysfs. Assuming you have
that mounted at /sys, I think we can figure out what the problem is. I
don't think installing an -mm kernel is necessary, although that is
the official testing version at this point.

Have you updated the lm-sensors package to the latest version
released? 2.10.2 was just released, but the w83627ehf driver should
work fine with 2.10.1 on your w83627dhg. However, any earlier version
will not detect it correctly. In fact, can you upgrade to 2.10.2? It
would help tracking down bugs.

I'm signing on to irc.freenode.net #linux-sensors. Look for user
dch24. Either way, the report is appreciated!

David

On 1/18/07, Daniel Ceregatti <daniel at ceregatti.org> wrote:
>
>  Hi,
>
>  I have the EVGA 122-CK-NF68-AR motherboard, which supposedly has this chip.
> I've patched my 2.6.19.2 vanilla kernel with both the patch in this email (1
> hunk failed in Documentation, no big), and the full file, to no avail. The
> module loads, but sensors reports this for both:
>
>  w83627dhg-isa-0290
>  Adapter: ISA adapter
>
>  A while back I had spoken with Khali on IRC. He told me to change the
> w83627ehf.c (from vanilla 2.6.18 or so at the time) manually. I changed it
> thusly (This is against vanilla 2.6.19.2):
>
>  -- snip --
>
>  --- drivers/hwmon/w83627ehf.c.orig      2007-01-18
> 21:44:12.065293174 -0800
>  +++ drivers/hwmon/w83627ehf.c.manually_patched  2007-01-18
> 21:49:52.365378263 -0800
>  @@ -65,8 +65,11 @@
>   #define SIO_REG_ENABLE         0x30    /* Logical device enable */
>   #define SIO_REG_ADDR           0x60    /* Logical device address (2 bytes)
> */
>
>  -#define SIO_W83627EHF_ID       0x8840
>  -#define SIO_ID_MASK            0xFFC0
>  +//#define SIO_W83627EHF_ID     0x8840
>  +//#define SIO_ID_MASK          0xFFC0
>  +
>  +#define SIO_W83627EHF_ID        0xA020
>  +#define SIO_ID_MASK            0xFFF0
>
>   static inline void
>   superio_outb(int reg, int val)
>
>  -- snip --
>
>  I load this module and run sensors:
>
>  w83627ehf-isa-0290
>  Adapter: ISA adapter
>  VCore:     +1.41 V  (min =  +0.00 V, max =  +1.74 V)
>  in1:      +11.14 V  (min =  +8.34 V, max = +11.83 V)
>  AVCC:      +3.20 V  (min =  +0.10 V, max =  +2.43 V) ALARM
>  3VCC:      +3.20 V  (min =  +1.15 V, max =  +3.57 V)
>  in4:       +1.48 V  (min =  +0.15 V, max =  +0.59 V) ALARM
>  in5:       +1.54 V  (min =  +0.72 V, max =  +1.71 V)
>  in6:       +5.86 V  (min =  +5.27 V, max =  +0.10 V) ALARM
>  VSB:       +3.20 V  (min =  +0.18 V, max =  +1.39 V) ALARM
>  VBAT:      +3.14 V  (min =  +2.64 V, max =  +3.84 V)
>  in9:       +0.10 V  (min =  +1.74 V, max =  +0.08 V) ALARM
>  Case Fan:    0 RPM  (min = 4560 RPM, div = 8) ALARM
>  CPU Fan:  2909 RPM  (min = 2636 RPM, div = 8)
>  Aux Fan:  1424 RPM  (min = 3879 RPM, div = 4) ALARM
>  fan4:        0 RPM  (min =  703 RPM, div = 32) ALARM
>  fan5:        0 RPM  (min = 3375 RPM, div = 8) ALARM
>  Sys Temp:    -65?C  (high =    +0?C, hyst =  +127?C)
>  CPU Temp:  +70.0?C  (high = +127.0?C, hyst =  +0.0?C)   ALARM
>  AUX Temp:  +57.0?C  (high = +127.0?C, hyst =  +0.0?C)
>
>  I'm guessing (hoping, actually) that most of that is wrong, but at the very
> least, I'm getting output.
>
>  Any thoughts as to how I should proceed? I suppose I could try the -mm
> tree, but I'm hesitant, as vanilla has always served me well.
>
>  Daniel Ceregatti
>
>  (Please CC me as I'm not on the list. Thanks)

