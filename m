From: jim.cromie@gmail.com (Jim Cromie)
Date: Thu, 07 Sep 2006 16:55:20 +0000
Subject: [lm-sensors] libsensors config file scanner speed
Message-Id: <45004EF8.1090908@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060906033418.GA7775@jupiter.solarsys.private>
In-Reply-To: <20060906033418.GA7775@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Hi Mark,
>
>   
> Not to discourage you from working on the scanner, every additional
> improvement is welcome... But just to underline the well known fact
> that sensors.conf.eg has grown much larger than the original authors of
> libsensors thought it ever would, and as a result 95% of the
> configuration file we install by default is useless for each user, and
> ruins the "sensors" performance. This means that we really need
> dedicated configuration files for people to use instead of the default
> configuration file.
>
> Other possible approachs:
> * Having a smaller dedicated configuration file which would only
>   contain the safest defaults (chip manufacturer recommended compute
>   lines and labels). The rest could be moved to documentation.
> * Having a separate default file for each chip, and copying it (or
>   merging them) to /etc/sensors.conf when the user runs sensors-detect.
> * Delaying the scanning of the configuration data until after we know
>   which chips have been found of the system. So we could happily skip
>   the data which has not been found.
>
> Or maybe it's more interesting to put our energy in the configuration
> files database, and let the default configuration file as is in the
> hope that people won't use it anymore anyway.
>
>   

something like this ?

[jimc at harpo lm-sensors]$ ls etc/sensors.conf.d/
abituguru  adm9240   fscpos   k8temp  lm85c    maxilife  smsc47m192  
w83697hf
adm1021    as99127f  fscscy   lm63    lm87     mtp008    via686a     w83782d
adm1024    asb100    gl518sm  lm75    lm90     pc87366   vt1211      w83783s
adm1025    bmc       gl520sm  lm78    lm92     pcf8591   vt8231      w83792d
adm1030    f71805f   it87     lm80    lm99     sis5595   w83627ehf   w83793
adm1031    fscher    it8716   lm83    max1619  smsc47m1  w83627thf   
w83l785ts

assuming yes, attached script will do the scut-work.

Before you use it for real, the sensors.conf.eg file needs some comments 
moved below
the "chip <foo>" lines they pertain to, otherwize theyre written into 
the wrong file.
I'll do that juggling if you want to go this route.

-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: split-sensors
Url: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060907/d76a67f6/attachment-0001.pl 
