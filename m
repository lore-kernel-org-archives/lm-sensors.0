From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:02 +0000
Subject: [PATCH 2.6] drivers/media/video/bt832.c: ACK return on
Message-Id: <200406221552.i5MFqX1l016959@zone3.gcu-squad.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040622151603.GA1473@mars>
In-Reply-To: <20040622151603.GA1473@mars>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Arthur,

>i2c_add_driver() may actually fail, but this driver returns 0
>regardless. Against 2.6.7. Thanks.

Your patches look good, but we do not have the possibility to apply them
ourselves. You should direct your requests to the drivers maintainers
(as you did for some of the patches). If you can't find who this is,
please try the media/video subsystem maintainer (if there is one). Else
I guess you can fallback to Greg KH since this is i2c stuff.

At any rate, please realize that any of these patches, sent only to the
lm_sensors mailing list, will be lost unless you redirect them to the
correct person.

Thanks,
Jean Delvare
