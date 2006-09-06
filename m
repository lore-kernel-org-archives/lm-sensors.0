From: michaelnel@comcast.net (Michael Nelson)
Date: Wed, 06 Sep 2006 18:19:59 +0000
Subject: [lm-sensors] Asus P5B Deluxe WiFi AP Sensors
Message-Id: <20060906181958.GA11352@seahunt.dyndns.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060822145643.GA5632@seahunt.dyndns.org>
In-Reply-To: <20060822145643.GA5632@seahunt.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Sep 06, 2006 at 12:08:33PM -0600, David Hubbard wrote:
> I just realized that the patch I sent is against the newest w83627ehf
> driver, which is not in the kernel yet. However, the .c file includes
> all the patches. Please use that file.

That's what I used.

> Can you please send the output of "lspci -n"?

:~$  /sbin/lspci -n
00:00.0 Class 0600: 8086:29a0 (rev 02)
00:01.0 Class 0604: 8086:29a1 (rev 02)
00:1a.0 Class 0c03: 8086:2834 (rev 02)
00:1a.1 Class 0c03: 8086:2835 (rev 02)
00:1a.7 Class 0c03: 8086:283a (rev 02)
00:1b.0 Class 0403: 8086:284b (rev 02)
00:1c.0 Class 0604: 8086:283f (rev 02)
00:1c.4 Class 0604: 8086:2847 (rev 02)
00:1c.5 Class 0604: 8086:2849 (rev 02)
00:1d.0 Class 0c03: 8086:2830 (rev 02)
00:1d.1 Class 0c03: 8086:2831 (rev 02)
00:1d.2 Class 0c03: 8086:2832 (rev 02)
00:1d.7 Class 0c03: 8086:2836 (rev 02)
00:1e.0 Class 0604: 8086:244e (rev f2)
00:1f.0 Class 0601: 8086:2810 (rev 02)
00:1f.2 Class 0106: 8086:2821 (rev 02)
00:1f.3 Class 0c05: 8086:283e (rev 02)
01:00.0 Class 0300: 10de:0391 (rev a1)
02:00.0 Class 0200: 11ab:4364 (rev 12)
03:00.0 Class 0106: 197b:2363 (rev 02)
03:00.1 Class 0101: 197b:2363 (rev 02)
05:02.0 Class 0100: 9005:0080 (rev 02)
05:03.0 Class 0c00: 104c:8023
05:04.0 Class 0200: 11ab:4320 (rev 13)

Thanks.  I'm at work now, will work with it some more tonight.

Michael

-- 

San Francisco, CA

