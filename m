From: brix@gentoo.org (Henrik Brix Andersen)
Date: Wed, 14 Jun 2006 16:20:26 +0000
Subject: [lm-sensors] ASUS NCCH-DR confusing 83792 vs. 83627THF
Message-Id: <20060614162026.GB3275@osgiliath>
List-Id: <lm-sensors.vger.kernel.org>
References: <44901813.3080703@fasytek.dk>
In-Reply-To: <44901813.3080703@fasytek.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Jun 14, 2006 at 06:04:37PM +0200, Jean Delvare wrote:
> I can't get why some distributions invented these lib64 directories. On
> 32-bit systems we have lib, not lib32, so why make it different on
> 64-bit systems? It may make sense to have a lib32 directory on 64-bit
> systems for libraries which are only available in 32-bit format, Gentoo
> is doing it almost this way (lib is a link to lib64, and there is lib32
> for the 32-bit libraries), but doing it the other way around sounds
> weird to me.

The distributions didn't invent this - it's part of the FHS:
http://www.pathname.com/fhs/pub/fhs-2.3.html#LIB64

I don't think the lm_sensors Makefile should attempt to be smart and
install to lib64 on 64bit systems. This should be left up to the
package manager of the distribution. If users wish to have libsensors
installed to another directory, they are free to overload the library
path on the make commandline ("make LIBDIR=/lib64 user_install").

Regards,
Brix
-- 
Henrik Brix Andersen <brix at gentoo.org>
Gentoo Metadistribution | Mobile computing herd
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 213 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060614/63642d50/attachment-0001.bin 
