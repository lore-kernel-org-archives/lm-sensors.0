From: oliver@are-b.org (oliver)
Date: Thu, 19 May 2005 06:23:30 +0000
Subject: update on bt869 driver
Message-Id: <3C86969E.6030708@are-b.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

I don't know where or how to deal with this, but I wrote some updates on 
the bt869 module i'd like to submit so I just attached the sensors.h 
bt869.c and bt869 (doc) as I don't even know how to do a simple 'diff' 
yet ....
Hey I'm a newbie at this .. actually this is my first time.
-------------- next part --------------
/*
    bt869.c - Part of lm_sensors, Linux kernel modules for hardware
             monitoring

    Copyright (c) 1998, 1999  Frodo Looijaard <>
    Copyright (c) 2001, 2002  Stephen Davies  <steve@daviesfam.org>
    Copyright (c) 2002, 2002  Oliver Schinagl <oliver@are-b.org>

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program; if not, write to the Free Software
    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
*/


#define DEBUG 1

#include <linux/version.h>
#include <linux/module.h>
#include <linux/slab.h>
#include <linux/i2c.h>
#include "sensors.h"
#include "version.h"
#include <linux/init.h>

#ifdef MODULE_LICENSE
MODULE_LICENSE("GPL");
#endif

#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,2,18)) || \
    (LINUX_VERSION_CODE = KERNEL_VERSION(2,3,0))
#define init_MUTEX(s) do { *(s) = MUTEX; } while(0)
#endif

#ifndef THIS_MODULE
#define THIS_MODULE NULL
#endif


/* Addresses to scan */
static unsigned short normal_i2c[] = { SENSORS_I2C_END };

/* found only at 0x44 or 0x45 */
static unsigned short normal_i2c_range[] = { 0x44, 0x45, SENSORS_I2C_END };
static unsigned int normal_isa[] = { SENSORS_ISA_END };
static unsigned int normal_isa_range[] = { SENSORS_ISA_END };

/* Insmod parameters */
SENSORS_INSMOD_1(bt869);

/* Many bt869 constants specified below */

/* The bt869 registers */
/* Coming soon: Many, many registers */

/* Conversions. Rounding and limit checking is only done on the TO_REG
   variants. Note that you should be a bit careful with which arguments
   these macros are called: arguments may be evaluated more than once.
   Fixing this is just not worth it. */

   /*none */

/* Initial values */
/*none*/

/* Each client has this additional data */
struct bt869_data {
	int sysctl_id;

	struct semaphore update_lock;
	char valid;		/* !=0 if following fields are valid */
	unsigned long last_updated;	/* In jiffies */

	u8 status[3];		/* Register values */
	u16 res[2];		/* Resolution XxY */
	u8 ntsc;		/* 1=NTSC, 0=PAL */
	u8 half;		/* go half res */
	u8 depth;		/* screen depth */
	u8 colorbars;		/* turn on/off colorbar calibration screen */
        u8 svideo;              /* output format: (2=RGB) 1=SVIDEO, 0=Composite */
	u8 sreset;		/* perform a softreset (SRESET) */
	u8 treset;		/* Perform a timing Reset (T-bit from the specs TIMING RESET in Register Bit Map */
	u8 reload;		/* Reload the default settings */
	u8 tv_off;		/* Turn picture to the TV on or Off */

};

#ifdef MODULE
extern int init_module(void);
extern int cleanup_module(void);
#endif				/* MODULE */

#ifdef MODULE
static
#else
extern
#endif
int __init sensors_bt869_init(void);
static int __init bt869_cleanup(void);
static int bt869_attach_adapter(struct i2c_adapter *adapter);
static int bt869_detect(struct i2c_adapter *adapter, int address,
			unsigned short flags, int kind);
static void bt869_init_client(struct i2c_client *client);
static int bt869_detach_client(struct i2c_client *client);
static int bt869_command(struct i2c_client *client, unsigned int cmd,
			 void *arg);
static void bt869_inc_use(struct i2c_client *client);
static void bt869_dec_use(struct i2c_client *client);
static int bt869_read_value(struct i2c_client *client, u8 reg);
static int bt869_write_value(struct i2c_client *client, u8 reg, u16 value);
static void bt869_write_values(struct i2c_client *client, u16 *values);
static void bt869_status(struct i2c_client *client, int operation,
			 int ctl_name, int *nrels_mag, long *results);
static void bt869_ntsc(struct i2c_client *client, int operation,
		       int ctl_name, int *nrels_mag, long *results);
static void bt869_res(struct i2c_client *client, int operation,
		      int ctl_name, int *nrels_mag, long *results);
static void bt869_half(struct i2c_client *client, int operation,
		       int ctl_name, int *nrels_mag, long *results);
static void bt869_colorbars(struct i2c_client *client, int operation,
			    int ctl_name, int *nrels_mag, long *results);
static void bt869_svideo(struct i2c_client *client, int operation,
			    int ctl_name, int *nrels_mag, long *results);
static void bt869_depth(struct i2c_client *client, int operation,
			int ctl_name, int *nrels_mag, long *results);
static void bt869_sreset(struct i2c_client *client, int operation,
			int ctl_name, int *nrels_mag, long *results);
static void bt869_treset(struct i2c_client *client, int operation,
			int ctl_name, int *nrels_mag, long *results);
static void bt869_reload(struct i2c_client *client, int operation,
			int ctl_name, int *nrels_mag, long *results);
static void bt869_tv_off(struct i2c_client *client, int operation,
			int ctl_name, int *nrels_mag, long *results);
static void bt869_update_client(struct i2c_client *client);


/* This is the driver that will be inserted */
static struct i2c_driver bt869_driver = {
	/* name */ "BT869 video-output chip driver",
	/* id */ I2C_DRIVERID_BT869,
	/* flags */ I2C_DF_NOTIFY,
	/* attach_adapter */ &bt869_attach_adapter,
	/* detach_client */ &bt869_detach_client,
	/* command */ &bt869_command,
	/* inc_use */ &bt869_inc_use,
	/* dec_use */ &bt869_dec_use
};

/* These files are created for each detected bt869. This is just a template;
   though at first sight, you might think we could use a statically
   allocated list, we need some way to get back to the parent - which
   is done through one of the 'extra' fields which are initialized
   when a new copy is allocated. */
static ctl_table bt869_dir_table_template[] = {
	{BT869_SYSCTL_STATUS, "status", NULL, 0, 0444, NULL, &i2c_proc_real,
	 &i2c_sysctl_real, NULL, &bt869_status},
	{BT869_SYSCTL_NTSC, "ntsc", NULL, 0, 0644, NULL, &i2c_proc_real,
	 &i2c_sysctl_real, NULL, &bt869_ntsc},
	{BT869_SYSCTL_RES, "res", NULL, 0, 0644, NULL, &i2c_proc_real,
	 &i2c_sysctl_real, NULL, &bt869_res},
	{BT869_SYSCTL_HALF, "half", NULL, 0, 0644, NULL, &i2c_proc_real,
	 &i2c_sysctl_real, NULL, &bt869_half},
	{BT869_SYSCTL_COLORBARS, "colorbars", NULL, 0, 0644, NULL, &i2c_proc_real,
	 &i2c_sysctl_real, NULL, &bt869_colorbars},
	{BT869_SYSCTL_DEPTH, "depth", NULL, 0, 0644, NULL, &i2c_proc_real,
	 &i2c_sysctl_real, NULL, &bt869_depth},
	{BT869_SYSCTL_SVIDEO, "svideo", NULL, 0, 0644, NULL, &i2c_proc_real,
	 &i2c_sysctl_real, NULL, &bt869_svideo},
	{BT869_SYSCTL_SRESET, "sreset", NULL, 0, 0664, NULL, &i2c_proc_real,
	 &i2c_sysctl_real, NULL, &bt869_sreset},
	{BT869_SYSCTL_TRESET, "treset", NULL, 0, 0664, NULL, &i2c_proc_real,
	 &i2c_sysctl_real, NULL, &bt869_treset},
	{BT869_SYSCTL_RELOAD, "reload", NULL, 0, 0664, NULL, &i2c_proc_real,
	 &i2c_sysctl_real, NULL, &bt869_reload},
	{BT869_SYSCTL_TV_OFF, "tv_off", NULL, 0, 0664, NULL, &i2c_proc_real,
	 &i2c_sysctl_real, NULL, &bt869_tv_off},
	{0}
};

/* ******************

720x576, 27.5MHz, PAL, no overscan compensation.

This mode should be use for digital video, DVD playback etc.

NOTE: This mode for PAL, see 720x480 for an equivalent NTSC mode
NOTE:    -- Steve Davies <steve@daviesfam.org>


Compatible X modeline:

    Mode        "720x576-BT869"
        DotClock        27.5
        HTimings        720 744 800 880
        VTimings        576 581 583 625
    EndMode

NOTE: I noticed that this mode isn't perfectly centered. Here are my 3 mode lines for all pal settings I use.
NOTE: Feedback can be sent to me <oliver@are-b.org>

        ModeLine "640x480PAL" 29.50 640  675  678  944   480  530  535  625
        Modeline "720x576PAL" 27.50 720  740  796  880   576  585  587  625
        ModeLine "800x600PAL" 36.00 800  800  802  960   600  653  655  750

625LINE=1							625 line output format
BST_AMP[7:0]=x57 87						Burst ampl. multiplication factor (PAL std??)
BY_PLL=0							Use the PLL
CATTENUATE[2:0]=0						No chroma attenuation
CCF1B1[7:0]=0							close caption stuff
CCF1B2[7:0]=0							close caption stuff
CCF2B1[7:0]=0							close caption stuff
CCF2B2[7:0]=0							close caption stuff
CCORING[2:0]=0							Bypass chroma coring
CCR_START[8:0]=0 [CCR_START[8]=0; CCR_START[7:0]=0]		Close-caption clock runin start from hsync
CC_ADD[11:0]=xD2 210  [CC_ADD[11:8]=0; CC_ADD[7:0]=xD2]		Close-caption DTO increment
CHECK_STAT=0							Don't check monitor status
CLPF[1:0]=0						  	Hoz chroma lowpass filter=Bypass
DACDISA=1							Disable DACA
DACDISB=0							Don't disable DACB
DACDISC=0							Don't disable DACC
DACOFF=0							Don't disable the DACs
DATDLY = 0							normal
DATSWP=0							normal
DCHROMA=0							Don't blank chroma
DIS_FFILT=1							Disable flickerfilter
DIS_GMSHC=1							Disable chroma psuedo-gamma removal
DIS_GMSHY=1							Disable luma pseudo gamma removal
DIS_GMUSHC=1							Disable chroma anti-pseudo gamma removal
DIS_GMUSHY=1							Disable luma anti-pseudo gamma removal
DIS_SCRESET=0							Normal subcarrier phase resets
DIS_YFLPF=0							Disable Luma initial hoz low pass filter
DIV2=0								Input pixel rate not divided by 2
ECBAR=0								No colour bars
ECCF1=0								Disable closed caption
ECCF2=0								Disable closed caption
ECCGATE=0							Normal close caption encoding
ECLIP=0								0=disable clipping
EN_ASYNC=0							set to 0 for normal operation
EN_BLANKO=0							BLANK is an input
EN_DOT=0							Disables dot clock sync on BLANK pin
EN_OUT=1							Allows outputs to be enabled
EN_XCLK=1							Use CLKI pin as clock source
ESTATUS[1:0]=0							Used to select readback register
FIELDI=0							Logical 1 on FIELD indicates even field
F_SELC[2:0]=0							5 line chroma flickerfilter
F_SELY[2:0]=0							5 line luma flickerfilter
HBURST_BEGIN[7:0]=x98 152					Chroma burst start point in clocks
HBURST_END[7:0]=x58 88						Chroma burst end point in clocks - 128
HSYNCI=0							Active low HSYNC
HSYNC_WIDTH[7:0]=x80 128					Analogue sync width in clocks
HSYNOFFSET[9:0]=0  [HSYNOFFSET[9:8]=0; HSYNOFFSET[7:0]=0]	hsync in "standard position"
HSYNWIDTH[5:0]=2						2 pixel hsync width
H_ACTIVE[9:0]=x2D0 720  [H_ACTIVE[9:8]=2; H_ACTIVE[7:0]=xD0]	Active pixels per line
H_BLANKI[8:0]=x84 132  [H_BLANKI[8]=0; H_BLANKI[7:0]=x84]	End of blanking of input video
H_BLANKO[9:0]=x120 288  [H_BLANKO[9:8]=1; H_BLANKO[7:0]=x20]	End of blanking from hoz sync leading edge
H_CLKI[10:0]=x378 888  [H_CLKI[10:8]=3; H_CLKI[7:0]=x78]	Input line length total in clocks
H_CLKO[11:0]=x6e0 1760  [H_CLKO[11:8]=6; H_CLKO[7:0]=xe0]	Output clocks per line
H_FRACT[7:0]=0							0 fractional input clocks per line
IN_MODE[2:0]=0							24Bit RGB muxed
LUMADLY[1:0]=0							0 pixel delay on Y_DLY luma
MCB[7:0]=x49 73							Mult factor for CB prior to subcarrier mod.
MCR[7:0]=x82 130						Mult factor for CR prior to subcarrier mod.
MODE2X=0							Don't divide clock input by 2
MSC[31:0]=x2945E0B4 692445365  [MSC[31:24]=x29; MSC[23:16]=x45; MSC[15:8]=xE0; MSC[7:0]=xB4] Subcarrier incr.
MY[7:0]=x8C 140							Mult factor for Y
NI_OUT=0							Normal interlaced output
OUT_MODE[1:0]=0							video0-3 is CVBS, Y, C, Y_DLY
OUT_MUXA[1:0]=0							Don't care as DACA is disabled
OUT_MUXB[1:0]=1							Output video[1] (Y) on DACB
OUT_MUXC[1:0]=2							Output video[2] (C) on DACC
PAL_MD=1							Video output in PAL mode
PHASE_OFF[7:0]=0						Subcarrier phase offset
PLL_FRACT[15:0]=x30 48  [PLL_FRACT[15:8]=0x0; PLL_FRACT[7:0]=x30] frac portion of pll multiplier
PLL_INT[5:0]=0x0C 12						Int portion of pll multiplier
SETUP=0								7.5-IRE setup disabled
SLAVER=1							
SRESET=0							Don't do a software reset
SYNC_AMP[7:0]=xF0 240						Sync amp mult. factor (PAL std???)
VBLANKDLY=0							Extra line of blanking in 2nd field?
VSYNCI=0							Active low VSYNC
VSYNC_DUR=0							2.5line VSYNC duration on output
VSYNCOFFSET[10:0]=0  [VSYNOFFSET[10:8]=0; VSYNOFFSET[7:0]=0]	VSYNC in standard position
VSYNWIDTH[2:0]=1						1 line of vsync width
V_ACTIVEI[9:0]=x240 576  [V_ACTIVEI[9:0]=2; V_ACTIVEI[7:0]=x40]	Active input lines
V_ACTIVEO[8:0]=x122 290  [V_ACTIVE0[8]=1; V_ACTIVEO[7:0]=x22]
V_BLANKI[7:0]=x2A 42						Input lines from vsync to first active line
V_BLANKO[7:0]=x16 22
V_LINESI[9:0]=x271 625  [V_LINESI[9:8]=2; V_LINESI[7:0]=x71]	Number of input lines
V_SCALE[13:0]=x1000 4096  [V_SCALE[13:8]=x10; V_SCALE[7:0]=0]	Vert scale coefficient="none"?
YATTENUATE[2:0]=0						no luma attenuation
YCORING[2:0]=0							Luma-coring bypass
YLPF[1:0]=0							Luma hoz low pass filter=bypass

***************** */

static u16 registers_720_576[]     {
      0x6e, 0x00,	/* HSYNOFFSET[7:0]=0 */
      0x70, 0x02,	/* HSYNOFFSET[9:8]=0; HSYNWIDTH[5:0]=2 */
      0x72, 0x00,	/* VSYNOFFSET[7:0]=0 */
      0x74, 0x01,	/* DATDLY = 0; DATSWP=0; VSYNOFFSET[10:8]=0; VSYNWIDTH[2:0]=1 */
      0x76, 0xe0,	/* H_CLKO[7:0]=xe0 */
      0x78, 0xd0,	/* H_ACTIVE[7:0]=xD0 */
      0x7a, 0x80,	/* HSYNC_WIDTH[7:0]=x80 */
      0x7c, 0x98,	/* HBURST_BEGIN[7:0]=x98 */
      0x7e, 0x58,	/* HBURST_END[7:0]=x58 */
      0x80, 0x20,	/* H_BLANKO[7:0]=x20 */
      0x82, 0x16,	/* V_BLANKO[7:0]=x16 */
      0x84, 0x22,	/* V_ACTIVEO[7:0]=x22 */
      0x86, 0xa6,	/* V_ACTIVE0[8]=1; H_ACTIVE[9:8]=2; H_CLKO[11:8]=6 */
      0x88, 0x00,	/* H_FRACT[7:0]=0 */
      0x8a, 0x78,	/* H_CLKI[7:0]=x78 */
      0x8c, 0x80,	/* H_BLANKI[7:0]=x84 */
      0x8e, 0x03,	/* VBLANKDLY=0; H_BLANKI[8]=0; H_CLKI[10:8]=3 */
      0x90, 0x71,	/* V_LINESI[7:0]=x71 */
      0x92, 0x2a,	/* V_BLANKI[7:0]=x2A */
      0x94, 0x40,	/* V_ACTIVEI[7:0]=x40 */
      0x96, 0x0a,	/* CLPF[1:0]=0; YLPF[1:0]=0; V_ACTIVEI[9:0]=2; V_LINESI[9:8]=2 */
      0x98, 0x00,	/* V_SCALE[7:0]=0 */
      0x9a, 0x50,	/* H_BLANKO[9:8]=1; V_SCALE[13:8]=x10 */
      0x9c, 0x30,	/* PLL_FRACT[7:0]=x30 */
      0x9e, 0x0,	/* PLL_FRACT[15:8]=0x0 */
      0xa0, 0x8c,	/* EN_XCLK=1; BY_PLL=0; PLL_INT[5:0]=0x0C */
      0xa2, 0x24,	/* ECLIP=0; PAL_MD=1; DIS_SCRESET=0; VSYNC_DUR=0; 625LINE=1; SETUP=0; NI_OUT=0 */
      0xa4, 0xf0,	/* SYNC_AMP[7:0]=xF0 */
      0xa6, 0x57,	/* BST_AMP[7:0]=x57 */
      0xa8, 0x82,	/* MCR[7:0]=x82 */
      0xaa, 0x49,	/* MCB[7:0]=x49 */
      0xac, 0x8c,	/* MY[7:0]=x8C */
      0xae, 0xb4,	/* MSC[7:0]=xb4 */
      0xb0, 0xe0,	/* MSC[15:8]=xe0 */
      0xb2, 0x45,	/* MSC[23:16]=x45 */
      0xb4, 0x29,	/* MSC[31:24]=x29 */
      0xb6, 0x00,	/* PHASE_OFF[7:0]=0 */
      //0xba, 0x21,	/* SRESET=0; CHECK_STAT=0; SLAVER=1; DACOFF=0; DACDISC=0; DACDISB=0; DACDISA=1 */
      0xc4, 0x01,	/* ESTATUS[1:0]=0; ECCF2=0; ECCF1=0; ECCGATE=0; ECBAR=0; DCHROMA=0; EN_OUT=1 */
      0xc6, 0x00,	/* EN_BLANKO=0; EN_DOT=0; FIELDI=0; VSYNCI=0; HSYNCI=0; IN_MODE[2:0]=0(24bRGB) */
      0xc8, 0x40,	/* DIS_YFLPF=0; DIS_FFILT=1; F_SELC[2:0]=0; F_SELY[2:0]=0 */
      0xca, 0xc0,	/* DIS_GMUSHY=1; DIS_GMSHY=1; YCORING[2:0]=0; YATTENUATE[2:0]=0 */
      0xcc, 0xc0,	/* DIS_GMUSHC=1; DIS_GMSHC=1; CCORING[2:0]=0; CATTENUATE[2:0]=0 */
      //0xce, 0x24,       /* OUT_MUXC=2 [C]; OUT_MUXB=1 [Y]; OUT_MUXA=0 [CVBS, but disabled]*/
      //0xce, 0x04,       /* OUT_MUXC=0 [CVBS]; OUT_MUXB=1 [Y]; OUT_MUXA=0 [CVBS, but disabled]*/
      0xd6, 0x00,	/* OUT_MODE[1:0]=0; LUMADLY[1:0]=0 */
      0, 0
    };


/* ******************

720x480, 27.5MHz, NTSC no overscan compensation.

This mode should be use for digital video, DVD playback etc.

NOTE: This mode for NTSC, see 720x576 for an equivalent PAL mode
NOTE:    -- Steve Davies <steve@daviesfam.org>

Compatible X modeline:

    Mode        "720x480-BT869"
        DotClock        27.5
        HTimings        720 744 800 872
        VTimings        480 483 485 525
    EndMode


625LINE=0							not 625 line output format
BST_AMP[7:0]=x74 116						Burst ampl. multiplication factor (NTSC std??)
BY_PLL=0							Use the PLL
CATTENUATE[2:0]=0						No chroma attenuation
CCF1B1[7:0]=0							close caption stuff
CCF1B2[7:0]=0							close caption stuff
CCF2B1[7:0]=0							close caption stuff
CCF2B2[7:0]=0							close caption stuff
CCORING[2:0]=0							Bypass chroma coring
CCR_START[8:0]=0 [CCR_START[8]=0; CCR_START[7:0]=0]		Close-caption clock runin start from hsync
CC_ADD[11:0]=xD2 210  [CC_ADD[11:8]=0; CC_ADD[7:0]=xD2]		Close-caption DTO increment
CHECK_STAT=0							Don't check monitor status
CLPF[1:0]=0						  	Hoz chroma lowpass filter=Bypass
DACDISA=1							Disable DACA
DACDISB=0							Don't disable DACB
DACDISC=0							Don't disable DACC
DACOFF=0							Don't disable the DACs
DATDLY = 0							normal
DATSWP=0							normal
DCHROMA=0							Don't blank chroma
DIS_FFILT=1							Disable flickerfilter
DIS_GMSHC=1							Disable chroma psuedo-gamma removal
DIS_GMSHY=1							Disable luma pseudo gamma removal
DIS_GMUSHC=1							Disable chroma anti-pseudo gamma removal
DIS_GMUSHY=1							Disable luma anti-pseudo gamma removal
DIS_SCRESET=0							Normal subcarrier phase resets
DIS_YFLPF=0							Disable Luma initial hoz low pass filter
DIV2=0								Input pixel rate not divided by 2
ECBAR=0								No colour bars
ECCF1=0								Disable closed caption
ECCF2=0								Disable closed caption
ECCGATE=0							Normal close caption encoding
ECLIP=0								0=disable clipping
EN_ASYNC=0							set to 0 for normal operation
EN_BLANKO=0							BLANK is an input
EN_DOT=0							Disables dot clock sync on BLANK pin
EN_OUT=1							Allows outputs to be enabled
EN_XCLK=1							Use CLKI pin as clock source
ESTATUS[1:0]=0							Used to select readback register
FIELDI=0							Logical 1 on FIELD indicates even field
F_SELC[2:0]=0							5 line chroma flickerfilter
F_SELY[2:0]=0							5 line luma flickerfilter
HBURST_BEGIN[7:0]=x92 146					Chroma burst start point in clocks
HBURST_END[7:0]=x57 87						Chroma burst end point in clocks - 128
HSYNCI=0							Active low HSYNC
HSYNC_WIDTH[7:0]=x80 128					Analogue sync width in clocks
HSYNOFFSET[9:0]=0  [HSYNOFFSET[9:8]=0; HSYNOFFSET[7:0]=0]	hsync in "standard position"
HSYNWIDTH[5:0]=2						2 pixel hsync width
H_ACTIVE[9:0]=x2D0 720  [H_ACTIVE[9:8]=2; H_ACTIVE[7:0]=xD0]	Active pixels per line
H_BLANKI[8:0]=x80 128  [H_BLANKI[8]=0; H_BLANKI[7:0]=x80]	End of blanking of input video
H_BLANKO[9:0]=x102 258  [H_BLANKO[9:8]=1; H_BLANKO[7:0]=x2]	End of blanking from hoz sync leading edge
H_CLKI[10:0]=x368 872  [H_CLKI[10:8]=3; H_CLKI[7:0]=x68]	Input line length total in clocks
H_CLKO[11:0]=x6d0 1744  [H_CLKO[11:8]=6; H_CLKO[7:0]=xD0]	Output clocks per line
H_FRACT[7:0]=0							0 fractional input clocks per line
IN_MODE[2:0]=0							24Bit RGB muxed
LUMADLY[1:0]=0							0 pixel delay on Y_DLY luma
MCB[7:0]=x43 67							Mult factor for CB prior to subcarrier mod.
MCR[7:0]=x77 119						Mult factor for CR prior to subcarrier mod.
MODE2X=0							Don't divide clock input by 2
MSC[31:0]=x215282E5 559055589  [MSC[31:24]=x21; MSC[23:16]=x52; MSC[15:8]=x82; MSC[7:0]=xE5] Subcarrier incr.
MY[7:0]=x85 133							Mult factor for Y
NI_OUT=0							Normal interlaced output
OUT_MODE[1:0]=0							video0-3 is CVBS, Y, C, Y_DLY
OUT_MUXA[1:0]=0							Don't care as DACA is disabled
OUT_MUXB[1:0]=1							Output video[1] (Y) on DACB
OUT_MUXC[1:0]=2							Output video[2] (C) on DACC
PAL_MD=0							Video output in PAL mode? No.
PHASE_OFF[7:0]=0						Subcarrier phase offset
PLL_FRACT[15:0]=x30 48  [PLL_FRACT[15:8]=0x0; PLL_FRACT[7:0]=x30] frac portion of pll multiplier
PLL_INT[5:0]=0x0C 12						Int portion of pll multiplier
SETUP=1								7.5-IRE enabled for NTSC
SLAVER=1							
SRESET=0							Don't do a software reset
SYNC_AMP[7:0]=xE5 229						Sync amp mult. factor (PAL std???)
VBLANKDLY=0							Extra line of blanking in 2nd field?
VSYNCI=0							Active low VSYNC
VSYNC_DUR=1							2.5line VSYNC duration on output (Yes for NTSC)
VSYNCOFFSET[10:0]=0  [VSYNOFFSET[10:8]=0; VSYNOFFSET[7:0]=0]	VSYNC in standard position
VSYNWIDTH[2:0]=1						1 line of vsync width
V_ACTIVEI[9:0]=x1E0 480  [V_ACTIVEI[9:0]=1; V_ACTIVEI[7:0]=xE0]	Active input lines
V_ACTIVEO[8:0]=xF0 240  [V_ACTIVE0[8]=0; V_ACTIVEO[7:0]=xF0]
V_BLANKI[7:0]=x2A 42						Input lines from vsync to first active line
V_BLANKO[7:0]=x16 22
V_LINESI[9:0]=x20D 525  [V_LINESI[9:8]=2; V_LINESI[7:0]=x0D]	Number of input lines
V_SCALE[13:0]=x1000 4096  [V_SCALE[13:8]=x10; V_SCALE[7:0]=0]	Vert scale coefficient="none"?
YATTENUATE[2:0]=0						no luma attenuation
YCORING[2:0]=0							Luma-coring bypass
YLPF[1:0]=0							Luma hoz low pass filter=bypass

***************** */

static u16 registers_720_480[]     {
      0x6e, 0x00,	/* HSYNOFFSET[7:0]=0 */
      0x70, 0x02,	/* HSYNOFFSET[9:8]=0; HSYNWIDTH[5:0]=2 */
      0x72, 0x00,	/* VSYNOFFSET[7:0]=0 */
      0x74, 0x01,	/* DATDLY = 0; DATSWP=0; VSYNOFFSET[10:8]=0; VSYNWIDTH[2:0]=1 */
      0x76, 0xD0,	/* H_CLKO[7:0]=xD0 */
      0x78, 0xD0,	/* H_ACTIVE[7:0]=xD0 */
      0x7a, 0x80,	/* HSYNC_WIDTH[7:0]=x80 */
      0x7c, 0x92,	/* HBURST_BEGIN[7:0]=x92 */
      0x7e, 0x57,	/* HBURST_END[7:0]=x57 */
      0x80, 0x02,	/* H_BLANKO[7:0]=x2 */
      0x82, 0x16,	/* V_BLANKO[7:0]=x16 */
      0x84, 0xF0,	/* V_ACTIVEO[7:0]=xF0 */
      0x86, 0x26,	/* V_ACTIVE0[8]=0; H_ACTIVE[9:8]=2; H_CLKO[11:8]=6 */
      0x88, 0x00,	/* H_FRACT[7:0]=0 */
      0x8a, 0xD0,	/* H_CLKI[7:0]=xD0 */
      0x8c, 0x80,	/* H_BLANKI[7:0]=x80 */
      0x8e, 0x03,	/* VBLANKDLY=0; H_BLANKI[8]=0; H_CLKI[10:8]=3 */
      0x90, 0x0D,	/* V_LINESI[7:0]=x0D */
      0x92, 0x2A,	/* V_BLANKI[7:0]=x2A */
      0x94, 0xE0,	/* V_ACTIVEI[7:0]=xE0 */
      0x96, 0x06,	/* CLPF[1:0]=0; YLPF[1:0]=0; V_ACTIVEI[9:8]=1; V_LINESI[9:8]=2 */
      0x98, 0x00,	/* V_SCALE[7:0]=0 */
      0x9a, 0x50,	/* H_BLANKO[9:8]=1; V_SCALE[13:8]=x10 */
      0x9c, 0x30,	/* PLL_FRACT[7:0]=x30 */
      0x9e, 0x0,	/* PLL_FRACT[15:8]=0x0 */
      0xa0, 0x8c,	/* EN_XCLK=1; BY_PLL=0; PLL_INT[5:0]=0x0C */
      0xa2, 0x0A,	/* ECLIP=0; PAL_MD=0; DIS_SCRESET=0; VSYNC_DUR=1; 625LINE=0; SETUP=1; NI_OUT=0 */
      0xa4, 0xE5,	/* SYNC_AMP[7:0]=xE5 */
      0xa6, 0x74,	/* BST_AMP[7:0]=x74 */
      0xa8, 0x77,	/* MCR[7:0]=x77 */
      0xaa, 0x43,	/* MCB[7:0]=x43 */
      0xac, 0x85,	/* MY[7:0]=x85 */
      0xae, 0xE5,	/* MSC[7:0]=xE5 */
      0xb0, 0x82,	/* MSC[15:8]=x82 */
      0xb2, 0x52,	/* MSC[23:16]=x52 */
      0xb4, 0x21,	/* MSC[31:24]=x21 */
      0xb6, 0x00,	/* PHASE_OFF[7:0]=0 */
      //0xba, 0x21,	/* SRESET=0; CHECK_STAT=0; SLAVER=1; DACOFF=0; DACDISC=0; DACDISB=0; DACDISA=1 */
      0xc4, 0x01,	/* ESTATUS[1:0]=0; ECCF2=0; ECCF1=0; ECCGATE=0; ECBAR=0; DCHROMA=0; EN_OUT=1 */
      0xc6, 0x00,	/* EN_BLANKO=0; EN_DOT=0; FIELDI=0; VSYNCI=0; HSYNCI=0; IN_MODE[2:0]=0(24bRGB) */
      0xc8, 0x40,	/* DIS_YFLPF=0; DIS_FFILT=1; F_SELC[2:0]=0; F_SELY[2:0]=0 */
      0xca, 0xc0,	/* DIS_GMUSHY=1; DIS_GMSHY=1; YCORING[2:0]=0; YATTENUATE[2:0]=0 */
      0xcc, 0xc0,	/* DIS_GMUSHC=1; DIS_GMSHC=1; CCORING[2:0]=0; CATTENUATE[2:0]=0 */
      //0xce, 0x24,       /* OUT_MUXC=2 [C]; OUT_MUXB=1 [Y]; OUT_MUXA=0 [CVBS, but disabled]*/
      //0xce, 0x04,       /* OUT_MUXC=0 [CVBS]; OUT_MUXB=1 [Y]; OUT_MUXA=0 [CVBS, but disabled]*/
      0xd6, 0x00,	/* OUT_MODE[1:0]=0; LUMADLY[1:0]=0 */
      0, 0
    };


/* Used by init/cleanup */
static int __initdata bt869_initialized = 0;

int bt869_id = 0;

int bt869_attach_adapter(struct i2c_adapter *adapter)
{
	return i2c_detect(adapter, &addr_data, bt869_detect);
}

/* This function is called by i2c_detect */
int bt869_detect(struct i2c_adapter *adapter, int address,
		 unsigned short flags, int kind)
{
	int i, cur;
	struct i2c_client *new_client;
	struct bt869_data *data;
	int err = 0;
	const char *type_name, *client_name;


	printk("bt869.o:  probing address %d .\n", address);
	/* Make sure we aren't probing the ISA bus!! This is just a safety check
	   at this moment; i2c_detect really won't call us. */
#ifdef DEBUG
	if (i2c_is_isa_adapter(adapter)) {
		printk
		    ("bt869.o: bt869_detect called for an ISA bus adapter?!?\n");
		return 0;
	}
#endif

	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_READ_BYTE |
				     I2C_FUNC_SMBUS_WRITE_BYTE_DATA))
		    goto ERROR0;

	/* OK. For now, we presume we have a valid client. We now create the
	   client structure, even though we cannot fill it completely yet.
	   But it allows us to access bt869_{read,write}_value. */
	if (!(new_client = kmalloc(sizeof(struct i2c_client) +
				   sizeof(struct bt869_data),
				   GFP_KERNEL))) {
		err = -ENOMEM;
		goto ERROR0;
	}

	data 	    (struct bt869_data *) (((struct i2c_client *) new_client) + 1);
	new_client->addr = address;
	new_client->data = data;
	new_client->adapter = adapter;
	new_client->driver = &bt869_driver;
	new_client->flags = 0;

	/* Now, we do the remaining detection. It is lousy. */
	i2c_smbus_write_byte_data(new_client, 0xC4, 0);	/* set status bank 0 */
	cur = i2c_smbus_read_byte(new_client);
	printk("bt869.o: address 0x%X testing-->0x%X\n", address, cur);
	if ((cur & 0xE0) != 0x20)
		goto ERROR1;

	/* Determine the chip type */
	kind = ((cur & 0x20) >> 5);

	if (kind) {
		type_name = "bt869";
		client_name = "bt869 chip";
		printk("bt869.o: BT869 detected\n");
	} else {
		type_name = "bt868";
		client_name = "bt868 chip";
		printk("bt869.o: BT868 detected\n");
	}

	/* Fill in the remaining client fields and put it into the global list */
	strcpy(new_client->name, client_name);

	new_client->id = bt869_id++;
	data->valid = 0;
	init_MUTEX(&data->update_lock);

	/* Tell the I2C layer a new client has arrived */
	if ((err = i2c_attach_client(new_client)))
		goto ERROR3;

	/* Register a new directory entry with module sensors */
	if ((i = i2c_register_entry(new_client, type_name,
					bt869_dir_table_template,
					THIS_MODULE)) < 0) {
		err = i;
		goto ERROR4;
	}
	data->sysctl_id = i;

	bt869_init_client((struct i2c_client *) new_client);
	return 0;

/* OK, this is not exactly good programming practice, usually. But it is
   very code-efficient in this case. */

      ERROR4:
	i2c_detach_client(new_client);
      ERROR3:
      ERROR1:
	kfree(new_client);
      ERROR0:
	return err;
}

int bt869_detach_client(struct i2c_client *client)
{
	int err;

	i2c_deregister_entry(((struct bt869_data *) (client->data))->
				 sysctl_id);

	if ((err = i2c_detach_client(client))) {
		printk
		    ("bt869.o: Client deregistration failed, client not detached.\n");
		return err;
	}

	kfree(client);

	return 0;
}


/* No commands defined yet */
int bt869_command(struct i2c_client *client, unsigned int cmd, void *arg)
{
	return 0;
}

/* Nothing here yet */
void bt869_inc_use(struct i2c_client *client)
{
#ifdef MODULE
	MOD_INC_USE_COUNT;
#endif
}

/* Nothing here yet */
void bt869_dec_use(struct i2c_client *client)
{
#ifdef MODULE
	MOD_DEC_USE_COUNT;
#endif
}

/* All registers are byte-sized.
   bt869 uses a high-byte first convention, which is exactly opposite to
   the usual practice. */
int bt869_read_value(struct i2c_client *client, u8 reg)
{
	return i2c_smbus_read_byte(client);
}

/* All registers are byte-sized.
   bt869 uses a high-byte first convention, which is exactly opposite to
   the usual practice. */
int bt869_write_value(struct i2c_client *client, u8 reg, u16 value)
{
#ifdef DEBUG
        printk("bt869.o: write_value(0x%X, 0x%X)\n", reg, value);
#endif
	return i2c_smbus_write_byte_data(client, reg, value);
}

void bt869_write_values(struct i2c_client *client, u16 *values)
{
  /* writes set of registers from array.  0,0 marks end of table */
  while (*values) {
    bt869_write_value(client, values[0], values[1]);
    values += 2;
  }
}

void bt869_init_client(struct i2c_client *client)
{
	struct bt869_data *data = client->data;

	/* Initialize the bt869 chip */
	bt869_write_value(client, 0x0ba, 0x80);
	//   bt869_write_value(client,0x0D6, 0x00);
	/* Be a slave to the clock on the Voodoo3 */
	bt869_write_value(client, 0xa0, 0x80);
	bt869_write_value(client, 0xba, 0x20);
	/* depth bpp */
	bt869_write_value(client, 0x0C6, 0x001);
	bt869_write_value(client, 0xC4, 1);
	/* Flicker free enable and config */
	bt869_write_value(client, 0xC8, 0);
	data->res[0] = 640;
	data->res[1] = 480;
	data->ntsc = 0;
	data->half = 0;
	data->colorbars = 0;
	data->svideo = 0;
	data->depth = 16;
	data->sreset = 0;
	data->treset = 0;
	data->reload = 0;
	data->tv_off = 1;
}

void bt869_update_client(struct i2c_client *client)
{
	struct bt869_data *data = client->data;

	down(&data->update_lock);

	if ((jiffies - data->last_updated > HZ + HZ / 2) ||
	    (jiffies < data->last_updated) || !data->valid) {
#ifdef DEBUG
		printk("Starting bt869 update\n");
#endif
		if ((data->res[0] = 800) && (data->res[1] = 600)) {
			/* 800x600 built-in mode */
		        bt869_write_value(client, 0xB8, (2 + (!data->ntsc)));
			bt869_write_value(client, 0xa0, 0x80 + 0x11);
			printk("bt869.o: writing into config -->0x%X\n",(2 + (!data->ntsc)));
		}
		else if ((data->res[0] = 720) && (data->res[1] = 576)) {
		        /* 720x576 no-overscan-compensation mode suitable for PAL DVD playback */
		        data->ntsc = 0; /* This mode always PAL */
		        bt869_write_values(client, registers_720_576);
		}
		else if ((data->res[0] = 720) && (data->res[1] = 480)) {
		        /* 720x480 no-overscan-compensation mode suitable for NTSC DVD playback */
		        data->ntsc = 1; /* This mode always NTSC */
		        bt869_write_values(client, registers_720_480);
		}
		else {
		        /* 640x480 built-in mode */
		        bt869_write_value(client, 0xB8, (!data->ntsc));
			bt869_write_value(client, 0xa0, 0x80 + 0x0C);
			printk("bt869.o: writing into config -->0x%X\n",
			       (0 + (!data->ntsc)));
			if ((data->res[0] != 640) || (data->res[1] != 480)) {
			  printk
			      ("bt869.o:  Warning: arbitrary resolutions not supported yet.  Using 640x480.\n");
			  data->res[0] = 640;
			  data->res[1] = 480;
			}
		}
		/* Set colour depth */
		if ((data->depth != 24) && (data->depth != 16))
			data->depth = 16;
		if (data->depth = 16)
			bt869_write_value(client, 0x0C6, 0x001);
		if (data->depth = 24)
			bt869_write_value(client, 0x0C6, 0x000);
		/* set "half" resolution mode */
		bt869_write_value(client, 0xd4, data->half << 6);
		/* Set composite/svideo mode, also enable the right dacs */
		switch (data->svideo) {
		case 2:  /* RGB */
		  /* requires hardware mod on Voodoo3 to get all outputs,
		     untested in practice... Feedback to steve@daviesfam.org please */
		  bt869_write_value(client, 0xd6, 0x0c);
		  bt869_write_value(client, 0xce, 0x24);
		  bt869_write_value(client, 0xba, 0x20);
		  break;
		case 1:  /* Svideo*/
		  bt869_write_value(client, 0xce, 0x24);
		  bt869_write_value(client, 0xba, 0x21);
		  break;
		default:  /* Composite */
		  bt869_write_value(client, 0xce, 0x00);
		  bt869_write_value(client, 0xba, 0x21);
		  break;
		}
		/* allows to reset the Timing */
		if(data->treset = 1)
		    bt869_write_value(client, 0x6C, 0x80);
		/* manual SRESET call */
		if(data->sreset = 1)
		    bt869_write_value(client, 0xB4, 0x80);
		/* reload default settings this is if you don't use modules and can't just 'unload and load' the module or mess
		up in some other way */
		if(data->reload = 1)
		    bt869_init_client((struct i2c_client *) client);
		/* turn the TV out on or off */
		if(data->tv_off = 1) {
		    bt869_write_value(client, 0xBA, 0x17);
    		    bt869_write_value(client, 0xC4, 0x00); 
		} else 
		if(data->tv_off = 0) {
		    bt869_write_value(client, 0xBA, 0x20);
		    bt869_write_value(client, 0xC4, 0x01); 
		}
		/* Enable outputs */
		bt869_write_value(client, 0xC4, 0x01);
		/* Issue timing reset */
		bt869_write_value(client, 0x6c, 0x80);

/* Read back status registers */
		bt869_write_value(client, 0xC4,
				  1 | (data->colorbars << 2));
		data->status[0] = bt869_read_value(client, 1);
		bt869_write_value(client, 0xC4,
				  0x41 | (data->colorbars << 2));
		data->status[1] = bt869_read_value(client, 1);
		bt869_write_value(client, 0xC4,
				  0x81 | (data->colorbars << 2));
		data->status[2] = bt869_read_value(client, 1);
		bt869_write_value(client, 0xC4,
				  0x0C1 | (data->colorbars << 2));
		data->last_updated = jiffies;
		data->valid = 1;
	}
	up(&data->update_lock);
}


void bt869_status(struct i2c_client *client, int operation, int ctl_name,
		  int *nrels_mag, long *results)
{
	struct bt869_data *data = client->data;
	if (operation = SENSORS_PROC_REAL_INFO)
		*nrels_mag = 0;
	else if (operation = SENSORS_PROC_REAL_READ) {
		bt869_update_client(client);
		results[0] = data->status[0];
		results[1] = data->status[1];
		results[2] = data->status[2];
		*nrels_mag = 3;
	} else if (operation = SENSORS_PROC_REAL_WRITE) {
		printk
		    ("bt869.o: Warning: write was requested on read-only proc file: status\n");
	}
}


void bt869_ntsc(struct i2c_client *client, int operation, int ctl_name,
		int *nrels_mag, long *results)
{
	struct bt869_data *data = client->data;
	if (operation = SENSORS_PROC_REAL_INFO)
		*nrels_mag = 0;
	else if (operation = SENSORS_PROC_REAL_READ) {
		bt869_update_client(client);
		results[0] = data->ntsc;
		*nrels_mag = 1;
	} else if (operation = SENSORS_PROC_REAL_WRITE) {
		if (*nrels_mag >= 1) {
			data->ntsc = (results[0] > 0);
		}
		bt869_update_client(client);
	}
}


void bt869_svideo(struct i2c_client *client, int operation, int ctl_name,
		int *nrels_mag, long *results)
{
	struct bt869_data *data = client->data;
	if (operation = SENSORS_PROC_REAL_INFO)
		*nrels_mag = 0;
	else if (operation = SENSORS_PROC_REAL_READ) {
		bt869_update_client(client);
		results[0] = data->svideo;
		*nrels_mag = 1;
	} else if (operation = SENSORS_PROC_REAL_WRITE) {
		if (*nrels_mag >= 1) {
			data->svideo = results[0];
		}
		bt869_update_client(client);
	}
}


void bt869_res(struct i2c_client *client, int operation, int ctl_name,
	       int *nrels_mag, long *results)
{
	struct bt869_data *data = client->data;
	if (operation = SENSORS_PROC_REAL_INFO)
		*nrels_mag = 0;
	else if (operation = SENSORS_PROC_REAL_READ) {
		bt869_update_client(client);
		results[0] = data->res[0];
		results[1] = data->res[1];
		*nrels_mag = 2;
	} else if (operation = SENSORS_PROC_REAL_WRITE) {
		if (*nrels_mag >= 1) {
			data->res[0] = results[0];
		}
		if (*nrels_mag >= 2) {
			data->res[1] = results[1];
		}
		bt869_update_client(client);
	}
}


void bt869_half(struct i2c_client *client, int operation, int ctl_name,
		int *nrels_mag, long *results)
{
	struct bt869_data *data = client->data;
	if (operation = SENSORS_PROC_REAL_INFO)
		*nrels_mag = 0;
	else if (operation = SENSORS_PROC_REAL_READ) {
		bt869_update_client(client);
		results[0] = data->half;
		*nrels_mag = 1;
	} else if (operation = SENSORS_PROC_REAL_WRITE) {
		if (*nrels_mag >= 1) {
			data->half = (results[0] > 0);
			bt869_update_client(client);
		}
	}
}

void bt869_colorbars(struct i2c_client *client, int operation,
		     int ctl_name, int *nrels_mag, long *results)
{
	struct bt869_data *data = client->data;
	if (operation = SENSORS_PROC_REAL_INFO)
		*nrels_mag = 0;
	else if (operation = SENSORS_PROC_REAL_READ) {
		bt869_update_client(client);
		results[0] = data->colorbars;
		*nrels_mag = 1;
	} else if (operation = SENSORS_PROC_REAL_WRITE) {
		if (*nrels_mag >= 1) {
			data->colorbars = (results[0] > 0);
			bt869_update_client(client);
		}
	}
}

void bt869_depth(struct i2c_client *client, int operation, int ctl_name,
		 int *nrels_mag, long *results)
{
	struct bt869_data *data = client->data;
	if (operation = SENSORS_PROC_REAL_INFO)
		*nrels_mag = 0;
	else if (operation = SENSORS_PROC_REAL_READ) {
		bt869_update_client(client);
		results[0] = data->depth;
		*nrels_mag = 1;
	} else if (operation = SENSORS_PROC_REAL_WRITE) {
		if (*nrels_mag >= 1) {
			data->depth = results[0];
			bt869_update_client(client);
		}
	}
}

void bt869_sreset(struct i2c_client *client, int operation, int ctl_name,
		 int *nrels_mag, long *results)
{
	struct bt869_data *data = client->data;
	if (operation = SENSORS_PROC_REAL_INFO)
		*nrels_mag = 0;
	else if (operation = SENSORS_PROC_REAL_READ) {
		bt869_update_client(client);
		results[0] = data->sreset;
		*nrels_mag = 1;
	} else if (operation = SENSORS_PROC_REAL_WRITE) {
		if (*nrels_mag >= 1) {
			data->sreset = results[0];
			bt869_update_client(client);
		}
	}
}

void bt869_treset(struct i2c_client *client, int operation, int ctl_name,
		 int *nrels_mag, long *results)
{
	struct bt869_data *data = client->data;
	if (operation = SENSORS_PROC_REAL_INFO)
		*nrels_mag = 0;
	else if (operation = SENSORS_PROC_REAL_READ) {
		bt869_update_client(client);
		results[0] = data->treset;
		*nrels_mag = 1;
	} else if (operation = SENSORS_PROC_REAL_WRITE) {
		if (*nrels_mag >= 1) {
			data->treset = results[0];
			bt869_update_client(client);
		}
	}
}

void bt869_reload(struct i2c_client *client, int operation, int ctl_name,
		 int *nrels_mag, long *results)
{
	struct bt869_data *data = client->data;
	if (operation = SENSORS_PROC_REAL_INFO)
		*nrels_mag = 0;
	else if (operation = SENSORS_PROC_REAL_READ) {
		bt869_update_client(client);
		results[0] = data->reload;
		*nrels_mag = 1;
	} else if (operation = SENSORS_PROC_REAL_WRITE) {
		if (*nrels_mag >= 1) {
			data->reload = results[0];
			bt869_update_client(client);
		}
	}
}

void bt869_tv_off(struct i2c_client *client, int operation, int ctl_name,
		 int *nrels_mag, long *results)
{
	struct bt869_data *data = client->data;
	if (operation = SENSORS_PROC_REAL_INFO)
		*nrels_mag = 0;
	else if (operation = SENSORS_PROC_REAL_READ) {
		bt869_update_client(client);
		results[0] = data->tv_off;
		*nrels_mag = 1;
	} else if (operation = SENSORS_PROC_REAL_WRITE) {
		if (*nrels_mag >= 1) {
			data->tv_off = results[0];
			bt869_update_client(client);
		}
	}
}

int __init sensors_bt869_init(void)
{
	int res;

	printk("bt869.o version %s (%s)\n", LM_VERSION, LM_DATE);
	bt869_initialized = 0;
	if ((res = i2c_add_driver(&bt869_driver))) {
		printk
		    ("bt869.o: Driver registration failed, module not inserted.\n");
		bt869_cleanup();
		return res;
	}
	bt869_initialized++;
	return 0;
}

int __init bt869_cleanup(void)
{
	int res;

	if (bt869_initialized >= 1) {
		if ((res = i2c_del_driver(&bt869_driver))) {
			printk
			    ("bt869.o: Driver deregistration failed, module not removed.\n");
			return res;
		}
		bt869_initialized--;
	}

	return 0;
}

EXPORT_NO_SYMBOLS;

#ifdef MODULE

MODULE_AUTHOR
    ("Frodo Looijaard <frodol@dds.nl>, Philip Edelbrock <phil@netroedge.com>, Stephen Davies <steve@daviesfam.org>, Oliver Schinagl <oliver@are-b.org>");
MODULE_DESCRIPTION("bt869 driver");

int init_module(void)
{
	return sensors_bt869_init();
}

int cleanup_module(void)
{
	return bt869_cleanup();
}

#endif				/* MODULE */
-------------- next part --------------
/*
    sensors.h - Part of lm_sensors, Linux kernel modules for hardware
                monitoring
    Copyright (c) 1998, 1999  Frodo Looijaard <frodol@dds.nl>

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program; if not, write to the Free Software
    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
*/

#ifndef SENSORS_NSENSORS_H
#define SENSORS_NSENSORS_H

#include <linux/i2c-proc.h>

#define LM78_SYSCTL_IN0 1000	/* Volts * 100 */
#define LM78_SYSCTL_IN1 1001
#define LM78_SYSCTL_IN2 1002
#define LM78_SYSCTL_IN3 1003
#define LM78_SYSCTL_IN4 1004
#define LM78_SYSCTL_IN5 1005
#define LM78_SYSCTL_IN6 1006
#define LM78_SYSCTL_FAN1 1101	/* Rotations/min */
#define LM78_SYSCTL_FAN2 1102
#define LM78_SYSCTL_FAN3 1103
#define LM78_SYSCTL_TEMP 1200	/* Degrees Celcius * 10 */
#define LM78_SYSCTL_VID 1300	/* Volts * 100 */
#define LM78_SYSCTL_FAN_DIV 2000	/* 1, 2, 4 or 8 */
#define LM78_SYSCTL_ALARMS 2001	/* bitvector */

#define LM78_ALARM_IN0 0x0001
#define LM78_ALARM_IN1 0x0002
#define LM78_ALARM_IN2 0x0004
#define LM78_ALARM_IN3 0x0008
#define LM78_ALARM_IN4 0x0100
#define LM78_ALARM_IN5 0x0200
#define LM78_ALARM_IN6 0x0400
#define LM78_ALARM_FAN1 0x0040
#define LM78_ALARM_FAN2 0x0080
#define LM78_ALARM_FAN3 0x0800
#define LM78_ALARM_TEMP 0x0010
#define LM78_ALARM_BTI 0x0020
#define LM78_ALARM_CHAS 0x1000
#define LM78_ALARM_FIFO 0x2000
#define LM78_ALARM_SMI_IN 0x4000

#define W83781D_SYSCTL_IN0 1000	/* Volts * 100 */
#define W83781D_SYSCTL_IN1 1001
#define W83781D_SYSCTL_IN2 1002
#define W83781D_SYSCTL_IN3 1003
#define W83781D_SYSCTL_IN4 1004
#define W83781D_SYSCTL_IN5 1005
#define W83781D_SYSCTL_IN6 1006
#define W83781D_SYSCTL_IN7 1007
#define W83781D_SYSCTL_IN8 1008
#define W83781D_SYSCTL_FAN1 1101	/* Rotations/min */
#define W83781D_SYSCTL_FAN2 1102
#define W83781D_SYSCTL_FAN3 1103
#define W83781D_SYSCTL_TEMP1 1200	/* Degrees Celcius * 10 */
#define W83781D_SYSCTL_TEMP2 1201	/* Degrees Celcius * 10 */
#define W83781D_SYSCTL_TEMP3 1202	/* Degrees Celcius * 10 */
#define W83781D_SYSCTL_VID 1300	/* Volts * 100 */
#define W83781D_SYSCTL_PWM1 1401
#define W83781D_SYSCTL_PWM2 1402
#define W83781D_SYSCTL_PWM3 1403
#define W83781D_SYSCTL_PWM4 1404
#define W83781D_SYSCTL_SENS1 1501	/* 1, 2, or Beta (3000-5000) */
#define W83781D_SYSCTL_SENS2 1502
#define W83781D_SYSCTL_SENS3 1503
#define W83781D_SYSCTL_RT1   1601	/* 32-entry table */
#define W83781D_SYSCTL_RT2   1602	/* 32-entry table */
#define W83781D_SYSCTL_RT3   1603	/* 32-entry table */
#define W83781D_SYSCTL_FAN_DIV 2000	/* 1, 2, 4 or 8 */
#define W83781D_SYSCTL_ALARMS 2001	/* bitvector */
#define W83781D_SYSCTL_BEEP 2002	/* bitvector */

#define W83781D_ALARM_IN0 0x0001
#define W83781D_ALARM_IN1 0x0002
#define W83781D_ALARM_IN2 0x0004
#define W83781D_ALARM_IN3 0x0008
#define W83781D_ALARM_IN4 0x0100
#define W83781D_ALARM_IN5 0x0200
#define W83781D_ALARM_IN6 0x0400
#define W83782D_ALARM_IN7 0x10000
#define W83782D_ALARM_IN8 0x20000
#define W83781D_ALARM_FAN1 0x0040
#define W83781D_ALARM_FAN2 0x0080
#define W83781D_ALARM_FAN3 0x0800
#define W83781D_ALARM_TEMP1 0x0010
#define W83781D_ALARM_TEMP23 0x0020	/* 781D only */
#define W83781D_ALARM_TEMP2 0x0020	/* 782D/783S */
#define W83781D_ALARM_TEMP3 0x2000	/* 782D only */
#define W83781D_ALARM_CHAS 0x1000

#define LM75_SYSCTL_TEMP 1200	/* Degrees Celcius * 10 */

#define ADM1021_SYSCTL_TEMP 1200
#define ADM1021_SYSCTL_REMOTE_TEMP 1201
#define ADM1021_SYSCTL_DIE_CODE 1202
#define ADM1021_SYSCTL_ALARMS 1203

#define ADM1021_ALARM_TEMP_HIGH 0x40
#define ADM1021_ALARM_TEMP_LOW 0x20
#define ADM1021_ALARM_RTEMP_HIGH 0x10
#define ADM1021_ALARM_RTEMP_LOW 0x08
#define ADM1021_ALARM_RTEMP_NA 0x04

#define GL518_SYSCTL_VDD  1000	/* Volts * 100 */
#define GL518_SYSCTL_VIN1 1001
#define GL518_SYSCTL_VIN2 1002
#define GL518_SYSCTL_VIN3 1003
#define GL518_SYSCTL_FAN1 1101	/* RPM */
#define GL518_SYSCTL_FAN2 1102
#define GL518_SYSCTL_TEMP 1200	/* Degrees Celcius * 10 */
#define GL518_SYSCTL_FAN_DIV 2000	/* 1, 2, 4 or 8 */
#define GL518_SYSCTL_ALARMS 2001	/* bitvector */
#define GL518_SYSCTL_BEEP 2002	/* bitvector */
#define GL518_SYSCTL_FAN1OFF 2003
#define GL518_SYSCTL_ITERATE 2004

#define GL518_ALARM_VDD 0x01
#define GL518_ALARM_VIN1 0x02
#define GL518_ALARM_VIN2 0x04
#define GL518_ALARM_VIN3 0x08
#define GL518_ALARM_TEMP 0x10
#define GL518_ALARM_FAN1 0x20
#define GL518_ALARM_FAN2 0x40

#define GL520_SYSCTL_VDD  1000	/* Volts * 100 */
#define GL520_SYSCTL_VIN1 1001
#define GL520_SYSCTL_VIN2 1002
#define GL520_SYSCTL_VIN3 1003
#define GL520_SYSCTL_VIN4 1004
#define GL520_SYSCTL_FAN1 1101	/* RPM */
#define GL520_SYSCTL_FAN2 1102
#define GL520_SYSCTL_TEMP1 1200	/* Degrees Celcius * 10 */
#define GL520_SYSCTL_TEMP2 1201	/* Degrees Celcius * 10 */
#define GL520_SYSCTL_VID 1300
#define GL520_SYSCTL_FAN_DIV 2000	/* 1, 2, 4 or 8 */
#define GL520_SYSCTL_ALARMS 2001	/* bitvector */
#define GL520_SYSCTL_BEEP 2002	/* bitvector */
#define GL520_SYSCTL_FAN1OFF 2003
#define GL520_SYSCTL_CONFIG 2004

#define GL520_ALARM_VDD 0x01
#define GL520_ALARM_VIN1 0x02
#define GL520_ALARM_VIN2 0x04
#define GL520_ALARM_VIN3 0x08
#define GL520_ALARM_TEMP1 0x10
#define GL520_ALARM_FAN1 0x20
#define GL520_ALARM_FAN2 0x40
#define GL520_ALARM_TEMP2 0x80
#define GL520_ALARM_VIN4 0x80

#define EEPROM_SYSCTL1 1000
#define EEPROM_SYSCTL2 1001
#define EEPROM_SYSCTL3 1002
#define EEPROM_SYSCTL4 1003
#define EEPROM_SYSCTL5 1004
#define EEPROM_SYSCTL6 1005
#define EEPROM_SYSCTL7 1006
#define EEPROM_SYSCTL8 1007
#define EEPROM_SYSCTL9 1008
#define EEPROM_SYSCTL10 1009
#define EEPROM_SYSCTL11 1010
#define EEPROM_SYSCTL12 1011
#define EEPROM_SYSCTL13 1012
#define EEPROM_SYSCTL14 1013
#define EEPROM_SYSCTL15 1014
#define EEPROM_SYSCTL16 1015

#define LM80_SYSCTL_IN0 1000	/* Volts * 100 */
#define LM80_SYSCTL_IN1 1001
#define LM80_SYSCTL_IN2 1002
#define LM80_SYSCTL_IN3 1003
#define LM80_SYSCTL_IN4 1004
#define LM80_SYSCTL_IN5 1005
#define LM80_SYSCTL_IN6 1006
#define LM80_SYSCTL_FAN1 1101	/* Rotations/min */
#define LM80_SYSCTL_FAN2 1102
#define LM80_SYSCTL_TEMP 1250	/* Degrees Celcius * 100 */
#define LM80_SYSCTL_FAN_DIV 2000	/* 1, 2, 4 or 8 */
#define LM80_SYSCTL_ALARMS 2001	/* bitvector */

#define ADM9240_SYSCTL_IN0 1000	/* Volts * 100 */
#define ADM9240_SYSCTL_IN1 1001
#define ADM9240_SYSCTL_IN2 1002
#define ADM9240_SYSCTL_IN3 1003
#define ADM9240_SYSCTL_IN4 1004
#define ADM9240_SYSCTL_IN5 1005
#define ADM9240_SYSCTL_FAN1 1101	/* Rotations/min */
#define ADM9240_SYSCTL_FAN2 1102
#define ADM9240_SYSCTL_TEMP 1250	/* Degrees Celcius * 100 */
#define ADM9240_SYSCTL_FAN_DIV 2000	/* 1, 2, 4 or 8 */
#define ADM9240_SYSCTL_ALARMS 2001	/* bitvector */
#define ADM9240_SYSCTL_ANALOG_OUT 2002
#define ADM9240_SYSCTL_VID 2003

#define ADM9240_ALARM_IN0 0x0001
#define ADM9240_ALARM_IN1 0x0002
#define ADM9240_ALARM_IN2 0x0004
#define ADM9240_ALARM_IN3 0x0008
#define ADM9240_ALARM_IN4 0x0100
#define ADM9240_ALARM_IN5 0x0200
#define ADM9240_ALARM_FAN1 0x0040
#define ADM9240_ALARM_FAN2 0x0080
#define ADM9240_ALARM_TEMP 0x0010
#define ADM9240_ALARM_CHAS 0x1000

#define ADM1024_SYSCTL_IN0 1000	/* Volts * 100 */
#define ADM1024_SYSCTL_IN1 1001
#define ADM1024_SYSCTL_IN2 1002
#define ADM1024_SYSCTL_IN3 1003
#define ADM1024_SYSCTL_IN4 1004
#define ADM1024_SYSCTL_IN5 1005
#define ADM1024_SYSCTL_FAN1 1101	/* Rotations/min */
#define ADM1024_SYSCTL_FAN2 1102
#define ADM1024_SYSCTL_TEMP 1250	/* Degrees Celcius * 100 */
#define ADM1024_SYSCTL_TEMP1 1290	/* Degrees Celcius */
#define ADM1024_SYSCTL_TEMP2 1295	/* Degrees Celcius */
#define ADM1024_SYSCTL_FAN_DIV 2000	/* 1, 2, 4 or 8 */
#define ADM1024_SYSCTL_ALARMS 2001	/* bitvector */
#define ADM1024_SYSCTL_ANALOG_OUT 2002
#define ADM1024_SYSCTL_VID 2003

#define ADM1024_ALARM_IN0 0x0001
#define ADM1024_ALARM_IN1 0x0002
#define ADM1024_ALARM_IN2 0x0004
#define ADM1024_ALARM_IN3 0x0008
#define ADM1024_ALARM_IN4 0x0100
#define ADM1024_ALARM_IN5 0x0200
#define ADM1024_ALARM_FAN1 0x0040
#define ADM1024_ALARM_FAN2 0x0080
#define ADM1024_ALARM_TEMP 0x0010
#define ADM1024_ALARM_TEMP1 0x0020
#define ADM1024_ALARM_TEMP2 0x0001
#define ADM1024_ALARM_CHAS 0x1000

#define ADM1025_SYSCTL_IN0 1000 /* Volts * 100 */
#define ADM1025_SYSCTL_IN1 1001
#define ADM1025_SYSCTL_IN2 1002
#define ADM1025_SYSCTL_IN3 1003
#define ADM1025_SYSCTL_IN4 1004
#define ADM1025_SYSCTL_IN5 1005
#define ADM1025_SYSCTL_RTEMP 1251
#define ADM1025_SYSCTL_TEMP 1250        /* Degrees Celcius * 100 */
#define ADM1025_SYSCTL_ALARMS 2001      /* bitvector */
#define ADM1025_SYSCTL_ANALOG_OUT 2002
#define ADM1025_SYSCTL_VID 2003

#define ADM1025_ALARM_IN0 0x0001
#define ADM1025_ALARM_IN1 0x0002
#define ADM1025_ALARM_IN2 0x0004
#define ADM1025_ALARM_IN3 0x0008
#define ADM1025_ALARM_IN4 0x0100
#define ADM1025_ALARM_IN5 0x0200
#define ADM1025_ALARM_RTEMP 0x0020
#define ADM1025_ALARM_TEMP 0x0010

#define LTC1710_SYSCTL_SWITCH_1 1000
#define LTC1710_SYSCTL_SWITCH_2 1001

#define LM80_ALARM_IN0 0x0001
#define LM80_ALARM_IN1 0x0002
#define LM80_ALARM_IN2 0x0004
#define LM80_ALARM_IN3 0x0008
#define LM80_ALARM_IN4 0x0010
#define LM80_ALARM_IN5 0x0020
#define LM80_ALARM_IN6 0x0040
#define LM80_ALARM_FAN1 0x0400
#define LM80_ALARM_FAN2 0x0800
#define LM80_ALARM_TEMP_HOT 0x0100
#define LM80_ALARM_TEMP_OS 0x2000
#define LM80_ALARM_CHAS 0x1000
#define LM80_ALARM_BTI 0x0200
#define LM80_ALARM_INT_IN 0x0080

#define MAXI_SYSCTL_FAN1   1101	/* Rotations/min */
#define MAXI_SYSCTL_FAN2   1102	/* Rotations/min */
#define MAXI_SYSCTL_FAN3   1103	/* Rotations/min */
#define MAXI_SYSCTL_FAN4   1104	/* Rotations/min */
#define MAXI_SYSCTL_TEMP1  1201	/* Degrees Celcius */
#define MAXI_SYSCTL_TEMP2  1202	/* Degrees Celcius */
#define MAXI_SYSCTL_TEMP3  1203	/* Degrees Celcius */
#define MAXI_SYSCTL_TEMP4  1204	/* Degrees Celcius */
#define MAXI_SYSCTL_TEMP5  1205	/* Degrees Celcius */
#define MAXI_SYSCTL_TEMP6  1206	/* Degrees Celcius */
#define MAXI_SYSCTL_PLL    1301	/* MHz */
#define MAXI_SYSCTL_VID1   1401	/* Volts / 6.337, for nba just Volts */
#define MAXI_SYSCTL_VID2   1402	/* Volts */
#define MAXI_SYSCTL_VID3   1403	/* Volts */
#define MAXI_SYSCTL_VID4   1404	/* Volts */
#define MAXI_SYSCTL_VID5   1405	/* Volts */
#define MAXI_SYSCTL_LCD1   1501	/* Line 1 of LCD */
#define MAXI_SYSCTL_LCD2   1502	/* Line 2 of LCD */
#define MAXI_SYSCTL_LCD3   1503	/* Line 3 of LCD */
#define MAXI_SYSCTL_LCD4   1504	/* Line 4 of LCD */
#define MAXI_SYSCTL_ALARMS 2001	/* Bitvector (see below) */

#define MAXI_ALARM_VID4      0x0001
#define MAXI_ALARM_TEMP2     0x0002
#define MAXI_ALARM_VID1      0x0004
#define MAXI_ALARM_VID2      0x0008
#define MAXI_ALARM_VID3      0x0010
#define MAXI_ALARM_PLL       0x0080
#define MAXI_ALARM_TEMP4     0x0100
#define MAXI_ALARM_TEMP5     0x0200
#define MAXI_ALARM_FAN1      0x1000
#define MAXI_ALARM_FAN2      0x2000
#define MAXI_ALARM_FAN3      0x4000

#define MAXI_ALARM_FAN       0x0100	/* To be used with  MaxiLife'99 */
#define MAXI_ALARM_VID       0x0200	/* The MSB specifies which sensor */
#define MAXI_ALARM_TEMP      0x0400	/* in the alarm group failed, i.e.: */
#define MAXI_ALARM_VADD      0x0800	/* 0x0402 = TEMP2 failed = CPU2 temp */

#define SIS5595_SYSCTL_IN0 1000	/* Volts * 100 */
#define SIS5595_SYSCTL_IN1 1001
#define SIS5595_SYSCTL_IN2 1002
#define SIS5595_SYSCTL_IN3 1003
#define SIS5595_SYSCTL_IN4 1004
#define SIS5595_SYSCTL_FAN1 1101	/* Rotations/min */
#define SIS5595_SYSCTL_FAN2 1102
#define SIS5595_SYSCTL_TEMP 1200	/* Degrees Celcius * 10 */
#define SIS5595_SYSCTL_FAN_DIV 2000	/* 1, 2, 4 or 8 */
#define SIS5595_SYSCTL_ALARMS 2001	/* bitvector */

#define SIS5595_ALARM_IN0 0x01
#define SIS5595_ALARM_IN1 0x02
#define SIS5595_ALARM_IN2 0x04
#define SIS5595_ALARM_IN3 0x08
#define SIS5595_ALARM_BTI 0x20
#define SIS5595_ALARM_FAN1 0x40
#define SIS5595_ALARM_FAN2 0x80
#define SIS5595_ALARM_IN4  0x8000
#define SIS5595_ALARM_TEMP 0x8000

#define VIA686A_SYSCTL_IN0 1000
#define VIA686A_SYSCTL_IN1 1001
#define VIA686A_SYSCTL_IN2 1002
#define VIA686A_SYSCTL_IN3 1003
#define VIA686A_SYSCTL_IN4 1004
#define VIA686A_SYSCTL_FAN1 1101
#define VIA686A_SYSCTL_FAN2 1102
#define VIA686A_SYSCTL_TEMP 1200
#define VIA686A_SYSCTL_TEMP2 1201
#define VIA686A_SYSCTL_TEMP3 1202
#define VIA686A_SYSCTL_FAN_DIV 2000
#define VIA686A_SYSCTL_ALARMS 2001

#define VIA686A_ALARM_IN0 0x01
#define VIA686A_ALARM_IN1 0x02
#define VIA686A_ALARM_IN2 0x04
#define VIA686A_ALARM_IN3 0x08
#define VIA686A_ALARM_TEMP 0x10
#define VIA686A_ALARM_FAN1 0x40
#define VIA686A_ALARM_FAN2 0x80
#define VIA686A_ALARM_IN4 0x100
#define VIA686A_ALARM_TEMP2 0x800
#define VIA686A_ALARM_CHAS 0x1000
#define VIA686A_ALARM_TEMP3 0x8000

#define ICSPLL_SYSCTL1 1000

#define BT869_SYSCTL_STATUS 1000
#define BT869_SYSCTL_NTSC   1001
#define BT869_SYSCTL_HALF   1002
#define BT869_SYSCTL_RES    1003
#define BT869_SYSCTL_COLORBARS    1004
#define BT869_SYSCTL_DEPTH  1005
#define BT869_SYSCTL_SVIDEO 1006
#define BT869_SYSCTL_RELOAD 1007
#define BT869_SYSCTL_SRESET 1008
#define BT869_SYSCTL_TRESET 1009
#define BT869_SYSCTL_TV_OFF 1010

#define MATORB_SYSCTL_DISP 1000

#define THMC50_SYSCTL_TEMP 1200	/* Degrees Celcius */
#define THMC50_SYSCTL_REMOTE_TEMP 1201	/* Degrees Celcius */
#define THMC50_SYSCTL_INTER 1202
#define THMC50_SYSCTL_INTER_MASK 1203
#define THMC50_SYSCTL_DIE_CODE 1204
#define THMC50_SYSCTL_ANALOG_OUT 1205

#define DDCMON_SYSCTL_ID 1010
#define DDCMON_SYSCTL_SIZE 1011
#define DDCMON_SYSCTL_SYNC 1012
#define DDCMON_SYSCTL_TIMINGS 1013
#define DDCMON_SYSCTL_SERIAL 1014

#define LM87_SYSCTL_IN0        1000 /* Volts * 100 */
#define LM87_SYSCTL_IN1        1001
#define LM87_SYSCTL_IN2        1002
#define LM87_SYSCTL_IN3        1003
#define LM87_SYSCTL_IN4        1004
#define LM87_SYSCTL_IN5        1005
#define LM87_SYSCTL_AIN1       1006
#define LM87_SYSCTL_AIN2       1007
#define LM87_SYSCTL_FAN1       1102
#define LM87_SYSCTL_FAN2       1103
#define LM87_SYSCTL_TEMP1  1250 /* Degrees Celcius * 100 */
#define LM87_SYSCTL_TEMP2   1251 /* Degrees Celcius * 100 */
#define LM87_SYSCTL_TEMP3   1252 /* Degrees Celcius * 100 */
#define LM87_SYSCTL_FAN_DIV    2000 /* 1, 2, 4 or 8 */
#define LM87_SYSCTL_ALARMS     2001 /* bitvector */
#define LM87_SYSCTL_ANALOG_OUT 2002
#define LM87_SYSCTL_VID        2003

#define LM87_ALARM_IN0          0x0001
#define LM87_ALARM_IN1          0x0002
#define LM87_ALARM_IN2          0x0004
#define LM87_ALARM_IN3          0x0008
#define LM87_ALARM_TEMP1        0x0010
#define LM87_ALARM_TEMP2        0x0020
#define LM87_ALARM_TEMP3        0x0020 /* same?? */
#define LM87_ALARM_FAN1         0x0040
#define LM87_ALARM_FAN2         0x0080
#define LM87_ALARM_IN4          0x0100
#define LM87_ALARM_IN5          0x0200
#define LM87_ALARM_RESERVED1    0x0400
#define LM87_ALARM_RESERVED2    0x0800
#define LM87_ALARM_CHAS         0x1000
#define LM87_ALARM_THERM_SIG    0x2000
#define LM87_ALARM_TEMP2_FAULT  0x4000
#define LM87_ALARM_TEMP3_FAULT 0x08000

#define PCF8574_SYSCTL_READ     1000
#define PCF8574_SYSCTL_WRITE    1001

#define MTP008_SYSCTL_IN0	1000	/* Volts * 100 */
#define MTP008_SYSCTL_IN1	1001
#define MTP008_SYSCTL_IN2	1002
#define MTP008_SYSCTL_IN3	1003
#define MTP008_SYSCTL_IN4	1004
#define MTP008_SYSCTL_IN5	1005
#define MTP008_SYSCTL_IN6	1006
#define MTP008_SYSCTL_FAN1	1101	/* Rotations/min */
#define MTP008_SYSCTL_FAN2	1102
#define MTP008_SYSCTL_FAN3	1103
#define MTP008_SYSCTL_TEMP1	1200	/* Degrees Celcius * 10 */
#define MTP008_SYSCTL_TEMP2	1201	/* Degrees Celcius * 10 */
#define MTP008_SYSCTL_TEMP3	1202	/* Degrees Celcius * 10 */
#define MTP008_SYSCTL_VID	1300	/* Volts * 100 */
#define MTP008_SYSCTL_PWM1	1401
#define MTP008_SYSCTL_PWM2	1402
#define MTP008_SYSCTL_PWM3	1403
#define MTP008_SYSCTL_SENS1	1501	/* 1, 2, or Beta (3000-5000) */
#define MTP008_SYSCTL_SENS2	1502
#define MTP008_SYSCTL_SENS3	1503
#define MTP008_SYSCTL_FAN_DIV	2000	/* 1, 2, 4 or 8 */
#define MTP008_SYSCTL_ALARMS	2001	/* bitvector */
#define MTP008_SYSCTL_BEEP	2002	/* bitvector */

#define MTP008_ALARM_IN0	0x0001
#define MTP008_ALARM_IN1	0x0002
#define MTP008_ALARM_IN2	0x0004
#define MTP008_ALARM_IN3	0x0008
#define MTP008_ALARM_IN4	0x0100
#define MTP008_ALARM_IN5	0x0200
#define MTP008_ALARM_IN6	0x0400
#define MTP008_ALARM_FAN1	0x0040
#define MTP008_ALARM_FAN2	0x0080
#define MTP008_ALARM_FAN3	0x0800
#define MTP008_ALARM_TEMP1	0x0010
#define MTP008_ALARM_TEMP2	0x0100
#define MTP008_ALARM_TEMP3	0x0200

#define DS1621_SYSCTL_TEMP 1200	/* Degrees Celcius * 10 */
#define DS1621_SYSCTL_ALARMS 2001	/* bitvector */
#define DS1621_ALARM_TEMP_HIGH 0x40
#define DS1621_ALARM_TEMP_LOW 0x20
#define DS1621_SYSCTL_ENABLE 2002
#define DS1621_SYSCTL_CONTINUOUS 2003
#define DS1621_SYSCTL_POLARITY 2004

#define IT87_SYSCTL_IN0 1000    /* Volts * 100 */
#define IT87_SYSCTL_IN1 1001
#define IT87_SYSCTL_IN2 1002
#define IT87_SYSCTL_IN3 1003
#define IT87_SYSCTL_IN4 1004
#define IT87_SYSCTL_IN5 1005
#define IT87_SYSCTL_IN6 1006
#define IT87_SYSCTL_IN7 1007
#define IT87_SYSCTL_IN8 1008
#define IT87_SYSCTL_FAN1 1101   /* Rotations/min */
#define IT87_SYSCTL_FAN2 1102
#define IT87_SYSCTL_FAN3 1103
#define IT87_SYSCTL_TEMP1 1200  /* Degrees Celcius * 10 */
#define IT87_SYSCTL_TEMP2 1201  /* Degrees Celcius * 10 */
#define IT87_SYSCTL_TEMP3 1202  /* Degrees Celcius * 10 */
#define IT87_SYSCTL_VID 1300    /* Volts * 100 */
#define IT87_SYSCTL_FAN_DIV 2000        /* 1, 2, 4 or 8 */
#define IT87_SYSCTL_ALARMS 2004    /* bitvector */

#define IT87_ALARM_IN0 0x000100
#define IT87_ALARM_IN1 0x000200
#define IT87_ALARM_IN2 0x000400
#define IT87_ALARM_IN3 0x000800
#define IT87_ALARM_IN4 0x001000
#define IT87_ALARM_IN5 0x002000
#define IT87_ALARM_IN6 0x004000
#define IT87_ALARM_IN7 0x008000
#define IT87_ALARM_FAN1 0x0001
#define IT87_ALARM_FAN2 0x0002
#define IT87_ALARM_FAN3 0x0004
#define IT87_ALARM_TEMP1 0x00010000
#define IT87_ALARM_TEMP2 0x00020000
#define IT87_ALARM_TEMP3 0x00040000

#define FSCPOS_SYSCTL_VOLT0    1000       /* 12 volt supply */
#define FSCPOS_SYSCTL_VOLT1    1001       /* 5 volt supply */
#define FSCPOS_SYSCTL_VOLT2    1002       /* batterie voltage*/
#define FSCPOS_SYSCTL_FAN0     1101       /* state, min, ripple, actual value fan 0 */
#define FSCPOS_SYSCTL_FAN1     1102       /* state, min, ripple, actual value fan 1 */
#define FSCPOS_SYSCTL_FAN2     1103       /* state, min, ripple, actual value fan 2 */
#define FSCPOS_SYSCTL_TEMP0    1201       /* state and value of sensor 0, cpu die */
#define FSCPOS_SYSCTL_TEMP1    1202       /* state and value of sensor 1, motherboard */
#define FSCPOS_SYSCTL_TEMP2    1203       /* state and value of sensor 2, chassis */
#define FSCPOS_SYSCTL_REV     2000        /* Revision */
#define FSCPOS_SYSCTL_EVENT   2001        /* global event status */
#define FSCPOS_SYSCTL_CONTROL 2002        /* global control byte */
#define FSCPOS_SYSCTL_WDOG     2003       /* state, min, ripple, actual value fan 2 */

#define FSCSCY_SYSCTL_VOLT0    1000       /* 12 volt supply */
#define FSCSCY_SYSCTL_VOLT1    1001       /* 5 volt supply */
#define FSCSCY_SYSCTL_VOLT2    1002       /* batterie voltage*/
#define FSCSCY_SYSCTL_FAN0     1101       /* state, min, ripple, actual value fan 0 */
#define FSCSCY_SYSCTL_FAN1     1102       /* state, min, ripple, actual value fan 1 */
#define FSCSCY_SYSCTL_FAN2     1103       /* state, min, ripple, actual value fan 2 */
#define FSCSCY_SYSCTL_FAN3     1104       /* state, min, ripple, actual value fan 3 */
#define FSCSCY_SYSCTL_FAN4     1105       /* state, min, ripple, actual value fan 4 */
#define FSCSCY_SYSCTL_FAN5     1106       /* state, min, ripple, actual value fan 5 */
#define FSCSCY_SYSCTL_TEMP0    1201       /* state and value of sensor 0, cpu die */
#define FSCSCY_SYSCTL_TEMP1    1202       /* state and value of sensor 1, motherboard */
#define FSCSCY_SYSCTL_TEMP2    1203       /* state and value of sensor 2, chassis */
#define FSCSCY_SYSCTL_TEMP3    1204       /* state and value of sensor 3, chassis */
#define FSCSCY_SYSCTL_REV     2000        /* Revision */
#define FSCSCY_SYSCTL_EVENT   2001        /* global event status */
#define FSCSCY_SYSCTL_CONTROL 2002        /* global control byte */
#define FSCSCY_SYSCTL_WDOG     2003       /* state, min, ripple, actual value fan 2 */
#define FSCSCY_SYSCTL_PCILOAD  2004       /* PCILoad value */
#define FSCSCY_SYSCTL_INTRUSION 2005      /* state, control for intrusion sensor */

#define PCF8591_SYSCTL_AIN_CONF 1000      /* Analog input configuration */
#define PCF8591_SYSCTL_CH0 1001           /* Input channel 1 */
#define PCF8591_SYSCTL_CH1 1002           /* Input channel 2 */
#define PCF8591_SYSCTL_CH2 1003           /* Input channel 3 */
#define PCF8591_SYSCTL_CH3 1004           /* Input channel 4 */
#define PCF8591_SYSCTL_AOUT_ENABLE 1005   /* Analog output enable flag */
#define PCF8591_SYSCTL_AOUT 1006          /* Analog output */

#endif				/* def SENSORS_SENSORS_H */
-------------- next part --------------
Kernel driver `bt869.o'
===========

Status: 'Beta' and needs further development and testing

Supported chips: 
  * Brooktree BT869 Video Modulator chips
    Prefix: `bt869'
    Addresses scanned: I2C 0x44 - 0x45 (inclusive)
    Datasheet: Publicly available at the brooktree web site
    (www.brooktree.com)

Author: Frodo Looijaard <frodol@dds.nl>, Philip Edelbrock
	<phil@netroedge.com>, Ralph Metzler <rjkm@thp.uni-koeln.de>
	Steve Davies <steve@daviesfam.org> added the 720x576 and
	720x480 support, and the svideo configuration.

Main Contact: Philip Edelbrock <phil@netroedge.com>

Module Parameters
-----------------
* force: short array (min = 1, max = 48)
  List of adapter,address pairs to boldly assume to be present
* force_bt869: short array (min = 1, max = 48)
  List of adapter,address pairs which are unquestionably assumed to contain
  a `bt869' chip
* ignore: short array (min = 1, max = 48)
  List of adapter,address pairs not to scan
* ignore_range: short array (min = 1, max = 48)
  List of adapter,start-addr,end-addr triples not to scan
* probe: short array (min = 1, max = 48)
  List of adapter,address pairs to scan additionally
* probe_range: short array (min = 1, max = 48)
  List of adapter,start-addr,end-addr triples to scan additionally


Description
-----------

This driver provides some access to the Brooktree bt869 found on some
video cards (like the 'Voodoo3 3000').  Typically, the output can be
either an s-video connection or composite video.  Resolutions
supported using the chip's built in configurations are 640x480 or
800x600.  In addition, a 720x576 PAL mode and a 720x480 NTSC mode,
both without overscan compensation, are supported - a convenient
configuration for video playback.

Other possible implementations may allow for double resolutions with some
decimations (e.g., a monitor running at 1280x960 but the TV out getting every
other pixel for 640x480).


Driver Features
---------------
Standards: (US) NTSC or PAL
Resolutions: 640x480, 800x600, 720x576 (PAL only), 720x480 (NTSC only)
Depths: 16, 24 or 32 bits
Colorbars: Switch on the built-in color bar generator. (FYI- using a blue
filter, you should see only alternating bright stripes of equal brightness.
Adjust your TV's color and saturation if this isn't the case.)
SVideo: composite or s-video output.  Also, theoretically, RGB output, though
this isn't tested and will require that your card presents all three DAC outputs
(the 3dfx Voodoo3 doesn't)

In your XF86Config file, you should have these entries for NTSC output:

ModeLine "640x480NTSC"  28.195793   640  656  658  784   480  520  525  600
ModeLine "720x480NTSC"  27.5        720  744  800  872   480  483  485  525
ModeLine "800x600NTSC"  38.769241   800  812  814  880   600  646  649  735

or for PAL

ModeLine "640x480PAL"   29.50       640  675  678  944   480  530  535  625
ModeLine "720x576PAL"   27.50       720  744  800  880   576  581  583  625
ModeLine "800x600PAL"   36.00       800  818  820  960   600  653  655  750

Also, don't forget to add these modes to the resolutions list in the
'screen' sections of XF86Config.  You can change modes on the fly in X by
pressing (usually) ctrl-alt-+ or ctrl-alt-(minus)  with + and - being the
keys on your numeric 10-key pad.

BTW- My monitor doesn't like these entries very much, and as I've read:
don't run your monitor out of spec or else it will burst into fire.  So,
having the monitor turned on while in any of these modes is at your own
risk.  (I've never heard of a monitor breaking from this, but it seems to
be fashionable to warn about it.)


Chip Features
-------------
The chip is very flexible and customizable for many standards.  Right
now the driver sticks with the chip's built in NTSC and PAL standards,
with the addition of the 720x576PAL and 720x480NTSC modes.  It also
does some other wacky stuff like closed-captioning, Macro-vision
copy-protection, and other things.  Check out the datasheet for more
info.


Issues
------
The depth register doesn't seem to do much?  If you have troubles or
aren't sure the output is working, turn the color-bars on.  If they display
OK, then the chip is syncing correctly.  The next thing to try is the depth
setting.  Lastly, turning off your computer and back on with your TV
connected but you monitor not, may force the video card to configure and
use the BT869 as your primary output device (all bets are off once X is
started).  Let me know if you have problems which you can't figure out 
(phil@netroedge.com).

--------------------------------

On May 3rd, 2001 (My birthday, as it happens to be :') Tomi Ollila sent me 
a how-to from a user's perspective on using the BT869 with a 3Dfx card.
It should also provide insight for other video card users who have a
BT869 on board.  Here is his document:


How-To
------


This text describes my successful attempt to eventually get the TV-Out
feature of 3DFX Voodoo 3 3000 (PAL) working in a Linux environment.
I've successfully configured the 800x600 mode -- And currently I am
not interested in 640x480 -- hardware scaling rules in all cases
I need the tv-out. My monitor works much less worse w/ 800x600PAL...

All the information is based on my best knowledge but there might be
some mistakes. In any case, THE ENTIRE RISK OF USING THIS INFORMATION
IS WITH YOU, AND NO ONE ELSE IS LIABLE OF ANY PROBLEMS ENCOUNTERED.
Please fix any mistakes, inaccuracies, writing errors, etc. you
notice in this document.

I was about to write briefly, but sorry due to limited resources
I did not have time to write briefly (too much thinking ;). 
Well, browse through the text and skip all irrelevant parts
to proceed...

Tomi Ollila <too@iki.fi>


The first time I got the the tv-out working I was working w/ Linux kernel
2.4.3. Now I am redoing the work w/ Linux 2.4.4 and recording the steps
in this document. Description of my system and software used is as follows:

RedHat 7.0 linux distribution (probably any distribution will do, since
all of the needed software is compiled from packages that are not RH-pagkaged)
(maybe if anything is important, are modutils-2.3.14-3 and kernel-headers-2.4.0-0.26)

XFree-4.0.3. I don't see any reason anyone uses any older. HW acceleration
of Voodoo3 3000 works out of the box with this. Also Windowed!!!

lm_sensors-2.5.5: Get this or newer. I have not used any older.

i2c-2.5.5: Probably 2.4.x -kernel distributions has recent enough version
of i2c. Since I also have IOmega BUZ and it's (working) versions require
i2c-old, I cannot use the one's kernel provided. Since I cannot say anything
about not using this i2c as separate package I suggest you do the same
and compile this also.

I have used kgcc that comes in RedHat 7.0 -distribution to compile all
stuff. Probably all other recent gcc -compilers will produce good results
also: kgcc -v outputs:
Reading specs from /usr/lib/gcc-lib/i386-glibc21-linux/egcs-2.91.66/specs
gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)

--

1) The work starts w/ kernel compilation (or skip to step 2, I quess it will
   work w/ any recent 2.2 and 2.4 -kernels)
 
   # run make config, make menuconfig or make xconfig (I suggest 'xconfig')

   For sure you need kernel module support and /proc -filesystem support
   (XXX add more absolute requirements)

   Now I cannot say for sure, if following things needs to be compiled 
   at kernel compilation time or does i2c-2.5.5 bring all these:
	character devices->i2c support->i2c support
	character devices->i2c support->i2c bit-banging interfaces (*)
	character devices->i2c support->i2c devices	(**)
	character devices->/dev/agpart support
	character devices->Direct Rendering Manager (XFree86 DRI support) (+)
	character devices->3dfx banshee/Voodoo3+

	make above as modules.

	(*) I already forgot why I wanted some special attention for this
	(**) It seems I never need this
	(+) Hmm, It seems I have compiled this as part of the kernel binary

	There is of course lot of other options you need to choose but these
	are probably the ones needed...

   # run make dep
   # run make bzImage
   # run make modules
   # run make modules_install (as root)
   # copy arch/i386/boot/bzImage to /boot/vmlinuz-2.4.4 (as root)
   # edit /etc/lilo.conf and run lilo (as root)

2) In order to (the most easiest way) compile separate i2c and lm_sensors
   -package, symlink your linux source tree to /usr/src/linux (unless it is
   there already) and do the following	

   # tar zxvf i2c-2.5.5.tar.gz
   # cd i2c-2.5.5
   # make
   # make install (as root)
   # cd ..
   # tar zxvf lm_sensors-2.5.5.tar.gz
   # cd lm_sensors-2.5.5
   # make
   # make install (as root)
   # cd ..

   Now you have all necessary modules installed on the system (and
   /usr/local/bin/sensors and /usr/local/sbin/sensors-detect).

   But there is some configuration missing in order to activate
   the needed functionality of the modules...

3) Now, before going any further, let's take a look the modifications that
   is required in XFree86 -configuration so that X is ready for the
   tv-out functionality next time it is started.

   XFree86-4.x uses the configuration file /etc/X11/XF86Config-4. Older
   configuration files needed "ModeLine"s for all display resolutions
   that are needed, but XFree86 version 4 can figure out those by itself.
   But what it cannot figure out, are some special ModeLines that may
   be reguired in various cases... and this is one of these.

   For Voodoo 3 3000 TV out feature, special modelines are needed for
   the supported resolutions, 640x480 and 800x600 (there might be others
   but I don't know enough of the issue. In this document, I only
   activate the 800x600 mode.

   Make backup copy of your /etc/X11/XF86Config-4 in case you accidentally
   screw something up so you can then reuse the old file if this happens.

   Open /etc/X11/XF86Config-4 in your favourite editor and find line
   that contains `Section "Monitor"'. At the end of that section,
   just before line `EndSection', add the following lines:

ModeLine "640x480PAL"   29.50       640  675  678  944  480  530  535  625
ModeLine "800x600PAL"   36.00       800  818  820  960  600  653  655  750

   Then, find lines that starts with something like:

Section "Screen"
        Identifier "Screen0"
        Device "3Dfx Interactive, Inc.|Voodoo 3"
        Monitor "<Your monitor>"
        DefaultDepth 16
...
        Subsection "Display"
                Depth 16
#               Modes "1024x768" "640x480" "800x600" "800x600PAL" #"400x300"
                Modes "1024x768" "800x600PAL" 
        EndSubSection

   Make sure that `DefaultDepth' is set 16 (I don't know if any other works)
   Then you notice there my resolutions as `Modes' -lines. I have outcommented
   the first `Modes' -line so that testing is easier. You can do what
   you widh here, just make sure to add that `"800x600PAL"' -line there.
   Save the file and exit editor.


4) It's is time to reboot (with new kernel), that is the easiest way to
   continue.

5) After rebooting, and X startup `lsmod' in my machine output following:
   Module                  Size  Used by
   tdfx                   54536   1
   es1371                 28500   0
   ac97_codec              8808   0 [es1371]

   tdfx -module was loaded by X, and sound module by some RH -startup script.

   Now you could run /usr/local/sbin/sensors-detect. After that was run in 
   my PII class -machine it suggested I add the following:

   to /etc/modules.conf
   alias char-major-89 i2c-dev

   to some startup script (i choose append to /etc/rc.local)
   # I2C adapter drivers
   /sbin/modprobe i2c-piix4
   /sbin/modprobe i2c-voodoo3
   # I2C chip drivers
   /sbin/modprobe w83781d
   /sbin/modprobe eeprom

   (you run the prg and add the stuff it suggests)

   Let's now /sbin/modprobe -v i2c-voodoo3. Now I have:

   Module                  Size  Used by
   i2c-voodoo3             3012   0  (unused)
   i2c-algo-bit            7796   2  [i2c-voodoo3]
   i2c-core               12844   0  [i2c-algo-bit]
   tdfx                   54536   1 
   es1371                 28500   0 
   ac97_codec              8808   0  [es1371]

   I think this is the only one of the above that is required for the task.
   (If that is not true, I'll revise this text and you never know I though
    such a thing)

   Now, turn on your TV set (unless it is already open) and make sure it
   is getting (either s-video or composite... I personally have only
   tested composite) input from your voodoo3 card. Don't change any
   screen resolution just yet...

   You notice the tv set screen is still blank. Changing screen resolutions
   won't do any change on that, don't bother trying.

   So, how to continue from there. The answer was found looking through
   all the files that are found with zsh command line in lm_sensors dir:
   grep -i voodoo3 **/*(.) | less
   The file doc/chips/bt869 contains interesting information, with it
   and some other information I found somewhere else, don't remember
   either, I did:

   modprobe -v bt869  (or insmod /lib/modules/2.x.x/misc/bt869)

   NOW! you should see some noise on your TV-Set screen.

   and `lsmod' returns (on my machine)

   Module                  Size  Used by
   bt869                   5392   0  (unused)
   i2c-voodoo3             3012   0  (unused)
   sensors                 6140   0  [bt869]
   i2c-algo-bit            7796   2  [i2c-voodoo3]
   i2c-core               12844   0  [bt869 sensors i2c-algo-bit]
   tdfx                   54536   1 
   es1371                 28500   0 
   ac97_codec              8808   0  [es1371]
 
   If you now try to change mode to `800x600PAL' The noise pattern just
   changes. That's because there are various parameters for bt869 to
   make it operate in different systems.

   The configuration entries for bt869 live somewhere in `proc' filesystem
   and since it is so hard to remember, the following commands helps out:

   # find /proc -name "bt869*" -print

   In my system that output: /proc/sys/dev/sensors/bt869-i2c-0-44. Since
   the last few characters may be different on your system I'll use...

   # ls  /proc/sys/dev/sensors/bt869*  ... and this outputs:

   colorbars:  Output colorbars instead of display data. Default `0'.
   depth:      Display depth. Seems to be `16' on my system.
   half:       No idea. Default `0'.
   ntsc:       1: use NTSC, 0: use PAL. Default: `1'.
   res;        Screen resolution to use. Defaut: `640 480'.
   status:     Outputs some status info I do not know what that is.

   For me, in order to get TV sync with incoming signal (or is it Voodoo3 
   that needs syncing), I first put colorbars on, and when I get colorbars
   visible I shut colorbars off -- and then I have part of my 1024x768
   displayed on TV-screen. Normal WIMP screen doesn't look so nice, but
   games, pictures, etc. Looks just fine. And HW acceleration rules.

   Do the following to achieve this:

   # echo 1 > /proc/sys/dev/sensors/bt869*/colorbars
   # echo 0 > /proc/sys/dev/sensors/bt869*/ntsc
   # echo 800 600 > /proc/sys/dev/sensors/bt869*/res

   Press ctrl-alt-num_keypad_+

   Now you should see vertical colorbars on your TV-Set

   # echo 0 > /proc/sys/dev/sensors/bt869*/colorbars

   Now (part of) your computer display should be visible on your TV-Set.   


   ... Ok, I did just that... after ctrl-alt-num_keypad_+ I did not get
   synchronized colorbar output visible on my TV. So, at this time I
   re-did...

   # echo 1 > /proc/sys/dev/sensors/bt869*/colorbars

   ... and got colorbars, and ...

   # echo 0 > /proc/sys/dev/sensors/bt869*/colorbars

   ... got my computer display visible on my TV.


#EOF
