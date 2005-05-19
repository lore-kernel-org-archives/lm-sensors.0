From: rkimber@ntlworld.com (rkimber@ntlworld.com)
Date: Thu, 19 May 2005 06:25:37 +0000
Subject: fan control question
Message-Id: <20050210161356.2a9c07bf.rkimber@ntlworld.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050205151509.7b26200c.rkimber@ntlworld.com>
In-Reply-To: <20050205151509.7b26200c.rkimber@ntlworld.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 5 Feb 2005 17:00:29 +0100 (CET)
Rudolf Marek <R.Marek@sh.cvut.cz> wrote:

> 
> > w83627thf-isa-0290
> 
> You can skip the driver initialization of the chip adding init parameter.
> 
> modprobe w83627hf init=0
> 
> In case the module loads automatically try to put
> this line into /etc/modules.conf. Or disable somehow automatic loading.
> 
> options w83627hf init=0

Many thanks.  That's solved it.

- Richard.
