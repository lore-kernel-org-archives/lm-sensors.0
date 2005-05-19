From: joden@lee.k12.nc.us (James Olin Oden)
Date: Thu, 19 May 2005 06:25:01 +0000
Subject: Intel 6300ESB ICH smbus driver support
Message-Id: <Pine.LNX.4.58.0406181756460.19803@malachi.lee.k12.nc.us>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.58.0406171117570.23892@malachi.lee.k12.nc.us>
In-Reply-To: <Pine.LNX.4.58.0406171117570.23892@malachi.lee.k12.nc.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 17 Jun 2004, James Olin Oden wrote:

> Hi All,
> 
> I have a board with the Intel 6300ESB ICH which contains an integrated
> smbus controller (is that the right terminology?).  Sensors does not seem 
> to detect this smbus controller, but after some groking of code it seems
> like it should.  The reason I say this, is I downloaded some patches to 
> the i2c-i801.c bus driver from intel for this ICH and then looked in 
> the latest sources (v2.8.7 of lm_sensors) and found what looked to be 
> the equivelant stuff being done in that source as in the patch (I say 
> equivelant, because Intel had generated their patch against the lm_sensors 
> that came with the RH 8 distro, so for instance structure initilization 
> was not done according to C99 in the Intel patch).  Basically, the patch
> and the source both simply say that the device in question is known by
> 0x25a4, and then the current source actually attempts to support some
> of its more advanced features.
> 
> Anyway, when I manually try to load the i2c-i801 driver it simply says the 
> i801 driver is not detected.  What might be wrong or what can I do next?
> 
> Many Thanks...james
> 
It was my fault.  The driver needed was indeed i2c-i801, but it only 
works if you compile against the kernel sources used to build the actual
kernel running on the target.  I knew this, but somehow I oopsed.  So 
yes 2.8.7 does support the Intel 6300ESB ICH.

..james
