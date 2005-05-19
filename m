From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:53 +0000
Subject: 2.4.30 kernel panic with bttv and i2c-2.9.1 (try2)
Message-Id: <20050422184411.258b49f0.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050422152915.046eb733@me>
In-Reply-To: <20050422152915.046eb733@me>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> From few days I'm having an bt878 based capture card.
> I was able to make it work with bttv driver in the 2.4.30 kernel.
> Then I installed latest i2c and lm-sensors (2.9.1) and jumped into
> problems- kernel panic.
> 
> 
> I have attached archive with:
> /proc/ksym copied after the oops, 
> the /var/log/ksymoops/ directory,
> the original nonprocesses kernel message,
> and ksymoops-ed message using modprobe logs as kops1.txt.
>  (probably ksym would be  better - attached as kops2.txt)

After a few hours of investigation, we noticed that i2c_msg has
additional fields in i2c-2.9.1 when compared with a 2.4 kernel. These
make the structure bigger, which causes offset troubles when one
manipulates arrays of i2c_msg - which is a quite typical thing to do
when calling i2c_transfer.

So we failed to bring i2c-2.9.1 in compatibility with 2.4 kernels again.
Shame on us.

The only user of these extra fields seems to be i2c-algo-biths, so I
would guess that they were added especially for it. They aren't even in
Linux 2.6.

We need to remove these extra fields in order to restore compatibility
with Linux 2.4. As I do not plan to spend time fixing i2c-algo-biths,
can't we simply get rid of it? It's not used by any driver, has not been
ported to Linux 2.6, has already caused more trouble than was worth, and
is overall not needed as far as I can see (i2c-algo-bit works just fine
for everyone).

Thanks,
-- 
Jean Delvare
