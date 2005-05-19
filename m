From: mds@mds.gotdns.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:25:38 +0000
Subject: TI TMP101 driver
Message-Id: <42167F07.6090809@mds.gotdns.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050218154856.GA14189@home.fluff.org>
In-Reply-To: <20050218154856.GA14189@home.fluff.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

isn't this chip compatible with the LM75 and its driver?
what's different about it if anything?


Ben Dooks wrote:
> Driver for the TI TMP101 i2c temperature sensor chip.
> 
> Note, although the TMP101 is capable of SM-Bus alert,
> I do not have that capability on any of the systems
> I have these chips fitted on, so have not tested
> it
> 
> Signed-off-by: Ben Dooks <ben-linux@fluff.org>
> 
> 
