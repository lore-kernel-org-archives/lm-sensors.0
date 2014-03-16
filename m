From: Jean Delvare <jdelvare@suse.de>
Date: Sun, 16 Mar 2014 11:06:18 +0000
Subject: Re: [lm-sensors] Any status update on supporting ITE IT8518E in lm-sensors?
Message-Id: <20140316120618.73d9703b@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1394202327.47510.YahooMailNeo@web160501.mail.bf1.yahoo.com>
In-Reply-To: <1394202327.47510.YahooMailNeo@web160501.mail.bf1.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi ianp,

On Fri, 7 Mar 2014 06:25:27 -0800 (PST), ianp wrote:
> I wish to setup lm-sensors on my Lenovo S110 netbook, but sensors-detect reports an 'unknown chip with ID 0x8518'.
> 
> There has been at least two requests from the Devices wiki page, but the links to the requests can't be accessed right now.

Unfortunately all links to the list archive were broken last time spam
was removed from the archive :( I've just fixed these ones.

> I request support for this chip as well.

I have added your request to the list. My feeling though is that a
native driver will never be written for this chip, as laptops have all
their power and thermal management done through ACPI.

-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
