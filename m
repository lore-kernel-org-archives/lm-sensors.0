From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 19 May 2005 06:25:53 +0000
Subject: Query: using parport to send 24-bit serial clock and data?
Message-Id: <4266ADB0.1020307@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <hbn5619oiuenbrvpf8sj49fh89kb1fj34s@4ax.com>
In-Reply-To: <hbn5619oiuenbrvpf8sj49fh89kb1fj34s@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> So which low-level driver would you suggest as a starting point?

I would create very own char device driver and start using portions from i2c-pport.
I would rip all i2c specific code...
for 2.6.x it can be found at http://assembler.cz/download/i2cpport26.tar.gz

regards

Rudolf
