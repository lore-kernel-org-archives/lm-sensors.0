From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:41 +0000
Subject: Latest cvs -> Compile Errors
Message-Id: <20021117204222.093f8ec0.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200211161710.26342.amalysh@web.de>
In-Reply-To: <200211161710.26342.amalysh@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

(Resending again, looks like there were problems with stimpy yesterday
evening and still this morning.)

> Khali, this probably breaks your doc-features tool.
It did, and I workaround it. I don't know how we can generate a doc for
bmcsensors since it has some kind of dynamic allocation for the
ctl_table, if I understand it well. I tool a look at the code and I
couldn't see how the proc names will be generated. It seems that
bmcsensors_proc_name_pool is used uninitialized (or is there something I
don't know about kmalloc?) I'd appreciate some explanations, for my
personal knowledge if not to find a way to generate the doc.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
