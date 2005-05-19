From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:52 +0000
Subject: Centrino (855PM, ICH4-M): 82801DBM w/o LPC Bridge/SMBus?
Message-Id: <1081847008.407bace03db50@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040412152503.GD6820@neu.nirvana>
In-Reply-To: <20040412152503.GD6820@neu.nirvana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> There is an adm1032 chip on it, as well as RAM eeproms.

Oh yeah, now I remember. When I asked about which systems had ADM1032
chips on them, Sean Gilmour (from Analog Devices) told us that mainly
notebooks (and the X-Box) used them. I just wish I had one on mine!

> I have also found some bugs in the p4b_smbus (the bits were valid
> for ICH2, not ICH4, as a sideeffect they enable USB UHCI #3 on
> ICH4).

Nice catching.

> I will prepare a diff to cvs and send it to you. Thanks!  (BTW cvs
> diff -N ... does not work with new, but not cvs added files and cvs
> add is not allowed with anonymous read-only access. How does one
> prepare a diff -N type patch?)

Never had to do that before. I guess that I would just duplicate the
working repository and treat the whole thing as static, off-line
directories. One of them being the snapshot of the CVS repository, the
other being your working directory.

BTW, what file do you want to create?

Another possibility is that we could grant you write access to the
repository. You look like a responsible person so I'd say it is safe
;)

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
