From: zdavatz@ywesee.com (Zeno R.R. Davatz)
Date: Thu, 19 May 2005 06:24:10 +0000
Subject: failed again; vetctor 300
Message-Id: <20030805234611.23978b98.zdavatz@ywesee.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030805222340.3799d819.zdavatz@ywesee.com>
In-Reply-To: <20030805222340.3799d819.zdavatz@ywesee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 6 Aug 2003 13:31:27 +0200
Jean Delvare <khali@linux-fr.org> wrote:

> Yes, I am. I should really have though of all that before, since I am
> the one who wrote the kernel i2c patch that fixes that. Stupid me.
Well we found the problem. That is most important. Thanks again.

> Must be Super I/O chips? This is something new in 2.8.0 actually, and
> not well tested. Maybe this will require some tweeking, thanks for
> reporting.
Yes correct.

> Solution #1:
> You stick to 2.7.0 until kernel 2.4.23 is released. This kernel version
> should include the i2c update and solve the problem you had.
Any idea when 2.4.23 will be released?
 
> Solution #2:
> You disable your sound module ("alias dmasound_pmac off" in
> /etc/modules.conf) and install 2.8.0. This should work, but you won't
> have sound anymore, of course.
Want my sound. It is back now.

> Solution #3:
> You use the i2c kernel patch for 2.8.0. This require recompiling your
> own kernel. I don't know it this is something you are used to do, nor if
> you simply want to. I guess this may prevent you from using the debian
> packages (unless these are sources packages tou have to compile anyway).
Not an option for me at the moment.

Thanks 
Zeno
