From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:37 +0000
Subject: Bug in /etc/sysconfig/lm_sensors
Message-Id: <3D5F08B3.C1920070@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3D5A8352.7070108@yahoo.es>
In-Reply-To: <3D5A8352.7070108@yahoo.es>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

thanks.
fixed in CVS.
mds

Ricardo Fernandez wrote:
> 
>       Hi, i'm using lm_sensors-2.6.4.tar.gz and i've found a bug in
> /etc/sysconfig/lm_sensors.
> 
> your  /etc/sysconfig/lm_sensors look like this
> 
> MODULE_1=xxxxxxxx
> MODULE_2=xxxxxxx
> MODULE_3=xxxxxxx
> MODULE_4=xxxxxxx
> 
> If you have to load 4 modules. The file must be look like this
> 
> MODULE_0=xxxxxx    <---- look this
> MODULE_1=xxxxxx
> MODULE_2=xxxxxxx
> MODULE_3=xxxxxxx
> 
> The module secuence must start with 0 because in the init script $i
> start with that number. Otherwise, the last module _never_ will be loaded.
> 
> Thanx for your time and excuse my poor english
