From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Sun, 29 Jan 2006 21:20:58 +0000
Subject: [lm-sensors] [PATCH] vt1211: Reading of temp1
Message-Id: <43DD31BA.9080804@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0601190913q4ac4079dw8be3bd609af7c60d@mail.gmail.com>
In-Reply-To: <191fb4ca0601190913q4ac4079dw8be3bd609af7c60d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Juerg Haefliger wrote:
> Hi Rudolf,
> 
> I checked out the CVS version and everything looks fine except that
> 'sensors' reports an insane temperature for the new temp1 (Int temp)
> reading. There's no compute line for temp1 in the vt1211 section of
> etc/sensors.conf.eg. Could you please add one (or apply the attached
> patch which just copies the compute line for temp3)?

Aha, correct. Thanks for pointing on it.
Fixed.

Thanks,
Rudolf

