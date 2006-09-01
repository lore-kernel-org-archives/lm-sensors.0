From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 01 Sep 2006 10:32:12 +0000
Subject: [lm-sensors] Is the Intel i945G supported/planned?
Message-Id: <20060901123212.cbbf6963.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <ce9ef0d90608291525r42520432gd67005073da32057@mail.gmail.com>
In-Reply-To: <ce9ef0d90608291525r42520432gd67005073da32057@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Sunil,

> yeah, I messed up a bit. i2c-dev is indeed a module and I didn't modprobe it
> before I ran sensors-detect.
> 
> But doesn't make much difference. I re-ran the sensors-detect and this time
> I asked it to load the i2c-dev. Didn't find any chip this time either.

It may not make much difference for your old sensors-detect and for
you, but it may make for us especially if you use the latest version of
sensors-detect:
http://www.lm-sensors.org/browser/lm-sensors/trunk/prog/detect/sensors-detect?format=txt

So please give it a try and report the full output. Maybe it won't find
anything, maybe you just don't have sensors on that system, but at
least we'll be sure.

Is there any hardware monitoring information reported by the BIOS?

-- 
Jean Delvare

