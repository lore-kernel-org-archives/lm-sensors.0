From: Matt Roberds <mattroberds@cox.net>
Date: Fri, 13 Feb 2009 05:23:12 +0000
Subject: Re: [lm-sensors] [PATCH 4/6] Read extra configuration files from
Message-Id: <Pine.LNX.4.64.0902122322560.32383@birdbird.example.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090211175008.0f843712@hyperion.delvare>
In-Reply-To: <20090211175008.0f843712@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 11 Feb 2009, Jean Delvare wrote:
> Read extra configuration files from /etc/sensors.d.

[...]
> +static int add_config_from_dir(const char *dir)
[...]
> +	for (res = 0, i = 0; !res && i < count; i++) {
> +		int len;
> +		char path[16 + NAME_MAX];
> +		FILE *input;
> +
> +		len = snprintf(path, sizeof(path), "%s/%s", dir,
> +			       namelist[i]->d_name);
> +		if (len < 0 || len >= (int)sizeof(path)) {
> +			res = -SENSORS_ERR_PARSE;
> +			continue;
> +		}

This says that the maximum length of the path to the config files is 16
characters?  Seems kind of short.  By default this will be
"/etc/sensors.d/" which clocks in at 15 bytes.  If somebody wants to use
(say) "/usr/local/etc/sensors.d/" they'll be out of luck.  Maybe
something like

char path[PATH_MAX + NAME_MAX];

would be better?

> +++ lm-sensors/lib/sensors.conf.5	2009-02-11 10:30:22.000000000 +0100
[...]
> +A directory where you can put additional libsensors configuration files.
> +Files found in this directory will be processed in alphabetical order after
> +the default configuration file. Files those name starts with a dot are
                                           ^
Spelling: "Files whose name starts"

> +++ lm-sensors/lib/libsensors.3	2009-02-11 10:29:09.000000000 +0100
[...]
> +A directory where you can put additional libsensors configuration files.
> +Files found in this directory will be processed in alphabetical order after
> +the default configuration file. Files those name starts with a dot are
                                           ^
Spelling: "Files whose name starts"

Matt Roberds


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
