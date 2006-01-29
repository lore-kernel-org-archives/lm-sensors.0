From: juergh@gmail.com (Juerg Haefliger)
Date: Sun, 29 Jan 2006 21:10:52 +0000
Subject: [lm-sensors] [PATCH] vt1211: Reading of temp1
Message-Id: <191fb4ca0601291310o178c6aa5of54f62566c561fd2@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0601190913q4ac4079dw8be3bd609af7c60d@mail.gmail.com>
In-Reply-To: <191fb4ca0601190913q4ac4079dw8be3bd609af7c60d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Rudolf,

I checked out the CVS version and everything looks fine except that
'sensors' reports an insane temperature for the new temp1 (Int temp)
reading. There's no compute line for temp1 in the vt1211 section of
etc/sensors.conf.eg. Could you please add one (or apply the attached
patch which just copies the compute line for temp3)?

Thanks
...juerg



-----Original Message-----
From: Rudolf Marek [mailto:r.marek at sh.cvut.cz]
Sent: Friday, January 27, 2006 12:44 PM
To: Juerg Haefliger
Cc: lm-sensors at lm-sensors.org
Subject: Re: [lm-sensors] [PATCH] vt1211: Reading of temp1


Applied, Thanks.

I added the label line to etc/sensors.conf.eg
Please can you test and see if everyting is OK? (grab it please from CVS)

Thanks,
regards
Rudolf
-------------- next part --------------
A non-text attachment was scrubbed...
Name: lm_sensors2-vt1211.patch
Type: application/octet-stream
Size: 455 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060129/01422ce5/lm_sensors2-vt1211.obj
