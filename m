From: adrian@humboldt.co.uk (Adrian Cox)
Date: Thu, 19 May 2005 06:25:08 +0000
Subject: i2c multi-master mode
Message-Id: <1091808938.2279.39.camel@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <200407300939.54751.bjanz@mac.com>
In-Reply-To: <200407300939.54751.bjanz@mac.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 2004-08-05 at 12:06, Burt Janz wrote:
> Precisely.  I don't expect to be operating in both modes simultaneously on the 
> same port... but, since the MPC5200 does have 2 I2C ports, it is quite 
> possible that one might be in "slave" and the other in "master" at the same 
> time.

Just so you know, I2C on the MPC5200 has been discussed a few times on
the linuxppc-embedded list recently. My driver for MPC107/824x/85xx/52xx
is in Greg KH's queue and should go to Linus sometime after 2.6.8 comes
out. The MPC5200 requires further patches to add the correct OCP
entries; Sylvain Munaut is preparing these. The driver does have some
problems with interrupts on MPC5200, but I'm told it works correctly in
polled mode.

See the archive:
http://lists.linuxppc.org/linuxppc-embedded/200407/msg00388.html
and mail me if you want to see the tidied version.

- Adrian Cox
Humboldt Solutions Ltd.

