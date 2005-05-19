From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:10 +0000
Subject: nforce2 i2c module compilation
Message-Id: <20030805155504.0d936513.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <000f01c35b57$0985ec80$0100a8c0@downstairs>
In-Reply-To: <000f01c35b57$0985ec80$0100a8c0@downstairs>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> Just wondering how to resolve this error I always get when trying to
> compile the lm sensors package (both from CVS pre- and post- 2.8.0
> release and the final released 2.8.0) on Redhat 9 or Severn
> (RH9.0.93).  I am using an ASUS A7N8X rev2 and was wanting to use the
> nforce2 sensor to try and get hardware monitoring much like
> Motherbaord monitor in windows, but for linux, going. Any help would
> be appreciated.

Strange error, never seen such, but I know Red Hat always add dozens of
patches to their lm_sensors packages so maybe there is a reason. Anyway,
let's see if we can help you.

1* Did you compile and install i2c-2.8.0 before trying to compile
lm_sensors? Did it produce any error or warning?

2* Is /lib/modules/2.4.20-19.9/build pointing to a real directory, with
sources that match your running kernel? Does this dir have a .config
file that also match your current config?

3* Is /usr/include/asm a real directory or a symlink? To what?

4* What if you disable the i2c-nforce2 module (edit
kernel/busses/Module.mk)? Does the compilation fail on next module, or
goes on?

With this information, I hope we'll be able to help.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
