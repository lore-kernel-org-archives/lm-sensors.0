From: michaelnel@comcast.net (Michael Nelson)
Date: Sun, 24 Dec 2006 02:11:41 +0000
Subject: [lm-sensors] Andigilog aSC7621 & Intel D975XBX2 Motherboard
Message-Id: <20061224021141.GA5428@seahunt.dyndns.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20061223234012.GA5410@seahunt.dyndns.org>
In-Reply-To: <20061223234012.GA5410@seahunt.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Dec 23, 2006 at 06:42:27PM -0700, George T. Joseph (development) wrote:
> Interesting.  I've tested the patch on 2.6.16, 2.6.18 and 2.6.19 kernels
> and it works every time.  I have NOT tested it with
> distribution-specific kernels though.  
> 
> Was drivers/hwmon/asc7xxx.c actually created?  The message from make
> implies that it wasn't.
> Were there ANY messages from patch?
> Does a 'patch -R' work cleanly? 

I found it in /usr/src/linux-2.6.19 ... which apparently it created during
the patch process.  Anyway, I copied the stuff I found there (including
asc7xxx.c) into the right places in the linux-2.6.18.2-34 tree and then
compiled again.  It worked, it built it. Rebooted the new kernel and it
inserted fine.

Sensors doesn't show much:

 sensors
 asc7621-i2c-0-2e
 Adapter: SMBus I801 adapter at 4000
 
 
... but gkrellm's sensor stuff shows five temps (one is the Nvidia GPU
temp), four fans, and all the voltages.  Some of the numbers are wierd, but
I suppose a properly tweaked /etc/sensors.conf should bring that in line.

Thanks!

Michael

-- 
If a kid asks where rain comes from, I think a cute thing to tell him is
"God is crying." And if he asks why God is crying, another cute thing to
tell him is "Probably because of something you did."

San Francisco, CA

