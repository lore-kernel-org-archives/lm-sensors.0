From: Matt Roberds <mattroberds@cox.net>
Date: Thu, 05 Feb 2009 02:29:40 +0000
Subject: Re: [lm-sensors] [RFC 0/4] Add support for multiple configuration
Message-Id: <Pine.LNX.4.64.0902042029140.13966@birdbird.example.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090204225329.0ebb0fef@hyperion.delvare>
In-Reply-To: <20090204225329.0ebb0fef@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 4 Feb 2009, Jean Delvare wrote:
> Another issue which still needs to be solved is the reporting of parse
> errors.

If you are going to have multiple config files, it might also be good to
report what files are being used, even when all of them parse OK.  This
would help the user detect a config file with permissions problems, or
that a config file didn't make it into the config directory for some
reason.  Maybe this only happens when -v is on, or similar.

> I fear that a clean solution would require an API change though.

The basic problem seems to be that you fopen the file and then pass a
FILE* down to the parser; I don't think you can work backwards to the
file name once you have a FILE*.  The API change would probably be to
pass the filename down as a string, either instead of the FILE* so the
parser can feed it to fopen, or along with the FILE* so the parser can
include the name in error messages.

Without an API change, you could do something like this.  This is based
on your patch 4/4.  fprintf(stderr) would probably get replaced by
sensors_error calls, and some of it might depend on a command-line
switch.

---
static int add_config_from_dir(const char *dir)
{
   	int i, count, res;
   	struct dirent **namelist;

   	count = scandir(dir, &namelist, config_file_filter, alphasort);
   	if (count < 0) {
   		if (errno = ENOMEM)
   			sensors_fatal_error(__func__, "Out of memory");
   		return 0;
   	}

   	for (res = 0, i = 0; !res && i < count; i++) {
   		int len;
   		char path[NAME_MAX];
   		FILE *input;

   		len = snprintf(path, NAME_MAX, "%s/%s", dir,
   			       namelist[i]->d_name);
   		if (len >= NAME_MAX)
   			sensors_fatal_error(__func__, "File name too long");

+		fprintf(stderr, "opening config file '%s': ", path);

   		input = fopen(path, "r");
   		if (input) {
+			fprintf(stderr, "ok; parsing: ");
   			res = parse_config(input);
+			if(res) {
   				/* parse problem */
+				fprintf(stderr, "error\n");
+			} else {
+				fprintf(stderr, "ok\n");
   			}
   			fclose(input);
+		}
+		else {
+		/* permissions problem, file disappeared, etc */
+			fprintf(stderr, "error\n");
+		}


   		free(namelist[i]);
   	}
   	free(namelist);

   	return res;
}
---

This still leaves it up to the user to connect the reported errors to a
file name which might not be on the same line.  In other words, the user
will see things like this:

---
opening config file 'ibm-5150.txt': ok; parsing: line 10: iin5 not valid
line 12: inn6 not valid
error
opening config file 'radeon-9500-asc.txt': ok; parsing: ok
---

and it might not be immediately obvious that "line 12" still refers to
ibm-5150.txt.  Also the naked "error" might be confusing.

In perfect happy world, something like this might be clearer:

---
opening ibm-5150.txt
ibm-5150.txt line 10: iin5 not valid
ibm-5150.txt line 12: inn6 not valid
opening radeon-9500-asc.txt
---

Matt Roberds


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
