From: Andre Prendel <andre_prendel@gmx.de>
Date: Wed, 22 Apr 2009 07:34:53 +0000
Subject: Re: [lm-sensors] [PATCH 6/8] sensord: Refactoring of loadConfig()
Message-Id: <20090422073453.GB5937@ubuntu>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090406075745.GG4734@ubuntu>
In-Reply-To: <20090406075745.GG4734@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

On Mon, Apr 20, 2009 at 12:10:48PM +0200, Jean Delvare wrote:
> On Mon, 6 Apr 2009 09:57:45 +0200, Andre Prendel wrote:
> > This patch does some refactoring of the loadConfig()
> > function.
> > ---
> > 
> > * Simplifying the conditions makes code flow clearer and eliminates
> > long lines (> 80 chars).
> > * Removed useless stat() call.
> > * Return -1 in error case, instead of several positiv values (never defined).
> 
> Spelling: positive.
> 
> If you make loadConfig() always return -1 on error then you also want
> to clean up the error message that is printed when reloadLib() fails,
> to no longer include the (now pointless) error value.
> 

You're right, thanks. It seems you're a very attentive reviewer :)

> This patch adds the following compilation warning:
> prog/sensord/lib.c: In function ‘loadConfig’:
> prog/sensord/lib.c:72: warning: ‘ret’ may be used uninitialized in this function
> Please fix.

Will do that. It's related to the wrong sensors_strerror() call you found.

> > 
> >  lib.c |   76 +++++++++++++++++++++++++++++++++++-------------------------------
> >  1 file changed, 41 insertions(+), 35 deletions(-)
> > 
> > --- quilt-sensors.orig/prog/sensord/lib.c	2009-04-03 09:31:57.000000000 +0200
> > +++ quilt-sensors/prog/sensord/lib.c	2009-04-04 18:30:46.000000000 +0200
> > @@ -20,7 +20,7 @@
> >   * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
> >   * MA 02110-1301 USA.
> >   */
> > -
> > +#include <errno.h>
> 
> I do like a blank line before the first include ;)

That's fine with me.

> 
> >  #include <stdio.h>
> >  #include <stdlib.h>
> >  #include <string.h>
> > @@ -34,46 +34,59 @@
> >  
> >  static int loadConfig(const char *cfgPath, int reload)
> >  {
> > -	struct stat stats;
> > -	FILE *cfg = NULL;
> > -	int ret = 0;
> > -
> > -	if (cfgPath && !strcmp(cfgPath, "-")) {
> > -		if (!reload) {
> > -			if ((ret = sensors_init(stdin))) {
> > -				sensorLog(LOG_ERR,
> > -					  "Error loading sensors configuration file <stdin>: %s",
> > -					  sensors_strerror(ret));
> > -				ret = 12;
> > -			}
> > -		}
> > -	} else if (cfgPath && stat(cfgPath, &stats) < 0) {
> > -		sensorLog(LOG_ERR,
> > -			  "Error stating sensors configuration file: %s",
> > -			  cfgPath);
> > -		ret = 10;
> > -	} else {
> > -		if (reload) {
> > -			sensorLog(LOG_INFO, "configuration reloading");
> > -			sensors_cleanup();
> > -		}
> > -		if (cfgPath && !(cfg = fopen(cfgPath, "r"))) {
> > -			sensorLog(LOG_ERR,
> > -				  "Error opening sensors configuration file: %s",
> > -				  cfgPath);
> > -			ret = 11;
> > -		} else if ((ret = sensors_init(cfg))) {
> > -			sensorLog(LOG_ERR,
> > -				  "Error loading sensors configuration file %s: %s",
> > -				  cfgPath ? cfgPath : "(default)",
> > -				  sensors_strerror(ret));
> > -			ret = 11;
> > -		}
> > -		if (cfg)
> > -			fclose(cfg);
> > -	}
> > +	int ret;
> > + 	FILE *fp;
> >  
> > -	return ret;
> > + 	/* Load default configuratinon. */
> 
> Typo: configuration.

Thanks.

> 
> > + 	if (!cfgPath) {
> > + 		if (reload)
> > +  			sensors_cleanup();
> 
> The original code was logging that the configuration file was being
> reloaded. This seemed a useful feature to me, why did you remove it?
> 

Not a certain reason. So I will bring back the logging.

> > +
> > + 		ret = sensors_init(NULL);
> > + 		if (ret) {
> > + 			sensorLog(LOG_ERR, "Error while loading default"
> 
> I suggest dropping the "while" for consistency.

Will do it.

> 
> > + 				  " configuration file: %s",
> > + 				  sensors_strerror(ret));
> > + 			return -1;
> > +  		}
> > + 		return 0;
> > + 	}
> > +
> > + 	/* Read config from stdin. */
> > + 	if (!strcmp(cfgPath, "-")) {
> 
> As a side note, reading the configuration from stdin doesn't strike me
> as something terribly useful. I wouldn't mind dropping support for
> this, to make the code more simple.

I agree. Will drop that.

> 
> > + 		if (reload)
> > + 			return 0;
> > +
> > + 		ret = sensors_init(stdin);
> > + 		if (ret) {
> > + 			sensorLog(LOG_ERR, "Error loading sensors"
> > + 				  " configuration file <stdin>: %s",
> > +  				  sensors_strerror(ret));
> > + 			return -1;
> > +  		}
> > + 		return 0;
> > +  	}
> > +
> > + 	fp = fopen(cfgPath, "r");
> > + 	if (!fp) {
> > + 		sensorLog(LOG_ERR, "Error opening config file %s: %s",
> > + 			  sensors_strerror(ret));
> 
> This call to sensors_strerror() is clearly incorrect, fopen() isn't
> part of the libsensors API ;)

You're right again. Will fix it.

> > + 		return -1;
> > + 	}
> > +
> > + 	ret = sensors_init(fp);
> > + 	if (ret) {
> > + 		if (reload)
> > + 			sensors_cleanup();
> 
> The logic looks all wrong to me. In reload mode, you have to call
> sensors_cleanup() _before_ sensors_init()!

And again :)

> 
> > +
> > + 		sensorLog(LOG_ERR, "Error loading sensors config file %s: %s",
> > + 			  cfgPath, sensors_strerror(ret));
> 
> It would also be nice to consistently use "config file" or
> "configuration file" in all messages. I think the latter has my
> preference.

And again :))

> 
> > + 		fclose(fp);
> > + 		return -1;
> > + 	}
> > + 	fclose(fp);
> > +
> > + 	return 0;
> >  }
> >  
> >  int loadLib(const char *cfgPath)
> 
> 
> -- 
> Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
