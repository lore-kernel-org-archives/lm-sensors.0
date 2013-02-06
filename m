From: Dag Wieers <dag@wieers.com>
Date: Wed, 06 Feb 2013 14:00:58 +0000
Subject: Re: [lm-sensors] i2c-i801 on AppleTV (1st gen)
Message-Id: <alpine.LRH.2.02.1302061455500.2736@pikachu.3ti.be>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="683428207-994820713-1360159258=:2736"
List-Id: <lm-sensors.vger.kernel.org>
References: <alpine.LRH.2.02.1302050844220.2736@pikachu.3ti.be>
In-Reply-To: <alpine.LRH.2.02.1302050844220.2736@pikachu.3ti.be>
To: lm-sensors@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--683428207-994820713-1360159258=:2736
Content-Type: TEXT/PLAIN; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: quoted-printable

On Wed, 6 Feb 2013, Jean Delvare wrote:

> Not good. This can mean one of two things: either the chip has no
> register 0x3f and it nacks non-existent register read attempts, or it
> doesn't support SMBus read byte transactions at all. In the latter
> case, I strongly suggest that you leave the chip alone. As for the
> former case, there are a few thermal sensor chips which behave like,
> don't have a register at 0x3f and can use slave address 0x48: DS1621
> and similar, DS75, LM73.

It now consistently returns 0x3d, could this be a thermal value, like 61=B0=
C ?

The GPU reports 46=B0C (coming from nvidia-smi).

--=20
-- dag wieers, dag@wieers.com, http://dag.wieers.com/
-- dagit linux solutions, info@dagit.net, http://dagit.net/

[Any errors in spelling, tact or fact are transmission errors]
--683428207-994820713-1360159258=:2736
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--683428207-994820713-1360159258=:2736--
