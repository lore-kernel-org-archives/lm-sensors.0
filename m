From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 05 Feb 2009 12:55:08 +0000
Subject: Re: [lm-sensors] [RFC 0/4] Add support for multiple configuration
Message-Id: <20090205135508.43d7ec47@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090204225329.0ebb0fef@hyperion.delvare>
In-Reply-To: <20090204225329.0ebb0fef@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Matt,

On Wed, 4 Feb 2009 20:29:40 -0600 (CST), Matt Roberds wrote:
> On Wed, 4 Feb 2009, Jean Delvare wrote:
> > Another issue which still needs to be solved is the reporting of parse
> > errors.
> 
> If you are going to have multiple config files, it might also be good to
> report what files are being used, even when all of them parse OK.  This
> would help the user detect a config file with permissions problems, or
> that a config file didn't make it into the config directory for some
> reason.  Maybe this only happens when -v is on, or similar.

We definitely don't want to print which configuration files are used by
default, the end user shouldn't have to care. Permission problems
should be reported regardless (my patch currently fails to do so,
thanks for pointing it out.) We could have option "-v" to print this
information, or maybe a dedicated mode (--test-config) that would
solely test that the configuration files are OK, without actually
reading sensor values. This latter option seems more useful as it could
be used by automatic configuration tools to validate their work.

That being said, all approaches would first require to extend the
libsensors API, as currently the choice of the default configuration
file(s) is left to the library and opaque to the user. We don't have a
channel to report it back.

This however is somewhat beyond the scope of my patch set. I think it
is important to get support for multiple configuration files quickly,
because other improvements depend on that. The improvement of error
reporting can wait.

> > I fear that a clean solution would require an API change though.
> 
> The basic problem seems to be that you fopen the file and then pass a
> FILE* down to the parser; I don't think you can work backwards to the
> file name once you have a FILE*.

Correct. This is however not the primary problem I had in mind. What
worries me more is the prototype of sensors_default_parse_error(),
because it is part of the API so we can't change it.

The fact that the user-space programs pass a FILE* rather than a file
name is what makes it possible to read the configuration file from
stdin (in sensors) or virtually from anywhere the user wants (sandbox,
network...) While this feature never stroke me as terribly useful, this
must have been the motivation for this specific part of the API (that
was before I joined the project.)

Note that this isn't necessarily a problem as far as API changes are
concerned. The need to let the user know in which configuration file a
parse error occurred only exists when the user did _not_ pass a FILE*
for the configuration. If he/she did, then libsensors will only process
that specific file (or whatever it actually is) so there is no need for
disambiguation.

> The API change would probably be to
> pass the filename down as a string, either instead of the FILE* so the
> parser can feed it to fopen, or along with the FILE* so the parser can
> include the name in error messages.

Yes, passing the file name as an extra parameter makes sense. My
initial idea was to simply remember the file name in a global variable,
but this wouldn't work for all errors.

> Without an API change, you could do something like this.  This is based
> on your patch 4/4.  fprintf(stderr) would probably get replaced by
> sensors_error calls, and some of it might depend on a command-line
> switch.

I don't really want to abuse sensors_error() for informative or debug
messages. But stderr isn't an option either. As I said above, the
problem is that we really lack the proper channel to return non-error
information down to the library user.

> ---
> static int add_config_from_dir(const char *dir)
> {
>    	int i, count, res;
>    	struct dirent **namelist;
> 
>    	count = scandir(dir, &namelist, config_file_filter, alphasort);
>    	if (count < 0) {
>    		if (errno = ENOMEM)
>    			sensors_fatal_error(__func__, "Out of memory");
>    		return 0;
>    	}
> 
>    	for (res = 0, i = 0; !res && i < count; i++) {
>    		int len;
>    		char path[NAME_MAX];
>    		FILE *input;
> 
>    		len = snprintf(path, NAME_MAX, "%s/%s", dir,
>    			       namelist[i]->d_name);
>    		if (len >= NAME_MAX)
>    			sensors_fatal_error(__func__, "File name too long");
> 
> +		fprintf(stderr, "opening config file '%s': ", path);
> 
>    		input = fopen(path, "r");
>    		if (input) {
> +			fprintf(stderr, "ok; parsing: ");
>    			res = parse_config(input);
> +			if(res) {
>    				/* parse problem */
> +				fprintf(stderr, "error\n");
> +			} else {
> +				fprintf(stderr, "ok\n");
>    			}
>    			fclose(input);
> +		}
> +		else {
> +		/* permissions problem, file disappeared, etc */
> +			fprintf(stderr, "error\n");
> +		}
> 
> 
>    		free(namelist[i]);
>    	}
>    	free(namelist);
> 
>    	return res;
> }
> ---
> 
> This still leaves it up to the user to connect the reported errors to a
> file name which might not be on the same line.  In other words, the user
> will see things like this:
> 
> ---
> opening config file 'ibm-5150.txt': ok; parsing: line 10: iin5 not valid
> line 12: inn6 not valid
> error
> opening config file 'radeon-9500-asc.txt': ok; parsing: ok
> ---
> 
> and it might not be immediately obvious that "line 12" still refers to
> ibm-5150.txt.  Also the naked "error" might be confusing.

The more critical problem is that errors might happen later. The line
number is stored in several data structures for this reason. The most
common case is "set" statements which fail on "sensors -s". If you
didn't store the configuration file name when you had a chance, you
simply don't have it available when you need it.

> In perfect happy world, something like this might be clearer:
> 
> ---
> opening ibm-5150.txt
> ibm-5150.txt line 10: iin5 not valid
> ibm-5150.txt line 12: inn6 not valid
> opening radeon-9500-asc.txt
> ---

This would indeed be ideal, however this seems impossible to do without
an API change. One possibility would be to add a new callback with the
extra parameter, but there are still compatibility concerns. I'll think
about it.

Thanks for your comments.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
