From: michaelnel@comcast.net (Michael Nelson)
Date: Wed, 20 Sep 2006 20:40:17 +0000
Subject: [lm-sensors] Asus P5B
Message-Id: <20060920204017.GA17945@seahunt.dyndns.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <b62408800609201018k102f2869wa8f97d0c83021fc8@mail.gmail.com>
In-Reply-To: <b62408800609201018k102f2869wa8f97d0c83021fc8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Sep 20, 2006 at 10:05:18PM +0200, Jean Delvare wrote:
> Ah, this is a misdetection. You don't have an LM78 chip. So the output
> above is crap. You must unload the lm78 driver, and use the w83627ehf
> driver instead - once David is done with adding support for your chip.

David's driver works very well on my P5B Deluxe WiFi AP.  Unfortunately, I
can't use it right now.  It is for the 2.6.18 series kernels, and 2.6.18 has
broken support for the JMicron IDE/SATA controller on my motherboard.  Alan
Cox's latest patch kills the kernel upon loading, so for right now I'm just
back to running the stock SuSE 10.1 kernel (2.6.16.something) and living
without sensors and my DVD.

Life sucks when you are using a MB that is riding the foreskin of technology.

I will revisit 2.6.18 when it's released.

Thanks for your work, David!

Michael

-- 

San Francisco, CA

