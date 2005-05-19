From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:29 +0000
Subject: lm_sensors, or rather /etc/conf.d/sensors
Message-Id: <20031212220928.447f5e4d.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Sometimes a module needs a parameter, such as the it87 for Asus A7V600
> board, eg to define sensor types.  However, nowhere is it stated how
> to include a parameter.
> After advice from Peter Ruskin on the gentoo-user list, I tried two
> methods that worked: putting the module with parameter in the 
> modules.autoload/<kernel-version> file; and adding the parameter in
> the conf.d/sensors file as 
> MODULE_1='it87 temp_type=0x1c'
> 
> My suggestion is that instructions for adding parameters to modules
> are added to the text of conf.d/sensors.  Maybe there is a better way
> - or maybe even a Gentoo-standard way of handling this type of
> problem?

I think you would simply create /etc/modules.d/it87 with "options it87
temp_type=0x1c" in it, and you're done. Not tried myself, I don't have
a Gentoo.

FYI, starting with lm_sensors 2.8.2, released today, you don't have to
provide the "temp_type" parameter. The sensor type can be chosen through
the /etc/sensors.conf file.

Hope that helps.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
