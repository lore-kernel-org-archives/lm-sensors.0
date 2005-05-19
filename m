From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:23 +0000
Subject: Can't access /proc file for writing
Message-Id: <20031102201743.5e95430c.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1067739926.5304.28.camel@hahasiah.rozsas.xx.nom.br>
In-Reply-To: <1067739926.5304.28.camel@hahasiah.rozsas.xx.nom.br>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> The comments in the /etc/sensors.conf in the section for the
> "as99127f-*" chipset, say the formulas are just a guess, because ASUS
> won't released a datasheet for this chipset.
> 
> With the virtual machine help, I believe I can figure out a more
> precise formula for theses readings. For this, I need to set up values
> with"sensors -s", Am I right ? If I will successfully, I can
> contribute back to community, with more precise configuration lines
> for this particular system.

That would be interesting for sure, but we have to solve the /proc
problem before.

> > Move to /proc/sys/dev/sensors, and show us what "ls -lR" returns.
> 
> Too long to put in-line. I am sending as an attached file.

OK, file permissions look good (most files have mode 644, which means
you are supposed to be allowed to write to them). Now I'd like you to
try actually writing to a file. For example, go to
/proc/sys/dev/sensors/as99127f-i2c-0-2d and do:
echo 70 > temp1

Then run sensors. Temp1's limit should now be 70 instead of 60.

If it works, this means that libsensors is having trouble.

If it doesn't, this means that the /proc interface itself is having
trouble.

> I think is worth to mention that in single user mode, the umask is
> 022. I expected 222 to explain theses permissions....

The mask as you set it in your shell is completely independant from the
/proc files permissions, which are set by the drivers.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
