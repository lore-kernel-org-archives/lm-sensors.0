From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Date: Sun, 12 Aug 2007 10:43:53 +0000
Subject: Re: [lm-sensors] 2.6.23-rc1 regression: hwmon/w83627ehf: wrong fan
Message-Id: <46BEE469.8080403@s5r6.in-berlin.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <46B5B290.4040907@s5r6.in-berlin.de>	<20070805162141.GI6221@jupiter.solarsys.private>	<46B6053E.2050708@s5r6.in-berlin.de>	<20070810230831.59cbc50f@hyperion.delvare>	<46BCE6D0.7060300@s5r6.in-berlin.de>	<20070811135705.0d0688d7@hyperion.delvare>	<46BDD8B3.8070708@s5r6.in-berlin.de> <20070812111713.1afb24c6@hyperion.delvare> <46BEE247.4040904@s5r6.in-berlin.de>
In-Reply-To: <46BEE247.4040904@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: "Mark M. Hoffman" <mhoffman@lightlink.com>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

I wrote:
> Jean Delvare wrote:
>> One remaining mystery is why you did not observe the problem with the
>> older kernel. Maybe the ACPI thermal driver was not loaded (or not
>> working) back then?
> 
> I found two differences:  Gentoo's udev init script autoloads thermal on
> boot under 2.6.23-rc2 but it doesn't under 2.6.22(-rc5), for a reason
> unknown to me.  If I manually load thermal under 2.6.22(-rc5),
[...]

The reason are obviously some post 2.6.22/ pre 2.6.23-rc1 commits which
add module aliases to ACPI drivers.
-- 
Stefan Richter
-===-=-== =--- -=--
http://arcgraph.de/sr/

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
