From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 20 Sep 2006 19:30:35 +0000
Subject: [lm-sensors] Asus P5B
Message-Id: <20060920213035.7b58da3f.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <b62408800609201018k102f2869wa8f97d0c83021fc8@mail.gmail.com>
In-Reply-To: <b62408800609201018k102f2869wa8f97d0c83021fc8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I have got lm_sensors installed (2.10)
> 
> m/b temp shows up but not cpu
> 
> attached output of ./sensors-detect
> 
> Can you tell me how to get cpu temp & fan set up please?

Your W83627DHG chip is properly detected, but it is not yet supported
by the w83627ehf driver. David Hubbard is working on adding support, he
posted a test patch some times ago:
http://lists.lm-sensors.org/pipermail/lm-sensors/2006-September/017625.html

Please see with David for the latest patches and how you can help with
testing.

I wonder how you get any temperature reported at all... May we see the
current output of "sensors"?

-- 
Jean Delvare

