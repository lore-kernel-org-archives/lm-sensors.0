From: steve@daviesfam.org (Stephen Davies)
Date: Thu, 19 May 2005 06:23:27 +0000
Subject: BT869 driver patch
Message-Id: <Pine.LNX.4.21.0201032010310.2759-200000@bob.daviesfam.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.21.0201031832260.2759-200000@bob.daviesfam.org>
In-Reply-To: <Pine.LNX.4.21.0201031832260.2759-200000@bob.daviesfam.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



On Thu, 3 Jan 2002 phil@netroedge.com wrote:

> Thanks for the submission.  The only piece right now that I'm not
> liking is that #define DO_720_576 and the later #ifdef.  Can we do
> away with these?  It's not clear what we gain with adding those in.
> Otherwise, I appreciate your work, and I'd like to incorporate your
> additions!

Here's a new version - removed the #define, also fixed a mistake in setup
for non-svideo.

Steve

-------------- next part --------------
Index: doc/chips/bt869
=================================RCS file: /home/cvs/lm_sensors2/doc/chips/bt869,v
retrieving revision 1.2
diff -u -r1.2 bt869
--- doc/chips/bt869	2001/05/03 21:00:33	1.2
+++ doc/chips/bt869	2002/01/03 20:16:43
@@ -11,7 +11,9 @@
     (www.brooktree.com)
 
 Author: Frodo Looijaard <frodol@dds.nl>, Philip Edelbrock
-	<phil@netroege.com> and Ralph Metzler <rjkm@thp.uni-koeln.de>
+	<phil@netroedge.com>, Ralph Metzler <rjkm@thp.uni-koeln.de>
+	Steve Davies <steve@daviesfam.org> added the 720x576
+	support, and the svideo configuration.
 
 Main Contact: Philip Edelbrock <phil@netroedge.com>
 
@@ -37,29 +39,36 @@
 This driver provides some access to the Brooktree bt869 found on some video
 cards (like the 'Voodoo3 3000').  Typically, the output can be either an
 s-video connection or composite video.  Resolutions supported using the
-chip's built in configurations are 640x480 or 800x600.  Other possible
-implementations may allow for double resolutions with some decimations
-(e.g., a monitor running at 1280x960 but the TV out getting every other
-pixel for 640x480).
+chip's built in configurations are 640x480 or 800x600.  In addition, a 720x576
+PAL mode without overscan compensation is supported - a convenient configuration
+for video playback.
+
+Other possible implementations may allow for double resolutions with some
+decimations (e.g., a monitor running at 1280x960 but the TV out getting every
+other pixel for 640x480).
 
 
 Driver Features
 ---------------
-Stanards: (US) NTSC or PAL (PAL untested)
-Resultions: 640x480 and 800x600
+Standards: (US) NTSC or PAL
+Resolutions: 640x480, 800x600 and 720x576 (PAL only)
 Depths: 16 bit or 32 (I forgot if 24 bit worked OK, it probably does)
 Colorbars: Switch on the built-in color bar generator. (FYI- using a blue
 filter, you should see only alternating bright stripes of equal brightness.
 Adjust your TV's color and saturation if this isn't the case.)
+SVideo: composite or s-video output.  Also, theoretically, RGB output, though
+this isn't tested and will require that your card presents all three DAC outputs
+(the 3dfx Voodoo3 doesn't)
 
 In your XF86Config file, you should have these entries for NTSC output:
 
 ModeLine "640x480NTSC"  28.195793   640  656  658  784   480  520  525  600
 ModeLine "800x600NTSC"  38.769241   800  812  814  880   600  646  649  735
 
-or for PAL (untested),
+or for PAL
 
 ModeLine "640x480PAL"   29.50       640  675  678  944   480  530  535  625
+ModeLine "720x576PAL"   27.50       720  744  800  880   576  581  583  625
 ModeLine "800x600PAL"   36.00       800  818  820  960   600  653  655  750
 
 Also, don't forget to add these modes to the resolutions list in the
@@ -77,9 +86,10 @@
 Chip Features
 -------------
 The chip is very flexible and customizable for many standards.  Right now
-the driver sticks with the chip's built in NTSC and PAL standards.  It also
-does some other wacky stuff like closed-captioning, Macro-vision
-copy-protection, and other things.  Check out the datasheet for more info.
+the driver sticks with the chip's built in NTSC and PAL standards, with the
+addition of the 720x576PAL mode.  It also does some other wacky stuff like
+closed-captioning, Macro-vision copy-protection, and other things.  Check
+out the datasheet for more info.
 
 
 Issues
Index: kernel/chips/bt869.c
=================================RCS file: /home/cvs/lm_sensors2/kernel/chips/bt869.c,v
retrieving revision 1.28
diff -u -r1.28 bt869.c
--- kernel/chips/bt869.c	2001/10/13 17:48:42	1.28
+++ kernel/chips/bt869.c	2002/01/03 20:16:45
@@ -1,7 +1,9 @@
 /*
     bt869.c - Part of lm_sensors, Linux kernel modules for hardware
              monitoring
+
     Copyright (c) 1998, 1999  Frodo Looijaard <frodol@dds.nl>
+    Copyright (c) 2001, 2002  Stephen Davies  <steve@daviesfam.org>
 
     This program is free software; you can redistribute it and/or modify
     it under the terms of the GNU General Public License as published by
@@ -83,6 +85,7 @@
 	u8 half;		/* go half res */
 	u8 depth;		/* screen depth */
 	u8 colorbars;		/* turn on/off colorbar calibration screen */
+        u8 svideo;              /* output format: (2=RGB) 1=SVIDEO, 0=Composite */
 };
 
 #ifdef MODULE
@@ -108,6 +111,7 @@
 static void bt869_dec_use(struct i2c_client *client);
 static int bt869_read_value(struct i2c_client *client, u8 reg);
 static int bt869_write_value(struct i2c_client *client, u8 reg, u16 value);
+static void bt869_write_values(struct i2c_client *client, u16 *values);
 static void bt869_status(struct i2c_client *client, int operation,
 			 int ctl_name, int *nrels_mag, long *results);
 static void bt869_ntsc(struct i2c_client *client, int operation,
@@ -118,6 +122,8 @@
 		       int ctl_name, int *nrels_mag, long *results);
 static void bt869_colorbars(struct i2c_client *client, int operation,
 			    int ctl_name, int *nrels_mag, long *results);
+static void bt869_svideo(struct i2c_client *client, int operation,
+			    int ctl_name, int *nrels_mag, long *results);
 static void bt869_depth(struct i2c_client *client, int operation,
 			int ctl_name, int *nrels_mag, long *results);
 static void bt869_update_client(struct i2c_client *client);
@@ -153,9 +159,173 @@
 	 &i2c_sysctl_real, NULL, &bt869_colorbars},
 	{BT869_SYSCTL_DEPTH, "depth", NULL, 0, 0644, NULL, &i2c_proc_real,
 	 &i2c_sysctl_real, NULL, &bt869_depth},
+	{BT869_SYSCTL_SVIDEO, "svideo", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &bt869_svideo},
 	{0}
 };
 
+/* ******************
+
+720x576, 27.5MHz, no overscan compensation - suitable for DVD playback etc
+                             <steve@daviesfam.org>
+
+FIXME: For the time being, this is PAL only.  NTSC DVDs are 720x480, aren't they?
+FIXME: Not sure what to do for the NTSC folks - if you're interested in helping
+FIXME: me do some NTSC modes more suitable for DVD playback, contact me.
+FIXME:  -- Steve Davies <steve@daviesfam.org>
+
+
+    Mode        "720x576-BT869"
+        DotClock        27.5
+        HTimings        720 744 800 880
+        VTimings        576 581 583 625
+    EndMode
+
+
+625LINE=1							625 line output format
+BST_AMP[7:0]=x59 89						Burst ampl. multiplication factor (PAL std??)
+BY_PLL=0							Use the PLL
+CATTENUATE[2:0]=0						No chroma attenuation
+CCF1B1[7:0]=0							close caption stuff
+CCF1B2[7:0]=0							close caption stuff
+CCF2B1[7:0]=0							close caption stuff
+CCF2B2[7:0]=0							close caption stuff
+CCORING[2:0]=0							Bypass chroma coring
+CCR_START[8:0]=0 [CCR_START[8]=0; CCR_START[7:0]=0]		Close-caption clock runin start from hsync
+CC_ADD[11:0]=xD2 210  [CC_ADD[11:8]=0; CC_ADD[7:0]=xD2]		Close-caption DTO increment
+CHECK_STAT=0							Don't check monitor status
+CLPF[1:0]=0						  	Hoz chroma lowpass filter=Bypass
+DACDISA=1							Disable DACA
+DACDISB=0							Don't disable DACB
+DACDISC=0							Don't disable DACC
+DACOFF=0							Don't disable the DACs
+DATDLY = 0							normal
+DATSWP=0							normal
+DCHROMA=0							Don't blank chroma
+DIS_FFILT=1							Disable flickerfilter
+DIS_GMSHC=1							Disable chroma psuedo-gamma removal
+DIS_GMSHY=1							Disable luma pseudo gamma removal
+DIS_GMUSHC=1							Disable chroma anti-pseudo gamma removal
+DIS_GMUSHY=1							Disable luma anti-pseudo gamma removal
+DIS_SCRESET=0							Normal subcarrier phase resets
+DIS_YFLPF=0							Disable Luma initial hoz low pass filter
+DIV2=0								Input pixel rate not divided by 2
+ECBAR=0								No colour bars
+ECCF1=0								Disable closed caption
+ECCF2=0								Disable closed caption
+ECCGATE=0							Normal close caption encoding
+ECLIP=0								0=disable clipping
+EN_ASYNC=0							set to 0 for normal operation
+EN_BLANKO=0							BLANK is an input
+EN_DOT=0							Disables dot clock sync on BLANK pin
+EN_OUT=1							Allows outputs to be enabled
+EN_XCLK=1							Use CLKI pin as clock source
+ESTATUS[1:0]=0							Used to select readback register
+FIELDI=0							Logical 1 on FIELD indicates even field
+F_SELC[2:0]=0							5 line chroma flickerfilter
+F_SELY[2:0]=0							5 line luma flickerfilter
+HBURST_BEGIN[7:0]=x98 152					Chroma burst start point in clocks
+HBURST_END[7:0]=x58 88						Chroma burst end point in clocks - 128
+HSYNCI=0							Active low HSYNC
+HSYNC_WIDTH[7:0]=x80 128					Analogue sync width in clocks
+HSYNOFFSET[9:0]=0  [HSYNOFFSET[9:8]=0; HSYNOFFSET[7:0]=0]	hsync in "standard position"
+HSYNWIDTH[5:0]=2						2 pixel hsync width
+H_ACTIVE[9:0]=x2D0 720  [H_ACTIVE[9:8]=2; H_ACTIVE[7:0]=xD0]	Active pixels per line
+H_BLANKI[8:0]=x84 132  [H_BLANKI[8]=0; H_BLANKI[7:0]=x84]	End of blanking of input video
+H_BLANKO[9:0]=x120 288  [H_BLANKO[9:8]=1; H_BLANKO[7:0]=x20]	End of blanking from hoz sync leading edge
+H_CLKI[10:0]=x378 888  [H_CLKI[10:8]=3; H_CLKI[7:0]=x78]	Input line length total in clocks
+H_CLKO[11:0]=x6e0 1760  [H_CLKO[11:8]=6; H_CLKO[7:0]=xe0]	Output clocks per line
+H_FRACT[7:0]=0							0 fractional input clocks per line
+IN_MODE[2:0]=0							24Bit RGB muxed
+LUMADLY[1:0]=0							0 pixel delay on Y_DLY luma
+MCB[7:0]=x49 73							Mult factor for CB prior to subcarrier mod.
+MCR[7:0]=x82 130						Mult factor for CR prior to subcarrier mod.
+MODE2X=0							Don't divide clock input by 2
+MSC[31:0]=x2945E0B4 692445365  [MSC[31:24]=x29; MSC[23:16]=x45; MSC[15:8]=xE0; MSC[7:0]=xB4] Subcarrier incr.
+MY[7:0]=x8C 140							Mult factor for Y
+NI_OUT=0							Normal interlaced output
+OUT_MODE[1:0]=0							video0-3 is CVBS, Y, C, Y_DLY
+OUT_MUXA[1:0]=0							Don't care as DACA is disabled
+OUT_MUXB[1:0]=1							Output video[1] (Y) on DACB
+OUT_MUXC[1:0]=2							Output video[2] (C) on DACC
+PAL_MD=1							Video output in PAL mode
+PHASE_OFF[7:0]=0						Subcarrier phase offset
+PLL_FRACT[15:0]=x30 48  [PLL_FRACT[15:8]=0x0; PLL_FRACT[7:0]=x30] frac portion of pll multiplier
+PLL_INT[5:0]=0x0C 12						Int portion of pll multiplier
+SETUP=0								7.5-IRE setup disabled
+SLAVER=1							
+SRESET=0							Don't do a software reset
+SYNC_AMP[7:0]=xF0 240						Sync amp mult. factor (PAL std???)
+VBLANKDLY=0							Extra line of blanking in 2nd field?
+VSYNCI=0							Active low VSYNC
+VSYNC_DUR=0							2.5line VSYNC duration on output
+VSYNCOFFSET[10:0]=0  [VSYNOFFSET[10:8]=0; VSYNOFFSET[7:0]=0]	VSYNC in standard position
+VSYNWIDTH[2:0]=1						1 line of vsync width
+V_ACTIVEI[9:0]=x240 576  [V_ACTIVEI[9:0]=2; V_ACTIVEI[7:0]=x40]	Active input lines
+V_ACTIVEO[8:0]=x122 290  [V_ACTIVE0[8]=1; V_ACTIVEO[7:0]=x22]
+V_BLANKI[7:0]=x2A 42						Input lines from vsync to first active line
+V_BLANKO[7:0]=x16 22
+V_LINESI[9:0]=x271 625  [V_LINESI[9:8]=2; V_LINESI[7:0]=x71]	Number of input lines
+V_SCALE[13:0]=x1000 4096  [V_SCALE[13:8]=x10; V_SCALE[7:0]=0]	Vert scale coefficient="none"?
+YATTENUATE[2:0]=0						no luma attenuation
+YCORING[2:0]=0							Luma-coring bypass
+YLPF[1:0]=0							Luma hoz low pass filter=bypass
+
+***************** */
+
+static u16 registers_720_576[] +    {
+      0x6e, 0x00,	/* HSYNOFFSET[7:0]=0 */
+      0x70, 0x02,	/* HSYNOFFSET[9:8]=0; HSYNWIDTH[5:0]=2 */
+      0x72, 0x00,	/* VSYNOFFSET[7:0]=0 */
+      0x74, 0x01,	/* DATDLY = 0; DATSWP=0; VSYNOFFSET[10:8]=0; VSYNWIDTH[2:0]=1 */
+      0x76, 0xe0,	/* H_CLKO[7:0]=xe0 */
+      0x78, 0xd0,	/* H_ACTIVE[7:0]=xD0 */
+      0x7a, 0x80,	/* HSYNC_WIDTH[7:0]=x80 */
+      0x7c, 0x98,	/* HBURST_BEGIN[7:0]=x98 */
+      0x7e, 0x58,	/* HBURST_END[7:0]=x58 */
+      0x80, 0x20,	/* H_BLANKO[7:0]=x20 */
+      0x82, 0x16,	/* V_BLANKO[7:0]=x16 */
+      0x84, 0x22,	/* V_ACTIVEO[7:0]=x22 */
+      0x86, 0xa6,	/* V_ACTIVE0[8]=1; H_ACTIVE[9:8]=2; H_CLKO[11:8]=6 */
+      0x88, 0x00,	/* H_FRACT[7:0]=0 */
+      0x8a, 0x78,	/* H_CLKI[7:0]=x78 */
+      0x8c, 0x80,	/* H_BLANKI[7:0]=x84 */
+      0x8e, 0x03,	/* VBLANKDLY=0; H_BLANKI[8]=0; H_CLKI[10:8]=3 */
+      0x90, 0x71,	/* V_LINESI[7:0]=x71 */
+      0x92, 0x2a,	/* V_BLANKI[7:0]=x2A */
+      0x94, 0x40,	/* V_ACTIVEI[7:0]=x40 */
+      0x96, 0x0a,	/* CLPF[1:0]=0; YLPF[1:0]=0; V_ACTIVEI[9:0]=2; V_LINESI[9:8]=2 */
+      0x98, 0x00,	/* V_SCALE[7:0]=0 */
+      0x9a, 0x50,	/* H_BLANKO[9:8]=1; V_SCALE[13:8]=x10 */
+      0x9c, 0x30,	/* PLL_FRACT[7:0]=x30 */
+      0x9e, 0x0,	/* PLL_FRACT[15:8]=0x0 */
+      0xa0, 0x8c,	/* EN_XCLK=1; BY_PLL=0; PLL_INT[5:0]=0x0C */
+      0xa2, 0x24,	/* ECLIP=0; PAL_MD=1; DIS_SCRESET=0; VSYNC_DUR=0; 625LINE=1; SETUP=0; NI_OUT=0 */
+      0xa4, 0xf0,	/* SYNC_AMP[7:0]=xF0 */
+      0xa6, 0x59,	/* BST_AMP[7:0]=x59 */
+      0xa8, 0x82,	/* MCR[7:0]=x82 */
+      0xaa, 0x49,	/* MCB[7:0]=x49 */
+      0xac, 0x8c,	/* MY[7:0]=x8C */
+      0xae, 0xb4,	/* MSC[7:0]=xb4 */
+      0xb0, 0xe0,	/* MSC[15:8]=xe0 */
+      0xb2, 0x45,	/* MSC[23:16]=x45 */
+      0xb4, 0x29,	/* MSC[31:24]=x29 */
+      0xb6, 0x00,	/* PHASE_OFF[7:0]=0 */
+      //0xba, 0x21,	/* SRESET=0; CHECK_STAT=0; SLAVER=1; DACOFF=0; DACDISC=0; DACDISB=0; DACDISA=1 */
+      0xc4, 0x01,	/* ESTATUS[1:0]=0; ECCF2=0; ECCF1=0; ECCGATE=0; ECBAR=0; DCHROMA=0; EN_OUT=1 */
+      0xc6, 0x00,	/* EN_BLANKO=0; EN_DOT=0; FIELDI=0; VSYNCI=0; HSYNCI=0; IN_MODE[2:0]=0(24bRGB) */
+      0xc8, 0x40,	/* DIS_YFLPF=0; DIS_FFILT=1; F_SELC[2:0]=0; F_SELY[2:0]=0 */
+      0xca, 0xc0,	/* DIS_GMUSHY=1; DIS_GMSHY=1; YCORING[2:0]=0; YATTENUATE[2:0]=0 */
+      0xcc, 0xc0,	/* DIS_GMUSHC=1; DIS_GMSHC=1; CCORING[2:0]=0; CATTENUATE[2:0]=0 */
+      //0xce, 0x24,       /* OUT_MUXC=2 [C]; OUT_MUXB=1 [Y]; OUT_MUXA=0 [CVBS, but disabled]*/
+      //0xce, 0x04,       /* OUT_MUXC=0 [CVBS]; OUT_MUXB=1 [Y]; OUT_MUXA=0 [CVBS, but disabled]*/
+      0xd6, 0x00,	/* OUT_MODE[1:0]=0; LUMADLY[1:0]=0 */
+      0, 0
+    };
+
+
+
 /* Used by init/cleanup */
 static int __initdata bt869_initialized = 0;
 
@@ -319,9 +489,21 @@
    the usual practice. */
 int bt869_write_value(struct i2c_client *client, u8 reg, u16 value)
 {
+#ifdef DEBUG
+        printk("bt869.o: write_value(0x%X, 0x%X)\n", reg, value);
+#endif
 	return i2c_smbus_write_byte_data(client, reg, value);
 }
 
+void bt869_write_values(struct i2c_client *client, u16 *values)
+{
+  /* writes set of registers from array.  0,0 marks end of table */
+  while (*values) {
+    bt869_write_value(client, values[0], values[1]);
+    values += 2;
+  }
+}
+
 void bt869_init_client(struct i2c_client *client)
 {
 	struct bt869_data *data = client->data;
@@ -342,6 +524,7 @@
 	data->ntsc = 1;
 	data->half = 0;
 	data->colorbars = 0;
+	data->svideo = 0;
 	data->depth = 16;
 
 }
@@ -357,42 +540,62 @@
 #ifdef DEBUG
 		printk("Starting bt869 update\n");
 #endif
-/* Set values of device */
-		if ((data->res[0] = 640) && (data->res[1] = 480)) {
-			bt869_write_value(client, 0xB8, (!data->ntsc));
-			bt869_write_value(client, 0xa0, 0x80 + 0x0C);
-			printk("bt869.o: writing into config -->0x%X\n",
-			       (0 + (!data->ntsc)));
-		} else if ((data->res[0] = 800) && (data->res[1] = 600)) {
-			bt869_write_value(client, 0xB8,
+		if ((data->res[0] = 800) && (data->res[1] = 600)) {
+			/* 800x600 built-in mode */
+		        bt869_write_value(client, 0xB8,
 					  (2 + (!data->ntsc)));
 			bt869_write_value(client, 0xa0, 0x80 + 0x11);
 			printk("bt869.o: writing into config -->0x%X\n",
 			       (2 + (!data->ntsc)));
-		} else {
-			bt869_write_value(client, 0xB8, (!data->ntsc));
+		}
+		else if ((data->res[0] = 720) && (data->res[1] = 576)) {
+		        /* 720x576 no-overscan-compensation mode suitable for PAL DVD playback */
+		        bt869_write_values(client,  registers_720_576);
+		}
+		else {
+		        /* 640x480 built-in mode */
+		        bt869_write_value(client, 0xB8, (!data->ntsc));
 			bt869_write_value(client, 0xa0, 0x80 + 0x0C);
 			printk("bt869.o: writing into config -->0x%X\n",
 			       (0 + (!data->ntsc)));
-			printk
+			if ((data->res[0] != 640) || (data->res[1] != 480)) {
+			  printk
 			    ("bt869.o:  Warning: arbitrary resolutions not supported yet.  Using 640x480.\n");
-			data->res[0] = 640;
-			data->res[1] = 480;
+			  data->res[0] = 640;
+			  data->res[1] = 480;
+			}
 		}
+		/* Set colour depth */
 		if ((data->depth != 24) && (data->depth != 16))
 			data->depth = 16;
 		if (data->depth = 16)
 			bt869_write_value(client, 0x0C6, 0x001);
 		if (data->depth = 24)
 			bt869_write_value(client, 0x0C6, 0x000);
-		bt869_write_value(client, 0xD4, data->half << 6);
-		/* Be a slave to the clock on the Voodoo3 */
-		bt869_write_value(client, 0xba, 0x20);
-		/* depth bpp */
-		bt869_write_value(client, 0x0C6, 0x001);
+		/* set "half" resolution mode */
+		bt869_write_value(client, 0xd4, data->half << 6);
+		/* Set composite/svideo mode, also enable the right dacs */
+		switch (data->svideo) {
+		case 2:  /* RGB - requires hardware mod on Voodoo3 to get all outputs */
+		  bt869_write_value(client, 0xd6, 0x0c);
+		  bt869_write_value(client, 0xce, 0x24);
+		  bt869_write_value(client, 0xba, 0x20);
+		  break;
+		case 1:  /* Svideo*/
+		  bt869_write_value(client, 0xce, 0x24);
+		  bt869_write_value(client, 0xba, 0x21);
+		  break;
+		default:  /* Composite */
+		  bt869_write_value(client, 0xce, 0x0);
+		  bt869_write_value(client, 0xba, 0x21);
+		  break;
+		}
+		/* Enable outputs */
 		bt869_write_value(client, 0xC4, 1);
+		/* Issue timing reset */
+		bt869_write_value(client, 0x6c, 0x80);
 
-/* Get status */
+/* Read back status registers */
 		bt869_write_value(client, 0xC4,
 				  1 | (data->colorbars << 2));
 		data->status[0] = bt869_read_value(client, 1);
@@ -449,6 +652,25 @@
 }
 
 
+void bt869_svideo(struct i2c_client *client, int operation, int ctl_name,
+		int *nrels_mag, long *results)
+{
+	struct bt869_data *data = client->data;
+	if (operation = SENSORS_PROC_REAL_INFO)
+		*nrels_mag = 0;
+	else if (operation = SENSORS_PROC_REAL_READ) {
+		bt869_update_client(client);
+		results[0] = data->svideo;
+		*nrels_mag = 1;
+	} else if (operation = SENSORS_PROC_REAL_WRITE) {
+		if (*nrels_mag >= 1) {
+			data->svideo = results[0];
+		}
+		bt869_update_client(client);
+	}
+}
+
+
 void bt869_res(struct i2c_client *client, int operation, int ctl_name,
 	       int *nrels_mag, long *results)
 {
@@ -563,7 +785,7 @@
 #ifdef MODULE
 
 MODULE_AUTHOR
-    ("Frodo Looijaard <frodol@dds.nl> and Philip Edelbrock <phil@netroedge.com>");
+    ("Frodo Looijaard <frodol@dds.nl>, Philip Edelbrock <phil@netroedge.com>, Stephen Davies <steve@daviesfam.org>");
 MODULE_DESCRIPTION("bt869 driver");
 
 int init_module(void)
Index: kernel/include/sensors.h
=================================RCS file: /home/cvs/lm_sensors2/kernel/include/sensors.h,v
retrieving revision 1.85
diff -u -r1.85 sensors.h
--- kernel/include/sensors.h	2001/11/20 17:11:20	1.85
+++ kernel/include/sensors.h	2002/01/03 20:16:46
@@ -370,6 +370,7 @@
 #define BT869_SYSCTL_RES    1003
 #define BT869_SYSCTL_COLORBARS    1004
 #define BT869_SYSCTL_DEPTH  1005
+#define BT869_SYSCTL_SVIDEO 1006
 
 #define MATORB_SYSCTL_DISP 1000
 
