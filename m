From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:48 +0000
Subject: [Fwd: PATCH: bmcsensors and i2c-ipmi port to 2.6]
Message-Id: <20040321112856.65d2cdba.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <4056FCE9.2020904@utsc.utoronto.ca>
In-Reply-To: <4056FCE9.2020904@utsc.utoronto.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Greg,

> Yani Ioannou wrote:
>
> > I can't imagine why
> > the device sysfs callbacks don't pass information on the file they
> > pertain to, like the base sysfs callbacks, I can only think there
> > must be a good reason, or something I'm missing.

See how I am not the only one complaining about the lack of an
additional parameter to i2c sysfs callback functions, that would let us
have a single callback function for several similar sysfs entries, much
like we were doing in 2.4.

Now that Yani seems to pretend other (non-i2c) sysfs callback functions
work that way, I am even more confused and really wonder why it was
decided we would not be able to use that possibility.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
