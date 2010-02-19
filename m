From: Andre Prendel <andre.prendel@gmx.de>
Date: Fri, 19 Feb 2010 19:38:21 +0000
Subject: [lm-sensors] [RFC PATCH v1 0/2] Add the sensors-config tool
Message-Id: <20100219193821.GA1917@andre-laptop>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

here is an updated version of the sensors-config tool.

Changes in v2:

Now the tool parses the configuration pages from lm-sensors.org to
determine the available config files.

Further I've introduced some metadata to the config files. For the
moment these are

# board_vendor: BOARDVENDOR
# board_name: BOARDNAME

The related files are located under /sys/class/dmi/id. board_name can
appear multiple times. So one config file can be used for several
motherboards.

The config files now will be installed under /var/lib and a matching
config will be copied as automobo.conf to /etc/sensors.d.

And I added a short script for use at startup. The script looks for an
suitable config and installs it otherwise it deletes an existing one.

So, this should address most of your comments from last email.

First question: What do you thing about the header keywords?

Maybe we could choose some of the available configs and add a
header. So you and can test the tool by yourself.

Second question: What should we use for the header data?

I'd suggest to only use a substring of the real dmi string. The
sensors-config tool don't need an exact match of the string.

For example

# board_vendor: Asus

matches for

ASUS
asus
Asus
ASUSTeK Computer INC.
...

Ok Hans, it's your turn.

Thanks,
Andre

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
