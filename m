From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Tue, 19 Dec 2006 13:22:55 +0000
Subject: [lm-sensors] generic chip support for sensors
Message-Id: <20061219132255.GD5240@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20061210000539.1f2f2bbd@ws01.atreidis.nl.eu.org>
In-Reply-To: <20061210000539.1f2f2bbd@ws01.atreidis.nl.eu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi again:

* Mark M. Hoffman <mhoffman at lightlink.com> [2006-12-19 08:11:01 -0500]:
> In fact, given the code below... you could do something like this for the sake
> of efficiency:
> 
> 		if (name = strchr(name + 5, '_'))
> 			return SENSORS_FEATURE_TEMP;
> 

Err, of course I meant to write (!(name = strchr(name + 5, '_')))

I guess that means we *would* be better off using regcomp(3).

> +		if (strstr(name, "hyst"))
> +			return SENSORS_FEATURE_TEMP_HYST;
> 
> And then the above would become:
> 
> 		if (!strncmp(name + 1, "hyst", 4))
> 
> etc.

Regards,

-- 
Mark M. Hoffman
mhoffman at lightlink.com


