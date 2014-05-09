From: Jean Delvare <jdelvare@suse.de>
Date: Fri, 09 May 2014 08:34:09 +0000
Subject: [lm-sensors] [PATCH 3/3] New helper tool: hwmon-dev
Message-Id: <20140509103409.3d774bb9@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This tool is a hwmon device name resolution helper. It can tell which
libsensors chip name corresponds to which kernel hwmon class device.
---
 Makefile                   |    2 
 prog/hwmon-dev/Module.mk   |   58 +++++++++++
 prog/hwmon-dev/hwmon-dev.1 |   63 ++++++++++++
 prog/hwmon-dev/hwmon-dev.c |  229 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 351 insertions(+), 1 deletion(-)

--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ lm-sensors/prog/hwmon-dev/Module.mk	2014-05-09 10:28:55.842409402 +0200
@@ -0,0 +1,58 @@
+#  Copyright (C) 2014  Jean Delvare <jdelvare@suse.de>
+#
+#  This program is free software; you can redistribute it and/or modify
+#  it under the terms of the GNU General Public License as published by
+#  the Free Software Foundation; either version 2 of the License, or
+#  (at your option) any later version.
+#
+#  This program is distributed in the hope that it will be useful,
+#  but WITHOUT ANY WARRANTY; without even the implied warranty of
+#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+#  GNU General Public License for more details.
+#
+#  You should have received a copy of the GNU General Public License
+#  along with this program; if not, write to the Free Software
+#  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+#  MA 02110-1301 USA.
+
+# Note that MODULE_DIR (the directory in which this file resides) is a
+# 'simply expanded variable'. That means that its value is substituted
+# verbatim in the rules, until it is redefined.
+MODULE_DIR := prog/hwmon-dev
+PROGHWMONDEVDIR := $(MODULE_DIR)
+
+PROGHWMONDEVMAN1DIR := $(MANDIR)/man1
+PROGHWMONDEVMAN1FILES := $(MODULE_DIR)/hwmon-dev.1
+
+# Regrettably, even 'simply expanded variables' will not put their currently
+# defined value verbatim into the command-list of rules...
+PROGHWMONDEVTARGETS := $(MODULE_DIR)/hwmon-dev
+PROGHWMONDEVSOURCES := $(MODULE_DIR)/hwmon-dev.c
+
+# Include all dependency files. We use '.rd' to indicate this will create
+# executables.
+INCLUDEFILES += $(PROGHWMONDEVSOURCES:.c=.rd)
+
+REMOVEHWMONDEVBIN := $(patsubst $(MODULE_DIR)/%,$(DESTDIR)$(BINDIR)/%,$(PROGHWMONDEVTARGETS))
+REMOVEHWMONDEVMAN := $(patsubst $(MODULE_DIR)/%,$(DESTDIR)$(PROGHWMONDEVMAN1DIR)/%,$(PROGHWMONDEVMAN1FILES))
+
+$(PROGHWMONDEVTARGETS): $(PROGHWMONDEVSOURCES:.c=.ro) lib/$(LIBSHBASENAME)
+	$(CC) $(EXLDFLAGS) -o $@ $(PROGHWMONDEVSOURCES:.c=.ro) -Llib -lsensors
+
+all-prog-hwmondev: $(PROGHWMONDEVTARGETS)
+user :: all-prog-hwmondev
+
+install-prog-hwmondev: all-prog-hwmondev
+	$(MKDIR) $(DESTDIR)$(BINDIR) $(DESTDIR)$(PROGHWMONDEVMAN1DIR)
+	$(INSTALL) -m 755 $(PROGHWMONDEVTARGETS) $(DESTDIR)$(BINDIR)
+	$(INSTALL) -m 644 $(PROGHWMONDEVMAN1FILES) $(DESTDIR)$(PROGHWMONDEVMAN1DIR)
+user_install :: install-prog-hwmondev
+
+user_uninstall::
+	$(RM) $(REMOVEHWMONDEVBIN)
+	$(RM) $(REMOVEHWMONDEVMAN)
+
+clean-prog-hwmondev:
+	$(RM) $(PROGHWMONDEVDIR)/*.rd $(PROGHWMONDEVDIR)/*.ro
+	$(RM) $(PROGHWMONDEVTARGETS)
+clean :: clean-prog-hwmondev
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ lm-sensors/prog/hwmon-dev/hwmon-dev.c	2014-05-09 10:28:55.842409402 +0200
@@ -0,0 +1,229 @@
+/*
+    hwmon-dev, a tool to map hwmon kernel devices to libsensors chips
+    Copyright (C) 2014        Jean Delvare <jdelvare@suse.de>
+
+    Partly inspired from sensors/main.c
+    Copyright (c) 1998, 1999  Frodo Looijaard <frodol@dds.nl>
+    Copyright (C) 2007-2012   Jean Delvare <jdelvare@suse.de>
+
+    This program is free software; you can redistribute it and/or modify
+    it under the terms of the GNU General Public License as published by
+    the Free Software Foundation; either version 2 of the License, or
+    (at your option) any later version.
+
+    This program is distributed in the hope that it will be useful,
+    but WITHOUT ANY WARRANTY; without even the implied warranty of
+    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+    GNU General Public License for more details.
+
+    You should have received a copy of the GNU General Public License
+    along with this program; if not, write to the Free Software
+    Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+    MA 02110-1301 USA.
+*/
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <getopt.h>
+#include <string.h>
+#include <errno.h>
+
+#include "lib/sensors.h"
+#include "lib/error.h"
+#include "version.h"
+
+#define PROGRAM			"hwmon-dev"
+#define VERSION			LM_VERSION
+
+static void print_short_help(void)
+{
+	printf("Try '%s -h' for more information\n", PROGRAM);
+}
+
+static void print_long_help(void)
+{
+	puts("Resolve libsensors chip names to kernel device names");
+	printf("Usage: %s {libsensors chip name}\n", PROGRAM);
+	printf("       %s -r {kernel device name}\n", PROGRAM);
+	puts("  -c, --config-file     Specify a config file\n"
+	     "  -h, --help            Display this help text\n"
+	     "  -r                    Reverse look-up\n"
+	     "  -v, --version         Display the program version\n"
+	     "\n"
+	     "Use `-' after `-c' to read the config file from stdin.\n"
+	     "Example libsensors chip names:\n"
+	     "\tlm78-i2c-0-2d\t*-i2c-0-2d\n"
+	     "\tlm78-i2c-0-*\t*-i2c-0-*\n"
+	     "\tlm78-i2c-*-2d\t*-i2c-*-2d\n"
+	     "\tlm78-i2c-*-*\t*-i2c-*-*\n"
+	     "\tlm78-isa-0290\t*-isa-0290\n"
+	     "\tlm78-isa-*\t*-isa-*\n"
+	     "\tlm78-*\n"
+	     "Example kernel device names:\n"
+	     "\thwmon0\n"
+	     "\thwmon1");
+}
+
+static void print_version(void)
+{
+	printf("%s version %s with libsensors version %s\n", PROGRAM, VERSION,
+	       libsensors_version);
+}
+
+/* Return 0 on success, and an exit error code otherwise */
+static int read_config_file(const char *config_file_name)
+{
+	FILE *config_file;
+	int err;
+
+	if (config_file_name) {
+		if (!strcmp(config_file_name, "-"))
+			config_file = stdin;
+		else
+			config_file = fopen(config_file_name, "r");
+
+		if (!config_file) {
+			fprintf(stderr, "Could not open config file\n");
+			perror(config_file_name);
+			return 1;
+		}
+	} else {
+		/* Use libsensors default */
+		config_file = NULL;
+	}
+
+	err = sensors_init(config_file);
+	if (err) {
+		fprintf(stderr, "sensors_init: %s\n", sensors_strerror(err));
+		if (config_file)
+			fclose(config_file);
+		return 1;
+	}
+
+	if (config_file && fclose(config_file) = EOF)
+		perror(config_file_name);
+
+	return 0;
+}
+
+static const char *sprintf_chip_name(const sensors_chip_name *name)
+{
+#define BUF_SIZE 200
+	static char buf[BUF_SIZE];
+
+	if (sensors_snprintf_chip_name(buf, BUF_SIZE, name) < 0)
+		return NULL;
+	return buf;
+}
+
+/* returns number of chips found */
+static int lib_to_kernel(const sensors_chip_name *match)
+{
+	const sensors_chip_name *chip;
+	int chip_nr;
+	int cnt = 0;
+
+	chip_nr = 0;
+	while ((chip = sensors_get_detected_chips(match, &chip_nr))) {
+		printf("%s\n", sensors_get_kernel_name(chip));
+		cnt++;
+	}
+	return cnt;
+}
+
+static int kernel_to_lib(const char *kernel_name)
+{
+	const sensors_chip_name *chip;
+	int chip_nr;
+
+	chip_nr = 0;
+	while ((chip = sensors_get_detected_chips(NULL, &chip_nr))) {
+		if (!strcmp(sensors_get_kernel_name(chip), kernel_name)) {
+			printf("%s\n", sprintf_chip_name(chip));
+			/* Kernel names are unique so we can stop searching */
+			return 1;
+		}
+	}
+	return 0;
+}
+
+int main(int argc, char *argv[])
+{
+	int c, err, reverse, cnt;
+	const char *config_file_name = NULL;
+	sensors_chip_name chip;
+
+	struct option long_opts[] =  {
+		{ "config-file", required_argument, NULL, 'c' },
+		{ "help", no_argument, NULL, 'h' },
+		{ "version", no_argument, NULL, 'v'},
+		{ 0, 0, 0, 0 }
+	};
+
+	reverse = 0;
+	while (1) {
+		c = getopt_long(argc, argv, "c:hrv", long_opts, NULL);
+		if (c = EOF)
+			break;
+		switch(c) {
+		case ':':
+		case '?':
+			print_short_help();
+			exit(1);
+		case 'c':
+			config_file_name = optarg;
+			break;
+		case 'h':
+			print_long_help();
+			exit(0);
+		case 'r':
+			reverse = 1;
+			break;
+		case 'v':
+			print_version();
+			exit(0);
+		default:
+			fprintf(stderr,
+				"Internal error while parsing options!\n");
+			exit(1);
+		}
+	}
+
+	if (argc < optind + 1) {
+		fprintf(stderr, "Missing name\n");
+		print_short_help();
+		exit(1);
+	} else if (argc > optind + 1) {
+		fprintf(stderr, "Too many names\n");
+		print_short_help();
+		exit(1);
+	}
+
+	err = read_config_file(config_file_name);
+	if (err)
+		exit(err);
+
+	if (reverse) {
+		cnt = kernel_to_lib(argv[optind]);
+	} else {
+		if (sensors_parse_chip_name(argv[optind], &chip)) {
+			fprintf(stderr, "%s: Parse error\n", argv[optind]);
+			print_short_help();
+			err = 1;
+			goto exit;
+		}
+
+		cnt = lib_to_kernel(&chip);
+
+		sensors_free_chip_name(&chip);
+	}
+
+	if (!cnt) {
+		fprintf(stderr, "%s: No match\n", argv[optind]);
+		err = 1;
+	}
+
+exit:
+	sensors_cleanup();
+	exit(err);
+}
--- lm-sensors.orig/Makefile	2014-05-09 09:55:56.849005848 +0200
+++ lm-sensors/Makefile	2014-05-09 10:32:31.502370315 +0200
@@ -106,7 +106,7 @@ BUILD_STATIC_LIB := 1
 # to do this. 
 
 # The subdirectories we need to build things in 
-SRCDIRS := lib prog/detect prog/pwm \
+SRCDIRS := lib prog/detect prog/hwmon-dev prog/pwm \
            prog/sensors ${PROG_EXTRA:%=prog/%} etc
 # Only build isadump and isaset on x86 machines.
 ifneq (,$(findstring $(MACHINE), i386 i486 i586 i686 x86_64))
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ lm-sensors/prog/hwmon-dev/hwmon-dev.1	2014-05-09 10:28:55.842409402 +0200
@@ -0,0 +1,63 @@
+.\" Copyright (C) 2014  Jean Delvare <jdelvare@suse.de>
+.\" hwmon-dev is distributed under the GPL
+.\"
+.\" Permission is granted to make and distribute verbatim copies of this
+.\" manual provided the copyright notice and this permission notice are
+.\" preserved on all copies.
+.\"
+.\" Permission is granted to copy and distribute modified versions of this
+.\" manual under the conditions for verbatim copying, provided that the
+.\" entire resulting derived work is distributed under the terms of a
+.\" permission notice identical to this one.
+.\"
+.\" Formatted or processed versions of this manual, if unaccompanied by
+.\" the source, must acknowledge the copyright and authors of this work.
+.\"
+.TH hwmon-dev 1  "May 2014" "lm-sensors 3" "Linux User's Manual"
+
+.SH NAME
+hwmon-dev \- resolve libsensors chip names to kernel device names
+
+.SH SYNOPSIS
+.B hwmon-dev {
+.I libsensors chip name
+.B }
+.br
+.B hwmon-dev -r {
+.I kernel device name
+.B }
+
+.SH DESCRIPTION
+.B hwmon-dev
+is used to resolve libsensors chip names to hwmon kernel device names.
+.B hwmon-dev -r
+is used to resolve hwmon kernel device names to libsensors chip names.
+
+.SH OPTIONS
+.IP "-c, --config-file config-file"
+Specify a configuration file. If no file is specified, the libsensors
+default configuration file is used. Use `-c /dev/null' to temporarily
+disable this default configuration file.
+.IP "-h, --help"
+Print a help text and exit.
+.IP "-r"
+Perform a reverse look-up.
+.IP "-v, --version"
+Print the program version and exit.
+
+.SH FILES
+.I /etc/sensors3.conf
+.br
+.I /etc/sensors.conf
+.RS
+The system wide configuration file. See
+.BR sensors.conf (5)
+for further details.
+.RE
+
+.SH SEE ALSO
+sensors.conf(5)
+
+.SH AUTHOR
+Jean Delvare
+http://www.lm-sensors.org/

-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
