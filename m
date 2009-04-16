From: Andre Prendel <andre_prendel@gmx.de>
Date: Thu, 16 Apr 2009 07:40:45 +0000
Subject: Re: [lm-sensors] Labling the fans
Message-Id: <20090416074044.GA4511@ubuntu>
List-Id: <lm-sensors.vger.kernel.org>
References: <1239315751.23846.5@mtranch.mtranch.com>
In-Reply-To: <1239315751.23846.5@mtranch.mtranch.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Apr 09, 2009 at 03:22:31PM -0700, Geoffrey Leach wrote:
> When I moved up to v 3.1.0 the seed of my CPU fan is now detected 
> (yea!), but the label is now "fan2" (boo!), and who can remember that?
> 
> Is there a way to change "fann" to something more useful?

You have to edit your sensors configuration file. See man 5
sensors.conf (LABEL STATEMENT).

The default config file is /etc/sensors3.conf.

In the first line of the sensors output you can find your sensor
chip. Search the line starting with

 chip "FIRST_LINE_OF_SENSORS_OUT"

in /etc/sensors3.conf.

Below that you will find some statements labeling the sysfs files to
more readable names. Edit the last argument to your desired value.

Here is an example for the Winbond W83792AD/D chip (from /etc/sensors3.conf):

[...]
chip "w83792d-*"

    label in0 "VCoreA"
    label in1 "VCoreB"
    label in2 "VIN0"
    label in3 "VIN1"
    label in4 "VIN2"
    label in5 "VIN3"
    label in6 "5VCC"
    label in7 "5VSB"
    label in8 "VBAT"
    label fan1 "Fan1"
    label fan2 "Fan2"
    label fan3 "Fan3"
    label fan4 "Fan4"
    label fan5 "Fan5"
    label fan6 "Fan6"
    label fan7 "Fan7"
    [...]

Andre

> 
> 
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
