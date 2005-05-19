From: phil@edgedesign.us (Philip Edelbrock)
Date: Thu, 19 May 2005 06:25:17 +0000
Subject: voodoo3 3000, Fedora 2, lm_sensors, and tv-out
Message-Id: <415AFFE0.103@edgedesign.us>
List-Id: <lm-sensors.vger.kernel.org>
References: <4159F327.8080607@edgedesign.us>
In-Reply-To: <4159F327.8080607@edgedesign.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Thanks.  Marion, you want to give it a shot and let us know how it 
works?  Perhaps Perry can work with you if you run into problems.

Thanks everyone!


Phil

Perry Gilfillan wrote:
> Philip Edelbrock wrote:
> 
>> Ah, I didn't realize you were trying to do this under a 2.6.x kernel 
>> (which I think FC2 is, check /proc/version).  We haven't ported the 
>> bt869 driver over yet.  I think last we heard Berni (b-gruber@gmx.de) 
>> was working on the port.  Check with him, or use a 2.4.x kernel.
>>
>> Sorry for the hassle.
>>
>>
>> Phil
>>
>> Marion Bates wrote:
>>
>>> Wow, thanks for replying so fast!
>>>
>>> I found another howto, very similar to Ollila's, here: 
>>> http://www.perturb.org/content/linux-voodoo3.txt  and at least it 
>>> gave me some diagnostic commands to run. Here they are, with their 
>>> output:
>>> [...]
> 
> 
> I have received a patch for the bt869 on 2.6.x from another V3TV user, 
> but have not had time to work with it, except to clean up the white 
> space, and I guesss T.Reed has not forwarded it to the sensors list 
> himself yet, so I'll do it now ;)
> 
> Here is what T.Reed wrote at the time:
>  > Curiousity got the better of me and I ended up porting the bt869
>  > driver to work with the 2.6.8.1 kernel. Attached is a diff taken in
>  > /usr/src/linux/drivers/i2c. I started with the lm_sensors-2.8.7
>  > version of bt869.c and used a diff between lm_sensors ds1621.c and the
>  > 2.6 version of ds1621.c to guide me through the porting process (that,
>  > and numerous compiler errors  :)
> 
> And these are my findings on functionality:
>  > As for functionality, I had more problems than you.  640x480 works out
>  > of the box as the default mode, but I could not test any other modes
>  > because the encoder seems to shut down as soon as I touch any of the
>  > /sys/bus/i2c/devices/*/* files, even just to cat the current values.
>  > The 640x480 would go to a blue screen when I try to cat some value,
>  > and test any other mode was futile because echoing to any of the files
>  > would result in a blue screen.
> 
> I have to reload the module to get output working again.
> 
> I've barely skimmed the data sheet, so can't offer any improvements at 
> this time.
> 
> Marion Bates wrote:
>  >
>  > eeprom-i2c-0-50
>  > Adapter: I2C Voodoo3/Banshee adapter
>  > Unknown EEPROM type (255).
>  >
>  > (I dunno what that's supposed to be telling me, but here it is
>  > anyway.)
>  >
> 
> The eeprom module will get false positive hits on i2c clients on the 
> voodoo3 i2c bus.  You will need to include the line 'option eeprom 
> checksum=1' in modules.conf or modprobe.conf to prevent this.
> 
> I think the false hit you saw would be for the ddcmon client.
> 
> Are you in fact using a 2.6.x kernel?  With a 2.6 kernel you would look 
> in /sys/bus/i2c/devices/?-0044/
> 
> Cheers,
> 
> Perry
> -----
> Gilfillan Family: http://www.gilfillan.org/
> 
> Projects:
>   V3TV:        http://www.gilfillan.org/v3tv/
>   VPX3224:    http://www.gilfillan.org/vpx3224/
>   V3TV-V4L2:    http://www.gilfillan.org/v3tv-v4l2/
>   snd-tvmixer:    http://www.gilfillan.org/ALSA/
>                 http://v3tv.sourceforge.net/
> 
> 
> ------------------------------------------------------------------------
> 
> --- drivers/i2c/chips/Kconfig.orig	2004-09-28 20:19:53.020219040 -0500
> +++ drivers/i2c/chips/Kconfig	2004-09-28 20:22:47.553157280 -0500
> @@ -75,6 +75,16 @@
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called fscher.
>  
> +config SENSORS_BT869
> +      	tristate "Brooktree BT869"
> +	depends on I2C && EXPERIMENTAL
> +	select I2C_SENSOR
> +	help
> +	  If you say yes here you get support for the Brooktree BT869.
> +
> +	  This driver can also be built as a module.  If so, the module
> +	  will be called bt869.
> +
>  config SENSORS_GL518SM
>  	tristate "Genesys Logic GL518SM"
>  	depends on I2C && EXPERIMENTAL
> --- drivers/i2c/chips/Makefile.orig	2004-09-28 20:19:53.242176995 -0500
> +++ drivers/i2c/chips/Makefile	2004-09-28 20:21:22.286309372 -0500
> @@ -10,6 +10,7 @@
>  obj-$(CONFIG_SENSORS_ADM1021)	+= adm1021.o
>  obj-$(CONFIG_SENSORS_ADM1025)	+= adm1025.o
>  obj-$(CONFIG_SENSORS_ADM1031)	+= adm1031.o
> +obj-$(CONFIG_SENSORS_BT869)	+= bt869.o
>  obj-$(CONFIG_SENSORS_DS1621)	+= ds1621.o
>  obj-$(CONFIG_SENSORS_EEPROM)	+= eeprom.o
>  obj-$(CONFIG_SENSORS_FSCHER)	+= fscher.o
> --- drivers/i2c/chips/bt869.c.orig	2004-09-28 21:26:32.654568626 -0500
> +++ drivers/i2c/chips/bt869.c	2004-09-28 20:59:04.664747206 -0500
> @@ -0,0 +1,776 @@
> +/*
> +    bt869.c - Part of lm_sensors, Linux kernel modules for hardware
> +             monitoring
> +
> +    Copyright (c) 1998, 1999  Frodo Looijaard <frodol@dds.nl>
> +    Copyright (c) 2001, 2002  Stephen Davies  <steve@daviesfam.org>
> +    
> +    Ported to Linux 2.6 by Toby Reed <treed2@wsu.edu>
> +
> +    This program is free software; you can redistribute it and/or modify
> +    it under the terms of the GNU General Public License as published by
> +    the Free Software Foundation; either version 2 of the License, or
> +    (at your option) any later version.
> +
> +    This program is distributed in the hope that it will be useful,
> +    but WITHOUT ANY WARRANTY; without even the implied warranty of
> +    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +    GNU General Public License for more details.
> +
> +    You should have received a copy of the GNU General Public License
> +    along with this program; if not, write to the Free Software
> +    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
> +*/
> +
> +#define DEBUG 1
> +
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/slab.h>
> +#include <linux/i2c.h>
> +#include <linux/i2c-sensor.h>
> +
> +MODULE_LICENSE("GPL");
> +
> +/* Addresses to scan */
> +
> +static unsigned short normal_i2c[] = { I2C_CLIENT_END };
> +
> +/* found only at 0x44 or 0x45 */
> +
> +static unsigned short normal_i2c_range[] = { 0x44, 0x45, I2C_CLIENT_END };
> +static unsigned int normal_isa[] = { I2C_CLIENT_ISA_END };
> +static unsigned int normal_isa_range[] = { I2C_CLIENT_ISA_END };
> +
> +/* Insmod parameters */
> +
> +SENSORS_INSMOD_1(bt869);
> +
> +/* Many bt869 constants specified below */
> +
> +/* The bt869 registers */
> +
> +/* Coming soon: Many, many registers */
> +
> +/* Conversions. Rounding and limit checking is only done on the TO_REG
> +   variants. Note that you should be a bit careful with which arguments
> +   these macros are called: arguments may be evaluated more than once.
> +   Fixing this is just not worth it. */
> +
> +    /*none */
> +
> +/* Initial values */
> +
> +/*none*/
> +
> +/* Each client has this additional data */
> +
> +struct bt869_data {
> +	struct i2c_client client;
> +	int sysctl_id;
> +	struct semaphore update_lock;
> +	char valid;		/* !=0 if following fields are valid */
> +	unsigned long last_updated;	/* In jiffies */
> +	u8 status[3];		/* Register values */
> +	u16 res[2];		/* Resolution XxY */
> +	u8 ntsc;		/* 1=NTSC, 0=PAL */
> +	u8 half;		/* go half res */
> +	u8 depth;		/* screen depth */
> +	u8 colorbars;		/* turn on/off colorbar calibration screen */
> +	u8 svideo;		/* output format: (2=RGB) 1=SVIDEO, 0=Composite */
> +};
> +
> +static int bt869_attach_adapter(struct i2c_adapter *adapter);
> +
> +static int bt869_detect(struct i2c_adapter *adapter, int address, int kind);
> +
> +static void bt869_init_client(struct i2c_client *client);
> +
> +static int bt869_detach_client(struct i2c_client *client);
> +
> +static int bt869_read_value(struct i2c_client *client, u8 reg);
> +
> +static int bt869_write_value(struct i2c_client *client, u8 reg, u16 value);
> +
> +static void bt869_write_values(struct i2c_client *client, u16 * values);
> +
> +static struct bt869_data *bt869_update_client(struct device *dev);
> +
> +/* This is the driver that will be inserted */
> +
> +static struct i2c_driver bt869_driver = {
> +	.owner = THIS_MODULE,
> +	.name = "bt869",
> +	.id = I2C_DRIVERID_BT869,
> +	.flags = I2C_DF_NOTIFY,
> +	.attach_adapter = bt869_attach_adapter,
> +	.detach_client = bt869_detach_client,
> +
> +};
> +
> +/* -- SENSORS SYSCTL START -- */
> +
> +#define BT869_SYSCTL_STATUS 1000
> +#define BT869_SYSCTL_NTSC   1001
> +#define BT869_SYSCTL_HALF   1002
> +#define BT869_SYSCTL_RES    1003
> +#define BT869_SYSCTL_COLORBARS    1004
> +#define BT869_SYSCTL_DEPTH  1005
> +#define BT869_SYSCTL_SVIDEO 1006
> +
> +/* -- SENSORS SYSCTL END -- */
> +
> +/* ******************
> +
> +720x576, 27.5MHz, PAL, no overscan compensation.
> +
> +This mode should be use for digital video, DVD playback etc.
> +NOTE: This mode for PAL, see 720x480 for an equivalent NTSC mode
> +
> +NOTE:    -- Steve Davies <steve@daviesfam.org>
> +
> +Compatible X modeline:
> +
> +    Mode        "720x576-BT869"
> +        DotClock        27.5
> +        HTimings        720 744 800 880
> +        VTimings        576 581 583 625
> +    EndMode
> +
> +625LINE=1		625 line output format
> +BST_AMP[7:0]=x57 87	Burst ampl. multiplication factor (PAL std??)
> +BY_PLL=0		Use the PLL
> +CATTENUATE[2:0]=0	No chroma attenuation
> +CCF1B1[7:0]=0		close caption stuff
> +CCF1B2[7:0]=0		close caption stuff
> +CCF2B1[7:0]=0		close caption stuff
> +CCF2B2[7:0]=0		close caption stuff
> +CCORING[2:0]=0		Bypass chroma coring
> +CCR_START[8:0]=0 [CCR_START[8]=0; CCR_START[7:0]=0]	Close-caption clock runin start from hsync
> +CC_ADD[11:0]=xD2 210  [CC_ADD[11:8]=0; CC_ADD[7:0]=xD2]	Close-caption DTO increment
> +CHECK_STAT=0		Don't check monitor status
> +CLPF[1:0]=0	  	Hoz chroma lowpass filter=Bypass
> +DACDISA=1		Disable DACA
> +DACDISB=0		Don't disable DACB
> +DACDISC=0		Don't disable DACC
> +DACOFF=0		Don't disable the DACs
> +DATDLY = 0		normal
> +DATSWP=0		normal
> +DCHROMA=0		Don't blank chroma
> +DIS_FFILT=1		Disable flickerfilter
> +DIS_GMSHC=1		Disable chroma psuedo-gamma removal
> +DIS_GMSHY=1		Disable luma pseudo gamma removal
> +DIS_GMUSHC=1		Disable chroma anti-pseudo gamma removal
> +DIS_GMUSHY=1		Disable luma anti-pseudo gamma removal
> +DIS_SCRESET=0		Normal subcarrier phase resets
> +DIS_YFLPF=0		Disable Luma initial hoz low pass filter
> +DIV2=0			Input pixel rate not divided by 2
> +ECBAR=0			No colour bars
> +ECCF1=0			Disable closed caption
> +ECCF2=0			Disable closed caption
> +ECCGATE=0		Normal close caption encoding
> +ECLIP=0			0=disable clipping
> +EN_ASYNC=0		set to 0 for normal operation
> +EN_BLANKO=0		BLANK is an input
> +EN_DOT=0		Disables dot clock sync on BLANK pin
> +EN_OUT=1		Allows outputs to be enabled
> +EN_XCLK=1		Use CLKI pin as clock source
> +ESTATUS[1:0]=0		Used to select readback register
> +FIELDI=0		Logical 1 on FIELD indicates even field
> +F_SELC[2:0]=0		5 line chroma flickerfilter
> +F_SELY[2:0]=0		5 line luma flickerfilter
> +HBURST_BEGIN[7:0]=x98 152	Chroma burst start point in clocks
> +HBURST_END[7:0]=x58 88		Chroma burst end point in clocks - 128
> +HSYNCI=0			Active low HSYNC
> +HSYNC_WIDTH[7:0]=x80 128	Analogue sync width in clocks
> +HSYNOFFSET[9:0]=0  [HSYNOFFSET[9:8]=0; HSYNOFFSET[7:0]=0]	hsync in "standard position"
> +HSYNWIDTH[5:0]=2						2 pixel hsync width
> +H_ACTIVE[9:0]=x2D0 720  [H_ACTIVE[9:8]=2; H_ACTIVE[7:0]=xD0]	Active pixels per line
> +H_BLANKI[8:0]=x84 132  [H_BLANKI[8]=0; H_BLANKI[7:0]=x84]	End of blanking of input video
> +H_BLANKO[9:0]=x120 288  [H_BLANKO[9:8]=1; H_BLANKO[7:0]=x20]	End of blanking from hoz sync leading edge
> +H_CLKI[10:0]=x378 888  [H_CLKI[10:8]=3; H_CLKI[7:0]=x78]	Input line length total in clocks
> +H_CLKO[11:0]=x6e0 1760  [H_CLKO[11:8]=6; H_CLKO[7:0]=xe0]	Output clocks per line
> +H_FRACT[7:0]=0		0 fractional input clocks per line
> +IN_MODE[2:0]=0		24Bit RGB muxed
> +LUMADLY[1:0]=0		0 pixel delay on Y_DLY luma
> +MCB[7:0]=x49 73		Mult factor for CB prior to subcarrier mod.
> +MCR[7:0]=x82 130	Mult factor for CR prior to subcarrier mod.
> +MODE2X=0		Don't divide clock input by 2
> +MSC[31:0]=x2945E0B4 692445365  [MSC[31:24]=x29; MSC[23:16]=x45; MSC[15:8]=xE0; MSC[7:0]=xB4] Subcarrier incr.
> +MY[7:0]=x8C 140		Mult factor for Y
> +NI_OUT=0		Normal interlaced output
> +OUT_MODE[1:0]=0		video0-3 is CVBS, Y, C, Y_DLY
> +OUT_MUXA[1:0]=0		Don't care as DACA is disabled
> +OUT_MUXB[1:0]=1		Output video[1] (Y) on DACB
> +OUT_MUXC[1:0]=2		Output video[2] (C) on DACC
> +PAL_MD=1		Video output in PAL mode
> +PHASE_OFF[7:0]=0	Subcarrier phase offset
> +PLL_FRACT[15:0]=x30 48  [PLL_FRACT[15:8]=0x0; PLL_FRACT[7:0]=x30] frac portion of pll multiplier
> +PLL_INT[5:0]=0x0C 12	Int portion of pll multiplier
> +SETUP=0			7.5-IRE setup disabled
> +SLAVER=1		
> +SRESET=0		Don't do a software reset
> +SYNC_AMP[7:0]=xF0 240	Sync amp mult. factor (PAL std???)
> +VBLANKDLY=0		Extra line of blanking in 2nd field?
> +VSYNCI=0		Active low VSYNC
> +VSYNC_DUR=0		2.5line VSYNC duration on output
> +VSYNCOFFSET[10:0]=0  [VSYNOFFSET[10:8]=0; VSYNOFFSET[7:0]=0]	VSYNC in standard position
> +VSYNWIDTH[2:0]=1	1 line of vsync width
> +V_ACTIVEI[9:0]=x240 576  [V_ACTIVEI[9:0]=2; V_ACTIVEI[7:0]=x40]	Active input lines
> +V_ACTIVEO[8:0]=x122 290  [V_ACTIVE0[8]=1; V_ACTIVEO[7:0]=x22]
> +V_BLANKI[7:0]=x2A 42	Input lines from vsync to first active line
> +V_BLANKO[7:0]=x16 22
> +V_LINESI[9:0]=x271 625  [V_LINESI[9:8]=2; V_LINESI[7:0]=x71]	Number of input lines
> +V_SCALE[13:0]=x1000 4096  [V_SCALE[13:8]=x10; V_SCALE[7:0]=0]	Vert scale coefficient="none"?
> +YATTENUATE[2:0]=0	no luma attenuation
> +YCORING[2:0]=0		Luma-coring bypass
> +YLPF[1:0]=0		Luma hoz low pass filter=bypass
> +
> +***************** */
> +
> +static u16 registers_720_576[] = {
> +	0x6e, 0x00,		/* HSYNOFFSET[7:0]=0 */
> +	0x70, 0x02,		/* HSYNOFFSET[9:8]=0; HSYNWIDTH[5:0]=2 */
> +	0x72, 0x00,		/* VSYNOFFSET[7:0]=0 */
> +	0x74, 0x01,		/* DATDLY = 0; DATSWP=0; VSYNOFFSET[10:8]=0; VSYNWIDTH[2:0]=1 */
> +	0x76, 0xe0,		/* H_CLKO[7:0]=xe0 */
> +	0x78, 0xd0,		/* H_ACTIVE[7:0]=xD0 */
> +	0x7a, 0x80,		/* HSYNC_WIDTH[7:0]=x80 */
> +	0x7c, 0x98,		/* HBURST_BEGIN[7:0]=x98 */
> +	0x7e, 0x58,		/* HBURST_END[7:0]=x58 */
> +	0x80, 0x20,		/* H_BLANKO[7:0]=x20 */
> +	0x82, 0x16,		/* V_BLANKO[7:0]=x16 */
> +	0x84, 0x22,		/* V_ACTIVEO[7:0]=x22 */
> +	0x86, 0xa6,		/* V_ACTIVE0[8]=1; H_ACTIVE[9:8]=2; H_CLKO[11:8]=6 */
> +	0x88, 0x00,		/* H_FRACT[7:0]=0 */
> +	0x8a, 0x78,		/* H_CLKI[7:0]=x78 */
> +	0x8c, 0x80,		/* H_BLANKI[7:0]=x84 */
> +	0x8e, 0x03,		/* VBLANKDLY=0; H_BLANKI[8]=0; H_CLKI[10:8]=3 */
> +	0x90, 0x71,		/* V_LINESI[7:0]=x71 */
> +	0x92, 0x2a,		/* V_BLANKI[7:0]=x2A */
> +	0x94, 0x40,		/* V_ACTIVEI[7:0]=x40 */
> +	0x96, 0x0a,		/* CLPF[1:0]=0; YLPF[1:0]=0; V_ACTIVEI[9:0]=2; V_LINESI[9:8]=2 */
> +	0x98, 0x00,		/* V_SCALE[7:0]=0 */
> +	0x9a, 0x50,		/* H_BLANKO[9:8]=1; V_SCALE[13:8]=x10 */
> +	0x9c, 0x30,		/* PLL_FRACT[7:0]=x30 */
> +	0x9e, 0x0,		/* PLL_FRACT[15:8]=0x0 */
> +	0xa0, 0x8c,		/* EN_XCLK=1; BY_PLL=0; PLL_INT[5:0]=0x0C */
> +	0xa2, 0x24,		/* ECLIP=0; PAL_MD=1; DIS_SCRESET=0; VSYNC_DUR=0; 625LINE=1; SETUP=0; NI_OUT=0 */
> +	0xa4, 0xf0,		/* SYNC_AMP[7:0]=xF0 */
> +	0xa6, 0x57,		/* BST_AMP[7:0]=x57 */
> +	0xa8, 0x82,		/* MCR[7:0]=x82 */
> +	0xaa, 0x49,		/* MCB[7:0]=x49 */
> +	0xac, 0x8c,		/* MY[7:0]=x8C */
> +	0xae, 0xb4,		/* MSC[7:0]=xb4 */
> +	0xb0, 0xe0,		/* MSC[15:8]=xe0 */
> +	0xb2, 0x45,		/* MSC[23:16]=x45 */
> +	0xb4, 0x29,		/* MSC[31:24]=x29 */
> +	0xb6, 0x00,		/* PHASE_OFF[7:0]=0 */
> +	//0xba, 0x21,     /* SRESET=0; CHECK_STAT=0; SLAVER=1; DACOFF=0; DACDISC=0; DACDISB=0; DACDISA=1 */
> +	0xc4, 0x01,		/* ESTATUS[1:0]=0; ECCF2=0; ECCF1=0; ECCGATE=0; ECBAR=0; DCHROMA=0; EN_OUT=1 */
> +	0xc6, 0x00,		/* EN_BLANKO=0; EN_DOT=0; FIELDI=0; VSYNCI=0; HSYNCI=0; IN_MODE[2:0]=0(24bRGB) */
> +	0xc8, 0x40,		/* DIS_YFLPF=0; DIS_FFILT=1; F_SELC[2:0]=0; F_SELY[2:0]=0 */
> +	0xca, 0xc0,		/* DIS_GMUSHY=1; DIS_GMSHY=1; YCORING[2:0]=0; YATTENUATE[2:0]=0 */
> +	0xcc, 0xc0,		/* DIS_GMUSHC=1; DIS_GMSHC=1; CCORING[2:0]=0; CATTENUATE[2:0]=0 */
> +	//0xce, 0x24,       /* OUT_MUXC=2 [C]; OUT_MUXB=1 [Y]; OUT_MUXA=0 [CVBS, but disabled]*/
> +	//0xce, 0x04,       /* OUT_MUXC=0 [CVBS]; OUT_MUXB=1 [Y]; OUT_MUXA=0 [CVBS, but disabled]*/
> +	0xd6, 0x00,		/* OUT_MODE[1:0]=0; LUMADLY[1:0]=0 */
> +	0, 0
> +};
> +
> +/* ******************
> +
> +720x480, 27.5MHz, NTSC no overscan compensation.
> +
> +This mode should be use for digital video, DVD playback etc.
> +NOTE: This mode for NTSC, see 720x576 for an equivalent PAL mode
> +NOTE:    -- Steve Davies <steve@daviesfam.org>
> +
> +Compatible X modeline:
> +
> +    Mode        "720x480-BT869"
> +        DotClock        27.5
> +        HTimings        720 744 800 872
> +        VTimings        480 483 485 525
> +    EndMode
> +
> +625LINE=0							not 625 line output format
> +BST_AMP[7:0]=x74 116						Burst ampl. multiplication factor (NTSC std??)
> +BY_PLL=0							Use the PLL
> +CATTENUATE[2:0]=0						No chroma attenuation
> +CCF1B1[7:0]=0							close caption stuff
> +CCF1B2[7:0]=0							close caption stuff
> +CCF2B1[7:0]=0							close caption stuff
> +CCF2B2[7:0]=0							close caption stuff
> +CCORING[2:0]=0							Bypass chroma coring
> +CCR_START[8:0]=0 [CCR_START[8]=0; CCR_START[7:0]=0]		Close-caption clock runin start from hsync
> +CC_ADD[11:0]=xD2 210  [CC_ADD[11:8]=0; CC_ADD[7:0]=xD2]		Close-caption DTO increment
> +CHECK_STAT=0							Don't check monitor status
> +CLPF[1:0]=0						  	Hoz chroma lowpass filter=Bypass
> +DACDISA=1							Disable DACA
> +DACDISB=0							Don't disable DACB
> +DACDISC=0							Don't disable DACC
> +DACOFF=0							Don't disable the DACs
> +DATDLY = 0							normal
> +DATSWP=0							normal
> +DCHROMA=0							Don't blank chroma
> +DIS_FFILT=1							Disable flickerfilter
> +DIS_GMSHC=1							Disable chroma psuedo-gamma removal
> +DIS_GMSHY=1							Disable luma pseudo gamma removal
> +DIS_GMUSHC=1							Disable chroma anti-pseudo gamma removal
> +DIS_GMUSHY=1							Disable luma anti-pseudo gamma removal
> +DIS_SCRESET=0							Normal subcarrier phase resets
> +DIS_YFLPF=0							Disable Luma initial hoz low pass filter
> +DIV2=0								Input pixel rate not divided by 2
> +ECBAR=0								No colour bars
> +ECCF1=0								Disable closed caption
> +ECCF2=0								Disable closed caption
> +ECCGATE=0							Normal close caption encoding
> +ECLIP=0								0=disable clipping
> +EN_ASYNC=0							set to 0 for normal operation
> +EN_BLANKO=0							BLANK is an input
> +EN_DOT=0							Disables dot clock sync on BLANK pin
> +EN_OUT=1							Allows outputs to be enabled
> +EN_XCLK=1							Use CLKI pin as clock source
> +ESTATUS[1:0]=0							Used to select readback register
> +FIELDI=0							Logical 1 on FIELD indicates even field
> +F_SELC[2:0]=0							5 line chroma flickerfilter
> +F_SELY[2:0]=0							5 line luma flickerfilter
> +HBURST_BEGIN[7:0]=x92 146					Chroma burst start point in clocks
> +HBURST_END[7:0]=x57 87						Chroma burst end point in clocks - 128
> +HSYNCI=0							Active low HSYNC
> +HSYNC_WIDTH[7:0]=x80 128					Analogue sync width in clocks
> +HSYNOFFSET[9:0]=0  [HSYNOFFSET[9:8]=0; HSYNOFFSET[7:0]=0]	hsync in "standard position"
> +HSYNWIDTH[5:0]=2						2 pixel hsync width
> +H_ACTIVE[9:0]=x2D0 720  [H_ACTIVE[9:8]=2; H_ACTIVE[7:0]=xD0]	Active pixels per line
> +H_BLANKI[8:0]=x80 128  [H_BLANKI[8]=0; H_BLANKI[7:0]=x80]	End of blanking of input video
> +H_BLANKO[9:0]=x102 258  [H_BLANKO[9:8]=1; H_BLANKO[7:0]=x2]	End of blanking from hoz sync leading edge
> +H_CLKI[10:0]=x368 872  [H_CLKI[10:8]=3; H_CLKI[7:0]=x68]	Input line length total in clocks
> +H_CLKO[11:0]=x6d0 1744  [H_CLKO[11:8]=6; H_CLKO[7:0]=xD0]	Output clocks per line
> +H_FRACT[7:0]=0							0 fractional input clocks per line
> +IN_MODE[2:0]=0							24Bit RGB muxed
> +LUMADLY[1:0]=0							0 pixel delay on Y_DLY luma
> +MCB[7:0]=x43 67							Mult factor for CB prior to subcarrier mod.
> +MCR[7:0]=x77 119						Mult factor for CR prior to subcarrier mod.
> +MODE2X=0							Don't divide clock input by 2
> +MSC[31:0]=x215282E5 559055589  [MSC[31:24]=x21; MSC[23:16]=x52; MSC[15:8]=x82; MSC[7:0]=xE5] Subcarrier incr.
> +MY[7:0]=x85 133							Mult factor for Y
> +NI_OUT=0							Normal interlaced output
> +OUT_MODE[1:0]=0							video0-3 is CVBS, Y, C, Y_DLY
> +OUT_MUXA[1:0]=0							Don't care as DACA is disabled
> +OUT_MUXB[1:0]=1							Output video[1] (Y) on DACB
> +OUT_MUXC[1:0]=2							Output video[2] (C) on DACC
> +PAL_MD=0							Video output in PAL mode? No.
> +PHASE_OFF[7:0]=0						Subcarrier phase offset
> +PLL_FRACT[15:0]=x30 48  [PLL_FRACT[15:8]=0x0; PLL_FRACT[7:0]=x30] frac portion of pll multiplier
> +PLL_INT[5:0]=0x0C 12						Int portion of pll multiplier
> +SETUP=1								7.5-IRE enabled for NTSC
> +SLAVER=1							
> +SRESET=0							Don't do a software reset
> +SYNC_AMP[7:0]=xE5 229						Sync amp mult. factor (PAL std???)
> +VBLANKDLY=0							Extra line of blanking in 2nd field?
> +VSYNCI=0							Active low VSYNC
> +VSYNC_DUR=1							2.5line VSYNC duration on output (Yes for NTSC)
> +VSYNCOFFSET[10:0]=0  [VSYNOFFSET[10:8]=0; VSYNOFFSET[7:0]=0]	VSYNC in standard position
> +VSYNWIDTH[2:0]=1						1 line of vsync width
> +V_ACTIVEI[9:0]=x1E0 480  [V_ACTIVEI[9:0]=1; V_ACTIVEI[7:0]=xE0]	Active input lines
> +V_ACTIVEO[8:0]=xF0 240  [V_ACTIVE0[8]=0; V_ACTIVEO[7:0]=xF0]
> +V_BLANKI[7:0]=x2A 42						Input lines from vsync to first active line
> +V_BLANKO[7:0]=x16 22
> +V_LINESI[9:0]=x20D 525  [V_LINESI[9:8]=2; V_LINESI[7:0]=x0D]	Number of input lines
> +V_SCALE[13:0]=x1000 4096  [V_SCALE[13:8]=x10; V_SCALE[7:0]=0]	Vert scale coefficient="none"?
> +YATTENUATE[2:0]=0						no luma attenuation
> +YCORING[2:0]=0							Luma-coring bypass
> +YLPF[1:0]=0							Luma hoz low pass filter=bypass
> +
> +***************** */
> +
> +static u16 registers_720_480[] = {
> +	0x6e, 0x00,		/* HSYNOFFSET[7:0]=0 */
> +	0x70, 0x02,		/* HSYNOFFSET[9:8]=0; HSYNWIDTH[5:0]=2 */
> +	0x72, 0x00,		/* VSYNOFFSET[7:0]=0 */
> +	0x74, 0x01,		/* DATDLY = 0; DATSWP=0; VSYNOFFSET[10:8]=0; VSYNWIDTH[2:0]=1 */
> +	0x76, 0xD0,		/* H_CLKO[7:0]=xD0 */
> +	0x78, 0xD0,		/* H_ACTIVE[7:0]=xD0 */
> +	0x7a, 0x80,		/* HSYNC_WIDTH[7:0]=x80 */
> +	0x7c, 0x92,		/* HBURST_BEGIN[7:0]=x92 */
> +	0x7e, 0x57,		/* HBURST_END[7:0]=x57 */
> +	0x80, 0x02,		/* H_BLANKO[7:0]=x2 */
> +	0x82, 0x16,		/* V_BLANKO[7:0]=x16 */
> +	0x84, 0xF0,		/* V_ACTIVEO[7:0]=xF0 */
> +	0x86, 0x26,		/* V_ACTIVE0[8]=0; H_ACTIVE[9:8]=2; H_CLKO[11:8]=6 */
> +	0x88, 0x00,		/* H_FRACT[7:0]=0 */
> +	0x8a, 0xD0,		/* H_CLKI[7:0]=xD0 */
> +	0x8c, 0x80,		/* H_BLANKI[7:0]=x80 */
> +	0x8e, 0x03,		/* VBLANKDLY=0; H_BLANKI[8]=0; H_CLKI[10:8]=3 */
> +	0x90, 0x0D,		/* V_LINESI[7:0]=x0D */
> +	0x92, 0x2A,		/* V_BLANKI[7:0]=x2A */
> +	0x94, 0xE0,		/* V_ACTIVEI[7:0]=xE0 */
> +	0x96, 0x06,		/* CLPF[1:0]=0; YLPF[1:0]=0; V_ACTIVEI[9:8]=1; V_LINESI[9:8]=2 */
> +	0x98, 0x00,		/* V_SCALE[7:0]=0 */
> +	0x9a, 0x50,		/* H_BLANKO[9:8]=1; V_SCALE[13:8]=x10 */
> +	0x9c, 0x30,		/* PLL_FRACT[7:0]=x30 */
> +	0x9e, 0x0,		/* PLL_FRACT[15:8]=0x0 */
> +	0xa0, 0x8c,		/* EN_XCLK=1; BY_PLL=0; PLL_INT[5:0]=0x0C */
> +	0xa2, 0x0A,		/* ECLIP=0; PAL_MD=0; DIS_SCRESET=0; VSYNC_DUR=1; 625LINE=0; SETUP=1; NI_OUT=0 */
> +	0xa4, 0xE5,		/* SYNC_AMP[7:0]=xE5 */
> +	0xa6, 0x74,		/* BST_AMP[7:0]=x74 */
> +	0xa8, 0x77,		/* MCR[7:0]=x77 */
> +	0xaa, 0x43,		/* MCB[7:0]=x43 */
> +	0xac, 0x85,		/* MY[7:0]=x85 */
> +	0xae, 0xE5,		/* MSC[7:0]=xE5 */
> +	0xb0, 0x82,		/* MSC[15:8]=x82 */
> +	0xb2, 0x52,		/* MSC[23:16]=x52 */
> +	0xb4, 0x21,		/* MSC[31:24]=x21 */
> +	0xb6, 0x00,		/* PHASE_OFF[7:0]=0 */
> +	//0xba, 0x21,     /* SRESET=0; CHECK_STAT=0; SLAVER=1; DACOFF=0; DACDISC=0; DACDISB=0; DACDISA=1 */
> +	0xc4, 0x01,		/* ESTATUS[1:0]=0; ECCF2=0; ECCF1=0; ECCGATE=0; ECBAR=0; DCHROMA=0; EN_OUT=1 */
> +	0xc6, 0x00,		/* EN_BLANKO=0; EN_DOT=0; FIELDI=0; VSYNCI=0; HSYNCI=0; IN_MODE[2:0]=0(24bRGB) */
> +	0xc8, 0x40,		/* DIS_YFLPF=0; DIS_FFILT=1; F_SELC[2:0]=0; F_SELY[2:0]=0 */
> +	0xca, 0xc0,		/* DIS_GMUSHY=1; DIS_GMSHY=1; YCORING[2:0]=0; YATTENUATE[2:0]=0 */
> +	0xcc, 0xc0,		/* DIS_GMUSHC=1; DIS_GMSHC=1; CCORING[2:0]=0; CATTENUATE[2:0]=0 */
> +	//0xce, 0x24,       /* OUT_MUXC=2 [C]; OUT_MUXB=1 [Y]; OUT_MUXA=0 [CVBS, but disabled]*/
> +	//0xce, 0x04,       /* OUT_MUXC=0 [CVBS]; OUT_MUXB=1 [Y]; OUT_MUXA=0 [CVBS, but disabled]*/
> +	0xd6, 0x00,		/* OUT_MODE[1:0]=0; LUMADLY[1:0]=0 */
> +	0, 0
> +};
> +
> +int bt869_id = 0;
> +
> +#define show(suffix, value)					\
> +static ssize_t show_##suffix(struct device *dev, char *buf)	\
> +{								\
> +	struct bt869_data *data = bt869_update_client(dev);	\
> +	return sprintf(buf, "%d\n", data->value);		\
> +}
> +
> +show(ntsc, ntsc);
> +show(half, half);
> +show(colorbars, colorbars);
> +show(depth, depth);
> +show(svideo, svideo);
> +
> +static ssize_t show_res(struct device *dev, char *buf)
> +{
> +	struct bt869_data *data = bt869_update_client(dev);
> +	return sprintf(buf, "%d %d\n", data->res[0], data->res[1]);
> +}
> +
> +#define set(suffix, value)					\
> +static ssize_t set_##suffix(struct device *dev, const char *buf, \
> + size_t count)							\
> +{								\
> +/*	struct i2c_client *client = to_i2c_client(dev);*/	\
> +	 struct bt869_data *data = bt869_update_client(dev);	\
> +	 data->value = simple_strtoul(buf, NULL, 10);		\
> +/*	bt869_write_value(client, reg, data->value);*/		\
> +	 bt869_update_client(dev);				\
> +	 return count;						\
> +}
> +
> +set(ntsc, ntsc);
> +set(half, half);
> +set(colorbars, colorbars);
> +set(depth, depth);
> +set(svideo, svideo);
> +
> +static ssize_t set_res(struct device *dev, const char *buf, size_t count)
> +{
> +/*	struct i2c_client *client = to_i2c_client(dev);*/
> +	struct bt869_data *data = bt869_update_client(dev);
> +	char *endp = NULL;
> +	data->res[0] = simple_strtoul(buf, &endp, 10);
> +	data->res[1] = simple_strtoul(endp + 1, NULL, 10);
> +/*	bt869_write_value(client, reg, data->res[0]);*/
> +	bt869_update_client(dev);
> +	return count;
> +}
> +
> +static ssize_t show_status(struct device *dev, char *buf)
> +{
> +	struct bt869_data *data = bt869_update_client(dev);
> +	return sprintf(buf, "%d %d %d\n", data->status[0], data->status[1],
> +		       data->status[2]);
> +}
> +
> +static DEVICE_ATTR(status, S_IRUGO, show_status, NULL);
> +static DEVICE_ATTR(ntsc, S_IWUSR | S_IRUGO, show_ntsc, set_ntsc);
> +static DEVICE_ATTR(res, S_IWUSR | S_IRUGO, show_res, set_res);
> +static DEVICE_ATTR(half, S_IWUSR | S_IRUGO, show_half, set_half);
> +static DEVICE_ATTR(colorbars, S_IWUSR | S_IRUGO, show_colorbars, set_colorbars);
> +static DEVICE_ATTR(depth, S_IWUSR | S_IRUGO, show_depth, set_depth);
> +static DEVICE_ATTR(svideo, S_IWUSR | S_IRUGO, show_svideo, set_svideo);
> +
> +static int bt869_attach_adapter(struct i2c_adapter *adapter)
> +{
> +	return i2c_detect(adapter, &addr_data, bt869_detect);
> +}
> +
> +/* This function is called by i2c_detect */
> +
> +int bt869_detect(struct i2c_adapter *adapter, int address, int kind)
> +{
> +	int cur;
> +	struct i2c_client *new_client;
> +	struct bt869_data *data;
> +	int err = 0;
> +
> +	if (!i2c_check_functionality
> +	    (adapter,
> +	     I2C_FUNC_SMBUS_READ_BYTE | I2C_FUNC_SMBUS_WRITE_BYTE_DATA))
> +
> +		goto exit;
> +
> +	/* OK. For now, we presume we have a valid client. We now create the
> +	   client structure, even though we cannot fill it completely yet.
> +	   But it allows us to access bt869_{read,write}_value. */
> +
> +	if (!(data = kmalloc(sizeof(struct bt869_data), GFP_KERNEL))) {
> +		err = -ENOMEM;
> +		goto exit;
> +	}
> +
> +	memset(data, 0, sizeof(struct bt869_data));
> +	new_client = &data->client;
> +	i2c_set_clientdata(new_client, data);
> +	new_client->addr = address;
> +	new_client->adapter = adapter;
> +	new_client->driver = &bt869_driver;
> +	new_client->flags = 0;
> +
> +	/* Now, we do the remaining detection. It is lousy. */
> +
> +	i2c_smbus_write_byte_data(new_client, 0xC4, 0);	/* set status bank 0 */
> +	cur = i2c_smbus_read_byte(new_client);
> +	printk("bt869.o: address 0x%X testing-->0x%X\n", address, cur);
> +	if ((cur & 0xE0) != 0x20)
> +		goto exit_free;
> +
> +	/* Determine the chip type */
> +
> +	kind = ((cur & 0x20) >> 5);
> +
> +	/* Fill in the remaining client fields and put it into the global list */
> +
> +	strlcpy(new_client->name, "bt869", I2C_NAME_SIZE);
> +	new_client->id = bt869_id++;
> +	data->valid = 0;
> +	init_MUTEX(&data->update_lock);
> +
> +	/* Tell the I2C layer a new client has arrived */
> +
> +	if ((err = i2c_attach_client(new_client)))
> +		goto exit_free;
> +
> +	bt869_init_client((struct i2c_client *)new_client);
> +	device_create_file(&new_client->dev, &dev_attr_status);
> +	device_create_file(&new_client->dev, &dev_attr_ntsc);
> +	device_create_file(&new_client->dev, &dev_attr_res);
> +	device_create_file(&new_client->dev, &dev_attr_half);
> +	device_create_file(&new_client->dev, &dev_attr_colorbars);
> +	device_create_file(&new_client->dev, &dev_attr_depth);
> +	device_create_file(&new_client->dev, &dev_attr_svideo);
> +
> +	return 0;
> +
> +/* OK, this is not exactly good programming practice, usually. But it is
> +   very code-efficient in this case. */
> +
> +      exit_free:
> +	kfree(data);
> +
> +      exit:
> +	return err;
> +
> +}
> +
> +static int bt869_detach_client(struct i2c_client *client)
> +{
> +	int err;
> +
> +/*	i2c_deregister_entry(((struct bt869_data *) (client->data))->
> +				 sysctl_id);*/
> +
> +	if ((err = i2c_detach_client(client))) {
> +		dev_err(&client->dev,
> +			"bt869.o: Client deregistration failed, client not detached.\n");
> +		return err;
> +	}
> +	kfree(i2c_get_clientdata(client));
> +
> +	return 0;
> +
> +}
> +
> +/* All registers are byte-sized.
> +   bt869 uses a high-byte first convention, which is exactly opposite to
> +   the usual practice. */
> +
> +static int bt869_read_value(struct i2c_client *client, u8 reg)
> +{
> +	return i2c_smbus_read_byte(client);
> +}
> +
> +/* All registers are byte-sized.
> +   bt869 uses a high-byte first convention, which is exactly opposite to
> +   the usual practice. */
> +
> +static int bt869_write_value(struct i2c_client *client, u8 reg, u16 value)
> +{
> +	dev_err(&client->dev, "bt869.o: write_value(0x%X, 0x%X)\n", reg, value);
> +	return i2c_smbus_write_byte_data(client, reg, value);
> +}
> +
> +static void bt869_write_values(struct i2c_client *client, u16 * values)
> +{
> +	/* writes set of registers from array.  0,0 marks end of table */
> +
> +	while (*values) {
> +		bt869_write_value(client, values[0], values[1]);
> +		values += 2;
> +	}
> +}
> +
> +static void bt869_init_client(struct i2c_client *client)
> +{
> +	struct bt869_data *data = i2c_get_clientdata(client);
> +
> +	/* Initialize the bt869 chip */
> +
> +	bt869_write_value(client, 0x0ba, 0x80);
> +
> +	//   bt869_write_value(client,0x0D6, 0x00);
> +	/* Be a slave to the clock on the Voodoo3 */
> +
> +	bt869_write_value(client, 0xa0, 0x80);
> +	bt869_write_value(client, 0xba, 0x20);
> +
> +	/* depth bpp */
> +
> +	bt869_write_value(client, 0x0C6, 0x001);
> +	bt869_write_value(client, 0xC4, 1);
> +
> +	/* Flicker free enable and config */
> +
> +	bt869_write_value(client, 0xC8, 0);
> +	data->res[0] = 640;
> +	data->res[1] = 480;
> +	data->ntsc = 1;
> +	data->half = 0;
> +	data->colorbars = 0;
> +	data->svideo = 0;
> +
> +	data->depth = 16;
> +}
> +
> +static struct bt869_data *bt869_update_client(struct device *dev)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct bt869_data *data = i2c_get_clientdata(client);
> +
> +	down(&data->update_lock);
> +
> +	if ((jiffies - data->last_updated > HZ + HZ / 2) ||
> +	    (jiffies < data->last_updated) || !data->valid) {
> +		dev_dbg(&client->dev, "Starting bt869 update\n");
> +		if ((data->res[0] = 800) && (data->res[1] = 600)) {
> +			/* 800x600 built-in mode */
> +			bt869_write_value(client, 0xB8, (2 + (!data->ntsc)));
> +			bt869_write_value(client, 0xa0, 0x80 + 0x11);
> +			printk("bt869.o: writing into config -->0x%X\n",
> +			       (2 + (!data->ntsc)));
> +		} else if ((data->res[0] = 720) && (data->res[1] = 576)) {
> +			/* 720x576 no-overscan-compensation mode suitable for PAL DVD playback */
> +			data->ntsc = 0;	/* This mode always PAL */
> +			bt869_write_values(client, registers_720_576);
> +		} else if ((data->res[0] = 720) && (data->res[1] = 480)) {
> +			/* 720x480 no-overscan-compensation mode suitable for NTSC DVD playback */
> +			data->ntsc = 1;	/* This mode always NTSC */
> +			bt869_write_values(client, registers_720_480);
> +		} else {
> +			/* 640x480 built-in mode */
> +			bt869_write_value(client, 0xB8, (!data->ntsc));
> +			bt869_write_value(client, 0xa0, 0x80 + 0x0C);
> +			printk("bt869.o: writing into config -->0x%X\n",
> +			       (0 + (!data->ntsc)));
> +			if ((data->res[0] != 640) || (data->res[1] != 480)) {
> +				printk
> +				    ("bt869.o:  Warning: arbitrary resolutions not "
> +				     "supported yet.  Using 640x480.\n");
> +				data->res[0] = 640;
> +				data->res[1] = 480;
> +			}
> +		}
> +		/* Set colour depth */
> +		if ((data->depth != 24) && (data->depth != 16))
> +			data->depth = 16;
> +		if (data->depth = 16)
> +			bt869_write_value(client, 0x0C6, 0x001);
> +		if (data->depth = 24)
> +			bt869_write_value(client, 0x0C6, 0x000);
> +		/* set "half" resolution mode */
> +		bt869_write_value(client, 0xd4, data->half << 6);
> +		/* Set composite/svideo mode, also enable the right dacs */
> +
> +		switch (data->svideo) {
> +		case 2:	/* RGB */
> +			/* requires hardware mod on Voodoo3 to get all outputs,
> +			   untested in practice... Feedback to steve@daviesfam.org please */
> +			bt869_write_value(client, 0xd6, 0x0c);
> +			bt869_write_value(client, 0xce, 0x24);
> +			bt869_write_value(client, 0xba, 0x20);
> +
> +			break;
> +
> +		case 1:	/* Svideo */
> +			bt869_write_value(client, 0xce, 0x24);
> +			bt869_write_value(client, 0xba, 0x21);
> +
> +			break;
> +
> +		default:	/* Composite */
> +			bt869_write_value(client, 0xce, 0x0);
> +			bt869_write_value(client, 0xba, 0x21);
> +
> +			break;
> +
> +		}
> +
> +		/* Enable outputs */
> +		bt869_write_value(client, 0xC4, 1);
> +		/* Issue timing reset */
> +		bt869_write_value(client, 0x6c, 0x80);
> +		/* Read back status registers */
> +		bt869_write_value(client, 0xC4, 1 | (data->colorbars << 2));
> +		data->status[0] = bt869_read_value(client, 1);
> +		bt869_write_value(client, 0xC4, 0x41 | (data->colorbars << 2));
> +		data->status[1] = bt869_read_value(client, 1);
> +		bt869_write_value(client, 0xC4, 0x81 | (data->colorbars << 2));
> +		data->status[2] = bt869_read_value(client, 1);
> +		bt869_write_value(client, 0xC4, 0x0C1 | (data->colorbars << 2));
> +		data->last_updated = jiffies;
> +		data->valid = 1;
> +	}
> +	up(&data->update_lock);
> +
> +	return data;
> +}
> +
> +static int __init bt869_init(void)
> +{
> +	return i2c_add_driver(&bt869_driver);
> +}
> +
> +static void __exit bt869_exit(void)
> +{
> +	i2c_del_driver(&bt869_driver);
> +}
> +
> +MODULE_AUTHOR
> +    ("Frodo Looijaard <frodol@dds.nl>, "
> +     "Philip Edelbrock <phil@netroedge.com>, "
> +     "Stephen Davies <steve@daviesfam.org>");
> +
> +MODULE_DESCRIPTION("bt869 driver");
> +module_init(bt869_init);
> +module_exit(bt869_exit);
