From: frodol@dds.nl (Frodo Looijaard)
Date: Thu, 19 May 2005 06:23:49 +0000
Subject: [Loop in filters detected]  Driver w83781d for lm_sensors (fwd)
Message-Id: <200302271244.h1RCiam05129@morannon.frodo.local>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="----=_NextPart_000_00FD_01C2DDEC.F3668DC0"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

Mikolaj Tutak wrote:
From frodol@dds.nl Thu Feb 27 07:10:05 2003
Received: by morannon.frodo.local (8.11.3/8.11.3) id h1R6A4530059 ; Thu, 27 Feb 2003 07:10:04 +0100
Return-Path: <frodol@dds.nl>
Received: from pop3.dds.nl [213.196.1.204]
	by localhost with POP3 (fetchmail-6.2.0)
	for frodo@localhost (single-drop); Thu, 27 Feb 2003 07:10:04 +0100 (CET)
Received: (qmail-ldap/ctrl 13394 invoked from network); 27 Feb 2003 06:03:16 -0000
Received: from stimpy.netroedge.com ([206.228.191.3]) (envelope-sender <lm78@Stimpy.netroedge.com>)
          by dds.nl (qmail-ldap-1.03) with SMTP
          for <frodol@dds.nl>; 27 Feb 2003 06:03:16 -0000
Received: (from lm78@localhost)
	by Stimpy.netroedge.com (8.11.1/8.11.1) id h1R6DFn23833;
	Wed, 26 Feb 2003 22:13:15 -0800
Received: from morannon.frodo.local (213-84-216-119.adsl.xs4all.nl [213.84.216.119])
	by Stimpy.netroedge.com (8.11.1/8.11.1) with ESMTP id h1R6CoS23758
	for <sensors@Stimpy.netroedge.com>; Wed, 26 Feb 2003 22:12:51 -0800
Received: by morannon.frodo.local (8.11.3/8.11.3) id h1R62OU29910 ; Thu, 27 Feb 2003 07:02:24 +0100
Received: by morannon.frodo.local (8.11.3/8.11.3) id h1QMP4521279 ; Wed, 26 Feb 2003 23:25:04 +0100
Received: from pop3.dds.nl [213.196.1.204]
	by localhost with POP3 (fetchmail-6.2.0)
	for frodo@localhost (single-drop); Wed, 26 Feb 2003 23:25:04 +0100 (CET)
Received: (qmail-ldap/ctrl 10981 invoked from network); 26 Feb 2003 22:15:53 -0000
Received: from aab130.warszawa.sdi.tpnet.pl (HELO mail.nixz.net) ([217.97.81.130]) (envelope-sender <mtutak@nixz.net>)
          by dds.nl (qmail-ldap-1.03) with SMTP
          for <frodol@dds.nl>; 26 Feb 2003 22:15:53 -0000
Received: from [10.9.8.27] (helo=bogo)
	by mail.nixz.net with asmtp (Exim 3.35 #1 (Debian))
	id 18o9q0-0005NJ-00
	for <frodol@dds.nl>; Wed, 26 Feb 2003 23:15:40 +0100
Message-ID: <010001c2dde4$98810730$1b08090a@bogo>
From: "Mikolaj Tutak" <mtutak@nixz.net>
To: <frodol@dds.nl>
Date: Wed, 26 Feb 2003 23:15:28 +0100
MIME-Version: 1.0
X-Security: MIME headers sanitized on Stimpy.netroedge.com
	See http://www.impsec.org/email-tools/procmail-security.html
	for details. $Revision: 1.129 $Date: 2001-04-14 20:20:43-07 
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_00FD_01C2DDEC.F3668DC0"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
X-Loop-Procmail: PreventLoop
Sender: frodol@dds.nl
X-SpamBouncer: 1.6 beta (6/22/02)
X-SBPass: Oversize-Leantagged
X-SBRule: Pattern Match (Embedded Script) (Score: 98785)
X-SBClass: Blocked
X-Loop-Procmail: Loop Detected
Subject: [Loop in filters detected]  Driver w83781d for lm_sensors

----------------- !! ATTENTION !! ----------------- 
The mailserver detected a loop in your mailfilters. 
Please check your filter settings in the webmail or 
manually edit your procmailrc. 
----------------- !! ATTENTION !! -----------------


This is a multi-part message in MIME format.

------=_NextPart_000_00FD_01C2DDEC.F3668DC0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: 7bit

Hi!

I have tested your W83781D driver with may Asus MB (A7V333, Asus chip
ASB100A) and I have discovered that temperature readings are wrong (BIOS
shows other values) :-(

Anyway I made some changes to your driver (only AS99127F/ASB100A part),
the idea was taken from "xmbmon".

Changes:

- new temperature sensor on address 0x17, named temp2 (works similar to
temp1 on 0x27, but connected with CPU temperature sensor). Readings from
0x17 show the same values like monitor built in MB BIOS - this readings
has less latency (CPU internal diode?).

- temp2 sensor renamed to temp3 (another CPU temperature sensor,
probably connected with thermistor under CPU - higher lattency). ASUS
doesn't show this values in BIOS monitor!

- temp3 sensor removed (unconnected?) - maybe better keep and rename to
temp4?

- removed macro AS99127_TEMP_ADD_TO_REG & AS99127_TEMP_ADD_FROM_REG -
standard one works _better_!

TODO:

- find right addresses for AS99127_REG_TEMP_OVER &
AS99127_REG_TEMP_HIST!

- fix alarms for temp2 sensors

All my changes were made on 2.7.0 version, tested with A7V333, A7V333-X,
A7V8N MB. If you like them, please include changes in official driver
code to make Asus user happy ;-) I can help you with tests on A7V333-X
MB.

--
      Nick

------=_NextPart_000_00FD_01C2DDEC.F3668DC0
Content-Type: text/plain; name="w83781d.c"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="w83781d.c"

/*=0A=
    w83781d.c - Part of lm_sensors, Linux kernel modules for hardware=0A=
                monitoring=0A=
    Copyright (c) 1998 - 2001  Frodo Looijaard <frodol@dds.nl>,=0A=
    Philip Edelbrock <phil@netroedge.com>,=0A=
    and Mark Studebaker <mdsxyz123@yahoo.com>=0A=
=0A=
    This program is free software; you can redistribute it and/or modify=0A=
    it under the terms of the GNU General Public License as published by=0A=
    the Free Software Foundation; either version 2 of the License, or=0A=
    (at your option) any later version.=0A=
=0A=
    This program is distributed in the hope that it will be useful,=0A=
    but WITHOUT ANY WARRANTY; without even the implied warranty of=0A=
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the=0A=
    GNU General Public License for more details.=0A=
=0A=
    You should have received a copy of the GNU General Public License=0A=
    along with this program; if not, write to the Free Software=0A=
    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.=0A=
*/=0A=
=0A=
/*=0A=
    Supports following chips:=0A=
=0A=
    Chip	#vin	#fanin	#pwm	#temp	wchipid	vendid	i2c	ISA=0A=
    as99127f	7	3	1?	3	0x30	0x12c3	yes	no=0A=
    asb100 "bach" (type_name =3D as99127f)	0x30	0x0694	yes	no=0A=
    w83781d	7	3	0	3	0x10	0x5ca3	yes	yes=0A=
    w83627hf	9	3	2	3	0x20	0x5ca3	yes	yes(LPC)=0A=
    w83782d	9	3	2-4	3	0x30	0x5ca3	yes	yes=0A=
    w83783s	5-6	3	2	1-2	0x40	0x5ca3	yes	no=0A=
    w83697hf	8	2	2	2	0x60	0x5ca3	no	yes(LPC)=0A=
=0A=
*/=0A=
=0A=
#include <linux/version.h>=0A=
#include <linux/module.h>=0A=
#include <linux/slab.h>=0A=
#include <linux/proc_fs.h>=0A=
#include <linux/ioport.h>=0A=
#include <linux/sysctl.h>=0A=
#include <asm/errno.h>=0A=
#include <asm/io.h>=0A=
#include <linux/types.h>=0A=
#include <linux/i2c.h>=0A=
#include "version.h"=0A=
#include "sensors.h"=0A=
#include "sensors_vid.h"=0A=
#include <linux/init.h>=0A=
=0A=
#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,2,18)) || \=0A=
    (LINUX_VERSION_CODE =3D=3D KERNEL_VERSION(2,3,0))=0A=
#define init_MUTEX(s) do { *(s) =3D MUTEX; } while(0)=0A=
#endif=0A=
=0A=
#ifndef THIS_MODULE=0A=
#define THIS_MODULE NULL=0A=
#endif=0A=
=0A=
/* RT Table support #defined so we can take it out if it gets bothersome =
*/=0A=
#define W83781D_RT 1=0A=
=0A=
/* Addresses to scan */=0A=
static unsigned short normal_i2c[] =3D { SENSORS_I2C_END };=0A=
static unsigned short normal_i2c_range[] =3D { 0x20, 0x2f, =
SENSORS_I2C_END };=0A=
static unsigned int normal_isa[] =3D { 0x0290, SENSORS_ISA_END };=0A=
static unsigned int normal_isa_range[] =3D { SENSORS_ISA_END };=0A=
=0A=
/* Insmod parameters */=0A=
SENSORS_INSMOD_6(w83781d, w83782d, w83783s, w83627hf, as99127f, =
w83697hf);=0A=
SENSORS_MODULE_PARM(force_subclients, "List of subclient addresses: " \=0A=
                      "{bus, clientaddr, subclientaddr1, =
subclientaddr2}");=0A=
=0A=
static int init =3D 1;=0A=
MODULE_PARM(init, "i");=0A=
MODULE_PARM_DESC(init, "Set to zero to bypass chip initialization");=0A=
=0A=
/* Constants specified below */=0A=
=0A=
/* Length of ISA address segment */=0A=
#define W83781D_EXTENT 8=0A=
=0A=
/* Where are the ISA address/data registers relative to the base address =
*/=0A=
#define W83781D_ADDR_REG_OFFSET 5=0A=
#define W83781D_DATA_REG_OFFSET 6=0A=
=0A=
/* The W83781D registers */=0A=
/* The W83782D registers for nr=3D7,8 are in bank 5 */=0A=
#define W83781D_REG_IN_MAX(nr) ((nr < 7) ? (0x2b + (nr) * 2) : \=0A=
					   (0x554 + (((nr) - 7) * 2)))=0A=
#define W83781D_REG_IN_MIN(nr) ((nr < 7) ? (0x2c + (nr) * 2) : \=0A=
					   (0x555 + (((nr) - 7) * 2)))=0A=
#define W83781D_REG_IN(nr)     ((nr < 7) ? (0x20 + (nr)) : \=0A=
					   (0x550 + (nr) - 7))=0A=
=0A=
#define W83781D_REG_FAN_MIN(nr) (0x3a + (nr))=0A=
#define W83781D_REG_FAN(nr) (0x27 + (nr))=0A=
=0A=
#define W83781D_REG_TEMP2 0x0150=0A=
#define W83781D_REG_TEMP3 0x0250=0A=
#define W83781D_REG_TEMP2_HYST 0x153=0A=
#define W83781D_REG_TEMP3_HYST 0x253=0A=
#define W83781D_REG_TEMP2_CONFIG 0x152=0A=
#define W83781D_REG_TEMP3_CONFIG 0x252=0A=
#define W83781D_REG_TEMP2_OVER 0x155=0A=
#define W83781D_REG_TEMP3_OVER 0x255=0A=
=0A=
#define W83781D_REG_TEMP 0x27=0A=
#define W83781D_REG_TEMP_OVER 0x39=0A=
#define W83781D_REG_TEMP_HYST 0x3A=0A=
#define W83781D_REG_BANK 0x4E=0A=
=0A=
#define AS99127_REG_TEMP 0x17=0A=
#define AS99127_REG_TEMP_OVER 0x19 // who guess right?=0A=
#define AS99127_REG_TEMP_HYST 0x1A // who guess right?=0A=
=0A=
#define W83781D_REG_CONFIG 0x40=0A=
#define W83781D_REG_ALARM1 0x41=0A=
#define W83781D_REG_ALARM2 0x42=0A=
#define W83781D_REG_ALARM3 0x450	/* not on W83781D */=0A=
=0A=
#define W83781D_REG_IRQ 0x4C=0A=
#define W83781D_REG_BEEP_CONFIG 0x4D=0A=
#define W83781D_REG_BEEP_INTS1 0x56=0A=
#define W83781D_REG_BEEP_INTS2 0x57=0A=
#define W83781D_REG_BEEP_INTS3 0x453	/* not on W83781D */=0A=
=0A=
#define W83781D_REG_VID_FANDIV 0x47=0A=
=0A=
#define W83781D_REG_CHIPID 0x49=0A=
#define W83781D_REG_WCHIPID 0x58=0A=
#define W83781D_REG_CHIPMAN 0x4F=0A=
#define W83781D_REG_PIN 0x4B=0A=
=0A=
/* 782D/783S only */=0A=
#define W83781D_REG_VBAT 0x5D=0A=
=0A=
/* PWM 782D (1-4) and 783S (1-2) only */=0A=
#define W83781D_REG_PWM1 0x5B	/* 782d and 783s/627hf datasheets disagree =
*/=0A=
				/* on which is which; */=0A=
#define W83781D_REG_PWM2 0x5A	/* We follow the 782d convention here, */=0A=
				/* However 782d is probably wrong. */=0A=
#define W83781D_REG_PWM3 0x5E=0A=
#define W83781D_REG_PWM4 0x5F=0A=
#define W83781D_REG_PWMCLK12 0x5C=0A=
#define W83781D_REG_PWMCLK34 0x45C=0A=
static const u8 regpwm[] =3D { W83781D_REG_PWM1, W83781D_REG_PWM2,=0A=
	W83781D_REG_PWM3, W83781D_REG_PWM4=0A=
};=0A=
#define W83781D_REG_PWM(nr) (regpwm[(nr) - 1])=0A=
=0A=
#define W83781D_REG_I2C_ADDR 0x48=0A=
#define W83781D_REG_I2C_SUBADDR 0x4A=0A=
=0A=
/* The following are undocumented in the data sheets however we=0A=
   received the information in an email from Winbond tech support */=0A=
/* Sensor selection - not on 781d */=0A=
#define W83781D_REG_SCFG1 0x5D=0A=
static const u8 BIT_SCFG1[] =3D { 0x02, 0x04, 0x08 };=0A=
#define W83781D_REG_SCFG2 0x59=0A=
static const u8 BIT_SCFG2[] =3D { 0x10, 0x20, 0x40 };=0A=
#define W83781D_DEFAULT_BETA 3435=0A=
=0A=
/* RT Table registers */=0A=
#define W83781D_REG_RT_IDX 0x50=0A=
#define W83781D_REG_RT_VAL 0x51=0A=
=0A=
/* Conversions. Rounding and limit checking is only done on the TO_REG=0A=
   variants. Note that you should be a bit careful with which arguments=0A=
   these macros are called: arguments may be evaluated more than once.=0A=
   Fixing this is just not worth it. */=0A=
#define IN_TO_REG(val)  (SENSORS_LIMIT((((val) * 10 + 8)/16),0,255))=0A=
#define IN_FROM_REG(val) (((val) * 16) / 10)=0A=
=0A=
extern inline u8 FAN_TO_REG(long rpm, int div)=0A=
{=0A=
	if (rpm =3D=3D 0)=0A=
		return 255;=0A=
	rpm =3D SENSORS_LIMIT(rpm, 1, 1000000);=0A=
	return SENSORS_LIMIT((1350000 + rpm * div / 2) / (rpm * div), 1,=0A=
			     254);=0A=
}=0A=
=0A=
#define FAN_FROM_REG(val,div) =
((val)=3D=3D0?-1:(val)=3D=3D255?0:1350000/((val)*(div)))=0A=
=0A=
#define TEMP_TO_REG(val) (SENSORS_LIMIT(((val)<0?(((val)-5)/10):\=0A=
                                                 ((val)+5)/10),0,255))=0A=
#define TEMP_FROM_REG(val) (((val)>0x80?(val)-0x100:(val))*10)=0A=
=0A=
#define TEMP_ADD_TO_REG(val)   (SENSORS_LIMIT(((((val) + 2) / 5) << 7),\=0A=
                                              0,0xffff))=0A=
#define TEMP_ADD_FROM_REG(val) (((val) >> 7) * 5)=0A=
=0A=
#define ALARMS_FROM_REG(val) (val)=0A=
#define PWM_FROM_REG(val) (val)=0A=
#define PWM_TO_REG(val) (SENSORS_LIMIT((val),0,255))=0A=
#define BEEPS_FROM_REG(val) (val)=0A=
#define BEEPS_TO_REG(val) ((val) & 0xffffff)=0A=
=0A=
#define BEEP_ENABLE_TO_REG(val)   ((val)?1:0)=0A=
#define BEEP_ENABLE_FROM_REG(val) ((val)?1:0)=0A=
=0A=
#define DIV_FROM_REG(val) (1 << (val))=0A=
=0A=
extern inline u8 DIV_TO_REG(long val, enum chips type)=0A=
{=0A=
	int i;=0A=
	val =3D SENSORS_LIMIT(val, 1,=0A=
		((type =3D=3D w83781d || type =3D=3D as99127f) ? 8 : 128)) >> 1;=0A=
	for (i =3D 0; i < 6; i++) {=0A=
		if (val =3D=3D 0)=0A=
			break;=0A=
		val >>=3D 1;=0A=
	}=0A=
	return ((u8) i);=0A=
}=0A=
=0A=
/* Initial limits */=0A=
#define W83781D_INIT_IN_0 (vid=3D=3D3500?280:vid/10)=0A=
#define W83781D_INIT_IN_1 (vid=3D=3D3500?280:vid/10)=0A=
#define W83781D_INIT_IN_2 330=0A=
#define W83781D_INIT_IN_3 (((500)   * 100)/168)=0A=
#define W83781D_INIT_IN_4 (((1200)  * 10)/38)=0A=
#define W83781D_INIT_IN_5 (((-1200) * -604)/2100)=0A=
#define W83781D_INIT_IN_6 (((-500)  * -604)/909)=0A=
#define W83781D_INIT_IN_7 (((500)   * 100)/168)=0A=
#define W83781D_INIT_IN_8 300=0A=
/* Initial limits for 782d/783s negative voltages */=0A=
/* Note level shift. Change min/max below if you change these. */=0A=
#define W83782D_INIT_IN_5 ((((-1200) + 1491) * 100)/514)=0A=
#define W83782D_INIT_IN_6 ((( (-500)  + 771) * 100)/314)=0A=
=0A=
#define W83781D_INIT_IN_PERCENTAGE 10=0A=
=0A=
#define W83781D_INIT_IN_MIN_0 \=0A=
        (W83781D_INIT_IN_0 - W83781D_INIT_IN_0 * =
W83781D_INIT_IN_PERCENTAGE \=0A=
         / 100)=0A=
#define W83781D_INIT_IN_MAX_0 \=0A=
        (W83781D_INIT_IN_0 + W83781D_INIT_IN_0 * =
W83781D_INIT_IN_PERCENTAGE \=0A=
         / 100)=0A=
#define W83781D_INIT_IN_MIN_1 \=0A=
        (W83781D_INIT_IN_1 - W83781D_INIT_IN_1 * =
W83781D_INIT_IN_PERCENTAGE \=0A=
         / 100)=0A=
#define W83781D_INIT_IN_MAX_1 \=0A=
        (W83781D_INIT_IN_1 + W83781D_INIT_IN_1 * =
W83781D_INIT_IN_PERCENTAGE \=0A=
         / 100)=0A=
#define W83781D_INIT_IN_MIN_2 \=0A=
        (W83781D_INIT_IN_2 - W83781D_INIT_IN_2 * =
W83781D_INIT_IN_PERCENTAGE \=0A=
         / 100)=0A=
#define W83781D_INIT_IN_MAX_2 \=0A=
        (W83781D_INIT_IN_2 + W83781D_INIT_IN_2 * =
W83781D_INIT_IN_PERCENTAGE \=0A=
         / 100)=0A=
#define W83781D_INIT_IN_MIN_3 \=0A=
        (W83781D_INIT_IN_3 - W83781D_INIT_IN_3 * =
W83781D_INIT_IN_PERCENTAGE \=0A=
         / 100)=0A=
#define W83781D_INIT_IN_MAX_3 \=0A=
        (W83781D_INIT_IN_3 + W83781D_INIT_IN_3 * =
W83781D_INIT_IN_PERCENTAGE \=0A=
         / 100)=0A=
#define W83781D_INIT_IN_MIN_4 \=0A=
        (W83781D_INIT_IN_4 - W83781D_INIT_IN_4 * =
W83781D_INIT_IN_PERCENTAGE \=0A=
         / 100)=0A=
#define W83781D_INIT_IN_MAX_4 \=0A=
        (W83781D_INIT_IN_4 + W83781D_INIT_IN_4 * =
W83781D_INIT_IN_PERCENTAGE \=0A=
         / 100)=0A=
#define W83781D_INIT_IN_MIN_5 \=0A=
        (W83781D_INIT_IN_5 - W83781D_INIT_IN_5 * =
W83781D_INIT_IN_PERCENTAGE \=0A=
         / 100)=0A=
#define W83781D_INIT_IN_MAX_5 \=0A=
        (W83781D_INIT_IN_5 + W83781D_INIT_IN_5 * =
W83781D_INIT_IN_PERCENTAGE \=0A=
         / 100)=0A=
#define W83781D_INIT_IN_MIN_6 \=0A=
        (W83781D_INIT_IN_6 - W83781D_INIT_IN_6 * =
W83781D_INIT_IN_PERCENTAGE \=0A=
         / 100)=0A=
#define W83781D_INIT_IN_MAX_6 \=0A=
        (W83781D_INIT_IN_6 + W83781D_INIT_IN_6 * =
W83781D_INIT_IN_PERCENTAGE \=0A=
         / 100)=0A=
#define W83781D_INIT_IN_MIN_7 \=0A=
        (W83781D_INIT_IN_7 - W83781D_INIT_IN_7 * =
W83781D_INIT_IN_PERCENTAGE \=0A=
         / 100)=0A=
#define W83781D_INIT_IN_MAX_7 \=0A=
        (W83781D_INIT_IN_7 + W83781D_INIT_IN_7 * =
W83781D_INIT_IN_PERCENTAGE \=0A=
         / 100)=0A=
#define W83781D_INIT_IN_MIN_8 \=0A=
        (W83781D_INIT_IN_8 - W83781D_INIT_IN_8 * =
W83781D_INIT_IN_PERCENTAGE \=0A=
         / 100)=0A=
#define W83781D_INIT_IN_MAX_8 \=0A=
        (W83781D_INIT_IN_8 + W83781D_INIT_IN_8 * =
W83781D_INIT_IN_PERCENTAGE \=0A=
         / 100)=0A=
/* Initial limits for 782d/783s negative voltages */=0A=
/* These aren't direct multiples because of level shift */=0A=
/* Beware going negative - check */=0A=
#define W83782D_INIT_IN_MIN_5_TMP \=0A=
        (((-1200 * (100 + W83781D_INIT_IN_PERCENTAGE)) + (1491 * =
100))/514)=0A=
#define W83782D_INIT_IN_MIN_5 \=0A=
        ((W83782D_INIT_IN_MIN_5_TMP > 0) ? W83782D_INIT_IN_MIN_5_TMP : 0)=0A=
#define W83782D_INIT_IN_MAX_5 \=0A=
        (((-1200 * (100 - W83781D_INIT_IN_PERCENTAGE)) + (1491 * =
100))/514)=0A=
#define W83782D_INIT_IN_MIN_6_TMP \=0A=
        ((( -500 * (100 + W83781D_INIT_IN_PERCENTAGE)) +  (771 * =
100))/314)=0A=
#define W83782D_INIT_IN_MIN_6 \=0A=
        ((W83782D_INIT_IN_MIN_6_TMP > 0) ? W83782D_INIT_IN_MIN_6_TMP : 0)=0A=
#define W83782D_INIT_IN_MAX_6 \=0A=
        ((( -500 * (100 - W83781D_INIT_IN_PERCENTAGE)) +  (771 * =
100))/314)=0A=
=0A=
#define W83781D_INIT_FAN_MIN_1 3000=0A=
#define W83781D_INIT_FAN_MIN_2 3000=0A=
#define W83781D_INIT_FAN_MIN_3 3000=0A=
=0A=
#define AS99127_INIT_TEMP_OVER 600=0A=
#define AS99127_INIT_TEMP_HYST 1270=0A=
#define W83781D_INIT_TEMP_OVER 600=0A=
#define W83781D_INIT_TEMP_HYST 1270	/* must be 127 for ALARM to work */=0A=
#define W83781D_INIT_TEMP2_OVER 600=0A=
#define W83781D_INIT_TEMP2_HYST 500=0A=
#define W83781D_INIT_TEMP3_OVER 600=0A=
#define W83781D_INIT_TEMP3_HYST 500=0A=
=0A=
#ifdef MODULE=0A=
extern int init_module(void);=0A=
extern int cleanup_module(void);=0A=
#endif				/* MODULE */=0A=
=0A=
/* There are some complications in a module like this. First off, =
W83781D chips=0A=
   may be both present on the SMBus and the ISA bus, and we have to =
handle=0A=
   those cases separately at some places. Second, there might be several=0A=
   W83781D chips available (well, actually, that is probably never done; =
but=0A=
   it is a clean illustration of how to handle a case like that). =
Finally,=0A=
   a specific chip may be attached to *both* ISA and SMBus, and we would=0A=
   not like to detect it double. Fortunately, in the case of the W83781D =
at=0A=
   least, a register tells us what SMBus address we are on, so that helps=0A=
   a bit - except if there could be more than one SMBus. Groan. No =
solution=0A=
   for this yet. */=0A=
=0A=
/* This module may seem overly long and complicated. In fact, it is not =
so=0A=
   bad. Quite a lot of bookkeeping is done. A real driver can often cut=0A=
   some corners. */=0A=
=0A=
/* For each registered W83781D, we need to keep some data in memory. That=0A=
   data is pointed to by w83781d_list[NR]->data. The structure itself is=0A=
   dynamically allocated, at the same time when a new w83781d client is=0A=
   allocated. */=0A=
struct w83781d_data {=0A=
	struct semaphore lock;=0A=
	int sysctl_id;=0A=
	enum chips type;=0A=
=0A=
	struct semaphore update_lock;=0A=
	char valid;		/* !=3D0 if following fields are valid */=0A=
	unsigned long last_updated;	/* In jiffies */=0A=
=0A=
	struct i2c_client *lm75;	/* for secondary I2C addresses */=0A=
	/* pointer to array of 2 subclients */=0A=
=0A=
	u8 in[9];		/* Register value - 8 & 9 for 782D only */=0A=
	u8 in_max[9];		/* Register value - 8 & 9 for 782D only */=0A=
	u8 in_min[9];		/* Register value - 8 & 9 for 782D only */=0A=
	u8 fan[3];		/* Register value */=0A=
	u8 fan_min[3];		/* Register value */=0A=
	u8 temp;=0A=
	u8 temp_over;		/* Register value */=0A=
	u8 temp_hyst;		/* Register value */=0A=
	u8 temp2;=0A=
	u8 temp2_over;		/* Register value */=0A=
	u8 temp2_hyst;		/* Register value */=0A=
	u16 temp_add[2];	/* Register value */=0A=
	u16 temp_add_over[2];	/* Register value */=0A=
	u16 temp_add_hyst[2];	/* Register value */=0A=
	u8 fan_div[3];		/* Register encoding, shifted right */=0A=
	u8 vid;			/* Register encoding, combined */=0A=
	u32 alarms;		/* Register encoding, combined */=0A=
	u32 beeps;		/* Register encoding, combined */=0A=
	u8 beep_enable;		/* Boolean */=0A=
	u8 pwm[4];		/* Register value */=0A=
	u16 sens[3];		/* 782D/783S only.=0A=
				   1 =3D pentium diode; 2 =3D 3904 diode;=0A=
				   3000-5000 =3D thermistor beta.=0A=
				   Default =3D 3435. =0A=
				   Other Betas unimplemented */=0A=
#ifdef W83781D_RT=0A=
	u8 rt[3][32];		/* Register value */=0A=
#endif=0A=
	u8 vrm;=0A=
};=0A=
=0A=
=0A=
#ifdef MODULE=0A=
static=0A=
#else=0A=
extern=0A=
#endif=0A=
int __init sensors_w83781d_init(void);=0A=
static int __init w83781d_cleanup(void);=0A=
=0A=
static int w83781d_attach_adapter(struct i2c_adapter *adapter);=0A=
static int w83781d_detect(struct i2c_adapter *adapter, int address,=0A=
			  unsigned short flags, int kind);=0A=
static int w83781d_detach_client(struct i2c_client *client);=0A=
static int w83781d_command(struct i2c_client *client, unsigned int cmd,=0A=
			   void *arg);=0A=
static void w83781d_inc_use(struct i2c_client *client);=0A=
static void w83781d_dec_use(struct i2c_client *client);=0A=
=0A=
static int w83781d_read_value(struct i2c_client *client, u16 register);=0A=
static int w83781d_write_value(struct i2c_client *client, u16 register,=0A=
			       u16 value);=0A=
static void w83781d_update_client(struct i2c_client *client);=0A=
static void w83781d_init_client(struct i2c_client *client);=0A=
=0A=
=0A=
static void w83781d_in(struct i2c_client *client, int operation,=0A=
		       int ctl_name, int *nrels_mag, long *results);=0A=
static void w83781d_fan(struct i2c_client *client, int operation,=0A=
			int ctl_name, int *nrels_mag, long *results);=0A=
static void w83781d_temp(struct i2c_client *client, int operation,=0A=
			 int ctl_name, int *nrels_mag, long *results);=0A=
static void w83781d_temp_add(struct i2c_client *client, int operation,=0A=
			     int ctl_name, int *nrels_mag, long *results);=0A=
static void w83781d_vid(struct i2c_client *client, int operation,=0A=
			int ctl_name, int *nrels_mag, long *results);=0A=
static void w83781d_vrm(struct i2c_client *client, int operation,=0A=
			int ctl_name, int *nrels_mag, long *results);=0A=
static void w83781d_alarms(struct i2c_client *client, int operation,=0A=
			   int ctl_name, int *nrels_mag, long *results);=0A=
static void w83781d_beep(struct i2c_client *client, int operation,=0A=
			 int ctl_name, int *nrels_mag, long *results);=0A=
static void w83781d_fan_div(struct i2c_client *client, int operation,=0A=
			    int ctl_name, int *nrels_mag, long *results);=0A=
static void w83781d_pwm(struct i2c_client *client, int operation,=0A=
			int ctl_name, int *nrels_mag, long *results);=0A=
static void w83781d_sens(struct i2c_client *client, int operation,=0A=
			 int ctl_name, int *nrels_mag, long *results);=0A=
#ifdef W83781D_RT=0A=
static void w83781d_rt(struct i2c_client *client, int operation,=0A=
		       int ctl_name, int *nrels_mag, long *results);=0A=
#endif=0A=
static u16 swap_bytes(u16 val);=0A=
=0A=
static int w83781d_id =3D 0;=0A=
=0A=
static struct i2c_driver w83781d_driver =3D {=0A=
	/* name */ "W83781D sensor driver",=0A=
	/* id */ I2C_DRIVERID_W83781D,=0A=
	/* flags */ I2C_DF_NOTIFY,=0A=
	/* attach_adapter */ &w83781d_attach_adapter,=0A=
	/* detach_client */ &w83781d_detach_client,=0A=
	/* command */ &w83781d_command,=0A=
	/* inc_use */ &w83781d_inc_use,=0A=
	/* dec_use */ &w83781d_dec_use=0A=
};=0A=
=0A=
/* Used by w83781d_init/cleanup */=0A=
static int __initdata w83781d_initialized =3D 0;=0A=
=0A=
/* The /proc/sys entries */=0A=
/* These files are created for each detected chip. This is just a =
template;=0A=
   though at first sight, you might think we could use a statically=0A=
   allocated list, we need some way to get back to the parent - which=0A=
   is done through one of the 'extra' fields which are initialized =0A=
   when a new copy is allocated. */=0A=
=0A=
/* just a guess - no datasheet */=0A=
static ctl_table as99127f_dir_table_template[] =3D {=0A=
	{W83781D_SYSCTL_IN0, "in0", NULL, 0, 0644, NULL, &i2c_proc_real,=0A=
	 &i2c_sysctl_real, NULL, &w83781d_in},=0A=
	{W83781D_SYSCTL_IN1, "in1", NULL, 0, 0644, NULL, &i2c_proc_real,=0A=
	 &i2c_sysctl_real, NULL, &w83781d_in},=0A=
	{W83781D_SYSCTL_IN2, "in2", NULL, 0, 0644, NULL, &i2c_proc_real,=0A=
	 &i2c_sysctl_real, NULL, &w83781d_in},=0A=
	{W83781D_SYSCTL_IN3, "in3", NULL, 0, 0644, NULL, &i2c_proc_real,=0A=
	 &i2c_sysctl_real, NULL, &w83781d_in},=0A=
	{W83781D_SYSCTL_IN4, "in4", NULL, 0, 0644, NULL, &i2c_proc_real,=0A=
	 &i2c_sysctl_real, NULL, &w83781d_in},=0A=
	{W83781D_SYSCTL_IN5, "in5", NULL, 0, 0644, NULL, &i2c_proc_real,=0A=
	 &i2c_sysctl_real, NULL, &w83781d_in},=0A=
	{W83781D_SYSCTL_IN6, "in6", NULL, 0, 0644, NULL, &i2c_proc_real,=0A=
	 &i2c_sysctl_real, NULL, &w83781d_in},=0A=
	{W83781D_SYSCTL_FAN1, "fan1", NULL, 0, 0644, NULL, &i2c_proc_real,=0A=
	 &i2c_sysctl_real, NULL, &w83781d_fan},=0A=
	{W83781D_SYSCTL_FAN2, "fan2", NULL, 0, 0644, NULL, &i2c_proc_real,=0A=
	 &i2c_sysctl_real, NULL, &w83781d_fan},=0A=
	{W83781D_SYSCTL_FAN3, "fan3", NULL, 0, 0644, NULL, &i2c_proc_real,=0A=
	 &i2c_sysctl_real, NULL, &w83781d_fan},=0A=
	{W83781D_SYSCTL_TEMP1, "temp1", NULL, 0, 0644, NULL, &i2c_proc_real,=0A=
	 &i2c_sysctl_real, NULL, &w83781d_temp},=0A=
	{W83781D_SYSCTL_TEMP2, "temp2", NULL, 0, 0644, NULL, &i2c_proc_real,=0A=
	 &i2c_sysctl_real, NULL, &w83781d_temp},=0A=
	{W83781D_SYSCTL_TEMP3, "temp3", NULL, 0, 0644, NULL, &i2c_proc_real,=0A=
	 &i2c_sysctl_real, NULL, &w83781d_temp_add},=0A=
	{W83781D_SYSCTL_VID, "vid", NULL, 0, 0444, NULL, &i2c_proc_real,=0A=
	 &i2c_sysctl_real, NULL, &w83781d_vid},=0A=
	{W83781D_SYSCTL_VRM, "vrm", NULL, 0, 0644, NULL, &i2c_proc_real,=0A=
	 &i2c_sysctl_real, NULL, &w83781d_vrm},=0A=
	{W83781D_SYSCTL_FAN_DIV, "fan_div", NULL, 0, 0644, NULL, &i2c_proc_real,=0A=
	 &i2c_sysctl_real, NULL, &w83781d_fan_div},=0A=
	{W83781D_SYSCTL_ALARMS, "alarms", NULL, 0, 0444, NULL, &i2c_proc_real,=0A=
	 &i2c_sysctl_real, NULL, &w83781d_alarms},=0A=
	{W83781D_SYSCTL_BEEP, "beep", NULL, 0, 0644, NULL, &i2c_proc_real,=0A=
	 &i2c_sysctl_real, NULL, &w83781d_beep},=0A=
	{W83781D_SYSCTL_PWM1, "pwm1", NULL, 0, 0644, NULL, &i2c_proc_real,=0A=
	 &i2c_sysctl_real, NULL, &w83781d_pwm},=0A=
	{W83781D_SYSCTL_PWM2, "pwm2", NULL, 0, 0644, NULL, &i2c_proc_real,=0A=
	 &i2c_sysctl_real, NULL, &w83781d_pwm},=0A=
	{0}=0A=
};=0A=
=0A=
static ctl_table w83781d_dir_table_template[] =3D {=0A=
	{W83781D_SYSCTL_IN0, "in0", NULL, 0, 0644, NULL, &i2c_proc_real,=0A=
	 &i2c_sysctl_real, NULL, &w83781d_in},=0A=
	{W83781D_SYSCTL_IN1, "in1", NULL, 0, 0644, NULL, &i2c_proc_real,=0A=
	 &i2c_sysctl_real, NULL, &w83781d_in},=0A=
	{W83781D_SYSCTL_IN2, "in2", NULL, 0, 0644, NULL, &i2c_proc_real,=0A=
	 &i2c_sysctl_real, NULL, &w83781d_in},=0A=
	{W83781D_SYSCTL_IN3, "in3", NULL, 0, 0644, NULL, &i2c_proc_real,=0A=
	 &i2c_sysctl_real, NULL, &w83781d_in},=0A=
	{W83781D_SYSCTL_IN4, "in4", NULL, 0, 0644, NULL, &i2c_proc_real,=0A=
	 &i2c_sysctl_real, NULL, &w83781d_in},=0A=
	{W83781D_SYSCTL_IN5, "in5", NULL, 0, 0644, NULL, &i2c_proc_real,=0A=
	 &i2c_sysctl_real, NULL, &w83781d_in},=0A=
	{W83781D_SYSCTL_IN6, "in6", NULL, 0, 0644, NULL, &i2c_proc_real,=0A=
	 &i2c_sysctl_real, NULL, &w83781d_in},=0A=
	{W83781D_SYSCTL_FAN1, "fan1", NULL, 0, 0644, NULL, &i2c_proc_real,=0A=
	 &i2c_sysctl_real, NULL, &w83781d_fan},=0A=
	{W83781D_SYSCTL_FAN2, "fan2", NULL, 0, 0644, NULL, &i2c_proc_real,=0A=
	 &i2c_sysctl_real, NULL, &w83781d_fan},=0A=
	{W83781D_SYSCTL_FAN3, "fan3", NULL, 0, 0644, NULL, &i2c_proc_real,=0A=
	 &i2c_sysctl_real, NULL, &w83781d_fan},=0A=
	{W83781D_SYSCTL_TEMP1, "temp1", NULL, 0, 0644, NULL, &i2c_proc_real,=0A=
	 &i2c_sysctl_real, NULL, &w83781d_temp},=0A=
	{W83781D_SYSCTL_TEMP2, "temp2", NULL, 0, 0644, NULL, &i2c_proc_real,=0A=
	 &i2c_sysctl_real, NULL, &w83781d_temp_add},=0A=
	{W83781D_SYSCTL_TEMP3, "temp3", NULL, 0, 0644, NULL, &i2c_proc_real,=0A=
	 &i2c_sysctl_real, NULL, &w83781d_temp_add},=0A=
	{W83781D_SYSCTL_VID, "vid", NULL, 0, 0444, NULL, &i2c_proc_real,=0A=
	 &i2c_sysctl_real, NULL, &w83781d_vid},=0A=
	{W83781D_SYSCTL_VRM, "vrm", NULL, 0, 0644, NULL, &i2c_proc_real,=0A=
	 &i2c_sysctl_real, NULL, &w83781d_vrm},=0A=
	{W83781D_SYSCTL_FAN_DIV, "fan_div", NULL, 0, 0644, NULL, &i2c_proc_real,=0A=
	 &i2c_sysctl_real, NULL, &w83781d_fan_div},=0A=
	{W83781D_SYSCTL_ALARMS, "alarms", NULL, 0, 0444, NULL, &i2c_proc_real,=0A=
	 &i2c_sysctl_real, NULL, &w83781d_alarms},=0A=
	{W83781D_SYSCTL_BEEP, "beep", NULL, 0, 0644, NULL, &i2c_proc_real,=0A=
	 &i2c_sysctl_real, NULL, &w83781d_beep},=0A=
#ifdef W83781D_RT=0A=
	{W83781D_SYSCTL_RT1, "rt1", NULL, 0, 0644, NULL, &i2c_proc_real,=0A=
	 &i2c_sysctl_real, NULL, &w83781d_rt},=0A=
	{W83781D_SYSCTL_RT2, "rt2", NULL, 0, 0644, NULL, &i2c_proc_real,=0A=
	 &i2c_sysctl_real, NULL, &w83781d_rt},=0A=
	{W83781D_SYSCTL_RT3, "rt3", NULL, 0, 0644, NULL, &i2c_proc_real,=0A=
	 &i2c_sysctl_real, NULL, &w83781d_rt},=0A=
#endif=0A=
	{0}=0A=
};=0A=
=0A=
/* without pwm3-4 */=0A=
static ctl_table w83782d_isa_dir_table_template[] =3D {=0A=
	{W83781D_SYSCTL_IN0, "in0", NULL, 0, 0644, NULL, &i2c_proc_real,=0A=
	 &i2c_sysctl_real, NULL, &w83781d_in},=0A=
	{W83781D_SYSCTL_IN1, "in1", NULL, 0, 0644, NULL, &i2c_proc_real,=0A=
	 &i2c_sysctl_real, NULL, &w83781d_in},=0A=
	{W83781D_SYSCTL_IN2, "in2", NULL, 0, 0644, NULL, &i2c_proc_real,=0A=
	 &i2c_sysctl_real, NULL, &w83781d_in},=0A=
	{W83781D_SYSCTL_IN3, "in3", NULL, 0, 0644, NULL, &i2c_proc_real,=0A=
	 &i2c_sysctl_real, NULL, &w83781d_in},=0A=
	{W83781D_SYSCTL_IN4, "in4", NULL, 0, 0644, NULL, &i2c_proc_real,=0A=
	 &i2c_sysctl_real, NULL, &w83781d_in},=0A=
	{W83781D_SYSCTL_IN5, "in5", NULL, 0, 0644, NULL, &i2c_proc_real,=0A=
	 &i2c_sysctl_real, NULL, &w83781d_in},=0A=
	{W83781D_SYSCTL_IN6, "in6", NULL, 0, 0644, NULL, &i2c_proc_real,=0A=
	 &i2c_sysctl_real, NULL, &w83781d_in},=0A=
	{W83781D_SYSCTL_IN7, "in7", NULL, 0, 0644, NULL, &i2c_proc_real,=0A=
	 &i2c_sysctl_real, NULL, &w83781d_in},=0A=
	{W83781D_SYSCTL_IN8, "in8", NULL, 0, 0644, NULL, &i2c_proc_real,=0A=
	 &i2c_sysctl_real, NULL, &w83781d_in},=0A=
	{W83781D_SYSCTL_FAN1, "fan1", NULL, 0, 0644, NULL, &i2c_proc_real,=0A=
	 &i2c_sysctl_real, NULL, &w83781d_fan},=0A=
	{W83781D_SYSCTL_FAN2, "fan2", NULL, 0, 0644, NULL, &i2c_proc_real,=0A=
	 &i2c_sysctl_real, NULL, &w83781d_fan},=0A=
	{W83781D_SYSCTL_FAN3, "fan3", NULL, 0, 0644, NULL, &i2c_proc_real,=0A=
	 &i2c_sysctl_real, NULL, &w83781d_fan},=0A=
	{W83781D_SYSCTL_TEMP1, "temp1", NULL, 0, 0644, NULL, &i2c_proc_real,=0A=
	 &i2c_sysctl_real, NULL, &w83781d_temp},=0A=
	{W83781D_SYSCTL_TEMP2, "temp2", NULL, 0, 0644, NULL, &i2c_proc_real,=0A=
	 &i2c_sysctl_real, NULL, &w83781d_temp_add},=0A=
	{W83781D_SYSCTL_TEMP3, "temp3", NULL, 0, 0644, NULL, &i2c_proc_real,=0A=
	 &i2c_sysctl_real, NULL, &w83781d_temp_add},=0A=
	{W83781D_SYSCTL_VID, "vid", NULL, 0, 0444, NULL, &i2c_proc_real,=0A=
	 &i2c_sysctl_real, NULL, &w83781d_vid},=0A=
	{W83781D_SYSCTL_VRM, "vrm", NULL, 0, 0644, NULL, &i2c_proc_real,=0A=
	 &i2c_sysctl_real, NULL, &w83781d_vrm},=0A=
	{W83781D_SYSCTL_FAN_DIV, "fan_div", NULL, 0, 0644, NULL, &i2c_proc_real,=0A=
	 &i2c_sysctl_real, NULL, &w83781d_fan_div},=0A=
	{W83781D_SYSCTL_ALARMS, "alarms", NULL, 0, 0444, NULL, &i2c_proc_real,=0A=
	 &i2c_sysctl_real, NULL, &w83781d_alarms},=0A=
	{W83781D_SYSCTL_BEEP, "beep", NULL, 0, 0644, NULL, &i2c_proc_real,=0A=
	 &i2c_sysctl_real, NULL, &w83781d_beep},=0A=
	{W83781D_SYSCTL_PWM1, "pwm1", NULL, 0, 0644, NULL, &i2c_proc_real,=0A=
	 &i2c_sysctl_real, NULL, &w83781d_pwm},=0A=
	{W83781D_SYSCTL_PWM2, "pwm2", NULL, 0, 0644, NULL, &i2c_proc_real,=0A=
	 &i2c_sysctl_real, NULL, &w83781d_pwm},=0A=
	{W83781D_SYSCTL_SENS1, "sensor1", NULL, 0, 0644, NULL, &i2c_proc_real,=0A=
	 &i2c_sysctl_real, NULL, &w83781d_sens},=0A=
	{W83781D_SYSCTL_SENS2, "sensor2", NULL, 0, 0644, NULL, &i2c_proc_real,=0A=
	 &i2c_sysctl_real, NULL, &w83781d_sens},=0A=
	{W83781D_SYSCTL_SENS3, "sensor3", NULL, 0, 0644, NULL, &i2c_proc_real,=0A=
	 &i2c_sysctl_real, NULL, &w83781d_sens},=0A=
	{0}=0A=
};=0A=
=0A=
/* with pwm3-4 */=0A=
static ctl_table w83782d_i2c_dir_table_template[] =3D {=0A=
	{W83781D_SYSCTL_IN0, "in0", NULL, 0, 0644, NULL, &i2c_proc_real,=0A=
	 &i2c_sysctl_real, NULL, &w83781d_in},=0A=
	{W83781D_SYSCTL_IN1, "in1", NULL, 0, 0644, NULL, &i2c_proc_real,=0A=
	 &i2c_sysctl_real, NULL, &w83781d_in},=0A=
	{W83781D_SYSCTL_IN2, "in2", NULL, 0, 0644, NULL, &i2c_proc_real,=0A=
	 &i2c_sysctl_real, NULL, &w83781d_in},=0A=
	{W83781D_SYSCTL_IN3, "in3", NULL, 0, 0644, NULL, &i2c_proc_real,=0A=
	 &i2c_sysctl_real, NULL, &w83781d_in},=0A=
	{W83781D_SYSCTL_IN4, "in4", NULL, 0, 0644, NULL, &i2c_proc_real,=0A=
	 &i2c_sysctl_real, NULL, &w83781d_in},=0A=
	{W83781D_SYSCTL_IN5, "in5", NULL, 0, 0644, NULL, &i2c_proc_real,=0A=
	 &i2c_sysctl_real, NULL, &w83781d_in},=0A=
	{W83781D_SYSCTL_IN6, "in6", NULL, 0, 0644, NULL, &i2c_proc_real,=0A=
	 &i2c_sysctl_real, NULL, &w83781d_in},=0A=
	{W83781D_SYSCTL_IN7, "in7", NULL, 0, 0644, NULL, &i2c_proc_real,=0A=
	 &i2c_sysctl_real, NULL, &w83781d_in},=0A=
	{W83781D_SYSCTL_IN8, "in8", NULL, 0, 0644, NULL, &i2c_proc_real,=0A=
	 &i2c_sysctl_real, NULL, &w83781d_in},=0A=
	{W83781D_SYSCTL_FAN1, "fan1", NULL, 0, 0644, NULL, &i2c_proc_real,=0A=
	 &i2c_sysctl_real, NULL, &w83781d_fan},=0A=
	{W83781D_SYSCTL_FAN2, "fan2", NULL, 0, 0644, NULL, &i2c_proc_real,=0A=
	 &i2c_sysctl_real, NULL, &w83781d_fan},=0A=
	{W83781D_SYSCTL_FAN3, "fan3", NULL, 0, 0644, NULL, &i2c_proc_real,=0A=
	 &i2c_sysctl_real, NULL, &w83781d_fan},=0A=
	{W83781D_SYSCTL_TEMP1, "temp1", NULL, 0, 0644, NULL, &i2c_proc_real,=0A=
	 &i2c_sysctl_real, NULL, &w83781d_temp},=0A=
	{W83781D_SYSCTL_TEMP2, "temp2", NULL, 0, 0644, NULL, &i2c_proc_real,=0A=
	 &i2c_sysctl_real, NULL, &w83781d_temp_add},=0A=
	{W83781D_SYSCTL_TEMP3, "temp3", NULL, 0, 0644, NULL, &i2c_proc_real,=0A=
	 &i2c_sysctl_real, NULL, &w83781d_temp_add},=0A=
	{W83781D_SYSCTL_VID, "vid", NULL, 0, 0444, NULL, &i2c_proc_real,=0A=
	 &i2c_sysctl_real, NULL, &w83781d_vid},=0A=
	{W83781D_SYSCTL_VRM, "vrm", NULL, 0, 0644, NULL, &i2c_proc_real,=0A=
	 &i2c_sysctl_real, NULL, &w83781d_vrm},=0A=
	{W83781D_SYSCTL_FAN_DIV, "fan_div", NULL, 0, 0644, NULL, &i2c_proc_real,=0A=
	 &i2c_sysctl_real, NULL, &w83781d_fan_div},=0A=
	{W83781D_SYSCTL_ALARMS, "alarms", NULL, 0, 0444, NULL, &i2c_proc_real,=0A=
	 &i2c_sysctl_real, NULL, &w83781d_alarms},=0A=
	{W83781D_SYSCTL_BEEP, "beep", NULL, 0, 0644, NULL, &i2c_proc_real,=0A=
	 &i2c_sysctl_real, NULL, &w83781d_beep},=0A=
	{W83781D_SYSCTL_PWM1, "pwm1", NULL, 0, 0644, NULL, &i2c_proc_real,=0A=
	 &i2c_sysctl_real, NULL, &w83781d_pwm},=0A=
	{W83781D_SYSCTL_PWM2, "pwm2", NULL, 0, 0644, NULL, &i2c_proc_real,=0A=
	 &i2c_sysctl_real, NULL, &w83781d_pwm},=0A=
	{W83781D_SYSCTL_PWM3, "pwm3", NULL, 0, 0644, NULL, &i2c_proc_real,=0A=
	 &i2c_sysctl_real, NULL, &w83781d_pwm},=0A=
	{W83781D_SYSCTL_PWM4, "pwm4", NULL, 0, 0644, NULL, &i2c_proc_real,=0A=
	 &i2c_sysctl_real, NULL, &w83781d_pwm},=0A=
	{W83781D_SYSCTL_SENS1, "sensor1", NULL, 0, 0644, NULL, &i2c_proc_real,=0A=
	 &i2c_sysctl_real, NULL, &w83781d_sens},=0A=
	{W83781D_SYSCTL_SENS2, "sensor2", NULL, 0, 0644, NULL, &i2c_proc_real,=0A=
	 &i2c_sysctl_real, NULL, &w83781d_sens},=0A=
	{W83781D_SYSCTL_SENS3, "sensor3", NULL, 0, 0644, NULL, &i2c_proc_real,=0A=
	 &i2c_sysctl_real, NULL, &w83781d_sens},=0A=
	{0}=0A=
};=0A=
=0A=
static ctl_table w83783s_dir_table_template[] =3D {=0A=
	{W83781D_SYSCTL_IN0, "in0", NULL, 0, 0644, NULL, &i2c_proc_real,=0A=
	 &i2c_sysctl_real, NULL, &w83781d_in},=0A=
	/* no in1 to maintain compatibility with 781d and 782d. */=0A=
	{W83781D_SYSCTL_IN2, "in2", NULL, 0, 0644, NULL, &i2c_proc_real,=0A=
	 &i2c_sysctl_real, NULL, &w83781d_in},=0A=
	{W83781D_SYSCTL_IN3, "in3", NULL, 0, 0644, NULL, &i2c_proc_real,=0A=
	 &i2c_sysctl_real, NULL, &w83781d_in},=0A=
	{W83781D_SYSCTL_IN4, "in4", NULL, 0, 0644, NULL, &i2c_proc_real,=0A=
	 &i2c_sysctl_real, NULL, &w83781d_in},=0A=
	{W83781D_SYSCTL_IN5, "in5", NULL, 0, 0644, NULL, &i2c_proc_real,=0A=
	 &i2c_sysctl_real, NULL, &w83781d_in},=0A=
	{W83781D_SYSCTL_IN6, "in6", NULL, 0, 0644, NULL, &i2c_proc_real,=0A=
	 &i2c_sysctl_real, NULL, &w83781d_in},=0A=
	{W83781D_SYSCTL_FAN1, "fan1", NULL, 0, 0644, NULL, &i2c_proc_real,=0A=
	 &i2c_sysctl_real, NULL, &w83781d_fan},=0A=
	{W83781D_SYSCTL_FAN2, "fan2", NULL, 0, 0644, NULL, &i2c_proc_real,=0A=
	 &i2c_sysctl_real, NULL, &w83781d_fan},=0A=
	{W83781D_SYSCTL_FAN3, "fan3", NULL, 0, 0644, NULL, &i2c_proc_real,=0A=
	 &i2c_sysctl_real, NULL, &w83781d_fan},=0A=
	{W83781D_SYSCTL_TEMP1, "temp1", NULL, 0, 0644, NULL, &i2c_proc_real,=0A=
	 &i2c_sysctl_real, NULL, &w83781d_temp},=0A=
	{W83781D_SYSCTL_TEMP2, "temp2", NULL, 0, 0644, NULL, &i2c_proc_real,=0A=
	 &i2c_sysctl_real, NULL, &w83781d_temp_add},=0A=
	{W83781D_SYSCTL_VID, "vid", NULL, 0, 0444, NULL, &i2c_proc_real,=0A=
	 &i2c_sysctl_real, NULL, &w83781d_vid},=0A=
	{W83781D_SYSCTL_VRM, "vrm", NULL, 0, 0644, NULL, &i2c_proc_real,=0A=
	 &i2c_sysctl_real, NULL, &w83781d_vrm},=0A=
	{W83781D_SYSCTL_FAN_DIV, "fan_div", NULL, 0, 0644, NULL, &i2c_proc_real,=0A=
	 &i2c_sysctl_real, NULL, &w83781d_fan_div},=0A=
	{W83781D_SYSCTL_ALARMS, "alarms", NULL, 0, 0444, NULL, &i2c_proc_real,=0A=
	 &i2c_sysctl_real, NULL, &w83781d_alarms},=0A=
	{W83781D_SYSCTL_BEEP, "beep", NULL, 0, 0644, NULL, &i2c_proc_real,=0A=
	 &i2c_sysctl_real, NULL, &w83781d_beep},=0A=
	{W83781D_SYSCTL_PWM1, "pwm1", NULL, 0, 0644, NULL, &i2c_proc_real,=0A=
	 &i2c_sysctl_real, NULL, &w83781d_pwm},=0A=
	{W83781D_SYSCTL_PWM2, "pwm2", NULL, 0, 0644, NULL, &i2c_proc_real,=0A=
	 &i2c_sysctl_real, NULL, &w83781d_pwm},=0A=
	{W83781D_SYSCTL_SENS1, "sensor1", NULL, 0, 0644, NULL, &i2c_proc_real,=0A=
	 &i2c_sysctl_real, NULL, &w83781d_sens},=0A=
	{W83781D_SYSCTL_SENS2, "sensor2", NULL, 0, 0644, NULL, &i2c_proc_real,=0A=
	 &i2c_sysctl_real, NULL, &w83781d_sens},=0A=
	{0}=0A=
};=0A=
=0A=
/* similar to w83782d but no fan3, no vid */=0A=
static ctl_table w83697hf_dir_table_template[] =3D {=0A=
	{W83781D_SYSCTL_IN0, "in0", NULL, 0, 0644, NULL, &i2c_proc_real,=0A=
	 &i2c_sysctl_real, NULL, &w83781d_in},=0A=
	/* no in1 to maintain compatibility with 781d and 782d. */=0A=
	{W83781D_SYSCTL_IN2, "in2", NULL, 0, 0644, NULL, &i2c_proc_real,=0A=
	 &i2c_sysctl_real, NULL, &w83781d_in},=0A=
	{W83781D_SYSCTL_IN3, "in3", NULL, 0, 0644, NULL, &i2c_proc_real,=0A=
	 &i2c_sysctl_real, NULL, &w83781d_in},=0A=
	{W83781D_SYSCTL_IN4, "in4", NULL, 0, 0644, NULL, &i2c_proc_real,=0A=
	 &i2c_sysctl_real, NULL, &w83781d_in},=0A=
	{W83781D_SYSCTL_IN5, "in5", NULL, 0, 0644, NULL, &i2c_proc_real,=0A=
	 &i2c_sysctl_real, NULL, &w83781d_in},=0A=
	{W83781D_SYSCTL_IN6, "in6", NULL, 0, 0644, NULL, &i2c_proc_real,=0A=
	 &i2c_sysctl_real, NULL, &w83781d_in},=0A=
	{W83781D_SYSCTL_IN7, "in7", NULL, 0, 0644, NULL, &i2c_proc_real,=0A=
	 &i2c_sysctl_real, NULL, &w83781d_in},=0A=
	{W83781D_SYSCTL_IN8, "in8", NULL, 0, 0644, NULL, &i2c_proc_real,=0A=
	 &i2c_sysctl_real, NULL, &w83781d_in},=0A=
	{W83781D_SYSCTL_FAN1, "fan1", NULL, 0, 0644, NULL, &i2c_proc_real,=0A=
	 &i2c_sysctl_real, NULL, &w83781d_fan},=0A=
	{W83781D_SYSCTL_FAN2, "fan2", NULL, 0, 0644, NULL, &i2c_proc_real,=0A=
	 &i2c_sysctl_real, NULL, &w83781d_fan},=0A=
	{W83781D_SYSCTL_TEMP1, "temp1", NULL, 0, 0644, NULL, &i2c_proc_real,=0A=
	 &i2c_sysctl_real, NULL, &w83781d_temp},=0A=
	{W83781D_SYSCTL_TEMP2, "temp2", NULL, 0, 0644, NULL, &i2c_proc_real,=0A=
	 &i2c_sysctl_real, NULL, &w83781d_temp_add},=0A=
	{W83781D_SYSCTL_FAN_DIV, "fan_div", NULL, 0, 0644, NULL, &i2c_proc_real,=0A=
	 &i2c_sysctl_real, NULL, &w83781d_fan_div},=0A=
	{W83781D_SYSCTL_ALARMS, "alarms", NULL, 0, 0444, NULL, &i2c_proc_real,=0A=
	 &i2c_sysctl_real, NULL, &w83781d_alarms},=0A=
	{W83781D_SYSCTL_BEEP, "beep", NULL, 0, 0644, NULL, &i2c_proc_real,=0A=
	 &i2c_sysctl_real, NULL, &w83781d_beep},=0A=
	{W83781D_SYSCTL_PWM1, "pwm1", NULL, 0, 0644, NULL, &i2c_proc_real,=0A=
	 &i2c_sysctl_real, NULL, &w83781d_pwm},=0A=
	{W83781D_SYSCTL_PWM2, "pwm2", NULL, 0, 0644, NULL, &i2c_proc_real,=0A=
	 &i2c_sysctl_real, NULL, &w83781d_pwm},=0A=
	{W83781D_SYSCTL_SENS1, "sensor1", NULL, 0, 0644, NULL, &i2c_proc_real,=0A=
	 &i2c_sysctl_real, NULL, &w83781d_sens},=0A=
	{W83781D_SYSCTL_SENS2, "sensor2", NULL, 0, 0644, NULL, &i2c_proc_real,=0A=
	 &i2c_sysctl_real, NULL, &w83781d_sens},=0A=
	{0}=0A=
};=0A=
=0A=
=0A=
/* This function is called when:=0A=
     * w83781d_driver is inserted (when this module is loaded), for each=0A=
       available adapter=0A=
     * when a new adapter is inserted (and w83781d_driver is still =
present) */=0A=
int w83781d_attach_adapter(struct i2c_adapter *adapter)=0A=
{=0A=
	return i2c_detect(adapter, &addr_data, w83781d_detect);=0A=
}=0A=
=0A=
int w83781d_detect(struct i2c_adapter *adapter, int address,=0A=
		   unsigned short flags, int kind)=0A=
{=0A=
	int i, val1 =3D 0, val2, id;=0A=
	struct i2c_client *new_client;=0A=
	struct w83781d_data *data;=0A=
	int err =3D 0;=0A=
	const char *type_name =3D "";=0A=
	const char *client_name =3D "";=0A=
	int is_isa =3D i2c_is_isa_adapter(adapter);=0A=
	enum vendor { winbond, asus } vendid;=0A=
=0A=
	if (!is_isa=0A=
	    && !i2c_check_functionality(adapter,=0A=
					I2C_FUNC_SMBUS_BYTE_DATA)) goto=0A=
		    ERROR0;=0A=
=0A=
	if (is_isa) {=0A=
		if (check_region(address, W83781D_EXTENT))=0A=
			goto ERROR0;=0A=
	}=0A=
=0A=
	/* Probe whether there is anything available on this address. Already=0A=
	   done for SMBus clients */=0A=
	if (kind < 0) {=0A=
		if (is_isa) {=0A=
=0A=
#define REALLY_SLOW_IO=0A=
			/* We need the timeouts for at least some LM78-like chips. But only=0A=
			   if we read 'undefined' registers. */=0A=
			i =3D inb_p(address + 1);=0A=
			if (inb_p(address + 2) !=3D i)=0A=
				goto ERROR0;=0A=
			if (inb_p(address + 3) !=3D i)=0A=
				goto ERROR0;=0A=
			if (inb_p(address + 7) !=3D i)=0A=
				goto ERROR0;=0A=
#undef REALLY_SLOW_IO=0A=
=0A=
			/* Let's just hope nothing breaks here */=0A=
			i =3D inb_p(address + 5) & 0x7f;=0A=
			outb_p(~i & 0x7f, address + 5);=0A=
			if ((inb_p(address + 5) & 0x7f) !=3D (~i & 0x7f)) {=0A=
				outb_p(i, address + 5);=0A=
				return 0;=0A=
			}=0A=
		}=0A=
	}=0A=
=0A=
	/* OK. For now, we presume we have a valid client. We now create the=0A=
	   client structure, even though we cannot fill it completely yet.=0A=
	   But it allows us to access w83781d_{read,write}_value. */=0A=
=0A=
	if (!(new_client =3D kmalloc(sizeof(struct i2c_client) +=0A=
				   sizeof(struct w83781d_data),=0A=
				   GFP_KERNEL))) {=0A=
		err =3D -ENOMEM;=0A=
		goto ERROR0;=0A=
	}=0A=
=0A=
	data =3D (struct w83781d_data *) (new_client + 1);=0A=
	new_client->addr =3D address;=0A=
	init_MUTEX(&data->lock);=0A=
	new_client->data =3D data;=0A=
	new_client->adapter =3D adapter;=0A=
	new_client->driver =3D &w83781d_driver;=0A=
	new_client->flags =3D 0;=0A=
=0A=
	/* Now, we do the remaining detection. */=0A=
=0A=
	/* The w8378?d may be stuck in some other bank than bank 0. This may=0A=
	   make reading other information impossible. Specify a force=3D... or=0A=
	   force_*=3D... parameter, and the Winbond will be reset to the right=0A=
	   bank. */=0A=
	if (kind < 0) {=0A=
		if (w83781d_read_value(new_client, W83781D_REG_CONFIG) &=0A=
		    0x80) goto ERROR1;=0A=
		val1 =3D w83781d_read_value(new_client, W83781D_REG_BANK);=0A=
		val2 =3D w83781d_read_value(new_client, W83781D_REG_CHIPMAN);=0A=
		/* Check for Winbond or Asus ID if in bank 0 */=0A=
		if ((!(val1 & 0x07)) &&=0A=
		    (((!(val1 & 0x80)) && (val2 !=3D 0xa3) && (val2 !=3D 0xc3) =0A=
			 && (val2 !=3D 0x94))=0A=
		     || ((val1 & 0x80) && (val2 !=3D 0x5c) && (val2 !=3D 0x12)=0A=
			 && (val2 !=3D 0x06)))) goto ERROR1;=0A=
		/* If Winbond SMBus, check address at 0x48. Asus doesn't support */=0A=
		if ((!is_isa) && (((!(val1 & 0x80)) && (val2 =3D=3D 0xa3)) ||=0A=
				  ((val1 & 0x80) && (val2 =3D=3D 0x5c)))) {=0A=
			if (w83781d_read_value=0A=
			    (new_client, W83781D_REG_I2C_ADDR) !=3D address)=0A=
				goto ERROR1;=0A=
		}=0A=
	}=0A=
=0A=
	/* We have either had a force parameter, or we have already detected the=0A=
	   Winbond. Put it now into bank 0 and Vendor ID High Byte */=0A=
	w83781d_write_value(new_client, W83781D_REG_BANK,=0A=
			    (w83781d_read_value(new_client,=0A=
						W83781D_REG_BANK) & 0x78) |=0A=
			    0x80);=0A=
=0A=
	/* Determine the chip type. */=0A=
	if (kind <=3D 0) {=0A=
		/* get vendor ID */=0A=
		val2 =3D w83781d_read_value(new_client, W83781D_REG_CHIPMAN);=0A=
		if (val2 =3D=3D 0x5c)=0A=
			vendid =3D winbond;=0A=
		else if ((val2 =3D=3D 0x12) || (val2 =3D=3D 0x06))=0A=
			vendid =3D asus;=0A=
		else=0A=
			goto ERROR1;=0A=
		/* mask off lower bit, not reliable */=0A=
		val1 =3D=0A=
		    w83781d_read_value(new_client,=0A=
				       W83781D_REG_WCHIPID) & 0xfe;=0A=
		if (val1 =3D=3D 0x10 && vendid =3D=3D winbond)=0A=
			kind =3D w83781d;=0A=
		else if (val1 =3D=3D 0x30 && vendid =3D=3D winbond)=0A=
			kind =3D w83782d;=0A=
		else if (val1 =3D=3D 0x40 && vendid =3D=3D winbond && !is_isa)=0A=
			kind =3D w83783s;=0A=
		else if (val1 =3D=3D 0x20 && vendid =3D=3D winbond)=0A=
			kind =3D w83627hf;=0A=
		else if (val1 =3D=3D 0x30 && vendid =3D=3D asus && !is_isa)=0A=
			kind =3D as99127f;=0A=
		else if (val1 =3D=3D 0x60 && vendid =3D=3D winbond && is_isa)=0A=
			kind =3D w83697hf;=0A=
		else {=0A=
			if (kind =3D=3D 0)=0A=
				printk=0A=
				    (KERN_WARNING "w83781d.o: Ignoring 'force' parameter for unknown =
chip at"=0A=
				     "adapter %d, address 0x%02x\n",=0A=
				     i2c_adapter_id(adapter), address);=0A=
			goto ERROR1;=0A=
		}=0A=
	}=0A=
=0A=
	if (kind =3D=3D w83781d) {=0A=
		type_name =3D "w83781d";=0A=
		client_name =3D "W83781D chip";=0A=
	} else if (kind =3D=3D w83782d) {=0A=
		type_name =3D "w83782d";=0A=
		client_name =3D "W83782D chip";=0A=
	} else if (kind =3D=3D w83783s) {=0A=
		type_name =3D "w83783s";=0A=
		client_name =3D "W83783S chip";=0A=
	} else if (kind =3D=3D w83627hf) {=0A=
		type_name =3D "w83627hf";=0A=
		client_name =3D "W83627HF chip";=0A=
	} else if (kind =3D=3D as99127f) {=0A=
		type_name =3D "as99127f";=0A=
		client_name =3D "AS99127F chip";=0A=
	} else if (kind =3D=3D w83697hf) {=0A=
		type_name =3D "w83697hf";=0A=
		client_name =3D "W83697HF chip";=0A=
	} else {=0A=
#ifdef DEBUG=0A=
		printk(KERN_ERR "w83781d.o: Internal error: unknown kind (%d)?!?",=0A=
		       kind);=0A=
#endif=0A=
		goto ERROR1;=0A=
	}=0A=
=0A=
	/* Reserve the ISA region */=0A=
	if (is_isa)=0A=
		request_region(address, W83781D_EXTENT, type_name);=0A=
=0A=
	/* Fill in the remaining client fields and put it into the global list =
*/=0A=
	strcpy(new_client->name, client_name);=0A=
	data->type =3D kind;=0A=
=0A=
	new_client->id =3D w83781d_id++;=0A=
	data->valid =3D 0;=0A=
	init_MUTEX(&data->update_lock);=0A=
=0A=
	/* Tell the I2C layer a new client has arrived */=0A=
	if ((err =3D i2c_attach_client(new_client)))=0A=
		goto ERROR3;=0A=
=0A=
	/* attach secondary i2c lm75-like clients */=0A=
	if (!is_isa) {=0A=
		if (!(data->lm75 =3D kmalloc(2 * sizeof(struct i2c_client),=0A=
					   GFP_KERNEL))) {=0A=
			err =3D -ENOMEM;=0A=
			goto ERROR4;=0A=
		}=0A=
		id =3D i2c_adapter_id(adapter);=0A=
		if(force_subclients[0] =3D=3D id && force_subclients[1] =3D=3D =
address) {=0A=
			for(i =3D 2; i <=3D 3; i++) {=0A=
				if(force_subclients[i] < 0x48 ||=0A=
				   force_subclients[i] > 0x4f) {=0A=
					printk(KERN_ERR "w83781d.o: Invalid subclient address %d; must be =
0x48-0x4f\n",=0A=
					        force_subclients[i]);=0A=
					goto ERROR5;=0A=
				}=0A=
			}=0A=
			w83781d_write_value(new_client,=0A=
			                    W83781D_REG_I2C_SUBADDR,=0A=
			                    (force_subclients[2] & 0x07) |=0A=
			                    ((force_subclients[3] & 0x07) <<4));=0A=
			data->lm75[0].addr =3D force_subclients[2];=0A=
		} else {=0A=
			val1 =3D w83781d_read_value(new_client,=0A=
					          W83781D_REG_I2C_SUBADDR);=0A=
			data->lm75[0].addr =3D 0x48 + (val1 & 0x07);=0A=
		}=0A=
		if (kind !=3D w83783s) {=0A=
			if(force_subclients[0] =3D=3D id &&=0A=
			   force_subclients[1] =3D=3D address) {=0A=
				data->lm75[1].addr =3D force_subclients[3];=0A=
			} else {=0A=
				data->lm75[1].addr =3D 0x48 + ((val1 >> 4) & 0x07);=0A=
			}=0A=
			if(data->lm75[0].addr =3D=3D data->lm75[1].addr) {=0A=
				printk(KERN_ERR "w83781d.o: Duplicate addresses 0x%x for =
subclients.\n",=0A=
					data->lm75[0].addr);=0A=
				goto ERROR5;=0A=
			}=0A=
		}=0A=
		if (kind =3D=3D w83781d)=0A=
			client_name =3D "W83781D subclient";=0A=
		else if (kind =3D=3D w83782d)=0A=
			client_name =3D "W83782D subclient";=0A=
		else if (kind =3D=3D w83783s)=0A=
			client_name =3D "W83783S subclient";=0A=
		else if (kind =3D=3D w83627hf)=0A=
			client_name =3D "W83627HF subclient";=0A=
		else if (kind =3D=3D as99127f)=0A=
			client_name =3D "AS99127F subclient";=0A=
=0A=
		for (i =3D 0; i <=3D 1; i++) {=0A=
			data->lm75[i].data =3D NULL;	/* store all data in w83781d */=0A=
			data->lm75[i].adapter =3D adapter;=0A=
			data->lm75[i].driver =3D &w83781d_driver;=0A=
			data->lm75[i].flags =3D 0;=0A=
			strcpy(data->lm75[i].name, client_name);=0A=
			data->lm75[i].id =3D w83781d_id++;=0A=
			if ((err =3D i2c_attach_client(&(data->lm75[i])))) {=0A=
				printk(KERN_ERR "w83781d.o: Subclient %d registration at address =
0x%x failed.\n",=0A=
				       i, data->lm75[i].addr);=0A=
				if (i =3D=3D 1)=0A=
					goto ERROR6;=0A=
				goto ERROR5;=0A=
			}=0A=
			if (kind =3D=3D w83783s)=0A=
				break;=0A=
		}=0A=
	} else {=0A=
		data->lm75 =3D NULL;=0A=
	}=0A=
=0A=
	/* Register a new directory entry with module sensors */=0A=
	if ((i =3D i2c_register_entry(new_client,=0A=
					type_name,=0A=
					(kind =3D=3D as99127f) ?=0A=
					   as99127f_dir_table_template :=0A=
					(kind =3D=3D w83781d) ?=0A=
					   w83781d_dir_table_template :=0A=
					(kind =3D=3D w83783s) ?=0A=
					   w83783s_dir_table_template :=0A=
					(kind =3D=3D w83697hf) ?=0A=
					   w83697hf_dir_table_template :=0A=
					(is_isa || kind =3D=3D w83627hf) ?=0A=
					   w83782d_isa_dir_table_template :=0A=
					   w83782d_i2c_dir_table_template,=0A=
					THIS_MODULE)) < 0) {=0A=
		err =3D i;=0A=
		goto ERROR7;=0A=
	}=0A=
	data->sysctl_id =3D i;=0A=
=0A=
	/* Initialize the chip */=0A=
	w83781d_init_client(new_client);=0A=
	return 0;=0A=
=0A=
/* OK, this is not exactly good programming practice, usually. But it is=0A=
   very code-efficient in this case. */=0A=
=0A=
      ERROR7:=0A=
	if (!is_isa)=0A=
		i2c_detach_client(&=0A=
				  (((struct=0A=
				     w83781d_data *) (new_client->data))->=0A=
				   lm75[1]));=0A=
      ERROR6:=0A=
	if (!is_isa)=0A=
		i2c_detach_client(&=0A=
				  (((struct=0A=
				     w83781d_data *) (new_client->data))->=0A=
				   lm75[0]));=0A=
      ERROR5:=0A=
	if (!is_isa)=0A=
		kfree(((struct w83781d_data *) (new_client->data))->lm75);=0A=
      ERROR4:=0A=
	i2c_detach_client(new_client);=0A=
      ERROR3:=0A=
	if (is_isa)=0A=
		release_region(address, W83781D_EXTENT);=0A=
      ERROR1:=0A=
	kfree(new_client);=0A=
      ERROR0:=0A=
	return err;=0A=
}=0A=
=0A=
int w83781d_detach_client(struct i2c_client *client)=0A=
{=0A=
	int err;=0A=
=0A=
	i2c_deregister_entry(((struct w83781d_data *) (client->data))->=0A=
				 sysctl_id);=0A=
=0A=
	if ((err =3D i2c_detach_client(client))) {=0A=
		printk=0A=
		    (KERN_ERR "w83781d.o: Client deregistration failed, client not =
detached.\n");=0A=
		return err;=0A=
	}=0A=
=0A=
	if(i2c_is_isa_client(client)) {=0A=
		release_region(client->addr, W83781D_EXTENT);=0A=
	} else {=0A=
		i2c_detach_client(&=0A=
				  (((struct=0A=
				     w83781d_data *) (client->data))->=0A=
				   lm75[0]));=0A=
		if((((struct w83781d_data *) (client->data))->type) !=3D w83783s)=0A=
			i2c_detach_client(&=0A=
				  (((struct=0A=
				     w83781d_data *) (client->data))->=0A=
				   lm75[1]));=0A=
		kfree(((struct w83781d_data *) (client->data))->lm75);=0A=
	}=0A=
	kfree(client);=0A=
=0A=
	return 0;=0A=
}=0A=
=0A=
/* No commands defined yet */=0A=
int w83781d_command(struct i2c_client *client, unsigned int cmd, void =
*arg)=0A=
{=0A=
	return 0;=0A=
}=0A=
=0A=
void w83781d_inc_use(struct i2c_client *client)=0A=
{=0A=
#ifdef MODULE=0A=
	MOD_INC_USE_COUNT;=0A=
#endif=0A=
}=0A=
=0A=
void w83781d_dec_use(struct i2c_client *client)=0A=
{=0A=
#ifdef MODULE=0A=
	MOD_DEC_USE_COUNT;=0A=
#endif=0A=
}=0A=
=0A=
u16 swap_bytes(u16 val)=0A=
{=0A=
	return (val >> 8) | (val << 8);=0A=
}=0A=
=0A=
/* The SMBus locks itself, usually, but nothing may access the Winbond =
between=0A=
   bank switches. ISA access must always be locked explicitly! =0A=
   We ignore the W83781D BUSY flag at this moment - it could lead to =
deadlocks,=0A=
   would slow down the W83781D access and should not be necessary. =0A=
   There are some ugly typecasts here, but the good news is - they should=0A=
   nowhere else be necessary! */=0A=
int w83781d_read_value(struct i2c_client *client, u16 reg)=0A=
{=0A=
	int res, word_sized, bank;=0A=
	struct i2c_client *cl;=0A=
=0A=
	down(&(((struct w83781d_data *) (client->data))->lock));=0A=
	if (i2c_is_isa_client(client)) {=0A=
		word_sized =3D (((reg & 0xff00) =3D=3D 0x100)=0A=
			      || ((reg & 0xff00) =3D=3D 0x200))=0A=
		    && (((reg & 0x00ff) =3D=3D 0x50)=0A=
			|| ((reg & 0x00ff) =3D=3D 0x53)=0A=
			|| ((reg & 0x00ff) =3D=3D 0x55));=0A=
		if (reg & 0xff00) {=0A=
			outb_p(W83781D_REG_BANK,=0A=
			       client->addr + W83781D_ADDR_REG_OFFSET);=0A=
			outb_p(reg >> 8,=0A=
			       client->addr + W83781D_DATA_REG_OFFSET);=0A=
		}=0A=
		outb_p(reg & 0xff, client->addr + W83781D_ADDR_REG_OFFSET);=0A=
		res =3D inb_p(client->addr + W83781D_DATA_REG_OFFSET);=0A=
		if (word_sized) {=0A=
			outb_p((reg & 0xff) + 1,=0A=
			       client->addr + W83781D_ADDR_REG_OFFSET);=0A=
			res =3D=0A=
			    (res << 8) + inb_p(client->addr +=0A=
					       W83781D_DATA_REG_OFFSET);=0A=
		}=0A=
		if (reg & 0xff00) {=0A=
			outb_p(W83781D_REG_BANK,=0A=
			       client->addr + W83781D_ADDR_REG_OFFSET);=0A=
			outb_p(0, client->addr + W83781D_DATA_REG_OFFSET);=0A=
		}=0A=
	} else {=0A=
		bank =3D (reg >> 8) & 0x0f;=0A=
		if (bank > 2)=0A=
			/* switch banks */=0A=
			i2c_smbus_write_byte_data(client, W83781D_REG_BANK,=0A=
						  bank);=0A=
		if (bank =3D=3D 0 || bank > 2) {=0A=
			res =3D i2c_smbus_read_byte_data(client, reg & 0xff);=0A=
		} else {=0A=
			/* switch to subclient */=0A=
			cl =3D=0A=
			    &(((struct w83781d_data *) (client->data))->=0A=
			      lm75[bank - 1]);=0A=
			/* convert from ISA to LM75 I2C addresses */=0A=
			switch (reg & 0xff) {=0A=
			case 0x50: /* TEMP */=0A=
				res =3D=0A=
				    swap_bytes(i2c_smbus_read_word_data=0A=
					       (cl, 0));=0A=
				break;=0A=
			case 0x52: /* CONFIG */=0A=
				res =3D i2c_smbus_read_byte_data(cl, 1);=0A=
				break;=0A=
			case 0x53: /* HYST */=0A=
				res =3D=0A=
				    swap_bytes(i2c_smbus_read_word_data=0A=
					       (cl, 2));=0A=
				break;=0A=
			case 0x55: /* OVER */=0A=
			default:=0A=
				res =3D=0A=
				    swap_bytes(i2c_smbus_read_word_data=0A=
					       (cl, 3));=0A=
				break;=0A=
			}=0A=
		}=0A=
		if (bank > 2)=0A=
			i2c_smbus_write_byte_data(client, W83781D_REG_BANK,=0A=
						  0);=0A=
	}=0A=
	up(&(((struct w83781d_data *) (client->data))->lock));=0A=
	return res;=0A=
}=0A=
=0A=
int w83781d_write_value(struct i2c_client *client, u16 reg, u16 value)=0A=
{=0A=
	int word_sized, bank;=0A=
	struct i2c_client *cl;=0A=
=0A=
	down(&(((struct w83781d_data *) (client->data))->lock));=0A=
	if (i2c_is_isa_client(client)) {=0A=
		word_sized =3D (((reg & 0xff00) =3D=3D 0x100)=0A=
			      || ((reg & 0xff00) =3D=3D 0x200))=0A=
		    && (((reg & 0x00ff) =3D=3D 0x53)=0A=
			|| ((reg & 0x00ff) =3D=3D 0x55));=0A=
		if (reg & 0xff00) {=0A=
			outb_p(W83781D_REG_BANK,=0A=
			       client->addr + W83781D_ADDR_REG_OFFSET);=0A=
			outb_p(reg >> 8,=0A=
			       client->addr + W83781D_DATA_REG_OFFSET);=0A=
		}=0A=
		outb_p(reg & 0xff, client->addr + W83781D_ADDR_REG_OFFSET);=0A=
		if (word_sized) {=0A=
			outb_p(value >> 8,=0A=
			       client->addr + W83781D_DATA_REG_OFFSET);=0A=
			outb_p((reg & 0xff) + 1,=0A=
			       client->addr + W83781D_ADDR_REG_OFFSET);=0A=
		}=0A=
		outb_p(value & 0xff,=0A=
		       client->addr + W83781D_DATA_REG_OFFSET);=0A=
		if (reg & 0xff00) {=0A=
			outb_p(W83781D_REG_BANK,=0A=
			       client->addr + W83781D_ADDR_REG_OFFSET);=0A=
			outb_p(0, client->addr + W83781D_DATA_REG_OFFSET);=0A=
		}=0A=
	} else {=0A=
		bank =3D (reg >> 8) & 0x0f;=0A=
		if (bank > 2)=0A=
			/* switch banks */=0A=
			i2c_smbus_write_byte_data(client, W83781D_REG_BANK,=0A=
						  bank);=0A=
		if (bank =3D=3D 0 || bank > 2) {=0A=
			i2c_smbus_write_byte_data(client, reg & 0xff,=0A=
						  value & 0xff);=0A=
		} else {=0A=
			/* switch to subclient */=0A=
			cl =3D &(((struct w83781d_data *) (client->data))->=0A=
			      lm75[bank - 1]);=0A=
			/* convert from ISA to LM75 I2C addresses */=0A=
			switch (reg & 0xff) {=0A=
			case 0x52: /* CONFIG */=0A=
				i2c_smbus_write_byte_data(cl, 1,=0A=
							  value & 0xff);=0A=
				break;=0A=
			case 0x53: /* HYST */=0A=
				i2c_smbus_write_word_data(cl, 2,=0A=
							  swap_bytes(value));=0A=
				break;=0A=
			case 0x55: /* OVER */=0A=
				i2c_smbus_write_word_data(cl, 3,=0A=
							  swap_bytes(value));=0A=
				break;=0A=
			}=0A=
		}=0A=
		if (bank > 2)=0A=
			i2c_smbus_write_byte_data(client, W83781D_REG_BANK,=0A=
						  0);=0A=
	}=0A=
	up(&(((struct w83781d_data *) (client->data))->lock));=0A=
	return 0;=0A=
}=0A=
=0A=
/* Called when we have found a new W83781D. It should set limits, etc. */=0A=
void w83781d_init_client(struct i2c_client *client)=0A=
{=0A=
	struct w83781d_data *data =3D client->data;=0A=
	int vid =3D 0, i;=0A=
	int type =3D data->type;=0A=
	u8 tmp;=0A=
=0A=
	if(init && type !=3D as99127f) { /* this resets registers we don't have=0A=
			                  documentation for on the as99127f */=0A=
		/* save this register */=0A=
		i =3D w83781d_read_value(client, W83781D_REG_BEEP_CONFIG);=0A=
		/* Reset all except Watchdog values and last conversion values=0A=
		   This sets fan-divs to 2, among others */=0A=
		w83781d_write_value(client, W83781D_REG_CONFIG, 0x80);=0A=
		/* Restore the register and disable power-on abnormal beep.=0A=
		   This saves FAN 1/2/3 input/output values set by BIOS. */=0A=
		w83781d_write_value(client, W83781D_REG_BEEP_CONFIG, i | 0x80);=0A=
		/* Disable master beep-enable (reset turns it on).=0A=
		   Individual beeps should be reset to off but for some reason=0A=
		   disabling this bit helps some people not get beeped */=0A=
		w83781d_write_value(client, W83781D_REG_BEEP_INTS2, 0);=0A=
	}=0A=
=0A=
	if (type !=3D w83697hf) {=0A=
		vid =3D w83781d_read_value(client, W83781D_REG_VID_FANDIV) & 0x0f;=0A=
		vid |=3D=0A=
		    (w83781d_read_value(client, W83781D_REG_CHIPID) & 0x01) << 4;=0A=
		data->vrm =3D DEFAULT_VRM;=0A=
		vid =3D vid_from_reg(vid, data->vrm);=0A=
	}=0A=
=0A=
	if ((type !=3D w83781d) && (type !=3D as99127f)) {=0A=
		tmp =3D w83781d_read_value(client, W83781D_REG_SCFG1);=0A=
		for (i =3D 1; i <=3D 3; i++) {=0A=
			if (!(tmp & BIT_SCFG1[i - 1])) {=0A=
				data->sens[i - 1] =3D W83781D_DEFAULT_BETA;=0A=
			} else {=0A=
				if (w83781d_read_value=0A=
				    (client,=0A=
				     W83781D_REG_SCFG2) & BIT_SCFG2[i - 1])=0A=
					data->sens[i - 1] =3D 1;=0A=
				else=0A=
					data->sens[i - 1] =3D 2;=0A=
			}=0A=
			if ((type =3D=3D w83783s || type =3D=3D w83697hf) && (i =3D=3D 2))=0A=
				break;=0A=
		}=0A=
	}=0A=
#ifdef W83781D_RT=0A=
/*=0A=
   Fill up the RT Tables.=0A=
   We assume that they are 32 bytes long, in order for temp 1-3.=0A=
   Data sheet documentation is sparse.=0A=
   We also assume that it is only for the 781D although I suspect=0A=
   that the others support it as well....=0A=
*/=0A=
=0A=
	if (init && type =3D=3D w83781d) {=0A=
		u16 k =3D 0;=0A=
/*=0A=
    Auto-indexing doesn't seem to work...=0A=
    w83781d_write_value(client,W83781D_REG_RT_IDX,0);=0A=
*/=0A=
		for (i =3D 0; i < 3; i++) {=0A=
			int j;=0A=
			for (j =3D 0; j < 32; j++) {=0A=
				w83781d_write_value(client,=0A=
						    W83781D_REG_RT_IDX,=0A=
						    k++);=0A=
				data->rt[i][j] =3D=0A=
				    w83781d_read_value(client,=0A=
						       W83781D_REG_RT_VAL);=0A=
			}=0A=
		}=0A=
	}=0A=
#endif				/* W83781D_RT */=0A=
=0A=
	if(init) {=0A=
		w83781d_write_value(client, W83781D_REG_IN_MIN(0),=0A=
				    IN_TO_REG(W83781D_INIT_IN_MIN_0));=0A=
		w83781d_write_value(client, W83781D_REG_IN_MAX(0),=0A=
				    IN_TO_REG(W83781D_INIT_IN_MAX_0));=0A=
		if (type !=3D w83783s && type !=3D w83697hf) {=0A=
			w83781d_write_value(client, W83781D_REG_IN_MIN(1),=0A=
					    IN_TO_REG(W83781D_INIT_IN_MIN_1));=0A=
			w83781d_write_value(client, W83781D_REG_IN_MAX(1),=0A=
					    IN_TO_REG(W83781D_INIT_IN_MAX_1));=0A=
		}=0A=
=0A=
		w83781d_write_value(client, W83781D_REG_IN_MIN(2),=0A=
				    IN_TO_REG(W83781D_INIT_IN_MIN_2));=0A=
		w83781d_write_value(client, W83781D_REG_IN_MAX(2),=0A=
				    IN_TO_REG(W83781D_INIT_IN_MAX_2));=0A=
		w83781d_write_value(client, W83781D_REG_IN_MIN(3),=0A=
				    IN_TO_REG(W83781D_INIT_IN_MIN_3));=0A=
		w83781d_write_value(client, W83781D_REG_IN_MAX(3),=0A=
				    IN_TO_REG(W83781D_INIT_IN_MAX_3));=0A=
		w83781d_write_value(client, W83781D_REG_IN_MIN(4),=0A=
				    IN_TO_REG(W83781D_INIT_IN_MIN_4));=0A=
		w83781d_write_value(client, W83781D_REG_IN_MAX(4),=0A=
				    IN_TO_REG(W83781D_INIT_IN_MAX_4));=0A=
		if (type =3D=3D w83781d || type =3D=3D as99127f) {=0A=
			w83781d_write_value(client, W83781D_REG_IN_MIN(5),=0A=
					    IN_TO_REG(W83781D_INIT_IN_MIN_5));=0A=
			w83781d_write_value(client, W83781D_REG_IN_MAX(5),=0A=
					    IN_TO_REG(W83781D_INIT_IN_MAX_5));=0A=
		} else {=0A=
			w83781d_write_value(client, W83781D_REG_IN_MIN(5),=0A=
					    IN_TO_REG(W83782D_INIT_IN_MIN_5));=0A=
			w83781d_write_value(client, W83781D_REG_IN_MAX(5),=0A=
					    IN_TO_REG(W83782D_INIT_IN_MAX_5));=0A=
		}=0A=
		if (type =3D=3D w83781d || type =3D=3D as99127f) {=0A=
			w83781d_write_value(client, W83781D_REG_IN_MIN(6),=0A=
					    IN_TO_REG(W83781D_INIT_IN_MIN_6));=0A=
			w83781d_write_value(client, W83781D_REG_IN_MAX(6),=0A=
					    IN_TO_REG(W83781D_INIT_IN_MAX_6));=0A=
		} else {=0A=
			w83781d_write_value(client, W83781D_REG_IN_MIN(6),=0A=
					    IN_TO_REG(W83782D_INIT_IN_MIN_6));=0A=
			w83781d_write_value(client, W83781D_REG_IN_MAX(6),=0A=
					    IN_TO_REG(W83782D_INIT_IN_MAX_6));=0A=
		}=0A=
		if ((type =3D=3D w83782d) || (type =3D=3D w83627hf) ||=0A=
		    (type =3D=3D w83697hf)) {=0A=
			w83781d_write_value(client, W83781D_REG_IN_MIN(7),=0A=
					    IN_TO_REG(W83781D_INIT_IN_MIN_7));=0A=
			w83781d_write_value(client, W83781D_REG_IN_MAX(7),=0A=
					    IN_TO_REG(W83781D_INIT_IN_MAX_7));=0A=
			w83781d_write_value(client, W83781D_REG_IN_MIN(8),=0A=
					    IN_TO_REG(W83781D_INIT_IN_MIN_8));=0A=
			w83781d_write_value(client, W83781D_REG_IN_MAX(8),=0A=
					    IN_TO_REG(W83781D_INIT_IN_MAX_8));=0A=
			w83781d_write_value(client, W83781D_REG_VBAT,=0A=
			    (w83781d_read_value(client, W83781D_REG_VBAT) | 0x01));=0A=
		}=0A=
		w83781d_write_value(client, W83781D_REG_FAN_MIN(1),=0A=
				    FAN_TO_REG(W83781D_INIT_FAN_MIN_1, 2));=0A=
		w83781d_write_value(client, W83781D_REG_FAN_MIN(2),=0A=
				    FAN_TO_REG(W83781D_INIT_FAN_MIN_2, 2));=0A=
		if (type !=3D w83697hf) {=0A=
			w83781d_write_value(client, W83781D_REG_FAN_MIN(3),=0A=
				    FAN_TO_REG(W83781D_INIT_FAN_MIN_3, 2));=0A=
		}=0A=
=0A=
		w83781d_write_value(client, W83781D_REG_TEMP_OVER,=0A=
				    TEMP_TO_REG(W83781D_INIT_TEMP_OVER));=0A=
		w83781d_write_value(client, W83781D_REG_TEMP_HYST,=0A=
				    TEMP_TO_REG(W83781D_INIT_TEMP_HYST));=0A=
=0A=
		if (type =3D=3D as99127f) {=0A=
			w83781d_write_value(client, AS99127_REG_TEMP_OVER,=0A=
					    TEMP_TO_REG(AS99127_INIT_TEMP_OVER));=0A=
			w83781d_write_value(client, AS99127_REG_TEMP_HYST,=0A=
					    TEMP_TO_REG(AS99127_INIT_TEMP_HYST));=0A=
		}=0A=
=0A=
		w83781d_write_value(client, W83781D_REG_TEMP2_OVER,=0A=
				    TEMP_ADD_TO_REG=0A=
				    (W83781D_INIT_TEMP2_OVER));=0A=
		w83781d_write_value(client, W83781D_REG_TEMP2_HYST,=0A=
				    TEMP_ADD_TO_REG=0A=
				    (W83781D_INIT_TEMP2_HYST));=0A=
=0A=
		w83781d_write_value(client, W83781D_REG_TEMP2_CONFIG, 0x00);=0A=
=0A=
		if (type !=3D w83783s && type !=3D w83697hf && type !=3D as99127f) {=0A=
			w83781d_write_value(client, W83781D_REG_TEMP3_OVER,=0A=
					    TEMP_ADD_TO_REG=0A=
					    (W83781D_INIT_TEMP3_OVER));=0A=
			w83781d_write_value(client, W83781D_REG_TEMP3_HYST,=0A=
					    TEMP_ADD_TO_REG=0A=
					    (W83781D_INIT_TEMP3_HYST));=0A=
			w83781d_write_value(client, W83781D_REG_TEMP3_CONFIG,=0A=
					    0x00);=0A=
		}=0A=
		if (type !=3D w83781d) {=0A=
			/* enable PWM2 control (can't hurt since PWM reg=0A=
		           should have been reset to 0xff) */=0A=
			w83781d_write_value(client, W83781D_REG_PWMCLK12, 0x19);=0A=
			/* enable comparator mode for temp2 and temp3 so=0A=
		           alarm indication will work correctly */=0A=
			w83781d_write_value(client, W83781D_REG_IRQ, 0x41);=0A=
		}=0A=
	}=0A=
=0A=
	/* Start monitoring */=0A=
	w83781d_write_value(client, W83781D_REG_CONFIG,=0A=
			    (w83781d_read_value(client,=0A=
						W83781D_REG_CONFIG) & 0xf7)=0A=
			    | 0x01);=0A=
}=0A=
=0A=
void w83781d_update_client(struct i2c_client *client)=0A=
{=0A=
	struct w83781d_data *data =3D client->data;=0A=
	int i;=0A=
=0A=
	down(&data->update_lock);=0A=
=0A=
	if ((jiffies - data->last_updated > HZ + HZ / 2) ||=0A=
	    (jiffies < data->last_updated) || !data->valid) {=0A=
=0A=
#ifdef DEBUG=0A=
		printk(KERN_DEBUG "Starting device update\n");=0A=
#endif=0A=
		for (i =3D 0; i <=3D 8; i++) {=0A=
			if ((data->type =3D=3D w83783s || data->type =3D=3D w83697hf)=0A=
			    && (i =3D=3D 1))=0A=
				continue;	/* 783S has no in1 */=0A=
			data->in[i] =3D=0A=
			    w83781d_read_value(client, W83781D_REG_IN(i));=0A=
			data->in_min[i] =3D=0A=
			    w83781d_read_value(client,=0A=
					       W83781D_REG_IN_MIN(i));=0A=
			data->in_max[i] =3D=0A=
			    w83781d_read_value(client,=0A=
					       W83781D_REG_IN_MAX(i));=0A=
			if ((data->type !=3D w83782d) && (data->type !=3D w83697hf)=0A=
			    && (data->type !=3D w83627hf) && (i =3D=3D 6))=0A=
				break;=0A=
		}=0A=
		for (i =3D 1; i <=3D 3; i++) {=0A=
			data->fan[i - 1] =3D=0A=
			    w83781d_read_value(client, W83781D_REG_FAN(i));=0A=
			data->fan_min[i - 1] =3D=0A=
			    w83781d_read_value(client,=0A=
					       W83781D_REG_FAN_MIN(i));=0A=
		}=0A=
		if (data->type !=3D w83781d) {=0A=
			for (i =3D 1; i <=3D 4; i++) {=0A=
				data->pwm[i - 1] =3D=0A=
				    w83781d_read_value(client,=0A=
						       W83781D_REG_PWM(i));=0A=
				if (((data->type =3D=3D w83783s)=0A=
				     || (data->type =3D=3D w83627hf)=0A=
				     || (data->type =3D=3D as99127f)=0A=
				     || (data->type =3D=3D w83697hf)=0A=
				     || ((data->type =3D=3D w83782d)=0A=
				        && i2c_is_isa_client(client)))=0A=
				    && i =3D=3D 2)=0A=
					break;=0A=
			}=0A=
		}=0A=
=0A=
		data->temp =3D w83781d_read_value(client, W83781D_REG_TEMP);=0A=
		data->temp_over =3D=0A=
		    w83781d_read_value(client, W83781D_REG_TEMP_OVER);=0A=
		data->temp_hyst =3D=0A=
		    w83781d_read_value(client, W83781D_REG_TEMP_HYST);=0A=
=0A=
		if (data->type =3D=3D as99127f) {=0A=
			data->temp2 =3D w83781d_read_value(client, AS99127_REG_TEMP);=0A=
			data->temp2_over =3D=0A=
			    w83781d_read_value(client, AS99127_REG_TEMP_OVER);=0A=
			data->temp2_hyst =3D=0A=
			    w83781d_read_value(client, AS99127_REG_TEMP_HYST);=0A=
		}=0A=
		=0A=
		data->temp_add[0] =3D=0A=
		    w83781d_read_value(client, W83781D_REG_TEMP2);=0A=
		data->temp_add_over[0] =3D=0A=
		    w83781d_read_value(client, W83781D_REG_TEMP2_OVER);=0A=
		data->temp_add_hyst[0] =3D=0A=
		    w83781d_read_value(client, W83781D_REG_TEMP2_HYST);=0A=
=0A=
		if (data->type !=3D w83783s && data->type !=3D w83697hf && data->type =
!=3D as99127f) {=0A=
			data->temp_add[1] =3D=0A=
			    w83781d_read_value(client, W83781D_REG_TEMP3);=0A=
			data->temp_add_over[1] =3D=0A=
			    w83781d_read_value(client, W83781D_REG_TEMP3_OVER);=0A=
			data->temp_add_hyst[1] =3D=0A=
			    w83781d_read_value(client, W83781D_REG_TEMP3_HYST);=0A=
		}=0A=
		i =3D w83781d_read_value(client, W83781D_REG_VID_FANDIV);=0A=
		if (data->type !=3D w83697hf) {=0A=
			data->vid =3D i & 0x0f;=0A=
			data->vid |=3D=0A=
			    (w83781d_read_value(client, W83781D_REG_CHIPID) & 0x01)=0A=
			    << 4;=0A=
		}=0A=
		data->fan_div[0] =3D (i >> 4) & 0x03;=0A=
		data->fan_div[1] =3D (i >> 6) & 0x03;=0A=
		if (data->type !=3D w83697hf) {=0A=
			data->fan_div[2] =3D (w83781d_read_value(client,=0A=
					       W83781D_REG_PIN) >> 6) & 0x03;=0A=
		}=0A=
		if ((data->type !=3D w83781d) && (data->type !=3D as99127f)) {=0A=
			i =3D w83781d_read_value(client, W83781D_REG_VBAT);=0A=
			data->fan_div[0] |=3D (i >> 3) & 0x04;=0A=
			data->fan_div[1] |=3D (i >> 4) & 0x04;=0A=
			if (data->type !=3D w83697hf)=0A=
				data->fan_div[2] |=3D (i >> 5) & 0x04;=0A=
		}=0A=
		data->alarms =3D=0A=
		    w83781d_read_value(client,=0A=
				       W83781D_REG_ALARM1) +=0A=
		    (w83781d_read_value(client, W83781D_REG_ALARM2) << 8);=0A=
		if ((data->type =3D=3D w83782d) || (data->type =3D=3D w83627hf)) {=0A=
			data->alarms |=3D=0A=
			    w83781d_read_value(client,=0A=
					       W83781D_REG_ALARM3) << 16;=0A=
		}=0A=
		i =3D w83781d_read_value(client, W83781D_REG_BEEP_INTS2);=0A=
		data->beep_enable =3D i >> 7;=0A=
		data->beeps =3D ((i & 0x7f) << 8) +=0A=
		    w83781d_read_value(client, W83781D_REG_BEEP_INTS1);=0A=
		if ((data->type !=3D w83781d) && (data->type !=3D as99127f)) {=0A=
			data->beeps |=3D=0A=
			    w83781d_read_value(client,=0A=
					       W83781D_REG_BEEP_INTS3) << 16;=0A=
		}=0A=
		data->last_updated =3D jiffies;=0A=
		data->valid =3D 1;=0A=
	}=0A=
=0A=
	up(&data->update_lock);=0A=
}=0A=
=0A=
=0A=
/* The next few functions are the call-back functions of the /proc/sys =
and=0A=
   sysctl files. Which function is used is defined in the ctl_table in=0A=
   the extra1 field.=0A=
   Each function must return the magnitude (power of 10 to divide the =
date=0A=
   with) if it is called with operation=3D=3DSENSORS_PROC_REAL_INFO. It =
must=0A=
   put a maximum of *nrels elements in results reflecting the data of =
this=0A=
   file, and set *nrels to the number it actually put in it, if =
operation=3D=3D=0A=
   SENSORS_PROC_REAL_READ. Finally, it must get upto *nrels elements from=0A=
   results and write them to the chip, if =
operations=3D=3DSENSORS_PROC_REAL_WRITE.=0A=
   Note that on SENSORS_PROC_REAL_READ, I do not check whether results is=0A=
   large enough (by checking the incoming value of *nrels). This is not =
very=0A=
   good practice, but as long as you put less than about 5 values in =
results,=0A=
   you can assume it is large enough. */=0A=
void w83781d_in(struct i2c_client *client, int operation, int ctl_name,=0A=
		int *nrels_mag, long *results)=0A=
{=0A=
	struct w83781d_data *data =3D client->data;=0A=
	int nr =3D ctl_name - W83781D_SYSCTL_IN0;=0A=
=0A=
	if (operation =3D=3D SENSORS_PROC_REAL_INFO)=0A=
		*nrels_mag =3D 2;=0A=
	else if (operation =3D=3D SENSORS_PROC_REAL_READ) {=0A=
		w83781d_update_client(client);=0A=
		results[0] =3D IN_FROM_REG(data->in_min[nr]);=0A=
		results[1] =3D IN_FROM_REG(data->in_max[nr]);=0A=
		results[2] =3D IN_FROM_REG(data->in[nr]);=0A=
		*nrels_mag =3D 3;=0A=
	} else if (operation =3D=3D SENSORS_PROC_REAL_WRITE) {=0A=
		if (*nrels_mag >=3D 1) {=0A=
			data->in_min[nr] =3D IN_TO_REG(results[0]);=0A=
			w83781d_write_value(client, W83781D_REG_IN_MIN(nr),=0A=
					    data->in_min[nr]);=0A=
		}=0A=
		if (*nrels_mag >=3D 2) {=0A=
			data->in_max[nr] =3D IN_TO_REG(results[1]);=0A=
			w83781d_write_value(client, W83781D_REG_IN_MAX(nr),=0A=
					    data->in_max[nr]);=0A=
		}=0A=
	}=0A=
}=0A=
=0A=
void w83781d_fan(struct i2c_client *client, int operation, int ctl_name,=0A=
		 int *nrels_mag, long *results)=0A=
{=0A=
	struct w83781d_data *data =3D client->data;=0A=
	int nr =3D ctl_name - W83781D_SYSCTL_FAN1 + 1;=0A=
=0A=
	if (operation =3D=3D SENSORS_PROC_REAL_INFO)=0A=
		*nrels_mag =3D 0;=0A=
	else if (operation =3D=3D SENSORS_PROC_REAL_READ) {=0A=
		w83781d_update_client(client);=0A=
		results[0] =3D FAN_FROM_REG(data->fan_min[nr - 1],=0A=
				  DIV_FROM_REG(data->fan_div[nr - 1]));=0A=
		results[1] =3D FAN_FROM_REG(data->fan[nr - 1],=0A=
			          DIV_FROM_REG(data->fan_div[nr - 1]));=0A=
		*nrels_mag =3D 2;=0A=
	} else if (operation =3D=3D SENSORS_PROC_REAL_WRITE) {=0A=
		if (*nrels_mag >=3D 1) {=0A=
			data->fan_min[nr - 1] =3D=0A=
			     FAN_TO_REG(results[0],=0A=
			            DIV_FROM_REG(data->fan_div[nr-1]));=0A=
			w83781d_write_value(client,=0A=
					    W83781D_REG_FAN_MIN(nr),=0A=
					    data->fan_min[nr - 1]);=0A=
		}=0A=
	}=0A=
}=0A=
=0A=
void w83781d_temp(struct i2c_client *client, int operation, int ctl_name,=0A=
		  int *nrels_mag, long *results)=0A=
{=0A=
	struct w83781d_data *data =3D client->data;=0A=
	int nr =3D ctl_name - W83781D_SYSCTL_TEMP1;=0A=
=0A=
	if (nr=3D=3D0) {=0A=
		if (operation =3D=3D SENSORS_PROC_REAL_INFO)=0A=
			*nrels_mag =3D 1;=0A=
		else if (operation =3D=3D SENSORS_PROC_REAL_READ) {=0A=
			w83781d_update_client(client);=0A=
			results[0] =3D TEMP_FROM_REG(data->temp_over);=0A=
			results[1] =3D TEMP_FROM_REG(data->temp_hyst);=0A=
			results[2] =3D TEMP_FROM_REG(data->temp);=0A=
			*nrels_mag =3D 3;=0A=
		} else if (operation =3D=3D SENSORS_PROC_REAL_WRITE) {=0A=
			if (*nrels_mag >=3D 1) {=0A=
				data->temp_over =3D TEMP_TO_REG(results[0]);=0A=
				w83781d_write_value(client, W83781D_REG_TEMP_OVER,=0A=
						    data->temp_over);=0A=
			}=0A=
			if (*nrels_mag >=3D 2) {=0A=
				data->temp_hyst =3D TEMP_TO_REG(results[1]);=0A=
				w83781d_write_value(client, W83781D_REG_TEMP_HYST,=0A=
						    data->temp_hyst);=0A=
			}=0A=
		}=0A=
	} else {=0A=
		if (operation =3D=3D SENSORS_PROC_REAL_INFO)=0A=
			*nrels_mag =3D 1;=0A=
		else if (operation =3D=3D SENSORS_PROC_REAL_READ) {=0A=
			w83781d_update_client(client);=0A=
			results[0] =3D TEMP_FROM_REG(data->temp2_over);=0A=
			results[1] =3D TEMP_FROM_REG(data->temp2_hyst);=0A=
			results[2] =3D TEMP_FROM_REG(data->temp2);=0A=
			*nrels_mag =3D 3;=0A=
		} else if (operation =3D=3D SENSORS_PROC_REAL_WRITE) {=0A=
			if (*nrels_mag >=3D 1) {=0A=
				data->temp2_over =3D TEMP_TO_REG(results[0]);=0A=
				w83781d_write_value(client, AS99127_REG_TEMP_OVER,=0A=
						    data->temp2_over);=0A=
			}=0A=
			if (*nrels_mag >=3D 2) {=0A=
				data->temp2_hyst =3D TEMP_TO_REG(results[1]);=0A=
				w83781d_write_value(client, AS99127_REG_TEMP_HYST,=0A=
						    data->temp2_hyst);=0A=
			}=0A=
		}=0A=
	}=0A=
}=0A=
=0A=
void w83781d_temp_add(struct i2c_client *client, int operation,=0A=
		      int ctl_name, int *nrels_mag, long *results)=0A=
{=0A=
	struct w83781d_data *data =3D client->data;=0A=
	int nr =3D ctl_name - W83781D_SYSCTL_TEMP2;=0A=
=0A=
	if (data->type =3D=3D as99127f)=0A=
		nr--;=0A=
=0A=
	if (operation =3D=3D SENSORS_PROC_REAL_INFO)=0A=
		*nrels_mag =3D 1;=0A=
	else if (operation =3D=3D SENSORS_PROC_REAL_READ) {=0A=
		w83781d_update_client(client);=0A=
=0A=
		results[0] =3D=0A=
		    TEMP_ADD_FROM_REG(data->temp_add_over[nr]);=0A=
		results[1] =3D=0A=
		    TEMP_ADD_FROM_REG(data->temp_add_hyst[nr]);=0A=
		results[2] =3D TEMP_ADD_FROM_REG(data->temp_add[nr]);=0A=
=0A=
		*nrels_mag =3D 3;=0A=
	} else if (operation =3D=3D SENSORS_PROC_REAL_WRITE) {=0A=
		if (*nrels_mag >=3D 1) {=0A=
			data->temp_add_over[nr] =3D=0A=
			    TEMP_ADD_TO_REG(results[0]);=0A=
=0A=
			w83781d_write_value(client,=0A=
			    nr ? W83781D_REG_TEMP3_OVER :=0A=
			    W83781D_REG_TEMP2_OVER,=0A=
			    data->temp_add_over[nr]);=0A=
		}=0A=
		if (*nrels_mag >=3D 2) {=0A=
			data->temp_add_hyst[nr] =3D=0A=
			    TEMP_ADD_TO_REG(results[1]);=0A=
			w83781d_write_value(client,=0A=
			    nr ? W83781D_REG_TEMP3_HYST :=0A=
			    W83781D_REG_TEMP2_HYST,=0A=
			    data->temp_add_hyst[nr]);=0A=
		}=0A=
	}=0A=
}=0A=
=0A=
=0A=
void w83781d_vid(struct i2c_client *client, int operation, int ctl_name,=0A=
		 int *nrels_mag, long *results)=0A=
{=0A=
	struct w83781d_data *data =3D client->data;=0A=
	if (operation =3D=3D SENSORS_PROC_REAL_INFO)=0A=
		*nrels_mag =3D 3;=0A=
	else if (operation =3D=3D SENSORS_PROC_REAL_READ) {=0A=
		w83781d_update_client(client);=0A=
		results[0] =3D vid_from_reg(data->vid, data->vrm);=0A=
		*nrels_mag =3D 1;=0A=
	}=0A=
}=0A=
=0A=
void w83781d_vrm(struct i2c_client *client, int operation, int ctl_name,=0A=
		 int *nrels_mag, long *results)=0A=
{=0A=
	struct w83781d_data *data =3D client->data;=0A=
	if (operation =3D=3D SENSORS_PROC_REAL_INFO)=0A=
		*nrels_mag =3D 1;=0A=
	else if (operation =3D=3D SENSORS_PROC_REAL_READ) {=0A=
		results[0] =3D data->vrm;=0A=
		*nrels_mag =3D 1;=0A=
	} else if (operation =3D=3D SENSORS_PROC_REAL_WRITE) {=0A=
		if (*nrels_mag >=3D 1)=0A=
			data->vrm =3D results[0];=0A=
	}=0A=
}=0A=
=0A=
void w83781d_alarms(struct i2c_client *client, int operation, int =
ctl_name,=0A=
		    int *nrels_mag, long *results)=0A=
{=0A=
	struct w83781d_data *data =3D client->data;=0A=
	if (operation =3D=3D SENSORS_PROC_REAL_INFO)=0A=
		*nrels_mag =3D 0;=0A=
	else if (operation =3D=3D SENSORS_PROC_REAL_READ) {=0A=
		w83781d_update_client(client);=0A=
		results[0] =3D ALARMS_FROM_REG(data->alarms);=0A=
		*nrels_mag =3D 1;=0A=
	}=0A=
}=0A=
=0A=
void w83781d_beep(struct i2c_client *client, int operation, int ctl_name,=0A=
		  int *nrels_mag, long *results)=0A=
{=0A=
	struct w83781d_data *data =3D client->data;=0A=
	int val;=0A=
=0A=
	if (operation =3D=3D SENSORS_PROC_REAL_INFO)=0A=
		*nrels_mag =3D 0;=0A=
	else if (operation =3D=3D SENSORS_PROC_REAL_READ) {=0A=
		w83781d_update_client(client);=0A=
		results[0] =3D BEEP_ENABLE_FROM_REG(data->beep_enable);=0A=
		results[1] =3D BEEPS_FROM_REG(data->beeps);=0A=
		*nrels_mag =3D 2;=0A=
	} else if (operation =3D=3D SENSORS_PROC_REAL_WRITE) {=0A=
		if (*nrels_mag >=3D 2) {=0A=
			data->beeps =3D BEEPS_TO_REG(results[1]);=0A=
			w83781d_write_value(client, W83781D_REG_BEEP_INTS1,=0A=
					    data->beeps & 0xff);=0A=
			if ((data->type !=3D w83781d) &&=0A=
			    (data->type !=3D as99127f)) {=0A=
				w83781d_write_value(client,=0A=
						    W83781D_REG_BEEP_INTS3,=0A=
						    ((data-> beeps) >> 16) &=0A=
						      0xff);=0A=
			}=0A=
			val =3D (data->beeps >> 8) & 0x7f;=0A=
		} else if (*nrels_mag >=3D 1)=0A=
			val =3D=0A=
			    w83781d_read_value(client,=0A=
					       W83781D_REG_BEEP_INTS2) &=0A=
			    0x7f;=0A=
		if (*nrels_mag >=3D 1) {=0A=
			data->beep_enable =3D BEEP_ENABLE_TO_REG(results[0]);=0A=
			w83781d_write_value(client, W83781D_REG_BEEP_INTS2,=0A=
					    val | data->beep_enable << 7);=0A=
		}=0A=
	}=0A=
}=0A=
=0A=
/* w83697hf only has two fans */=0A=
void w83781d_fan_div(struct i2c_client *client, int operation,=0A=
		     int ctl_name, int *nrels_mag, long *results)=0A=
{=0A=
	struct w83781d_data *data =3D client->data;=0A=
	int old, old2, old3 =3D 0;=0A=
=0A=
	if (operation =3D=3D SENSORS_PROC_REAL_INFO)=0A=
		*nrels_mag =3D 0;=0A=
	else if (operation =3D=3D SENSORS_PROC_REAL_READ) {=0A=
		w83781d_update_client(client);=0A=
		results[0] =3D DIV_FROM_REG(data->fan_div[0]);=0A=
		results[1] =3D DIV_FROM_REG(data->fan_div[1]);=0A=
		if (data->type =3D=3D w83697hf) {=0A=
			*nrels_mag =3D 2;=0A=
		} else {=0A=
			results[2] =3D DIV_FROM_REG(data->fan_div[2]);=0A=
			*nrels_mag =3D 3;=0A=
		}=0A=
	} else if (operation =3D=3D SENSORS_PROC_REAL_WRITE) {=0A=
		old =3D w83781d_read_value(client, W83781D_REG_VID_FANDIV);=0A=
		/* w83781d and as99127f don't have extended divisor bits */=0A=
		if ((data->type !=3D w83781d) && data->type !=3D as99127f) {=0A=
			old3 =3D=0A=
			    w83781d_read_value(client, W83781D_REG_VBAT);=0A=
		}=0A=
		if (*nrels_mag >=3D 3 && data->type !=3D w83697hf) {=0A=
			data->fan_div[2] =3D=0A=
			    DIV_TO_REG(results[2], data->type);=0A=
			old2 =3D w83781d_read_value(client, W83781D_REG_PIN);=0A=
			old2 =3D=0A=
			    (old2 & 0x3f) | ((data->fan_div[2] & 0x03) << 6);=0A=
			w83781d_write_value(client, W83781D_REG_PIN, old2);=0A=
			if ((data->type !=3D w83781d) &&=0A=
			    (data->type !=3D as99127f)) {=0A=
				old3 =3D=0A=
				    (old3 & 0x7f) |=0A=
				    ((data->fan_div[2] & 0x04) << 5);=0A=
			}=0A=
		}=0A=
		if (*nrels_mag >=3D 2) {=0A=
			data->fan_div[1] =3D=0A=
			    DIV_TO_REG(results[1], data->type);=0A=
			old =3D=0A=
			    (old & 0x3f) | ((data->fan_div[1] & 0x03) << 6);=0A=
			if ((data->type !=3D w83781d) &&=0A=
			    (data->type !=3D as99127f)) {=0A=
				old3 =3D=0A=
				    (old3 & 0xbf) |=0A=
				    ((data->fan_div[1] & 0x04) << 4);=0A=
			}=0A=
		}=0A=
		if (*nrels_mag >=3D 1) {=0A=
			data->fan_div[0] =3D=0A=
			    DIV_TO_REG(results[0], data->type);=0A=
			old =3D=0A=
			    (old & 0xcf) | ((data->fan_div[0] & 0x03) << 4);=0A=
			w83781d_write_value(client, W83781D_REG_VID_FANDIV,=0A=
					    old);=0A=
			if ((data->type !=3D w83781d) &&=0A=
			    (data->type !=3D as99127f)) {=0A=
				old3 =3D=0A=
				    (old3 & 0xdf) |=0A=
				    ((data->fan_div[0] & 0x04) << 3);=0A=
				w83781d_write_value(client,=0A=
						    W83781D_REG_VBAT,=0A=
						    old3);=0A=
			}=0A=
		}=0A=
	}=0A=
}=0A=
=0A=
void w83781d_pwm(struct i2c_client *client, int operation, int ctl_name,=0A=
		 int *nrels_mag, long *results)=0A=
{=0A=
	struct w83781d_data *data =3D client->data;=0A=
	int nr =3D 1 + ctl_name - W83781D_SYSCTL_PWM1;=0A=
=0A=
	if (operation =3D=3D SENSORS_PROC_REAL_INFO)=0A=
		*nrels_mag =3D 0;=0A=
	else if (operation =3D=3D SENSORS_PROC_REAL_READ) {=0A=
		w83781d_update_client(client);=0A=
		results[0] =3D PWM_FROM_REG(data->pwm[nr - 1]);=0A=
		*nrels_mag =3D 1;=0A=
	} else if (operation =3D=3D SENSORS_PROC_REAL_WRITE) {=0A=
		if (*nrels_mag >=3D 1) {=0A=
			data->pwm[nr - 1] =3D PWM_TO_REG(results[0]);=0A=
			w83781d_write_value(client, W83781D_REG_PWM(nr),=0A=
					    data->pwm[nr - 1]);=0A=
		}=0A=
	}=0A=
}=0A=
=0A=
void w83781d_sens(struct i2c_client *client, int operation, int ctl_name,=0A=
		  int *nrels_mag, long *results)=0A=
{=0A=
	struct w83781d_data *data =3D client->data;=0A=
	int nr =3D 1 + ctl_name - W83781D_SYSCTL_SENS1;=0A=
	u8 tmp;=0A=
=0A=
	if (operation =3D=3D SENSORS_PROC_REAL_INFO)=0A=
		*nrels_mag =3D 0;=0A=
	else if (operation =3D=3D SENSORS_PROC_REAL_READ) {=0A=
		results[0] =3D data->sens[nr - 1];=0A=
		*nrels_mag =3D 1;=0A=
	} else if (operation =3D=3D SENSORS_PROC_REAL_WRITE) {=0A=
		if (*nrels_mag >=3D 1) {=0A=
			switch (results[0]) {=0A=
			case 1:	/* PII/Celeron diode */=0A=
				tmp =3D w83781d_read_value(client,=0A=
						       W83781D_REG_SCFG1);=0A=
				w83781d_write_value(client,=0A=
						    W83781D_REG_SCFG1,=0A=
						    tmp | BIT_SCFG1[nr -=0A=
								    1]);=0A=
				tmp =3D w83781d_read_value(client,=0A=
						       W83781D_REG_SCFG2);=0A=
				w83781d_write_value(client,=0A=
						    W83781D_REG_SCFG2,=0A=
						    tmp | BIT_SCFG2[nr -=0A=
								    1]);=0A=
				data->sens[nr - 1] =3D results[0];=0A=
				break;=0A=
			case 2:	/* 3904 */=0A=
				tmp =3D w83781d_read_value(client,=0A=
						       W83781D_REG_SCFG1);=0A=
				w83781d_write_value(client,=0A=
						    W83781D_REG_SCFG1,=0A=
						    tmp | BIT_SCFG1[nr -=0A=
								    1]);=0A=
				tmp =3D w83781d_read_value(client,=0A=
						       W83781D_REG_SCFG2);=0A=
				w83781d_write_value(client,=0A=
						    W83781D_REG_SCFG2,=0A=
						    tmp & ~BIT_SCFG2[nr -=0A=
								     1]);=0A=
				data->sens[nr - 1] =3D results[0];=0A=
				break;=0A=
			case W83781D_DEFAULT_BETA:	/* thermistor */=0A=
				tmp =3D w83781d_read_value(client,=0A=
						       W83781D_REG_SCFG1);=0A=
				w83781d_write_value(client,=0A=
						    W83781D_REG_SCFG1,=0A=
						    tmp & ~BIT_SCFG1[nr -=0A=
								     1]);=0A=
				data->sens[nr - 1] =3D results[0];=0A=
				break;=0A=
			default:=0A=
				printk=0A=
				    (KERN_ERR "w83781d.o: Invalid sensor type %ld; must be 1, 2, or =
%d\n",=0A=
				     results[0], W83781D_DEFAULT_BETA);=0A=
				break;=0A=
			}=0A=
		}=0A=
	}=0A=
}=0A=
=0A=
#ifdef W83781D_RT=0A=
void w83781d_rt(struct i2c_client *client, int operation, int ctl_name,=0A=
		int *nrels_mag, long *results)=0A=
{=0A=
	struct w83781d_data *data =3D client->data;=0A=
	int nr =3D 1 + ctl_name - W83781D_SYSCTL_RT1;=0A=
	int i;=0A=
=0A=
	if (operation =3D=3D SENSORS_PROC_REAL_INFO)=0A=
		*nrels_mag =3D 0;=0A=
	else if (operation =3D=3D SENSORS_PROC_REAL_READ) {=0A=
		for (i =3D 0; i < 32; i++) {=0A=
			results[i] =3D data->rt[nr - 1][i];=0A=
		}=0A=
		*nrels_mag =3D 32;=0A=
	} else if (operation =3D=3D SENSORS_PROC_REAL_WRITE) {=0A=
		if (*nrels_mag > 32)=0A=
			*nrels_mag =3D 32;=0A=
		for (i =3D 0; i < *nrels_mag; i++) {=0A=
			/* fixme: no bounds checking 0-255 */=0A=
			data->rt[nr - 1][i] =3D results[i];=0A=
			w83781d_write_value(client, W83781D_REG_RT_IDX, i);=0A=
			w83781d_write_value(client, W83781D_REG_RT_VAL,=0A=
					    data->rt[nr - 1][i]);=0A=
		}=0A=
	}=0A=
}=0A=
#endif=0A=
=0A=
int __init sensors_w83781d_init(void)=0A=
{=0A=
	int res;=0A=
=0A=
	printk(KERN_INFO "w83781d.o version %s (%s)\n", LM_VERSION, LM_DATE);=0A=
	w83781d_initialized =3D 0;=0A=
=0A=
	if ((res =3D i2c_add_driver(&w83781d_driver))) {=0A=
		printk=0A=
		    (KERN_ERR "w83781d.o: Driver registration failed, module not =
inserted.\n");=0A=
		w83781d_cleanup();=0A=
		return res;=0A=
	}=0A=
	w83781d_initialized++;=0A=
	return 0;=0A=
}=0A=
=0A=
int __init w83781d_cleanup(void)=0A=
{=0A=
	int res;=0A=
=0A=
	if (w83781d_initialized >=3D 1) {=0A=
		if ((res =3D i2c_del_driver(&w83781d_driver))) {=0A=
			printk=0A=
			    (KERN_ERR "w83781d.o: Driver deregistration failed, module not =
removed.\n");=0A=
			return res;=0A=
		}=0A=
		w83781d_initialized--;=0A=
	}=0A=
	return 0;=0A=
}=0A=
=0A=
EXPORT_NO_SYMBOLS;=0A=
=0A=
#ifdef MODULE=0A=
=0A=
MODULE_AUTHOR("Frodo Looijaard <frodol@dds.nl>, "=0A=
	      "Philip Edelbrock <phil@netroedge.com>, "=0A=
	      "and Mark Studebaker <mdsxyz123@yahoo.com>");=0A=
MODULE_DESCRIPTION("W83781D driver");=0A=
#ifdef MODULE_LICENSE=0A=
MODULE_LICENSE("GPL");=0A=
#endif=0A=
=0A=
=0A=
int init_module(void)=0A=
{=0A=
	return sensors_w83781d_init();=0A=
}=0A=
=0A=
int cleanup_module(void)=0A=
{=0A=
	return w83781d_cleanup();=0A=
}=0A=
=0A=
#endif				/* MODULE */=0A=

------=_NextPart_000_00FD_01C2DDEC.F3668DC0
Content-Type: application/octet-stream; name="w83781d.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="w83781d.diff"

--- w83781d.orig.c	Sun Sep 22 00:11:56 2002=0A=
+++ w83781d.c	Wed Feb 26 23:04:31 2003=0A=
@@ -111,6 +111,10 @@=0A=
 #define W83781D_REG_TEMP_HYST 0x3A=0A=
 #define W83781D_REG_BANK 0x4E=0A=
 =0A=
+#define AS99127_REG_TEMP 0x17=0A=
+#define AS99127_REG_TEMP_OVER 0x19 // who guess right?=0A=
+#define AS99127_REG_TEMP_HYST 0x1A // who guess right?=0A=
+=0A=
 #define W83781D_REG_CONFIG 0x40=0A=
 #define W83781D_REG_ALARM1 0x41=0A=
 #define W83781D_REG_ALARM2 0x42=0A=
@@ -188,10 +192,6 @@=0A=
                                               0,0xffff))=0A=
 #define TEMP_ADD_FROM_REG(val) (((val) >> 7) * 5)=0A=
 =0A=
-#define AS99127_TEMP_ADD_TO_REG(val) (SENSORS_LIMIT((((((val) + =
2)*4)/10) \=0A=
-                                               << 7),0,0xffff))=0A=
-#define AS99127_TEMP_ADD_FROM_REG(val) ((((val) >> 7) * 10) / 4)=0A=
-=0A=
 #define ALARMS_FROM_REG(val) (val)=0A=
 #define PWM_FROM_REG(val) (val)=0A=
 #define PWM_TO_REG(val) (SENSORS_LIMIT((val),0,255))=0A=
@@ -307,6 +307,8 @@=0A=
 #define W83781D_INIT_FAN_MIN_2 3000=0A=
 #define W83781D_INIT_FAN_MIN_3 3000=0A=
 =0A=
+#define AS99127_INIT_TEMP_OVER 600=0A=
+#define AS99127_INIT_TEMP_HYST 1270=0A=
 #define W83781D_INIT_TEMP_OVER 600=0A=
 #define W83781D_INIT_TEMP_HYST 1270	/* must be 127 for ALARM to work */=0A=
 #define W83781D_INIT_TEMP2_OVER 600=0A=
@@ -358,6 +360,9 @@=0A=
 	u8 temp;=0A=
 	u8 temp_over;		/* Register value */=0A=
 	u8 temp_hyst;		/* Register value */=0A=
+	u8 temp2;=0A=
+	u8 temp2_over;		/* Register value */=0A=
+	u8 temp2_hyst;		/* Register value */=0A=
 	u16 temp_add[2];	/* Register value */=0A=
 	u16 temp_add_over[2];	/* Register value */=0A=
 	u16 temp_add_hyst[2];	/* Register value */=0A=
@@ -479,7 +484,7 @@=0A=
 	{W83781D_SYSCTL_TEMP1, "temp1", NULL, 0, 0644, NULL, &i2c_proc_real,=0A=
 	 &i2c_sysctl_real, NULL, &w83781d_temp},=0A=
 	{W83781D_SYSCTL_TEMP2, "temp2", NULL, 0, 0644, NULL, &i2c_proc_real,=0A=
-	 &i2c_sysctl_real, NULL, &w83781d_temp_add},=0A=
+	 &i2c_sysctl_real, NULL, &w83781d_temp},=0A=
 	{W83781D_SYSCTL_TEMP3, "temp3", NULL, 0, 0644, NULL, &i2c_proc_real,=0A=
 	 &i2c_sysctl_real, NULL, &w83781d_temp_add},=0A=
 	{W83781D_SYSCTL_VID, "vid", NULL, 0, 0444, NULL, &i2c_proc_real,=0A=
@@ -1423,38 +1428,28 @@=0A=
 				    TEMP_TO_REG(W83781D_INIT_TEMP_HYST));=0A=
 =0A=
 		if (type =3D=3D as99127f) {=0A=
-			w83781d_write_value(client, W83781D_REG_TEMP2_OVER,=0A=
-					    AS99127_TEMP_ADD_TO_REG=0A=
-					    (W83781D_INIT_TEMP2_OVER));=0A=
-			w83781d_write_value(client, W83781D_REG_TEMP2_HYST,=0A=
-					    AS99127_TEMP_ADD_TO_REG=0A=
-					    (W83781D_INIT_TEMP2_HYST));=0A=
-		} else {=0A=
-			w83781d_write_value(client, W83781D_REG_TEMP2_OVER,=0A=
-					    TEMP_ADD_TO_REG=0A=
-					    (W83781D_INIT_TEMP2_OVER));=0A=
-			w83781d_write_value(client, W83781D_REG_TEMP2_HYST,=0A=
-					    TEMP_ADD_TO_REG=0A=
-					    (W83781D_INIT_TEMP2_HYST));=0A=
+			w83781d_write_value(client, AS99127_REG_TEMP_OVER,=0A=
+					    TEMP_TO_REG(AS99127_INIT_TEMP_OVER));=0A=
+			w83781d_write_value(client, AS99127_REG_TEMP_HYST,=0A=
+					    TEMP_TO_REG(AS99127_INIT_TEMP_HYST));=0A=
 		}=0A=
+=0A=
+		w83781d_write_value(client, W83781D_REG_TEMP2_OVER,=0A=
+				    TEMP_ADD_TO_REG=0A=
+				    (W83781D_INIT_TEMP2_OVER));=0A=
+		w83781d_write_value(client, W83781D_REG_TEMP2_HYST,=0A=
+				    TEMP_ADD_TO_REG=0A=
+				    (W83781D_INIT_TEMP2_HYST));=0A=
+=0A=
 		w83781d_write_value(client, W83781D_REG_TEMP2_CONFIG, 0x00);=0A=
 =0A=
-		if (type =3D=3D as99127f) {=0A=
-			w83781d_write_value(client, W83781D_REG_TEMP3_OVER,=0A=
-					    AS99127_TEMP_ADD_TO_REG=0A=
-					    (W83781D_INIT_TEMP3_OVER));=0A=
-			w83781d_write_value(client, W83781D_REG_TEMP3_HYST,=0A=
-					    AS99127_TEMP_ADD_TO_REG=0A=
-					    (W83781D_INIT_TEMP3_HYST));=0A=
-		} else if (type !=3D w83783s && type !=3D w83697hf) {=0A=
+		if (type !=3D w83783s && type !=3D w83697hf && type !=3D as99127f) {=0A=
 			w83781d_write_value(client, W83781D_REG_TEMP3_OVER,=0A=
 					    TEMP_ADD_TO_REG=0A=
 					    (W83781D_INIT_TEMP3_OVER));=0A=
 			w83781d_write_value(client, W83781D_REG_TEMP3_HYST,=0A=
 					    TEMP_ADD_TO_REG=0A=
 					    (W83781D_INIT_TEMP3_HYST));=0A=
-		}=0A=
-		if (type !=3D w83783s && type !=3D w83697hf) {=0A=
 			w83781d_write_value(client, W83781D_REG_TEMP3_CONFIG,=0A=
 					    0x00);=0A=
 		}=0A=
@@ -1532,13 +1527,23 @@=0A=
 		    w83781d_read_value(client, W83781D_REG_TEMP_OVER);=0A=
 		data->temp_hyst =3D=0A=
 		    w83781d_read_value(client, W83781D_REG_TEMP_HYST);=0A=
+=0A=
+		if (data->type =3D=3D as99127f) {=0A=
+			data->temp2 =3D w83781d_read_value(client, AS99127_REG_TEMP);=0A=
+			data->temp2_over =3D=0A=
+			    w83781d_read_value(client, AS99127_REG_TEMP_OVER);=0A=
+			data->temp2_hyst =3D=0A=
+			    w83781d_read_value(client, AS99127_REG_TEMP_HYST);=0A=
+		}=0A=
+		=0A=
 		data->temp_add[0] =3D=0A=
 		    w83781d_read_value(client, W83781D_REG_TEMP2);=0A=
 		data->temp_add_over[0] =3D=0A=
 		    w83781d_read_value(client, W83781D_REG_TEMP2_OVER);=0A=
 		data->temp_add_hyst[0] =3D=0A=
 		    w83781d_read_value(client, W83781D_REG_TEMP2_HYST);=0A=
-		if (data->type !=3D w83783s && data->type !=3D w83697hf) {=0A=
+=0A=
+		if (data->type !=3D w83783s && data->type !=3D w83697hf && data->type =
!=3D as99127f) {=0A=
 			data->temp_add[1] =3D=0A=
 			    w83781d_read_value(client, W83781D_REG_TEMP3);=0A=
 			data->temp_add_over[1] =3D=0A=
@@ -1664,24 +1669,49 @@=0A=
 		  int *nrels_mag, long *results)=0A=
 {=0A=
 	struct w83781d_data *data =3D client->data;=0A=
-	if (operation =3D=3D SENSORS_PROC_REAL_INFO)=0A=
-		*nrels_mag =3D 1;=0A=
-	else if (operation =3D=3D SENSORS_PROC_REAL_READ) {=0A=
-		w83781d_update_client(client);=0A=
-		results[0] =3D TEMP_FROM_REG(data->temp_over);=0A=
-		results[1] =3D TEMP_FROM_REG(data->temp_hyst);=0A=
-		results[2] =3D TEMP_FROM_REG(data->temp);=0A=
-		*nrels_mag =3D 3;=0A=
-	} else if (operation =3D=3D SENSORS_PROC_REAL_WRITE) {=0A=
-		if (*nrels_mag >=3D 1) {=0A=
-			data->temp_over =3D TEMP_TO_REG(results[0]);=0A=
-			w83781d_write_value(client, W83781D_REG_TEMP_OVER,=0A=
-					    data->temp_over);=0A=
+	int nr =3D ctl_name - W83781D_SYSCTL_TEMP1;=0A=
+=0A=
+	if (nr=3D=3D0) {=0A=
+		if (operation =3D=3D SENSORS_PROC_REAL_INFO)=0A=
+			*nrels_mag =3D 1;=0A=
+		else if (operation =3D=3D SENSORS_PROC_REAL_READ) {=0A=
+			w83781d_update_client(client);=0A=
+			results[0] =3D TEMP_FROM_REG(data->temp_over);=0A=
+			results[1] =3D TEMP_FROM_REG(data->temp_hyst);=0A=
+			results[2] =3D TEMP_FROM_REG(data->temp);=0A=
+			*nrels_mag =3D 3;=0A=
+		} else if (operation =3D=3D SENSORS_PROC_REAL_WRITE) {=0A=
+			if (*nrels_mag >=3D 1) {=0A=
+				data->temp_over =3D TEMP_TO_REG(results[0]);=0A=
+				w83781d_write_value(client, W83781D_REG_TEMP_OVER,=0A=
+						    data->temp_over);=0A=
+			}=0A=
+			if (*nrels_mag >=3D 2) {=0A=
+				data->temp_hyst =3D TEMP_TO_REG(results[1]);=0A=
+				w83781d_write_value(client, W83781D_REG_TEMP_HYST,=0A=
+						    data->temp_hyst);=0A=
+			}=0A=
 		}=0A=
-		if (*nrels_mag >=3D 2) {=0A=
-			data->temp_hyst =3D TEMP_TO_REG(results[1]);=0A=
-			w83781d_write_value(client, W83781D_REG_TEMP_HYST,=0A=
-					    data->temp_hyst);=0A=
+	} else {=0A=
+		if (operation =3D=3D SENSORS_PROC_REAL_INFO)=0A=
+			*nrels_mag =3D 1;=0A=
+		else if (operation =3D=3D SENSORS_PROC_REAL_READ) {=0A=
+			w83781d_update_client(client);=0A=
+			results[0] =3D TEMP_FROM_REG(data->temp2_over);=0A=
+			results[1] =3D TEMP_FROM_REG(data->temp2_hyst);=0A=
+			results[2] =3D TEMP_FROM_REG(data->temp2);=0A=
+			*nrels_mag =3D 3;=0A=
+		} else if (operation =3D=3D SENSORS_PROC_REAL_WRITE) {=0A=
+			if (*nrels_mag >=3D 1) {=0A=
+				data->temp2_over =3D TEMP_TO_REG(results[0]);=0A=
+				w83781d_write_value(client, AS99127_REG_TEMP_OVER,=0A=
+						    data->temp2_over);=0A=
+			}=0A=
+			if (*nrels_mag >=3D 2) {=0A=
+				data->temp2_hyst =3D TEMP_TO_REG(results[1]);=0A=
+				w83781d_write_value(client, AS99127_REG_TEMP_HYST,=0A=
+						    data->temp2_hyst);=0A=
+			}=0A=
 		}=0A=
 	}=0A=
 }=0A=
@@ -1692,51 +1722,38 @@=0A=
 	struct w83781d_data *data =3D client->data;=0A=
 	int nr =3D ctl_name - W83781D_SYSCTL_TEMP2;=0A=
 =0A=
+	if (data->type =3D=3D as99127f)=0A=
+		nr--;=0A=
+=0A=
 	if (operation =3D=3D SENSORS_PROC_REAL_INFO)=0A=
 		*nrels_mag =3D 1;=0A=
 	else if (operation =3D=3D SENSORS_PROC_REAL_READ) {=0A=
 		w83781d_update_client(client);=0A=
-		if (data->type =3D=3D as99127f) {=0A=
-			results[0] =3D=0A=
-			    AS99127_TEMP_ADD_FROM_REG(data->=0A=
-						      temp_add_over[nr]);=0A=
-			results[1] =3D=0A=
-			    AS99127_TEMP_ADD_FROM_REG(data->=0A=
-						      temp_add_hyst[nr]);=0A=
-			results[2] =3D=0A=
-			    AS99127_TEMP_ADD_FROM_REG(data->temp_add[nr]);=0A=
-		} else {=0A=
-			results[0] =3D=0A=
-			    TEMP_ADD_FROM_REG(data->temp_add_over[nr]);=0A=
-			results[1] =3D=0A=
-			    TEMP_ADD_FROM_REG(data->temp_add_hyst[nr]);=0A=
-			results[2] =3D TEMP_ADD_FROM_REG(data->temp_add[nr]);=0A=
-		}=0A=
+=0A=
+		results[0] =3D=0A=
+		    TEMP_ADD_FROM_REG(data->temp_add_over[nr]);=0A=
+		results[1] =3D=0A=
+		    TEMP_ADD_FROM_REG(data->temp_add_hyst[nr]);=0A=
+		results[2] =3D TEMP_ADD_FROM_REG(data->temp_add[nr]);=0A=
+=0A=
 		*nrels_mag =3D 3;=0A=
 	} else if (operation =3D=3D SENSORS_PROC_REAL_WRITE) {=0A=
 		if (*nrels_mag >=3D 1) {=0A=
-			if (data->type =3D=3D as99127f)=0A=
-				data->temp_add_over[nr] =3D=0A=
-				    AS99127_TEMP_ADD_TO_REG(results[0]);=0A=
-			else=0A=
-				data->temp_add_over[nr] =3D=0A=
-				    TEMP_ADD_TO_REG(results[0]);=0A=
+			data->temp_add_over[nr] =3D=0A=
+			    TEMP_ADD_TO_REG(results[0]);=0A=
+=0A=
 			w83781d_write_value(client,=0A=
-					    nr ? W83781D_REG_TEMP3_OVER :=0A=
-					    W83781D_REG_TEMP2_OVER,=0A=
-					    data->temp_add_over[nr]);=0A=
+			    nr ? W83781D_REG_TEMP3_OVER :=0A=
+			    W83781D_REG_TEMP2_OVER,=0A=
+			    data->temp_add_over[nr]);=0A=
 		}=0A=
 		if (*nrels_mag >=3D 2) {=0A=
-			if (data->type =3D=3D as99127f)=0A=
-				data->temp_add_hyst[nr] =3D=0A=
-				    AS99127_TEMP_ADD_TO_REG(results[1]);=0A=
-			else=0A=
-				data->temp_add_hyst[nr] =3D=0A=
-				    TEMP_ADD_TO_REG(results[1]);=0A=
+			data->temp_add_hyst[nr] =3D=0A=
+			    TEMP_ADD_TO_REG(results[1]);=0A=
 			w83781d_write_value(client,=0A=
-					    nr ? W83781D_REG_TEMP3_HYST :=0A=
-					    W83781D_REG_TEMP2_HYST,=0A=
-					    data->temp_add_hyst[nr]);=0A=
+			    nr ? W83781D_REG_TEMP3_HYST :=0A=
+			    W83781D_REG_TEMP2_HYST,=0A=
+			    data->temp_add_hyst[nr]);=0A=
 		}=0A=
 	}=0A=
 }=0A=

------=_NextPart_000_00FD_01C2DDEC.F3668DC0--


-- 
Frodo Looijaard <frodol@dds.nl>  PGP key and more: http://huizen.dds.nl/~frodol
Defenestration n. (formal or joc.):
  The act of removing Windows from your computer in disgust, usually followed
  by the installation of Linux or some other Unix-like operating system.
