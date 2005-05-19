From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:48 +0000
Subject: [PATCH] Manpages for i2cdump, i2cset and isadump
Message-Id: <20040320193006.21dcefb3.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040320174606.GA20666@pc.aurel32.private>
In-Reply-To: <20040320174606.GA20666@pc.aurel32.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Please find attached a patch against the current CVS to add manpages
> for i2cdump, i2cset and isadump. I send the three manpages in one
> patch because they all require the modification of the same file, 
> prog/dump/Module.mk

Agreed. See my comments inline.

> diff -urN lm_sensors2.orig/prog/dump/i2cdump.8 lm_sensors2/prog/dump/i2cdump.8
> --- lm_sensors2.orig/prog/dump/i2cdump.8	1970-01-01 01:00:00.000000000 +0100
> +++ lm_sensors2/prog/dump/i2cdump.8	2004-03-20 18:32:21.000000000 +0100
> @@ -0,0 +1,35 @@
> +.TH I2CDUMP

Please add the section (8) and the date (Month YYYY) on TH lines.

> +.SH NAME
> +i2cdump \- Examine I2C registers
> +
> +.SH SYNOPSIS
> +.B i2cdump
> +.I i2cbus
> +.I address
> +.RI [ mode ]
> +.RI [ "bank " [ "bankreg"]]  

Missing whitespace?

> +
> +.SH DESCRIPTION
> +i2cdump is a small helper program to examine registers 
> +visible through the I\u2\dC bus.   
> + 
> +.SH OPTIONS
> +At least two options must be provided to i2cdump. \fIi2cbus\fR indicates the
> +number of the I\u2\dC bus to be scanned. This number should correspond to one
> +of the busses listed in \fB/proc/bus/i2c\fP. \fIaddress\fR indicates the 
> +address to be scanned on that bus, and is an integer between 0 and 127. The 

The address is more usually expressed in hexadecimal. "between 0x00 an
0x7F" would look better.

> +\fImode\fR parameter, if specified, is one of the letters \fBb\fP, \fBw\fP, 
> +\fBs\fP, or \fBi\fP, corresponding to a read size of a single byte, a 16-bit 
> +word, an SMBus block, or an I\u2\dC block, respectively.  If the \fImode\fR 
> +parameter is omitted, i2cdump defaults to byte access. 

You forget about mode 'c' here. You should also mention the PEC 'p' flag.

> +The \fIbank\fR and \fIbankaddr\fR parameters appear to only be useful on W83781
> +chips. \fIbank\fR is an integer between 0 and 15, and \fIbankreg\fR is an 
> +integer between 0 and 255.  The W83781 data sheet has more information on the 
> +usage of these parameters. 

It's not really limited to the W83781. A more correct expression would
be "W83781D and similar chips" (actually all Winbond and Asus chips
AFAIK). And it does not "appear", it "is" ;)

You don't mention the default value for the bankreg.

I don't think we ever saw banks over 3 bits (ie max value ie 7, not 15).

bankreg is also better expressed in hexa, "between 0x00 and 0xFF".

Don't you mention you in a AUTHORS section? Most Debian man page
writters do that.

.SH "AUTHOR"
.PP
This manual page was written by Your Name <you@debian.org> for
the Debian GNU/Linux system (but may be used by others).

Most of the comments I made on this first page apply to the other ones
as well.

> diff -urN lm_sensors2.orig/prog/dump/isadump.8 lm_sensors2/prog/dump/isadump.8
> --- lm_sensors2.orig/prog/dump/isadump.8	1970-01-01 01:00:00.000000000 +0100
> +++ lm_sensors2/prog/dump/isadump.8	2004-03-20 18:32:21.000000000 +0100
> @@ -0,0 +1,36 @@
> +.TH ISADUMP 8 
> +.SH NAME
> +isadump \- Examine ISA registers
> +
> +.SH SYNOPSIS
> +.B isadump
> +.RI [ Iaddrreg ]
> +.RI [ datareg ] 
> +.RI [ "bank " [ "bankreg"]]  

You do not document the flat mode.

> +
> +.SH DESCRIPTION
> +isadump is a small helper program to examine registers visible through the ISA
> +bus. It is intended to probe a W83781D chip on the ISA bus.

No, any chip that lives on the ISA bus working with an address register
and a data register (non-flat mode) or a flat 256 bytes range.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
