From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 12 Jan 2013 21:47:05 +0000
Subject: Re: [lm-sensors] [PATCH v2] hwmon: Driver for Maxim MAX6697 and compatibles
Message-Id: <20130112224705.72fd59d2@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1355722390-24798-1-git-send-email-linux@roeck-us.net>
	<20130111174105.GA23433@roeck-us.net>
In-Reply-To: <20130111174105.GA23433@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: lm-sensors@lm-sensors.org, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Rob Landley <rob@landley.net>, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org

Hi Guenter,

On Fri, 11 Jan 2013 09:41:05 -0800, Guenter Roeck wrote:
> On Sun, Dec 16, 2012 at 09:33:09PM -0800, Guenter Roeck wrote:
> > Add support for MAX6581, MAX6602, MAX6622, MAX6636, MAX6689, MAX6693,
> > MAX6694, MAX6697, MAX6698, and MAX6699 temperature sensors
> > 
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> 
> I plan to line this driver up for 3.9. Only change from the code below is to
> replace SENSORS_LIMIT with clamp_val. Any objections, make yourself heard.

I am in the process of reviewing this driver, I do have some comments
and hope to be done by tomorrow evening.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
