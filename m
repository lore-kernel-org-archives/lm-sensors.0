From: linux-clusters@mindspring.com (Steven A. DuChene)
Date: Fri, 03 Mar 2006 20:43:59 +0000
Subject: [lm-sensors] ADM1024
Message-Id: <261519.1141418639369.JavaMail.root@mswamui-backed.atl.sa.earthlink.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <002a01c23476$84783190$0201d00a@hq.pc3.xstreamis.com>
In-Reply-To: <002a01c23476$84783190$0201d00a@hq.pc3.xstreamis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The non-2.6-integrated module code does indeed exist in the lm_sensors
source but I do not see any mention of anyone working on porting it
to the new 2.6 kernel hwmon infrastructure. The boards with the adm1024
exist (at least in Murray's and my case) and I am more than willing to test
any pre-release code or if there is good documentation on what has to
be done to migrate existing 2.4 modules for chips to the 2.6 hwmon chip
module code stuff I wouldn't mind looking that over as well.

Murray Blakeman wrote:
> Where can I get this module from?
>
> I am running Linux Kernel 2.6.15.1 and the ADM1024 module doesn't appear to
> be part of it.
>
>
>   

Jim Cromie replied:
> forgive me for not knowing, but you presume it to be supported ? but omitted ?
>
> IOW, did you check if it is supported ?  and if not, are you interested in adding it ?
>
> I'm not trying to be snide here; there are other adm 102x devices supported,
> (I hacked at 1026.c, but I dont have the chip to sanity test the patch,
> and apparently no-one else does either)

