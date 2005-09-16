From: aurelien@aurel32.net (Aurelien Jarno)
Date: Fri, 16 Sep 2005 12:04:07 +0000
Subject: [lm-sensors] sensord and RAM SPD
Message-Id: <432A9865.2000509@aurel32.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050916094258.GA26164@bode.aurel32.net>
In-Reply-To: <20050916094258.GA26164@bode.aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare a ?crit :
> Considering that:
> * the code was outdated for a long time and nobody complained;
> * SPD EEPROMs are not sensors;
> * SPD EEPROM values never change;
> * eeprom support will be ultimately dropped from libsensors;
> I'd prefer that we plain drop eeprom support from sensord.
> 
That's also fine with me. Do you want a patch for that?

Aurelien

-- 
   .''`.  Aurelien Jarno             | GPG: 1024D/F1BCDB73
  : :' :  Debian GNU/Linux developer | Electrical Engineer
  `. `'   aurel32@debian.org         | aurelien@aurel32.net
    `-    people.debian.org/~aurel32 | www.aurel32.net
