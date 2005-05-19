From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:23 +0000
Subject: adm1026 driver port for kernel 2.6.10-rc2  [RE-REVISED DRIVER]
Message-Id: <20041120113210.40e194fb.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041102221745.GB18020@penguincomputing.com>
	<NN38qQl1.1099468908.1237810.khali@gcu.info>
	<20041103164354.GB20465@penguincomputing.com>
	<20041118185612.GA20728@penguincomputing.com>
	<1100945635.2639.31.camel@laptop.fenrus.org>
In-Reply-To: <1100945635.2639.31.camel@laptop.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arjan van de Ven <arjan@infradead.org>
Cc: Justin Thiessen <jthiessen@penguincomputing.com>, Greg KH <greg@kroah.com>, LM Sensors <sensors@stimpy.netroedge.com>, LKML <linux-kernel@vger.kernel.org>

Hi Arjan,

> > static ssize_t show_in(struct device *dev, char *buf, int nr)
> > {
> > 	struct adm1026_data *data = adm1026_update_device(dev);
> > 	return sprintf(buf,"%d\n", INS_FROM_REG(nr, data->in[nr]));
> > }
> 
> any chance you could make this use snprintf instead ?

None of the other hardware monitoring clients driver do, nor do I think
they should. What are we trying to improve?

Thanks.

-- 
Jean Delvare
http://khali.linux-fr.org/
