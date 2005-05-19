From: arjan@infradead.org (Arjan van de Ven)
Date: Thu, 19 May 2005 06:25:23 +0000
Subject: adm1026 driver port for kernel 2.6.10-rc2  [RE-REVISED DRIVER]
Message-Id: <1101157242.2813.34.camel@laptop.fenrus.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041102221745.GB18020@penguincomputing.com>
	 <NN38qQl1.1099468908.1237810.khali@gcu.info>
	 <20041103164354.GB20465@penguincomputing.com>
	 <20041118185612.GA20728@penguincomputing.com>
	 <1100945635.2639.31.camel@laptop.fenrus.org>
	 <20041122194327.GB4698@penguincomputing.com>
In-Reply-To: <20041122194327.GB4698@penguincomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Justin Thiessen <jthiessen@penguincomputing.com>
Cc: greg@kroah.com, phil@netroedge.com, khali@linux-fr.org, sensors@Stimpy.netroedge.com, linux-kernel@vger.kernel.org


> > this locking construct is rahter awkward; is it possible to refactor the
> > code such that you can down and up in the same function ?
> 
> Yes, at the cost of some minor code duplication or the introduction of
> another variable.  Is that preferable?  Is holding the lock across function
> calls a Bad Idea?

holding lock across function calls isn't, unlocking in another function than you take the lock is.
For one it makes auditing the code a lot harder.

