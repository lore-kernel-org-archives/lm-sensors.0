From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 02 Dec 2011 07:21:20 +0000
Subject: Re: [lm-sensors] How to get patches and build with them?
Message-Id: <20111202082120.33f6afc0@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4ED7B66A.6030009@catcons.co.uk>
In-Reply-To: <4ED7B66A.6030009@catcons.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 02 Dec 2011 12:01:59 +0530, Charles wrote:
> Many thanks for the prompt reply Jean :)
> 
> I went with your recommended patches for starters.  Had to use -p3 (not
> in expected directory?).

I was no longer sure if it was -p2 or -p3. The -p3 is probably needed
because of the leading / in the file paths.

>  The build is for Slackware64 13.1, upgraded to
> kernel 2.6.38.7 running on an ASUS PBH67-V motherboard which has a
> Nuvoton NCT6776F -- as the newly installed lm_sensors 3.3.1
> sensors-detect now reports :)
> 
> These are the download and patch commands used:
> 
> gpg --keyserver wwwkeys.pgp.net --recv-keys 38F02FC8
> 
> cd /tmp \
>   && rm -fr lm_sensors-3.3.1 \
>   && wget
> http://dl.lm-sensors.org/lm-sensors/releases/lm_sensors-3.3.1.tar.bz2 \
>   && wget
> http://dl.lm-sensors.org/lm-sensors/releases/lm_sensors-3.3.1.tar.bz2.sig \
>   && gpg --verify lm_sensors-3.3.1.tar.bz2.sig \
>   && tar -jxvf lm_sensors-3.3.1.tar.bz2 \
>   && cd lm_sensors-3.3.1 \
>   && wget --output-document=patch_5991 \
>     'http://www.lm-sensors.org/changeset/5991?format=diff&newY91' \
>   && wget --output-document=patch_5992 \
>     'http://www.lm-sensors.org/changeset/5992?format=diff&newY92' \
>   && wget --output-document=patch_5993 \
>     'http://www.lm-sensors.org/changeset/5993?format=diff&newY93' \
>   && wget --output-document=patch_5999 \
>     'http://www.lm-sensors.org/changeset/5999?format=diff&newY99' \
>   && patch -p3 < patch_5991 \
>   && patch -p3 < patch_5992 \
>   && patch -p3 < patch_5993 \
>   && patch -p3 < patch_5999
> 
> BTW, make PREFIX=/tmp/tmp installed to /usr/local
> 
> After installing to /usr/local the following symlink was required to
> allow GKrellM to start:
> 
> ln -s /usr/local/lib/libsensors.so.4 /usr/lib64/libsensors.so.4

This can probably be avoided by passing LIBDIR=/usr/local/lib64 to
make, and adding /usr/local/lib64 to /etc/ld.so.conf if it's not
already there. Alternatively, just adding /usr/local/lib
to /etc/ld.so.conf should work too.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
