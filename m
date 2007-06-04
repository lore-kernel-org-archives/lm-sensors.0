From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 04 Jun 2007 15:37:52 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] hwmon/sis5595: Convert to a platform
Message-Id: <20070604173752.2f1f68c4@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070603174224.44353a33@hyperion.delvare>
In-Reply-To: <20070603174224.44353a33@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Ivo,

On Mon, 4 Jun 2007 14:42:30 +0200, Ivo Manca wrote:
> I'll try to get it working on the pc. Since it's only a 333mhz Celeron cpu 
> with about 32MB of ram, it might take some while to fetch a new kernel and 
> compile it ;). Or are there any other ways I can compile it with less 
> effort?

If you have another system of the same architecture, you can simply
compile your kernel there, make a staged install (set INSTALL_PATH and
INSTALL_MOD_PATH) and copy all the files over the network.

Or if you have other systems with the same architecture _and_ compiler,
look into distcc. I have been using it some times ago and it was
working fine.
http://distcc.samba.org/

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
