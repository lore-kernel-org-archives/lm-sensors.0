From: Curt.Blank@curtronics.com (Curt Blank)
Date: Thu, 22 Mar 2007 06:03:45 +0000
Subject: [lm-sensors] k8temp
Message-Id: <46021C41.6070908@curtronics.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200703212247.05783.tomcw@adelphia.net>
In-Reply-To: <200703212247.05783.tomcw@adelphia.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Tom Weichmann wrote:
> Does anyone know anything about this kernal module?  imsensors-detect 
> recommended that I modprobe it, but it is not included with SuSE 10.2 on 
> kernal 2.6.18.8.  I can't seem to find anything definateive on the web, is 
> this kernal too old to include this module?
> 
> Thanks,
> 
> Tom Weichmann
> 
> _______________________________________________
> lm-sensors mailing list
> lm-sensors at lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

Hi Tom,

Good timing. I just backported it from 2.6.21 to SuSE 10.1 2.6.16 
yesterday (Wednesday). I would guess that it be the same for you on 10.2 
or you might have to tweak it a bit. I tar'd it up and put it here:

http://www.curtronics.com/patches/
	k8temp_2.6.21_backport_to_SuSE_10.1_2.6.16.tar.gz

It was extremely easy, complied right up once the change was made to the 
pci_ids.h file.

-Curt Blank

