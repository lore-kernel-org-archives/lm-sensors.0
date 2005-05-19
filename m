From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:30 +0000
Subject: bus scan removal
Message-Id: <20031222185546.5b5b60fc.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031221100543.28eaf2ff.khali@linux-fr.org>
In-Reply-To: <20031221100543.28eaf2ff.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > I searched my mail archive for Greg's original comment, but couldn't
> > find it. Greg, any chance you could refresh my memory?
> 
> For systems that have a 64bit kernel, and a 32bit userspace, all
> ioctls in the kernel need a "thunking" layer in order to pass the data
> between the kernel and userspace properly.  Last I looked that layer
> did not contain any i2c ioctls, so i2c-dev will not work on those
> kinds of systems (ppc64, sparc64, mips64, amd64, ia64, etc...)

OK. This means that these architectures can't user i2cdetect at the
moment, but could do at a later time, providing the necessary layer is
written.

So I think that the right thing to do would be to remove all bus
scanning from the drivers themselves. Reasons for doing this have been
discused earlier in this thread. If some people need bus scanning and
i2cdetect doesn't work for them, I guess we'll hear from them, and
we'll write the layer.

Unless anyone objects, I'll be writing patches for both linux 2.4.23 and
2.6.0, and submit them to Marcelo and Greg, respectively.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
