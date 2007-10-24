From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 24 Oct 2007 15:09:25 +0000
Subject: [lm-sensors] [PATCH 2/6] No default configuration file name in
Message-Id: <20071024170925.501dcfc6@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

"sensors" no longer needs a default configuration file name. If no
file name is provided on the command line, use the libsensors default.

---
 prog/sensors/main.c    |   31 +++++++++++++++++--------------
 prog/sensors/sensors.1 |    8 ++++----
 2 files changed, 21 insertions(+), 18 deletions(-)

--- lm-sensors-3.orig/prog/sensors/main.c	2007-10-21 16:22:06.000000000 +0200
+++ lm-sensors-3/prog/sensors/main.c	2007-10-24 15:04:12.000000000 +0200
@@ -39,7 +39,6 @@
 
 #define PROGRAM			"sensors"
 #define VERSION			LM_VERSION
-#define DEFAULT_CONFIG_FILE	ETCDIR "/sensors.conf"
 
 static int do_sets, do_raw, hide_adapter;
 
@@ -54,9 +53,8 @@ static void print_short_help(void)
 static void print_long_help(void)
 {
 	printf("Usage: %s [OPTION]... [CHIP]...\n", PROGRAM);
-	printf("  -c, --config-file     Specify a config file (default: %s)\n",
-	       DEFAULT_CONFIG_FILE);
-	puts("  -h, --help            Display this help text\n"
+	puts("  -c, --config-file     Specify a config file\n"
+	     "  -h, --help            Display this help text\n"
 	     "  -s, --set             Execute `set' statements (root only)\n"
 	     "  -f, --fahrenheit      Show temperatures in degrees fahrenheit\n"
 	     "  -A, --no-adapter      Do not show adapter for each chip\n"
@@ -88,15 +86,20 @@ static int read_config_file(const char *
 	FILE *config_file;
 	int err;
 
-	if (!strcmp(config_file_name, "-"))
-		config_file = stdin;
-	else
-		config_file = fopen(config_file_name, "r");
+	if (config_file_name) {
+		if (!strcmp(config_file_name, "-"))
+			config_file = stdin;
+		else
+			config_file = fopen(config_file_name, "r");
 
-	if (!config_file) {
-		fprintf(stderr, "Could not open config file\n");
-		perror(config_file_name);
-		return 1;
+		if (!config_file) {
+			fprintf(stderr, "Could not open config file\n");
+			perror(config_file_name);
+			return 1;
+		}
+	} else {
+		/* Use libsensors default */
+		config_file = NULL;
 	}
 
 	err = sensors_init(config_file);
@@ -106,7 +109,7 @@ static int read_config_file(const char *
 		return 1;
 	}
 
-	if (fclose(config_file) = EOF)
+	if (config_file && fclose(config_file) = EOF)
 		perror(config_file_name);
 
 	return 0;
@@ -239,7 +242,7 @@ static void print_bus_list(void)
 int main(int argc, char *argv[])
 {
 	int c, res, i, error, do_bus_list;
-	const char *config_file_name = DEFAULT_CONFIG_FILE;
+	const char *config_file_name = NULL;
 
 	struct option long_opts[] =  {
 		{ "help", no_argument, NULL, 'h' },
--- lm-sensors-3.orig/prog/sensors/sensors.1	2007-10-21 16:20:25.000000000 +0200
+++ lm-sensors-3/prog/sensors/sensors.1	2007-10-24 16:22:00.000000000 +0200
@@ -22,7 +22,7 @@
 .\" Formatted or processed versions of this manual, if unaccompanied by
 .\" the source, must acknowledge the copyright and authors of this work.
 .\"
-.TH sensors 1  "September 2007" "lm-sensors 3" "Linux User's Manual"
+.TH sensors 1  "October 2007" "lm-sensors 3" "Linux User's Manual"
 .SH NAME
 sensors \- print sensors information
 .SH SYNOPSIS
@@ -50,9 +50,9 @@ is used to generate bus statements suita
 
 .SH OPTIONS
 .IP "-c config-file"
-Specify a configuration file. If no file is specified, `/etc/sensors.conf'
-is used. Use `-c /dev/null' to temporarily disable this default configuration
-file.
+Specify a configuration file. If no file is specified, the libsensors
+default configuration file is used. Use `-c /dev/null' to temporarily
+disable this default configuration file.
 .IP -h
 Print a help text and exit.
 .IP -s


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
