From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:23:34 +0000
Subject: How to activate the SMBus on P4B533E/ICH4?
Message-Id: <3D1247F9.73501DE@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.31.0206192315370.4147-100000@klaus.dns2go.com>
In-Reply-To: <Pine.LNX.4.31.0206192315370.4147-100000@klaus.dns2go.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

ich4 supported in CVS (assuming it's in lspci and you don't need p4b)
bach not supported

Klaus Woltereck wrote:
> 
> Hi,
> I just got a brand new board.
> Its a  Asus P4B533E with 845E/ICH4/W83791 on it, and a ASIC
> called 'ASB100-A Bach' :-/
> 
> As http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/prog/hotplug/README.p4b
> describes, Asus has the bad habit to disable the SMBus PCI-function
> somehow :(    The procedure in README.p4b seems not to work with the ICH4.
> 
> Does anyone have an idea how to activate the SMBus on the ICH4?
> 
> Thanks,
> Klaus
