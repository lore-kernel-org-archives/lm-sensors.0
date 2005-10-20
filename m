From: S.Bieganski@tue.nl (Szymon Bieganski)
Date: Thu, 20 Oct 2005 00:18:46 +0000
Subject: [lm-sensors] feedback request: i2c bus and v4l driver for PCRadio
Message-Id: <op.sywywaqmbj4yoq@mail.tue.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <opsik3vcn0bj4yoq@mailhost.ics.ele.tue.nl>
In-Reply-To: <opsik3vcn0bj4yoq@mailhost.ics.ele.tue.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello again,

Done:

/usr/src$> diffstat spase.diff
  i2c/busses/Kconfig            |   11
  i2c/busses/Makefile           |    1
  i2c/busses/i2c-spase.c        |  213 +++++++++++
  media/radio/Kconfig           |    7
  media/radio/Makefile          |    1
  media/radio/radio-spase-i2c.c |  754  
++++++++++++++++++++++++++++++++++++++++++
  6 files changed, 987 insertions(+)
/usr/src$>

Jean, thanks for your tips.

with kind regards
Szymon
-- 
----                                                                                          
----
Szymon Bieganski, PhD candidate S.Bieganski@tue.nl
TU/e EE dept ICS group, (+31) 40 247 3394
----                                                                                          
----

--------------- spase.diff ----------------
diff -urN kernel-source-2.6.8/drivers/i2c/busses/Kconfig  
linux/drivers/i2c/busses/Kconfig
--- kernel-source-2.6.8/drivers/i2c/busses/Kconfig	2004-08-14  
07:37:40.000000000 +0200
+++ linux/drivers/i2c/busses/Kconfig	2005-03-06 18:13:12.000000000 +0100
@@ -70,6 +70,17 @@
  	  This support is also available as a module.  If so, the module
  	  will be called i2c-elektor.

+config I2C_SPASE
+	tristate "PC-Radio ISA card with i2c bus"
+	depends on I2C && ISA && EXPERIMENTAL
+	select I2C_ALGOBIT
+	help
+	  This supports the PC-Radio Spase ISA bus I2C adapter.  Say Y if you own
+	  such an adapter.
+
+	  This support is also available as a module.  If so, the module
+	  will be called i2c-spase.
+
  config I2C_HYDRA
  	tristate "CHRP Apple Hydra Mac I/O I2C interface"
  	depends on I2C && PCI && PPC_CHRP && EXPERIMENTAL
diff -urN kernel-source-2.6.8/drivers/i2c/busses/Makefile  
linux/drivers/i2c/busses/Makefile
--- kernel-source-2.6.8/drivers/i2c/busses/Makefile	2004-08-14  
07:36:14.000000000 +0200
+++ linux/drivers/i2c/busses/Makefile	2005-03-06 18:08:07.000000000 +0100
@@ -32,6 +32,7 @@
  obj-$(CONFIG_I2C_VOODOO3)	+= i2c-voodoo3.o
  obj-$(CONFIG_SCx200_ACB)	+= scx200_acb.o
  obj-$(CONFIG_SCx200_I2C)	+= scx200_i2c.o
+obj-$(CONFIG_I2C_SPASE)	+= i2c-spase.o

  ifeq ($(CONFIG_I2C_DEBUG_BUS),y)
  EXTRA_CFLAGS += -DDEBUG
diff -urN kernel-source-2.6.8/drivers/i2c/busses/i2c-spase.c  
linux/drivers/i2c/busses/i2c-spase.c
--- kernel-source-2.6.8/drivers/i2c/busses/i2c-spase.c	1970-01-01  
01:00:00.000000000 +0100
+++ linux/drivers/i2c/busses/i2c-spase.c	2005-10-19 23:30:39.000000000  
+0200
@@ -0,0 +1,213 @@
+/*  
------------------------------------------------------------------------ *
+ * i2c-spase-bit.c I2C bus present on the board of PCRadio  
Spase-003            *
+ *  
------------------------------------------------------------------------ *
+   Copyright (C) 2004 Szymon Bieganski <S.Bieganski@tue.nl>
+
+   Based on older i2c-parport.c driver and radio-spase.c by Michiel  
Ronsse <ronsse@elis.rug.ac.be>
+
+   This program is free software; you can redistribute it and/or modify
+   it under the terms of the GNU General Public License as published by
+   the Free Software Foundation; either version 2 of the License, or
+   (at your option) any later version.
+
+   This program is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+   GNU General Public License for more details.
+
+   You should have received a copy of the GNU General Public License
+   along with this program; if not, write to the Free Software
+   Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *  
------------------------------------------------------------------------ */
+
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/ioport.h>
+#include <linux/delay.h>	/* udelay			*/
+#include <linux/i2c.h>
+#include <linux/i2c-algo-bit.h>
+#include <asm/io.h>
+#include <linux/proc_fs.h>    /* /proc interface              */
+
+#define DEFAULT_BASE 0x1B0
+#define SPASE_SCLK	0x00000001
+#define SPASE_SDAT	0x00000002
+#define SPASE_SDAT_OE	0x00000004
+
+/* #define PROC_READ */
+
+#define I2C_HW_B_SPASE	0xff	/* Parallel port Philips style adapter */
+
+static int base;
+static int proc = 1;
+
+static int cur_state;
+
+struct proc_dir_entry *proc_entry;
+
+MODULE_PARM(base, "i");
+MODULE_PARM_DESC(base, "Base I/O address");
+MODULE_PARM(proc, "i");
+MODULE_PARM_DESC(proc, "enable /proc/i2c status entry  (set to 1 to  
enable)");
+
+static inline void port_write(unsigned char d)
+{
+	outb(d, base);
+}
+
+static inline unsigned char port_read(void)
+{
+	return inb(base);
+}
+
+/* ----- Unified line operation functions  
--------------------------------- */
+
+static inline void line_set(int state, unsigned char d)
+{
+	if(state)
+		cur_state |= d;
+	else
+		cur_state &= ~d;
+
+	port_write(cur_state);
+}
+
+static inline int line_get(void)
+{
+	return (SPASE_SDAT_OE & port_read()) = SPASE_SDAT_OE;
+}
+
+/* ----- I2C algorithm call-back functions and structures  
----------------- */
+
+static void spase_setscl(void *data, int state)
+{
+	line_set(state, SPASE_SCLK);
+}
+
+static void spase_setsda(void *data, int state)
+{
+	line_set(state, SPASE_SDAT);
+}
+
+static int spase_getsda(void *data)
+{
+	return line_get();
+}
+
+/* Encapsulate the functions above in the correct structure
+	 Note that getscl will be set to NULL by the attaching code for adapters
+	 that cannot read SCL back */
+static struct i2c_algo_bit_data spase_algo_data = {
+	.setsda		= spase_setsda,
+	.setscl		= spase_setscl,
+	.getsda		= spase_getsda,
+	.getscl		= NULL, /* spase_getscl,*/
+	.udelay		= 5,
+	.mdelay		= 50,
+	.timeout		= HZ,
+};
+
+/* ----- I2c structure  
---------------------------------------------------- */
+
+static struct i2c_adapter spase_adapter = {
+	.owner		= THIS_MODULE,
+	.class		= I2C_CLASS_HWMON,
+	.id		= -1, /* FIXME !!!!! I2C_HW_B_SPASE, */
+	.algo_data	= &spase_algo_data,
+	I2C_DEVNAME("PCRadio Spase-003 adapter"),
+};
+
+/*---------------------------------------------------------------------*/
+
+static int read_proc(char *buf, char **start, off_t offset,
+		     int len, int *eof, void *data )
+{
+	*start = 0;
+	*eof   = 1;
+
+	return sprintf(buf,
+		"Type:       SPASE PCRadio-003 i2c port device\n"
+		"IO-port: 0x%x\n"
+		"\n"
+		"state:   0x%x\n"
+		"  SDA   %s   |\\           \n"
+		"      ______| \\_____ ____  \n"
+		"            | /     T     \n"
+		"            |/      |     \n"
+		"  SDA   %s     /|    |     \n"
+		"      _______/ |____|    \n"
+		"             \\ |         \n"
+		"              \\|         \n"
+		"                         \n"
+		"  SCL   %s   |\\           \n"
+		"      ______| \\_____     \n"
+		"            | /          \n"
+		"            |/           \n"
+		"SDA line:       %s -> %s\n"
+		"SCL line:       %s\n",
+		base,
+		cur_state,
+		(cur_state & SPASE_SDAT)?("H"):("L"),
+#ifdef PROC_READ
+		(line_get()?("H"):("L")),
+#else
+		"*",
+#endif
+		(cur_state & SPASE_SCLK)?("H"):("L"),
+		(cur_state & SPASE_SDAT)?("H"):("L"),
+#ifdef PROC_READ
+		(line_get()?("H"):("L")),
+#else
+		"*",
+#endif
+		(cur_state & SPASE_SCLK)?("H"):("L")
+		);
+}
+
+/* ----- Module loading, unloading and information  
------------------------ */
+
+static int __init i2c_spasebit_init(void)
+{
+	if (base = 0) {
+		printk(KERN_INFO "i2c-spase: using default base 0x%x\n", DEFAULT_BASE);
+		base = DEFAULT_BASE;
+	}
+
+	if (!request_region(base, 1, "i2c-spase"))
+	return -EBUSY;
+
+	cur_state = 0;
+	/* Reset hardware to a sane state (SCL and SDA high) */
+	spase_setsda(NULL, 1);
+	spase_setscl(NULL, 1);
+	/* Other init if needed (power on...) */
+
+	if (i2c_bit_add_bus(&spase_adapter) < 0) {
+		printk(KERN_ERR "i2c-spase: Unable to register with I2C\n");
+		release_region(base, 1);
+		return -ENODEV;
+	}
+
+	if(proc)
+		if((proc_entry = create_proc_entry("i2c", 0, NULL )))
+			proc_entry->read_proc = read_proc;
+
+	return 0;
+}
+
+static void __exit i2c_spasebit_exit(void)
+{
+	i2c_bit_del_bus(&spase_adapter);
+	if (proc_entry)
+		remove_proc_entry("i2c", NULL);
+	release_region(base, 1);
+}
+
+MODULE_AUTHOR("Szymon Bieganski <S.Bieganski@tue.nl>");
+MODULE_DESCRIPTION("I2C bus on PC-Radio Spase-003 board");
+MODULE_LICENSE("GPL");
+
+module_init(i2c_spasebit_init);
+module_exit(i2c_spasebit_exit);
diff -urN kernel-source-2.6.8/drivers/media/radio/Kconfig  
linux/drivers/media/radio/Kconfig
--- kernel-source-2.6.8/drivers/media/radio/Kconfig	2004-08-14  
07:37:15.000000000 +0200
+++ linux/drivers/media/radio/Kconfig	2005-02-26 17:26:13.000000000 +0100
@@ -49,6 +49,13 @@
  	  To compile this driver as a module, choose M here: the
  	  module will be called radio-aimslab.

+config RADIO_SPASE
+	tristate "Radio Spase support (EXPERIMENTAL)"
+	depends on ISA && VIDEO_DEV && EXPERIMENTAL
+	---help---
+	  To compile this driver as a module, choose M here: the
+	  module will be called radio-spase.
+
  config RADIO_RTRACK_PORT
  	hex "RadioTrack i/o port (0x20f or 0x30f)"
  	depends on RADIO_RTRACK=y
diff -urN kernel-source-2.6.8/drivers/media/radio/Makefile  
linux/drivers/media/radio/Makefile
--- kernel-source-2.6.8/drivers/media/radio/Makefile	2004-08-14  
07:37:14.000000000 +0200
+++ linux/drivers/media/radio/Makefile	2005-03-06 22:20:13.000000000 +0100
@@ -20,3 +20,4 @@
  obj-$(CONFIG_RADIO_GEMTEK_PCI) += radio-gemtek-pci.o
  obj-$(CONFIG_RADIO_TRUST) += radio-trust.o
  obj-$(CONFIG_RADIO_MAESTRO) += radio-maestro.o
+obj-$(CONFIG_RADIO_SPASE) += radio-spase-i2c.o
diff -urN kernel-source-2.6.8/drivers/media/radio/radio-spase-i2c.c  
linux/drivers/media/radio/radio-spase-i2c.c
--- kernel-source-2.6.8/drivers/media/radio/radio-spase-i2c.c	1970-01-01  
01:00:00.000000000 +0100
+++ linux/drivers/media/radio/radio-spase-i2c.c	2005-10-19  
23:54:22.000000000 +0200
@@ -0,0 +1,754 @@
+/* Spase driver for Linux radio support (C) 2004 Szymon Bieganski
+ * S.Bieganski@tue.nl
+ *
+ * Based on RadioTrack I/RadioReveal (C) 1997 M. Kirkwood
+ *  and radio-spase.c by Michiel Ronsse <ronsse@elis.rug.ac.be>
+ *
+ */
+
+#include <linux/module.h>	/* Modules 			*/
+#include <linux/init.h>		/* Initdata			*/
+#include <linux/videodev.h>	/* kernel radio structs		*/
+#include <linux/config.h>	/* CONFIG_RADIO_RTRACK2_PORT 	*/
+#include <linux/spinlock.h>
+#include <linux/proc_fs.h>    /* /proc interface              */
+
+/* #include <linux/i2c-dev.h> */
+#include <linux/i2c.h>
+
+#ifndef CONFIG_RADIO_SPASE_PORT
+#define CONFIG_RADIO_SPASE_PORT 0
+#endif
+
+static int io = CONFIG_RADIO_SPASE_PORT;
+static int volume_max = -1; /* unrestricted */
+static int volume_rear = 0;
+static int radio_nr = -1;
+static int display = 0;
+static spinlock_t lock;
+
+struct proc_dir_entry *proc_entry;
+static int proc = 1;
+
+struct i2c_adapter* spase_i2c_adap = 0;
+struct i2c_client* sound = 0;
+struct i2c_client* synth = 0;
+struct i2c_client* fmif = 0;
+
+struct sp_device
+{
+	unsigned int port;
+	// in v4l units (0 ... 65535)
+	unsigned int cur_vol;
+	unsigned int cur_bass;
+	unsigned int cur_treble;
+	// in v4l units and range 0 - left; 65535 - right
+	unsigned int cur_bal;
+	// in 1/16th of kHz steps
+	unsigned long cur_freq;
+	unsigned int mode_muted;
+	/*   unsigned int mode_stereo; */
+};
+
+static struct sp_device spase_unit;
+
+/* local things */
+
+#define FALSE 0
+#define TRUE  1
+
+#define SOUND_ADDRESS 64 /* 0x80 -> 0x40 = 64 */
+#define SYNTH_ADDRESS 98 /* 0xC4 -> 0x62 = 98 */
+#define FMIF_ADDRESS  97 /* 0xC2 -> 0x61 = 97 */
+
+#define STEREO 0x60
+#define MONO   0x64
+
+#define MUTE   0x80
+#define NOMUTE 0x00
+
+// in kHz units
+#define IF_FREQ (10700)
+#define LOW_RANGE   (87500)
+#define HIGH_RANGE (108000)
+
+/*---------------------------------------------------------------------*/
+static void Rotate(unsigned char* byte)
+{
+	int i;
+	unsigned char c; c = *byte & 0xff;
+	*byte = 0;
+
+	for(i = 7; i; --i) {
+		if(c & 0x1)
+			*byte |= 0x1;
+
+		*byte <<= 1;
+		c >>= 1;
+	}
+
+	if(c & 0x1)
+		*byte |= 0x1;
+}
+
+static int GetTuningInfo(char * Level, char * Stereo, int * Deviation)
+{
+	char buf[2];
+
+	int error = 0;
+
+	error = i2c_master_recv(fmif, buf, 2);
+
+	if(error != 2)
+		return -1;
+	
+	/* just to help computation -> this IC returns values which are  
transferred by I2C LSB-first */
+	Rotate(&buf[0]);
+	Rotate(&buf[1]);
+
+	if(Stereo) {
+#if 1
+		*Stereo = (buf[1] = 127);  /* 0..1     */
+#else
+		*Stereo = ((buf[0] & 0x0F) >> 1) > 5;
+#endif
+	}
+
+	if(Level)
+		*Level = (buf[0] & 0x0F) >> 1;         /* 0..7     */
+
+	if(Deviation)
+		*Deviation = (buf[1] - 127) >> 1;          /* -64..+64 */
+
+/*   printk(KERN_INFO "spase: MP %d/ Lev %d/ Dev %d.\n", (buf[0] & 0xF0)  
>> 4, buf[0] & 0x0F, buf[1] >> 1); */
+
+	return error;
+}
+
+/* Layer 3: spase layer ************************************************/
+
+int Sound(int Mode)
+{
+	char buf[2];
+	buf[0] = 0x05;
+	buf[1] = Mode ? NOMUTE : MUTE;
+
+	if(2 != i2c_master_send(sound, buf, 2))
+		return -1;
+	return 0;
+}
+
+/*---------------------------------------------------------------------*/
+
+int SetStereo(int Stereo)
+{
+	// it does NOTHING here
+	return 0;
+
+	char buf[2];
+	buf[0] = 0x02;
+	buf[1] = Stereo ? STEREO : MONO;
+
+	if(2 != i2c_master_send(synth, buf, 2))
+		return -1;
+
+	return 0;
+}
+
+/*---------------------------------------------------------------------*/
+
+int SetFrequency(unsigned long Frequency)
+{
+	unsigned long DividingNumber = Frequency / 10;
+	DividingNumber += IF_FREQ / 10;
+	char buf[6];
+
+/*   DividingNumber = (unsigned long)(200*Frequency + 2140); */
+	buf[0] = 0x0;
+	buf[1] = 1 | (DividingNumber << 1);      /* set the LSB */
+	buf[2] = DividingNumber >> 7;
+	/* Set 10kHz stepsize, FM Band */
+	buf[3] = STEREO | ((DividingNumber >> 15) & 3);
+
+	if(4 != i2c_master_send(synth, buf, 4))
+		return -1;
+
+	return 0;
+}
+
+/*---------------------------------------------------------------------*/
+
+int SetAudio(unsigned int v4l_Volume, unsigned int v4l_Balance, unsigned  
int v4l_Treble, unsigned int v4l_Bass)
+{
+	char buf[6];
+
+	int half = 1 << 4;
+/*   int full = 1 << 5; */
+/*   int quarter = 1 << 3; */
+
+	int Dummy,
+		Volume = v4l_Volume >> 10,
+		Balance = (v4l_Balance >> 11) - half,
+		Treble = (v4l_Treble >> 12),
+		Bass = (v4l_Bass >> 12);
+	
+	/* volume :
+	   63: +20db
+	   62: +18db
+	   ...
+	   53: 0 db
+	   52: -2db
+	   ...
+	   20: -66db
+	   <20: mute
+	*/
+
+	/* volume */
+	if(Volume < 0)
+		Volume = 0;
+	if(Volume > volume_max)
+		Volume = volume_max;
+
+	/* mapping volume/balance to volume_left/volume_right */
+	buf[1] = Volume;       /* Left volume:  0..63 */
+	buf[2] = Volume;       /* Right volume: 0..63 */
+
+	Dummy = (abs(Balance) * Volume) / volume_max;
+	/*   Dummy = (Dummy < 0) ? 0 : Dummy; */
+	/*   Dummy = (Dummy > full) ? full : Dummy; */
+
+	if(Balance < 0)
+		buf[1] = buf[1] - abs(Dummy);
+	if(buf[1] < 0)
+		buf[1] = 0;
+
+	if(Balance > 0)
+		buf[2] = buf[2] - abs(Dummy);
+	if(buf[2] < 0)
+		buf[2] = 0;
+
+	/* bass */
+	/*   Bass += 7;  */
+	/* 3..11 */
+	if(Bass < 3)
+		Bass = 3;
+	if(Bass > 11)
+		Bass = 11;
+	buf[3] = Bass;
+
+	/* treble */
+	/*   Treble += 7; */
+	/* 3..11 */
+	if(Treble < 3)
+		Treble = 3;
+	if(Treble > 11)
+		Treble = 11;
+	buf[4] = Treble;
+
+#if 0
+	buf[0] = 0x0;
+#else
+	buf[0] = 0x0;
+	buf[5] += volume_rear;
+	buf[5] += 0; /* 4th bit -> select rear fader */
+	buf[5] += 32; /* 5th bit -> enable fader */
+#endif
+
+	if(6 != i2c_master_send(sound, buf, 6))
+		return -1;
+
+	return 0;
+}
+
+/*---------------------------------------------------------------------*/
+
+static int InitRadio(void)
+{
+	char buf[2];
+	int ret = 0;
+
+	buf[0] = 0xFE;
+	if(1 != (ret = i2c_master_send(fmif, buf, 1)) ) {
+		printk(KERN_INFO "spase: fmif chip initialization failed (returned  
0x%x).\n", ret);
+		return -EINVAL;
+	}
+
+	buf[0] = 0x04;
+	buf[1] = 0x0;
+	/* 4th byte -> fader */
+	if(volume_rear > 0) {
+		buf[1] += volume_rear;
+		buf[1] += 0; /* 4th bit -> select rear fader */
+		buf[1] += 32; /* 5th bit -> enable fader */
+		int ret = buf[1];
+		printk(KERN_INFO "spase: fader driven with value 0x%x.\n", ret);
+		if(2 != (ret = i2c_master_send(sound, buf, 2)) ) {
+			printk(KERN_INFO "spase: sound chip initialization failed (returned  
0x%x).\n", ret);
+			return -EINVAL;
+		}
+	}
+	/*   else */
+	/*     buf[1] = 0xFF; */
+
+	SetStereo(TRUE);
+
+	return 0;
+}
+
+/*---------------------------------------------------------------------*/
+
+static int sp_do_ioctl(struct inode *inode, struct file *file,
+		       unsigned int cmd, void *arg)
+{
+	struct video_device *dev = video_devdata(file);
+	struct sp_device *sp = dev->priv;
+
+	switch(cmd) {
+	case VIDIOCGCAP: {
+		struct video_capability *v = arg;
+		memset(v,0,sizeof(*v));
+		v->type=VID_TYPE_TUNER;
+		v->channels=1;
+		v->audios=1;
+		strcpy(v->name, "SPASE PCRadio-003");
+		return 0;
+	}
+	case VIDIOCGTUNER: {
+		struct video_tuner *v = arg;
+		if(v->tuner)	/* Only 1 tuner */
+			return -EINVAL;
+		char stereo, signal;
+		GetTuningInfo(&signal, &stereo, (int*)NULL /*deviation*/ );
+		v->signal = (signal * 65536) / 7;
+		v->rangelow  = LOW_RANGE * 16;
+		v->rangehigh = HIGH_RANGE * 16;
+		v->flags = VIDEO_TUNER_LOW | (stereo ? VIDEO_TUNER_STEREO_ON : 0);
+		v->mode = VIDEO_MODE_AUTO;
+		strcpy(v->name, "FM");
+		return 0;
+	}
+	case VIDIOCSTUNER: {
+		struct video_tuner *v = arg;
+		if(v->tuner!=0)
+			return -EINVAL;
+		/* Only 1 tuner so no setting needed ! */
+		return 0;
+	}
+	case VIDIOCGFREQ: {
+		unsigned long *freq = arg;
+		*freq = sp->cur_freq;
+		return 0;
+	}
+	case VIDIOCSFREQ: {
+		unsigned long *freq = arg;
+		sp->cur_freq = *freq;
+/* 		  Sound(FALSE); */
+		SetFrequency(sp->cur_freq / 16);
+/* 		  Sound(TRUE); */
+		return 0;
+	}
+	case VIDIOCGAUDIO: {
+		struct video_audio *v = arg;
+		memset(v,0, sizeof(*v));
+		v->flags |= VIDEO_AUDIO_MUTABLE | VIDEO_AUDIO_VOLUME
+			| VIDEO_AUDIO_BASS | VIDEO_AUDIO_TREBLE /*| VIDEO_AUDIO_BALANCE */;
+		v->flags  |= sp->mode_muted ? VIDEO_AUDIO_MUTE : 0;
+		v->volume = sp->cur_vol;
+		v->balance = sp->cur_bal;
+		v->bass    = sp->cur_bass;
+		v->treble  = sp->cur_treble;
+		v->step = 1024; //65535/64
+#if 1
+		char stereo;
+		GetTuningInfo((char*)NULL, &stereo, (int*)NULL);
+		v->mode    = stereo ? VIDEO_SOUND_STEREO : VIDEO_SOUND_MONO;
+#else
+		v->mode    = sp->mode_stereo ? VIDEO_SOUND_STEREO : VIDEO_SOUND_MONO;
+#endif
+		strcpy(v->name, "Radio");
+		return 0;
+	}
+	case VIDIOCSAUDIO: {
+		struct video_audio *v = arg;
+		if(v->audio)
+			return -EINVAL;
+		if(v->flags & VIDEO_AUDIO_MUTE) {
+			sp->mode_muted = TRUE;
+			Sound(FALSE);
+		} else {
+			sp->mode_muted = FALSE;
+			sp->cur_vol    = v->volume;
+			sp->cur_bass   = v->bass;
+			sp->cur_treble = v->treble;
+			sp->cur_bal    = v->balance;
+			SetAudio(v->volume,
+				 v->balance,
+				 v->treble,
+				 v->bass);
+			Sound(TRUE);
+		}
+/*  		  char stereo; */
+/*  		  GetTuningInfo((char*)NULL, &stereo, (int*)NULL); */
+/*  		  sp->mode_stereo = (v->mode & VIDEO_SOUND_STEREO) ? (stereo ? TRUE  
: FALSE) : FALSE; */
+/* 	SetStereo(sp->mode_stereo); */
+		return 0;
+	}
+	default:
+		return -ENOIOCTLCMD;
+	}
+}
+
+static int sp_ioctl(struct inode *inode, struct file *file,
+		    unsigned int cmd, unsigned long arg)
+{
+	return video_usercopy(inode, file, cmd, arg, sp_do_ioctl);
+}
+
+#if 0
+static int sp_close(struct inode *inode, struct file *file)
+{
+	struct  video_device *dev = file->private_data;
+	struct cam_data *cam = dev->priv;
+
+	if(cam->proc_entry)
+		cam->proc_entry->uid = 0;
+	return 0;
+}
+#endif
+
+static struct file_operations spase_fops = {
+	.owner          = THIS_MODULE,
+	.open           = video_exclusive_open,
+	.release        = video_exclusive_release, /* sp_close, */
+	.ioctl          = sp_ioctl,
+	.llseek         = no_llseek,
+};
+
+static struct video_device spase_radio = {
+	.owner        = THIS_MODULE,
+	.name	        = "SPASE PCRadio-003",
+	.type	        = VID_TYPE_TUNER,
+	.hardware     = VID_HARDWARE_RTRACK2, /* just borrowed ;) */
+	.fops         = &spase_fops,
+};
+
+/*---------------------------------------------------------------------*/
+
+static int read_proc(char *buf, char **start, off_t offset,
+		     int len, int *eof, void *data )
+{
+	*start = 0;
+	*eof   = 1;
+
+	char stereo, signal; int deviation;
+	GetTuningInfo(&signal, &stereo, &deviation);
+
+	deviation += 64;
+	int megas = (int)(spase_unit.cur_freq/16000);
+	int kilos = (int)(spase_unit.cur_freq/16 - 1000 * megas);
+	int h_kilos = (int)(kilos / 100);
+	int t_kilos = (int)((kilos / 10) - (h_kilos * 10));
+	int u_kilos = (int)(kilos - (t_kilos * 10) - (h_kilos * 100));
+	return sprintf(buf,
+		       "Type:       SPASE PCRadio-003\n"
+		       "I2C-port:   %s\n"
+		       "Frequency:  %3d.%1d%1d%1d MHz\n"
+		       "Volume:     %d%%\n"
+		       "Balance:    %d%% [%.*s^%.*s]\n"
+		       "Bass:       %d%% [%.*s^%.*s]\n"
+		       "Treble:     %d%% [%.*s^%.*s]\n"
+		       "Power:      %s\n\n"
+		       "Signal: %s%s%s  %3d%% [%.*s%.*s]\n",
+		       spase_i2c_adap->name,
+		       megas, h_kilos, t_kilos, u_kilos,
+		       (spase_unit.cur_vol * 100)/65536,
+		       (spase_unit.cur_bal * 100)/65536,
+		       (spase_unit.cur_bal * 10)/65536,      "................",
+		       10 - (spase_unit.cur_bal * 10)/65536, "................",
+		       (spase_unit.cur_bass * 100)/65536,
+		       (spase_unit.cur_bass * 10)/65536,      "................",
+		       10 - (spase_unit.cur_bass * 10)/65536, "................",
+		       (spase_unit.cur_treble * 100)/65536,
+		       (spase_unit.cur_treble * 10)/65536,      "................",
+		       10 - (spase_unit.cur_treble * 10)/65536, "................",
+		       spase_unit.mode_muted ? "off" : "on",
+		       stereo ? "O" : " ",
+		       signal > 3 ? "-" : " ",
+		       stereo ? "O" : " ",
+		       (signal * 100) / 7,
+		       (signal << 1),     "################",
+		       (7 - signal) << 1, "................"
+		);
+}
+
+/*---------------------------------------------------------------------*/
+
+static int spase_attach_adapter(struct i2c_adapter *adapter)
+{
+	return 0; /* I know it is dangerous but check if the chip is actually  
connected is performed anyway */
+}
+
+static int spase_detach_client(struct i2c_client *client)
+{
+	int err;
+	if((err = i2c_detach_client(client))) {
+		printk("spase: Client deregistration failed, client not detached.\n");
+		return err;
+	}
+	kfree(client);
+	return 0;
+}
+
+struct i2c_driver sound_driver = {
+	.owner          = THIS_MODULE,
+	.name = "sound",
+	.id = -1,
+	.flags = I2C_DF_NOTIFY,
+	.attach_adapter = &spase_attach_adapter,
+	.detach_client  = &spase_detach_client,
+	.command        = NULL
+};
+
+struct i2c_driver synth_driver = {
+	.owner          = THIS_MODULE,
+	.name = "synth",
+	.id = -1,
+	.flags = I2C_DF_NOTIFY,
+	.attach_adapter = &spase_attach_adapter,
+	.detach_client  = &spase_detach_client,
+	.command        = NULL
+};
+
+struct i2c_driver fmif_driver = {
+	.owner          = THIS_MODULE,
+	.name = "fmif", /* !!!!! dont use slash in the name field !!!! */
+	.id = -1,
+	.flags = I2C_DF_NOTIFY,
+	.attach_adapter = &spase_attach_adapter,
+	.detach_client  = &spase_detach_client,
+	.command        = NULL
+};
+
+struct i2c_driver display_driver = {
+	.owner          = THIS_MODULE,
+	.name = "display", /* !!!!! dont use slash in the name field !!!! */
+	.id = -1,
+	.flags = I2C_DF_NOTIFY,
+	.attach_adapter = &spase_attach_adapter,
+	.detach_client  = &spase_detach_client,
+	.command        = NULL
+};
+
+static struct i2c_client client_template +{
+	I2C_DEVNAME("(chip unset)"),
+	.flags      = I2C_CLIENT_ALLOW_USE,
+        .driver     = &sound_driver,
+};
+
+static int __init spase_init(void)
+{
+	int r = request_module("i2c-spase");
+	if(r < 0) {
+		printk(KERN_INFO "spase: i2c adapter module is not loadable (returned  
0x%x).\n", r);
+		return -EINVAL;
+	}
+	spase_i2c_adap = i2c_get_adapter(io);
+
+	if(spase_i2c_adap != 0) {
+		if(i2c_adapter_id(spase_i2c_adap) = -1) {
+			i2c_put_adapter(spase_i2c_adap);
+			printk(KERN_INFO "spase: adapter 0x%x was not registered.\n", io);
+			return -EINVAL;
+		}
+	} else {
+		printk(KERN_INFO "spase: i2c bus driver 0x%x was not loaded.\n", io);
+		return -EINVAL;
+	}
+
+	i2c_add_driver(&sound_driver);
+
+	client_template.adapter = spase_i2c_adap;
+
+	client_template.addr = SOUND_ADDRESS;
+	client_template.driver = &sound_driver;
+	sprintf(client_template.name, "tea6310t sound processor");
+	if (NULL = (sound = kmalloc(sizeof(struct i2c_client), GFP_KERNEL)))
+		return -ENOMEM;
+	memcpy(sound, &client_template, sizeof(struct i2c_client));
+
+	if(i2c_attach_client(sound) = -EBUSY) {
+		printk(KERN_INFO "spase: SOUND chip not detected at address 0x%x.\n",  
SOUND_ADDRESS);
+		i2c_del_driver(&sound_driver);
+
+		i2c_put_adapter(spase_i2c_adap);
+		return -ENODEV;
+	}
+
+	i2c_add_driver(&synth_driver);
+
+	client_template.addr = SYNTH_ADDRESS;
+	client_template.driver = &synth_driver;
+	sprintf(client_template.name, "tsa6057 PLL synth");
+	if (NULL = (synth = kmalloc(sizeof(struct i2c_client), GFP_KERNEL)))
+		return -ENOMEM;
+	memcpy(synth, &client_template, sizeof(struct i2c_client));
+
+	if(i2c_attach_client(synth) = -EBUSY) {
+		if(sound)
+			i2c_detach_client(sound);
+		i2c_del_driver(&sound_driver);
+
+		printk(KERN_INFO "spase: SYNTH chip not detected at address 0x%x.\n",  
SYNTH_ADDRESS);
+		i2c_del_driver(&synth_driver);
+
+		i2c_put_adapter(spase_i2c_adap);
+		return -ENODEV;
+	}
+
+	i2c_add_driver(&fmif_driver);
+
+	client_template.addr = FMIF_ADDRESS;
+	client_template.driver = &fmif_driver;
+	sprintf(client_template.name, "tea6100 FM/IF");
+	if (NULL = (fmif = kmalloc(sizeof(struct i2c_client), GFP_KERNEL)))
+		return -ENOMEM;
+	memcpy(fmif, &client_template, sizeof(struct i2c_client));
+
+	if(i2c_attach_client(fmif) = -EBUSY) {
+		if(synth)
+			i2c_detach_client(synth);
+		i2c_del_driver(&synth_driver);
+
+		if(sound)
+			i2c_detach_client(sound);
+		i2c_del_driver(&sound_driver);
+
+		printk(KERN_INFO "spase: FMIF chip not detected at address 0x%x.\n",  
FMIF_ADDRESS);
+		i2c_del_driver(&fmif_driver);
+
+		i2c_put_adapter(spase_i2c_adap);
+		return -ENODEV;
+	}
+
+/*   printk(KERN_INFO "spase: FMIF (0x%x), SYNTH (0x%x) and SOUND (0x%x)  
chips detected.\n", FMIF_ADDRESS, SYNTH_ADDRESS, SOUND_ADDRESS); */
+	spase_radio.priv = &spase_unit;
+
+	spin_lock_init(&lock);
+	if(video_register_device(&spase_radio, VFL_TYPE_RADIO, radio_nr) = -1) {
+		if(fmif)
+			i2c_detach_client(fmif);
+		i2c_del_driver(&fmif_driver);
+
+		if(synth)
+			i2c_detach_client(synth);
+		i2c_del_driver(&synth_driver);
+
+		if(sound)
+			i2c_detach_client(sound);
+		i2c_del_driver(&sound_driver);
+
+		i2c_put_adapter(spase_i2c_adap);
+		return -EINVAL;
+	}
+
+	spase_unit.mode_muted = TRUE;
+/* 	spase_unit.mode_stereo = TRUE; */
+	spase_unit.port = io;
+
+	if (InitRadio() = -EINVAL) {
+		video_unregister_device(&spase_radio);
+		if(fmif)
+			i2c_detach_client(fmif);
+		i2c_del_driver(&fmif_driver);
+
+		if(synth)
+			i2c_detach_client(synth);
+		i2c_del_driver(&synth_driver);
+
+		if(sound)
+			i2c_detach_client(sound);
+		i2c_del_driver(&sound_driver);
+		return -EINVAL;
+	}
+
+	printk(KERN_INFO "Spase-003 PCRadio card registered at I2C bus  
\"%s\".\n", spase_i2c_adap->name);
+
+	if(volume_max < 0)
+		volume_max = 63;
+	else {
+		if(volume_max > 63)
+			volume_max = 63;
+		printk(KERN_ERR "By the user request volume_max set to %d\n",  
volume_max);
+	}
+
+	if(volume_rear > 15)
+		volume_rear = 15;
+
+	if(volume_rear < 0)
+		volume_rear = 0;
+
+	printk(KERN_ERR "By the user request volume_rear set to %d\n",  
volume_rear);
+
+	if(proc)
+		if((proc_entry = create_proc_entry( "radio", 0444, NULL )))
+			proc_entry->read_proc = read_proc;
+
+	spase_unit.cur_vol = 0;
+	spase_unit.cur_bass = (1 << 15);
+	spase_unit.cur_treble = (1 << 15);
+	spase_unit.cur_bal = (1 << 15);
+
+	SetAudio(spase_unit.cur_vol, spase_unit.cur_bal, spase_unit.cur_treble,  
spase_unit.cur_bass);
+
+	return 0;
+}
+
+MODULE_AUTHOR("Szymon Bieganski <S.Bieganski@tue.nl>");
+MODULE_DESCRIPTION("A driver for the PCRadio Spase radio card.");
+MODULE_LICENSE("GPL");
+
+MODULE_PARM(io, "i");
+MODULE_PARM_DESC(io, "I2C bus address (0, 1, 2 ...)");
+
+MODULE_PARM(radio_nr, "i");
+
+MODULE_PARM(volume_max, "i");
+MODULE_PARM_DESC(volume_max, "Maximum volume for Philips TEA6310T audio  
processor (0..63)");
+
+MODULE_PARM(volume_rear, "i");
+MODULE_PARM_DESC(volume_rear, "The volume of extra rear output of Philips  
TEA6310T audio processor (0..15)");
+
+MODULE_PARM(proc, "i");
+MODULE_PARM_DESC(proc, "Enable /proc/radio entry (set to 1 to enable)");
+
+static void __exit spase_cleanup_module(void)
+{
+	video_unregister_device(&spase_radio);
+	if(proc_entry)
+		remove_proc_entry("radio", NULL);
+
+	if(fmif)
+		i2c_detach_client(fmif);
+	i2c_del_driver(&fmif_driver);
+
+	if(synth)
+		i2c_detach_client(synth);
+	i2c_del_driver(&synth_driver);
+
+	if(sound)
+		i2c_detach_client(sound);
+	i2c_del_driver(&sound_driver);
+
+	if(spase_i2c_adap != 0)
+		i2c_put_adapter(spase_i2c_adap);
+}
+
+module_init(spase_init);
+module_exit(spase_cleanup_module);
+
+/*
+  Local variables:
+  compile-command: "mmake"
+  End:
+*/
