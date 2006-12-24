From: michaelnel@comcast.net (Michael Nelson)
Date: Sun, 24 Dec 2006 01:22:25 +0000
Subject: [lm-sensors] Andigilog aSC7621 & Intel D975XBX2 Motherboard
Message-Id: <20061224012224.GA16594@seahunt.dyndns.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20061223234012.GA5410@seahunt.dyndns.org>
In-Reply-To: <20061223234012.GA5410@seahunt.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Dec 23, 2006 at 05:44:49PM -0700, George T. Joseph (development) wrote:
> 
> Anyway, apply the patch to a 2.6.18 or greater kernel.

I tried applying it to SUSE 10.2's linux-2.6.18.2-34 kernel source.  It
seemed to apply OK and I enabled it in .config, but when I recompiled the
kernel:

<snip>

  CC [M]  drivers/hwmon/adm1031.o
  CC [M]  drivers/hwmon/adm9240.o
make[2]: *** No rule to make target drivers/hwmon/asc7xxx.c', needed by drivers/hwmon/asc7xxx.o'.  Stop.
make[1]: *** [drivers/hwmon] Error 2
make: *** [drivers] Error 2
    
So I guess it actually did not apply the patch correctly.    

Michael

-- 
If a kid asks where rain comes from, I think a cute thing to tell him is
"God is crying." And if he asks why God is crying, another cute thing to
tell him is "Probably because of something you did."

San Francisco, CA

