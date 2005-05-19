From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:52 +0000
Subject: lm-sensors-2.70 and chip W83977EF
Message-Id: <20030405214152.3c0ced22.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200304040904.02936.jean.ribiere@wanadoo.fr>
In-Reply-To: <200304040904.02936.jean.ribiere@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


[PLEASE ALWAYS ANSWER TO THE LIST, NOT TO ME ALONE]

(You'd think people would figure out by themselves...)

> I have examined the informations in the BIOS setup :
> - Temperature warning 70?C/158?F
> - CPU (CON2) Temperature : N/A
> - System temperature : varies from 31?C to 32?C
> - CPU Fan : 0 RPM
> - Chassis Fan : 0 RPM
> - VCore : varies from 1.63V to 1.64V
> - 3.3V : varies from 3.36V to 3.37V
> - +5V : stable  5.16V
> - +12V : varies from 11.97 to 12.03 V
> - -12V : stable -12.03 V
> 
> I have also installed livewiredev under Windows, withe the same
> results
> 
> So I have modified sensors.conf to ignore fans, in6 and temp1 and the 
> output is conform to the BIOS information.

So my theory was exact, nothing was wrong, only unused sensors.

> For information, I had a problem in the installation :
> the script lm_sensors.init contains a line :
> . /etc/init.d/functions
> but in Slackaware I don't have a directory /etc/init.d
> so I had to modify this script to define echo_failure() and
> echo_success()

This script is intended for Red Hat-like distributions, which Slackware
isn't. That's why the script isn't installed by default on non Red
Hat-like systems.

By the was, Slackware users are supposed to be clever enough to tweak
the initscripts by themselves to make them work for their system
(Slackware user speaking ;)).

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
