From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Sun, 05 Mar 2006 20:53:09 +0000
Subject: [lm-sensors] ADM1024
Message-Id: <440B4FB5.400@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <002a01c23476$84783190$0201d00a@hq.pc3.xstreamis.com>
In-Reply-To: <002a01c23476$84783190$0201d00a@hq.pc3.xstreamis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Steven A. DuChene wrote:
> The non-2.6-integrated module code does indeed exist in the lm_sensors
> source but I do not see any mention of anyone working on porting it
> to the new 2.6 kernel hwmon infrastructure. The boards with the adm1024
> exist (at least in Murray's and my case) and I am more than willing to test
> any pre-release code or if there is good documentation on what has to
> be done to migrate existing 2.4 modules for chips to the 2.6 hwmon chip
> module code stuff I wouldn't mind looking that over as well.


Yes it is in the  porting-clients  see the Documentation/i2c/ directory.

You may also take a look how other drivers look like, mainly the interface
has been changed so please check the hwmon/sysfs-interface file too. If you
need further help with porting please write back.

Good luck,

Regards
Rudolf

