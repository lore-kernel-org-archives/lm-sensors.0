From: aurelien@aurel32.net (Aurelien Jarno)
Date: Thu, 19 May 2005 06:24:48 +0000
Subject: [PATCH] Manpages for i2cdump, i2cset and isadump
Message-Id: <20040320204537.GA25838@pc.aurel32.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040320174606.GA20666@pc.aurel32.private>
In-Reply-To: <20040320174606.GA20666@pc.aurel32.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I updated the patch using your advices.

On Sat, Mar 20, 2004 at 07:30:06PM +0100, Jean Delvare wrote:
> Don't you mention you in a AUTHORS section? Most Debian man page
> writters do that.
> 
> .SH "AUTHOR"
> .PP
> This manual page was written by Your Name <you@debian.org> for
> the Debian GNU/Linux system (but may be used by others).
> 
> Most of the comments I made on this first page apply to the other ones
> as well.
In fact I didn't write that manpages, they were in the lm-sensors Debian
package when I started to maintain it. I credited David Z Maze the
previous maintainer.


-- 
  .''`.  Aurelien Jarno	              GPG: 1024D/F1BCDB73
 : :' :  Debian GNU/Linux developer | Electrical Engineering Student 
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net
-------------- next part --------------
diff -urN lm_sensors2.orig/prog/dump/i2cdump.8 lm_sensors2/prog/dump/i2cdump.8
--- lm_sensors2.orig/prog/dump/i2cdump.8	1970-01-01 01:00:00.000000000 +0100
+++ lm_sensors2/prog/dump/i2cdump.8	2004-03-20 21:31:43.000000000 +0100
@@ -0,0 +1,42 @@
+.TH I2CDUMP 8 "March 2004"
+.SH NAME
+i2cdump \- Examine I2C registers
+
+.SH SYNOPSIS
+.B i2cdump
+.I address
+.RI [ mode ]
+.RI [ "bank " [ "bankreg" ] ]
+
+.SH DESCRIPTION
+i2cdump is a small helper program to examine registers 
+visible through the I\u2\dC bus.   
+ 
+.SH OPTIONS
+At least two options must be provided to i2cdump. \fIi2cbus\fR indicates the
+number of the I\u2\dC bus to be scanned. This number should correspond to one
+of the busses listed in \fB/proc/bus/i2c\fP. \fIaddress\fR indicates the 
+address to be scanned on that bus, and is an integer between 0x00 and 0x7F. The
+\fImode\fR parameter, if specified, is one of the letters \fBb\fP, \fBw\fP, 
+\fBs\fP, or \fBi\fP, corresponding to a read size of a single byte, a 16-bit
+word, an SMBus block, an I\u2\dC block, respectively. The \fBc\fP mode is a 
+little different, it reads all bytes consecutively, and is useful for chips that
+have an address auto-increment feature. A \fBp\fP could also be append to the 
+\fImode\fR parameter to enable PEC checking. If the \fImode\fR parameter is 
+omitted, i2cdump defaults to byte access.
+
+.PP 
+The \fIbank\fR and \fIbankaddr\fR parameters are useful on W83781D and similar 
+chips, and defaults to 0x4E. \fIbank\fR is an integer between 0 and 7, and
+\fIbankreg\fR is an integer between 0x00 and 0xFF. The W83781D data sheet has
+more information on the usage of these parameters. 
+
+.SH CONFORMING TO
+lm_sensors-2.x
+
+.SH SEE ALSO
+isadump(8), i2cset(8) 
+
+.SH AUTHOR
+This manual page was written by David Z Maze <dmaze@debian.org> for
+the Debian GNU/Linux system (but may be used by others).
diff -urN lm_sensors2.orig/prog/dump/i2cset.8 lm_sensors2/prog/dump/i2cset.8
--- lm_sensors2.orig/prog/dump/i2cset.8	1970-01-01 01:00:00.000000000 +0100
+++ lm_sensors2/prog/dump/i2cset.8	2004-03-20 21:31:43.000000000 +0100
@@ -0,0 +1,48 @@
+.TH I2CSET 8 "March 2004"
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
+integer between 0x00 and 0xff. \fIvalue\fR is the value to write to that 
+location on the chip. 
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
+
+.SH AUTHOR
+This manual page was written by David Z Maze <dmaze@debian.org> for
+the Debian GNU/Linux system (but may be used by others).
diff -urN lm_sensors2.orig/prog/dump/isadump.8 lm_sensors2/prog/dump/isadump.8
--- lm_sensors2.orig/prog/dump/isadump.8	1970-01-01 01:00:00.000000000 +0100
+++ lm_sensors2/prog/dump/isadump.8	2004-03-20 21:31:43.000000000 +0100
@@ -0,0 +1,50 @@
+.TH ISADUMP 8 "March 2004"
+.SH NAME
+isadump \- Examine ISA registers
+
+.SH SYNOPSIS
+.B isadump
+.RI [ addrreg ]
+.RI [ datareg ] 
+.RI [ "bank " [ "bankreg"] ]
+.br
+.B isadump 
+.BI "-f " "ADDRESS"
+(for flat address space)
+
+.SH DESCRIPTION
+isadump is a small helper program to examine registers visible through the ISA
+bus. It is intended to probe any chip that lives on the ISA bus working with an
+address register and a data register (non-flat mode) or a flat 256 bytes range.
+ 
+.SH OPTIONS (normal mode)
+At least two options must be provided to isadump. \fIaddrreg\fR contains the
+ISA address of the address register for the chip to probe; \fIdatareg\fR 
+contains the address of the data register. Both addresses are integers between 
+0x0000 and 0xFFFF. \fIbank\fR, if provided, is the bank number to probe, and 
+defaults to 0. \fIbankreg\fR is the bank register number, and defaults to 0x4E.
+.PP
+\fIbankreg\fR is written to \fIaddrreg\fR, and \fIbank\fR is OR'd with 0x80
+and written to \fIdatareg\fR. Then values from 0x00 to 0xFF are written in 
+sequence to \fIaddrreg\fR, and data is read from \fIdatareg\fR and displayed.
+
+.SH OPTIONS (flat mode)
+In flat mode (triggered by the \fB-f\fR flag), only one parameter must be 
+provided. \fIADDRESS\fR contains the ISA address of the address register 
+for the chip to probe; it is an integer between 0x0000 and 0xFFFF.
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
+
+.SH AUTHOR
+This manual page was written by David Z Maze <dmaze@debian.org> for
+the Debian GNU/Linux system (but may be used by others).
diff -urN lm_sensors2.orig/prog/dump/Module.mk lm_sensors2/prog/dump/Module.mk
--- lm_sensors2.orig/prog/dump/Module.mk	2004-03-20 18:39:10.000000000 +0100
+++ lm_sensors2/prog/dump/Module.mk	2004-03-20 21:31:14.000000000 +0100
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
