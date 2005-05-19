From: aurelien@aurel32.net (Aurelien Jarno)
Date: Thu, 19 May 2005 06:24:48 +0000
Subject: [PATCH] Manpages for i2cdump, i2cset and isadump
Message-Id: <20040320174606.GA20666@pc.aurel32.private>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

Please find attached a patch against the current CVS to add manpages
for i2cdump, i2cset and isadump. I send the three manpages in one patch
because they all require the modification of the same file, 
prog/dump/Module.mk

Cheers,
Aurelien

-- 
  .''`.  Aurelien Jarno	              GPG: 1024D/F1BCDB73
 : :' :  Debian GNU/Linux developer | Electrical Engineering Student 
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net
-------------- next part --------------
diff -urN lm_sensors2.orig/prog/dump/i2cdump.8 lm_sensors2/prog/dump/i2cdump.8
--- lm_sensors2.orig/prog/dump/i2cdump.8	1970-01-01 01:00:00.000000000 +0100
+++ lm_sensors2/prog/dump/i2cdump.8	2004-03-20 18:32:21.000000000 +0100
@@ -0,0 +1,35 @@
+.TH I2CDUMP
+.SH NAME
+i2cdump \- Examine I2C registers
+
+.SH SYNOPSIS
+.B i2cdump
+.I i2cbus
+.I address
+.RI [ mode ]
+.RI [ "bank " [ "bankreg"]]  
+
+.SH DESCRIPTION
+i2cdump is a small helper program to examine registers 
+visible through the I\u2\dC bus.   
+ 
+.SH OPTIONS
+At least two options must be provided to i2cdump. \fIi2cbus\fR indicates the
+number of the I\u2\dC bus to be scanned. This number should correspond to one
+of the busses listed in \fB/proc/bus/i2c\fP. \fIaddress\fR indicates the 
+address to be scanned on that bus, and is an integer between 0 and 127. The 
+\fImode\fR parameter, if specified, is one of the letters \fBb\fP, \fBw\fP, 
+\fBs\fP, or \fBi\fP, corresponding to a read size of a single byte, a 16-bit 
+word, an SMBus block, or an I\u2\dC block, respectively.  If the \fImode\fR 
+parameter is omitted, i2cdump defaults to byte access. 
+.PP 
+The \fIbank\fR and \fIbankaddr\fR parameters appear to only be useful on W83781
+chips. \fIbank\fR is an integer between 0 and 15, and \fIbankreg\fR is an 
+integer between 0 and 255.  The W83781 data sheet has more information on the 
+usage of these parameters. 
+
+.SH CONFORMING TO
+lm_sensors-2.x
+
+.SH SEE ALSO
+isadump(8), i2cset(8) 
diff -urN lm_sensors2.orig/prog/dump/i2cset.8 lm_sensors2/prog/dump/i2cset.8
--- lm_sensors2.orig/prog/dump/i2cset.8	1970-01-01 01:00:00.000000000 +0100
+++ lm_sensors2/prog/dump/i2cset.8	2004-03-20 18:32:21.000000000 +0100
@@ -0,0 +1,44 @@
+.TH I2CSET 8
+.SH "NAME" 
+i2cset \- Set I\u2\dC registers 
+
+.SH SYNOPSIS
+.B i2cset
+.R i2cbus
+.R chip-address
+.R data-address
+.R value
+.RI [ mode ]
+
+.SH DESCRIPTION
+i2cset is a small helper program to set registers visible through the I\u2\dC
+bus.
+
+.SH OPTIONS
+There are four required options to i2cset. \fIi2cbus\fR indicates the number
+of the I\u2\dC bus to be scanned.  This number should correspond to one of
+the busses listed in \fB/proc/bus/i2c\fP. \fIchip-address\fR specifies the 
+address of the chip on that bus, and is an integer between 0 and 127. 
+\fIdata-address\fR specifies the address on that chip to write to, and is an 
+integer between 0 and 127. \fIvalue\fR is the value to write to that location
+on the chip. 
+.PP 
+The \fImode\fR parameter, if specified, is one of the letters \fBb\fP or 
+\fBw\fP, corresponding to a write size of a single byte or a 16-bit word, 
+respectively. If the \fImode\fR parameter is omitted, i2cset defaults to byte
+access. The \fIvalue\fR provided must be within range for the specified data
+type (0-255 for bytes, 0-65535 for words). 
+
+.SH WARNING
+.PP 
+i2cset can be extremely dangerous if used improperly. It can confuse your 
+I\u2\dC bus, cause data loss, or have more serious side effects. Writing to
+a serial EEPROM on a memory DIMM (chip addresses between 0x50 and 0x57) may
+DESTROY your memory, leaving your system unbootable!  Be extremely careful 
+using this program. 
+
+.SH CONFORMING TO
+lm_sensors-2.x
+
+.SH SEE ALSO
+i2cdump(8) 
diff -urN lm_sensors2.orig/prog/dump/isadump.8 lm_sensors2/prog/dump/isadump.8
--- lm_sensors2.orig/prog/dump/isadump.8	1970-01-01 01:00:00.000000000 +0100
+++ lm_sensors2/prog/dump/isadump.8	2004-03-20 18:32:21.000000000 +0100
@@ -0,0 +1,36 @@
+.TH ISADUMP 8 
+.SH NAME
+isadump \- Examine ISA registers
+
+.SH SYNOPSIS
+.B isadump
+.RI [ Iaddrreg ]
+.RI [ datareg ] 
+.RI [ "bank " [ "bankreg"]]  
+
+.SH DESCRIPTION
+isadump is a small helper program to examine registers visible through the ISA
+bus. It is intended to probe a W83781D chip on the ISA bus.
+ 
+.SH OPTIONS
+At least two options must be provided to isadump. \fIaddrreg\fR contains the
+ISA address of the address register for the chip to probe; \fIdatareg\fR 
+contains the address of the data register. Both addresses are integers between 
+0 and 65536. \fIbank\fR, if provided, is the bank number to probe, and defaults
+to 0. \fIbankreg\fR is the bank register number, and defaults to 0x4E. 
+.PP
+\fIbankreg\fR is written to +\fIaddrreg\fR, and +\fIbank\fR is OR'd with 0x80
+and written to \fIdatareg\fR.  Then values from 0 to 255 are written in 
+sequence to \fIaddrreg\fR, and data is read from \fIdatareg\fR and displayed.
+
+.SH WARNINGS 
+Poking around in ISA data space is extremely dangerous. 
+Running isadump with random parameters can cause system 
+crashes, data loss, and worse!  Be extremely careful when using 
+this program. 
+
+.SH CONFORMING TO
+lm_sensors-2.x
+
+.SH SEE ALSO
+i2cdump(8)
diff -urN lm_sensors2.orig/prog/dump/Module.mk lm_sensors2/prog/dump/Module.mk
--- lm_sensors2.orig/prog/dump/Module.mk	2004-03-20 18:39:10.000000000 +0100
+++ lm_sensors2/prog/dump/Module.mk	2004-03-20 18:37:39.000000000 +0100
@@ -21,6 +21,10 @@
 MODULE_DIR := prog/dump
 PROGDUMPDIR := $(MODULE_DIR)
 
+PROGDUMPMAN8DIR := $(MANDIR)/man8
+PROGDUMPMAN8FILES := $(MODULE_DIR)/isadump.8 $(MODULE_DIR)/i2cdump.8 \
+		     $(MODULE_DIR)/i2cset.8
+
 # Regrettably, even 'simply expanded variables' will not put their currently
 # defined value verbatim into the command-list of rules...
 PROGDUMPTARGETS := $(MODULE_DIR)/isadump $(MODULE_DIR)/i2cdump \
@@ -44,8 +48,9 @@
 	$(CC) $(EXLDFLAGS) -o $@ $^
 
 install-prog-dump: all-prog-dump
-	$(MKDIR) $(DESTDIR)$(SBINDIR)
+	$(MKDIR) $(DESTDIR)$(SBINDIR) $(DESTDIR)$(PROGDUMPMAN8DIR)
 	$(INSTALL) -m 755 $(PROGDUMPBININSTALL) $(DESTDIR)$(SBINDIR)
+	$(INSTALL) -m 644 $(PROGDUMPMAN8FILES) $(DESTDIR)$(PROGDUMPMAN8DIR)
 user_install :: install-prog-dump
 
 clean-prog-dump:
