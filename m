From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:13 +0000
Subject: i801 bus problems
Message-Id: <20040903135207.M14212@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.58.0409022207200.19686@desitka.sh.cvut.cz>
In-Reply-To: <Pine.LNX.4.58.0409022207200.19686@desitka.sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Confirmed  SMSC EMC6D103 !!!!
> 
> on a photo of the mobo on the web there was a
> ADM1027

Since both chips are compatible, I guess intel use whatever they have at hand
at the moment.

Anyway the story is quiet easy to understand now.

1* The "no response" errors in the logs are for the other possible addresses
of LM85-compatible chips (0x2c and 0x2d). That's not what your chip uses so
the bus cannot read from these addresses. Nothing wrong.

2* The lm85 driver in Linux 2.6 doesn't support SMSC chips, although the 2.4
driver does. Using force=0,0x2e should work in the meantime. The original post
suggests you tried and it didn't, but the log right after that says "found
normal i2c entry for adapter 0, addr 2e" so I doubt it worked, you must have
missed something. Just try again.

At some time, the SMSC support should be ported from the 2.4 driver, and
extended to the 103 and maybe 102 as well if they are compatible (and they
seem to be but I don't know the LM85 family that good).

-- 
Jean Delvare
http://khali.linux-fr.org/
