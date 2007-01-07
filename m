From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 07 Jan 2007 21:21:21 +0000
Subject: [lm-sensors] Tyan S2696 and ADT7470
Message-Id: <20070107222121.7e8e4ff6.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <E1H1lxZ-0002Zb-00@smtp.tt-solutions.com>
In-Reply-To: <E1H1lxZ-0002Zb-00@smtp.tt-solutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 07 Jan 2007 11:42:43 +0100, Rudolf Marek wrote:
> >  Is there any sufficiently clean and simple driver I could use as an
> > example/starting point by chance?
> 
> Yes maybe you can study the  w83l785ts.c  it is just temperature driver. Most
> simple. Also you may read the docs in kernel Documentation/hwmon/ and /i2c/
> 
> I had in plan to create some example driver for i2c devices but no time yet :/

In theory Documentation/i2c/writing-clients is that example driver, but
in practice it's terribly out-date and thus quite useless. Using a
real, simple driver as an example is probably the best solution, at
least it doesn't get out-of-date as documentation does.

-- 
Jean Delvare

